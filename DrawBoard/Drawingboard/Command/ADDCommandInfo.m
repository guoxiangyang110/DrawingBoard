//
//  ADDCommandInfo.m
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/8.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import "ADDCommandInfo.h"

@implementation ADDCommandInfo
- (instancetype) init{
    if (self = [super init]) {
        self.name = @"ADD";
    }
    return self;
}

@end


@implementation ADDTraceCommandInfo

// 这个方法对比上面的其他方法更加没有侵入性和污染，因为不需要导入Status和Ad的头文件
+ (NSDictionary *)objectClassInArray{
    return @{
             @"tracePointList" : @"ADDTracePointCommandInfo",
             };
}

@end


@implementation ADDTracePointCommandInfo

@end
