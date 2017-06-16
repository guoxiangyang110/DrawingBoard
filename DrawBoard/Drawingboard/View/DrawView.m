//
//  DrawView.m
//  drawingBoard
//
//  Created by dengwei on 15/6/26.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DrawView.h"
#import "DrawPath.h"
#import "CommandManager.h"
#import "ReplayManager.h"
#import "UIColor+Extension.h"

@interface DrawView()

//当前绘图路径
@property (assign, nonatomic)CGMutablePathRef drawPath;
//绘图路径数组
@property (strong, nonatomic)NSMutableArray *drawPathArray;
@property (strong, nonatomic)NSMutableArray *drawPathUndoArray;

//路径是否被释放
@property (assign, nonatomic)BOOL pathReleased;
@property (strong, nonatomic)NSMutableArray *indexPathVertexArray;

@property (assign, nonatomic)BOOL replaying;
@property (assign, nonatomic)BOOL recording;

@property (strong, nonatomic) CommandManager *commandManager;
@property (strong, nonatomic) ReplayManager *replayManager;

@property (strong, nonatomic) UIProgressView* progress;
@end

@implementation DrawView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self sizeToFit];
        
        self.contentMode = UIViewContentModeRedraw;
        
        self.multipleTouchEnabled = NO;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //设置属性值
        self.lineWidth = 5.0;
        self.drawColor = @"FF0000";
    }
    
    return self;
}

#pragma mark - 绘制视图
//注意：drawRect方法每次都是完整的绘制视图中需要绘制部分内容
-(void)drawRect:(CGRect)rect
{
    NSLog(@"%s %f %f",__func__,rect.size.width,rect.size.height);
    
    //1.获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (_replaying) {
        [self drawViewReplay:context];
    } else{
        [self drawView:context];
    }
    
}

#pragma mark - 绘图视图内容的方法
-(void)drawView:(CGContextRef)context{
    //--------------------------------------
    //首先将绘图数组中的路径全部绘制出来
    for(DrawPath *path in self.drawPathArray){
        if (path.image == nil) {
        
            CGContextAddPath(context, path.drawPath.CGPath);
        
            [[UIColor colorWithHexColorString:path.drawColor] set];
            CGContextSetLineWidth(context, path.lineWidth);
            CGContextSetLineCap(context, kCGLineCapRound);
        
            CGContextDrawPath(context, kCGPathStroke);
        }else{

            [path.image drawInRect:self.bounds];
            
        }
    }
    
    //--------------------------------------
    //以下代码绘制当前路径的内容，就是手指还没有离开屏幕
    //内存管理部分提到，所有create创建的都要release，而不能设置成NULL
    if (self.pathReleased) {
        return;
    }
    
    //1.添加路径
    CGContextAddPath(context, self.drawPath);
    
    //2.设置上下文属性
    [[UIColor colorWithHexColorString:self.drawColor] set];
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    //3.绘制路径
    CGContextDrawPath(context, kCGPathStroke);
}

-(void)drawViewReplay:(CGContextRef)context{

    INITConfigCommandInfo *config = self.replayManager.cofigInfo.config;
    
    for (ADDCommandInfo *command in self.replayManager.redoStack) {
        
        [self drawPath:context command:command config:config];
    }
    
    if (self.replayManager.redoStackTopInfo) {
        ADDCommandInfo *command = self.replayManager.redoStackTopInfo;

        [self drawPath:context command:command config:config];
    }
    
    [self timeChangeValidate];
}

