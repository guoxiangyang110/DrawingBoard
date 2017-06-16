//
//  INITCommandInfo.h
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/8.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import "CommandInfo.h"
@class INITConfigCommandInfo;

@interface INITCommandInfo : CommandInfo

@property (nonatomic, strong) INITConfigCommandInfo *config;

@end



@interface INITConfigCommandInfo : NSObject

@property (nonatomic, assign) double page_width;
@property (nonatomic, assign) double page_height;
@property (nonatomic, copy) NSString *voice_path;

@end
