//
//  ReplayManager.m
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/9.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import "ReplayManager.h"

@interface ReplayManager ()

@property (nonatomic, assign) int commandIndex;
@property (nonatomic, strong) NSDictionary *commandSELMap;

@end

@implementation ReplayManager

- (void) commandListFromJsonArray:(id)json{
    NSMutableArray  *temp = [NSMutableArray array];
    
    NSMutableArray *dicList = [NSMutableArray mj_objectArrayWithKeyValuesArray:json];
    for (NSDictionary *dic in dicList) {
        CommandInfo *command = [CommandInfo commandWithDic:dic Key:[dic  objectForKey:@"name"]];
        
        [temp addObject:command];
    }

    self.drawCommandArray = temp;
}

- (void) startPlay{
    if (self.drawCommandArray==nil || self.drawCommandArray.count<1) {
        NSLog(@"数据不能为空");
        return;
    }
    
    CommandInfo *first = self.drawCommandArray.firstObject;
    CommandInfo *last = self.drawCommandArray.lastObject;

    if (![first.name isEqualToString:@"INIT"]) {
        NSLog(@"未找到开始命令");
        return;
    }
    
    if (![last.name isEqualToString:@"END"]) {
        NSLog(@"未找到结束命令");
        return;
    }

    [self commandInit:first];
    
    _commandIndex = 1;
    
    self.datePlayBegin = [[NSDate date] timeIntervalSince1970]*1000;
    self.dateInterval = last.time;
    [self.undoStack removeAllObjects];
    [self.redoStack removeAllObjects];
    
    self.commandSELMap = @{@"INIT":NSStringFromSelector(@selector(commandInit:)),
                           @"ADD":NSStringFromSelector(@selector(commandAdd:)),
                           @"RMV":NSStringFromSelector(@selector(commandUndo:)),
                           @"POP":NSStringFromSelector(@selector(commandRedo:)),
                           @"CLEAR":NSStringFromSelector(@selector(commandClear:)),
                           @"END":NSStringFromSelector(@selector(commandEnd:))
                           };
    
}

- (void) stopPlay{
     
}

- (void) updateStack:(long)interval{
    int count = (int)self.drawCommandArray.count;
    int index = _commandIndex;
    
    for (int i=index; i<count; i++) {
        CommandInfo *command = [self.drawCommandArray objectAtIndex:i];
        
        if ([command.name isEqualToString:@"ADD"]) {
            ADDCommandInfo *add = (ADDCommandInfo *)command;
            
            if (add.trace.endTime<interval) {
                _commandIndex++;
                [self commandAdd:command];
                
                self.redoStackTopInfo = nil;
                
            } else if (add.trace.beginTime<interval){
                
                self.redoStackTopInfo = [self copyFromCommand:add interval:interval];
            }
        
        } else if (command.time<interval){
            _commandIndex++;
            
            SEL sel = NSSelectorFromString([self.commandSELMap objectForKey:command.name]);
            [self performSelector:sel withObject:command];
        }
        
    }
    
}

#pragma mark - Command
- (void) commandRedo:(CommandInfo *)command{
    POPCommandInfo *pop = (POPCommandInfo *)command;
    ADDCommandInfo *add = (ADDCommandInfo *)[self undoStackContainsCommand:pop.identifier];
    if (add) {
        [self.undoStack removeObject:add];
        [self.redoStack addObject:add];
    }
    
}

- (void) commandUndo:(CommandInfo *)command{
    RMVCommandInfo *rmv = (RMVCommandInfo *)command;
    ADDCommandInfo *add = (ADDCommandInfo *)[self redoStackContainsCommand:rmv.identifier];
    if (add) {
        [self.redoStack removeObject:add];
        [self.undoStack addObject:add];
    }

}

- (void) commandAdd:(CommandInfo *)command{
    [self.redoStack addObject:command];
}

- (void) commandInit:(CommandInfo *)command{
    self.cofigInfo = (INITCommandInfo *)command;
}

- (void) commandClear:(CommandInfo *)command{
    [self.redoStack removeAllObjects];
}

- (void) commandEnd:(CommandInfo *)command{
    self.datePlayBegin = 0;
    self.dateInterval = 0;
    [self.undoStack removeAllObjects];
    [self.redoStack removeAllObjects];
    
    [self stopPlay];
}

#pragma mark - Pravite

- (CommandInfo *) undoStackContainsCommand:(long long)identifier{
    for (ADDCommandInfo *command in self.undoStack) {
        if (command.trace.identifier==identifier) {
            return command;
        }
    }
    return nil;
}

- (CommandInfo *) redoStackContainsCommand:(long long)identifier{
    for (ADDCommandInfo *command in self.redoStack) {
        if (command.trace.identifier==identifier) {
            return command;
        }
    }
    return nil;
}

- (ADDCommandInfo *) copyFromCommand:(ADDCommandInfo *)add interval:(long)interval{
    ADDCommandInfo *top = [[ADDCommandInfo alloc]init];
    top.time = add.time;
    
    ADDTraceCommandInfo *traceT = [[ADDTraceCommandInfo alloc]init];
    
    traceT.identifier = add.trace.identifier;
    traceT.beginTime = add.trace.beginTime;
    traceT.endTime = add.trace.endTime;
    traceT.penWidth = add.trace.penWidth;
    traceT.penColor = add.trace.penColor;
    traceT.pathType = add.trace.pathType;
    
    NSMutableArray *pointList = [NSMutableArray array];
    for (ADDTracePointCommandInfo *point in add.trace.tracePointList) {
        if (point.time<interval) {
            ADDTracePointCommandInfo *pointT = [[ADDTracePointCommandInfo alloc]init];
            pointT.time = point.time;
            pointT.x = point.x;
            pointT.y = point.y;
            
            [pointList addObject:pointT];
        }
    }
    
    traceT.tracePointList = pointList;
    
    top.trace = traceT;
    
    return top;
    
}

#pragma mark - Getter

- (NSMutableArray *) redoStack{
    if (!_redoStack) {
        _redoStack = [NSMutableArray array];
    }
    
    return _redoStack;
}

- (NSMutableArray *) undoStack{
    if (!_undoStack) {
        _undoStack = [NSMutableArray array];
    }
    
    return _undoStack;
}

@end