- (void) drawPath:(CGContextRef)context command:(ADDCommandInfo *)command config:(INITConfigCommandInfo *)config{
    
    CGMutablePathRef drawPath = CGPathCreateMutable();
    
    ADDTracePointCommandInfo *first = command.trace.tracePointList.firstObject;
    CGPathMoveToPoint(drawPath, NULL, config.page_width*first.x, config.page_height*first.y);
    
    int countPoint = (int)command.trace.tracePointList.count;
    for (int i=1;i<countPoint;i++ ) {
        ADDTracePointCommandInfo *point = [command.trace.tracePointList objectAtIndex:i];
        
        CGPathAddLineToPoint(drawPath, NULL, config.page_width*point.x, config.page_height*point.y);
    }
    
    UIBezierPath *bPath = [UIBezierPath bezierPathWithCGPath:drawPath];
    CGContextAddPath(context, bPath.CGPath);
    
    CGPathRelease(drawPath);
    
    NSString *colorHex = [UIColor colorHexStringWithInt10:command.trace.penColor];
    [[UIColor colorWithHexColorString:colorHex] set];
    CGContextSetLineWidth(context, command.trace.penWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextDrawPath(context, kCGPathStroke);

//    NSLog(@"----------->count:%d empty:%d b:%f %f px:%f",self.replayManager.redoStack.count,bPath.isEmpty,bPath.bounds.size.width,bPath.bounds.size.height,bPath.currentPoint.x);
}

#pragma mark - 触摸事件
#pragma mark - 触摸开始，创建绘图路径
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (event.allTouches.count>1) {
        [[self nextResponder] touchesBegan:touches withEvent:event];
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    self.drawPath = CGPathCreateMutable();
  
    self.indexPathVertexArray = [NSMutableArray array];

    //记录路径没有被释放
    self.pathReleased = NO;
    
    //在路径中记录触摸的初始点
    CGPathMoveToPoint(self.drawPath, NULL, location.x, location.y);
    
    DrawPath *path = [DrawPath drawPathWithCGPath:self.drawPath color:self.drawColor lineWidth:self.lineWidth];
    path.date = [[NSDate date]timeIntervalSince1970]*1000-self.commandManager.dateRecordBegin;
    path.x = location.x/self.frame.size.width;
    path.y = location.y/self.frame.size.height;
    
    [self.indexPathVertexArray addObject:path];

    NSLog(@"%s tap:%d touchs:%d event:%d  X:%f Y:%f x:%f y:%f W:%f H:%f",__func__,touch.tapCount,touches.allObjects.count,event.allTouches.allObjects.count,location.x,location.y,self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
}
#pragma mark - 移动过程中，将触摸点不断添加到绘图路径
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (event.allTouches.count>1) {
        [[self nextResponder] touchesMoved:touches withEvent:event];
        return;
    }
    
    if (self.pathReleased)  return;

    //可以获取用户当前触摸的点
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    //将触摸点添加至路径
    CGPathAddLineToPoint(self.drawPath, NULL, location.x, location.y);
    [self setNeedsDisplay];
    
    DrawPath *path = [DrawPath drawPathWithCGPath:self.drawPath color:self.drawColor lineWidth:self.lineWidth];
    path.date = [[NSDate date]timeIntervalSince1970]*1000-self.commandManager.dateRecordBegin;
    path.x = location.x/self.frame.size.width;
    path.y = location.y/self.frame.size.height;
    
    [self.indexPathVertexArray addObject:path];
    
    NSLog(@"%s %f %f",__func__,location.x,location.y);

}

#pragma mark - 触摸结束，释放路径
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (event.allTouches.count>1) {
        [[self nextResponder] touchesEnded:touches withEvent:event];
        return;
    }
    
    if (self.pathReleased)  return;
    
    //一笔画完之后将完整的路径添加到路径数组中
    //使用数组的懒加载
    if (self.drawPathArray == nil) {
        self.drawPathArray = [NSMutableArray array];
    }
    
    if (self.drawPathUndoArray == nil) {
        self.drawPathUndoArray = [NSMutableArray array];
    }
    
    //要将CGPathRef添加到NSArray之中，需要借助贝塞尔曲线对象
    //贝塞尔曲线时UIKit对CGPathRef的一个封装，贝塞尔路径的对象可以直接添加到数组
    //UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.drawPath];
    
    DrawPath *path = [DrawPath drawPathWithCGPath:self.drawPath color:self.drawColor lineWidth:self.lineWidth];
    path.date = [[NSDate date] timeIntervalSince1970]*1000-self.commandManager.dateRecordBegin;

    //需要记录当前绘制路径的颜色和线宽
    [self.drawPathArray addObject:path];
    
    path.vertexList = self.indexPathVertexArray;
    
    self.indexPathVertexArray = nil;

    if (self.recording) {
        [self.commandManager commandAddWithPath:path];
    }

    CGPathRelease(self.drawPath);
    
    //记录路径被释放
    self.pathReleased = YES;
    
    NSLog(@"%s",__func__);

}

