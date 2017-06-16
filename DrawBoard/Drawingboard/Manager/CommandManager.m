//
//  CommandManager.m
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/9.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import "CommandManager.h"
#import "INITCommandInfo.h"
#import "ADDCommandInfo.h"
#import "RMVCommandInfo.h"
#import "POPCommandInfo.h"
#import "CLEARCommandInfo.h"
#import "ENDCommandInfo.h"
#import "UIColor+Extension.h"

@interface CommandManager ()

@property (nonatomic, assign) BOOL isRecording;
@end

@implementation CommandManager

- (void) startRecord{
    [self.drawCommandArray removeAllObjects];
    
    self.dateRecordBegin = [[NSDate date]timeIntervalSince1970]*1000;
    
    
    [self commandInit];

}

- (void) stopRecord{
    
    [self commandEnd];
    
    [self jsonFromCommandList:self.drawCommandArray];
}


- (void) commandRedoWithId:(long long)identifier time:(long)time{
    POPCommandInfo *command = [[POPCommandInfo alloc]init];
    command.identifier = identifier;
    command.time = time;
    
    [self addCommand:command];
}

- (void) commandUndoWithId:(long long)identifier time:(long)time{
    RMVCommandInfo * command = [[RMVCommandInfo alloc]init];
    command.identifier = identifier;
    command.time = time;
    
    [self addCommand:command];

}

- (void) commandAddWithPath:(DrawPath *)path{
    ADDCommandInfo *command = [[ADDCommandInfo alloc]init];
    command.time = [[NSDate date]timeIntervalSince1970]*1000-self.dateRecordBegin;
    
    ADDTraceCommandInfo *trace = [[ADDTraceCommandInfo alloc]init];
    long long begin = ((DrawPath *)path.vertexList.firstObject).date;
    
    trace.identifier = path.identifier;
    trace.beginTime = begin;
    trace.endTime = path.date;
    trace.penWidth = path.lineWidth;
    trace.penColor = [UIColor colorInt10WithHexColorString:path.drawColor];
    
    NSMutableArray *tracePointList = [NSMutableArray array];
    
    for (DrawPath *subP in path.vertexList) {
        ADDTracePointCommandInfo *tracePoint = [[ADDTracePointCommandInfo  alloc]init];
        tracePoint.time = subP.date;
        tracePoint.x = subP.x;
        tracePoint.y = subP.y;
        
        [tracePointList addObject:tracePoint];

    }
    
    trace.tracePointList = tracePointList;
    
    command.trace = trace;
    
    [self addCommand:command];

}

- (void) commandInit{
    
    INITCommandInfo *command = [[INITCommandInfo alloc]init];
    command.time = [[NSDate date]timeIntervalSince1970]*1000-self.dateRecordBegin;
    
    INITConfigCommandInfo *config = [[INITConfigCommandInfo alloc]init];
    config.page_width = [[UIScreen mainScreen]bounds].size.width;
    config.page_height = [[UIScreen mainScreen]bounds].size.height-64;
    config.voice_path = self.recordAideoPath;
    
    command.config = config;
    
    [self addCommand:command];
    
}

- (void) commandClear{
    CLEARCommandInfo *command = [[CLEARCommandInfo alloc]init];
    command.time = [[NSDate date]timeIntervalSince1970]*1000-self.dateRecordBegin;
    
    [self addCommand:command];
}

- (void) commandEnd{
    ENDCommandInfo *command = [[ENDCommandInfo alloc]init];
    command.time = [[NSDate date]timeIntervalSince1970]*1000-self.dateRecordBegin;

    [self addCommand:command];
}

- (void) addCommand:(CommandInfo *)command{
    [self.drawCommandArray addObject:command];
    
}

- (NSString *) jsonFromCommandList:(NSArray *)commandList{
    
    NSMutableArray *arr =  [NSMutableArray mj_keyValuesArrayWithObjectArray:self.drawCommandArray];
    NSString *json = [arr mj_JSONString];
    
    return json;
}
#pragma mark - Getter

- (NSMutableArray *) drawCommandArray{
    if (!_drawCommandArray) {
        _drawCommandArray = [NSMutableArray array];
    }
    
    return _drawCommandArray;
}

@end
