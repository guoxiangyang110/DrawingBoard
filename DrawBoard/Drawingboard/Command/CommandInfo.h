//
//  CommandInfo.h
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/8.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface CommandInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) long long time;

+ (instancetype) commandWithDic:(NSDictionary *)dic Key:(NSString *)key;

@end