#pragma mark -Public 工具视图执行方法
-(void)redoStep{
    if (self.drawPathUndoArray==nil || self.drawPathUndoArray.count<1)  return;

    DrawPath *last = self.drawPathUndoArray.lastObject;

    if (self.recording) {
        long time = [[NSDate date] timeIntervalSince1970]*1000-self.commandManager.dateRecordBegin;

        [self.commandManager commandRedoWithId:last.identifier time:time];
    }
    
    //在执行撤销操作时，当前没有绘图路径
    //要做撤销操作，需要把路径数组中最后一条路径删除
    [self.drawPathArray addObject:last];
    [self.drawPathUndoArray removeObject:last];
    
    [self setNeedsDisplay];
}

-(void)undoStep{
    if (self.drawPathArray==nil || self.drawPathArray.count<1)  return;
    
    DrawPath *last = self.drawPathArray.lastObject;

    if (self.recording) {
        long time = [[NSDate date] timeIntervalSince1970]*1000-self.commandManager.dateRecordBegin;

        [self.commandManager commandUndoWithId:last.identifier time:time];
    }

    //在执行撤销操作时，当前没有绘图路径
    //要做撤销操作，需要把路径数组中最后一条路径删除
    [self.drawPathArray removeObject:last];
    [self.drawPathUndoArray addObject:last];
    
    [self setNeedsDisplay];
}

-(void)clearScreen{
    if (self.recording) {
        [self.commandManager commandClear];
    }
    
    //在执行清屏操作时，当前没有绘图路径
    //要做清屏操作，只要把路径数组清空即可
    [self.drawPathArray removeAllObjects];
    [self.drawPathUndoArray removeAllObjects];
    
    self.indexPathVertexArray = nil;
    
    [self setNeedsDisplay];
}

- (void) replay{
    self.userInteractionEnabled = NO;
    
    [self stopRecord];
    
    [self startReplay];
    
    if (!_progress) {
        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
        [self addSubview:_progress];
    }
    _progress.progress = 0;
    _progress.hidden = NO;
}

- (void) startRecord{
    self.commandManager = [[CommandManager alloc]init];
    [self.commandManager startRecord];
    
    self.recording = YES;
}

- (void) stopRecord{
    if (self.recording) {
        self.recording = NO;
        
        [self.commandManager stopRecord];
    }
}

#pragma mark - Pravite

-(void)startReplay{
    if (_replayManager==nil) {
        _replayManager = [[ReplayManager alloc]init];
    }
    
    NSString *json = [_commandManager  jsonFromCommandList:_commandManager.drawCommandArray];
//    _replayManager.drawCommandArray = _commandManager.drawCommandArray;
    [_replayManager commandListFromJsonArray:json];
    
    [_replayManager startPlay];
    
    _replaying = YES;

    [self timeChangeValidate];
}


#pragma mark - image的setter方法
-(void)setImage:(UIImage *)image
{
    /*目前绘图的方法：
     1.用self.drawPathArray记录已经完成（抬起手指）的路径
     2.用self.drawPath记录当前正在拖动中的路径
     
     绘制时，首先绘制self.drawPathArray，然后再绘制self.drawPath
     
     image传入时，drawPath没有被创建（被release但不是NULL）
     
     如果，
     1.将image也添加到self.drawPathArray（DrawPath）
     2.在绘图时，根据是否存在image判断是否绘制路径还是图像，就可以
       实现用一个路径数组即绘制路径，又绘制图像的目的
     
     之所以要用一个数组，时因为绘图是有顺序的
     
     接下来，首先需要扩充DrawPath，使其支持image
     */
    //1.实例化一个新的DrawPath
    DrawPath *path = [[DrawPath alloc]init];
    [path setImage:image];
    
    //2.将其添加到self.drawPathArray，这个数组是懒加载
    if (self.drawPathArray == nil) {
        self.drawPathArray = [NSMutableArray array];
    }
    
    [self.drawPathArray addObject:path];
    
    //3.重绘
    [self setNeedsDisplay];
}

#pragma mark - Timer


-(void)timeChangeValidate{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(0.05);
        
        long long timerInterval = self.replayManager.dateInterval;
        long timeNum = [[NSDate date]timeIntervalSince1970]*1000 - self.replayManager.datePlayBegin;
        NSLog(@"%s %ld %lld",__func__,timeNum,timerInterval);
        
        [self.replayManager updateStack:timeNum];
        
        if (timeNum < timerInterval) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setNeedsDisplay];
                
                [_progress setProgress:(double)timeNum/timerInterval animated:YES];
                
                NSLog(@"----------display");
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _progress.hidden = YES;
            });
            
            _replaying = NO;
            
            self.userInteractionEnabled = YES;
        }
        
    });
}


@end
