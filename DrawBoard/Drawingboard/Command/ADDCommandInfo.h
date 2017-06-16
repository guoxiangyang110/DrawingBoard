//
//  ADDCommandInfo.h
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/8.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import "CommandInfo.h"
#import <UIKit/UIKit.h>

@class ADDTraceCommandInfo;
@class ADDTracePointCommandInfo;

@interface ADDCommandInfo : CommandInfo

@property (nonatomic, strong) ADDTraceCommandInfo *trace;

@end


@interface ADDTraceCommandInfo : NSObject

@property (nonatomic, assign) long long identifier;
@property (nonatomic, assign) long long beginTime;
@property (nonatomic, assign) long long endTime;
@property (nonatomic, assign) double penWidth;
@property (nonatomic, assign) int penColor;
@property (nonatomic, assign) int pathType;

@property (nonatomic, strong) NSMutableArray *tracePointList;


@end


@interface ADDTracePointCommandInfo : NSObject

@property (nonatomic, assign) long time;
@property (nonatomic, assign) double x;
@property (nonatomic, assign) double y;

@end
