//
//  CommandInfo.m
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/8.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import "CommandInfo.h"
#import "ADDCommandInfo.h"
#import "INITCommandInfo.h"
#import "CLEARCommandInfo.h"
#import "RMVCommandInfo.h"
#import "POPCommandInfo.h"
#import "ENDCommandInfo.h"

@implementation CommandInfo

+ (instancetype) commandWithDic:(NSDictionary *)dic Key:(NSString *)key{

    NSDictionary *dicT = @{@"INIT":@"INITCommandInfo",
                           @"ADD":@"ADDCommandInfo",
                           @"RMV":@"RMVCommandInfo",
                           @"POP":@"POPCommandInfo",
                           @"CLEAR":@"CLEARCommandInfo",
                           @"END":@"ENDCommandInfo",
                           };
    
    Class cla = NSClassFromString([dicT objectForKey:key]);
    CommandInfo *instance = [[cla alloc]init];
    [instance mj_setKeyValues:dic];
    
    return instance;
}

@end
