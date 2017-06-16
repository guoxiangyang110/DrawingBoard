//
//  ReplayManager.h
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/9.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INITCommandInfo.h"
#import "ADDCommandInfo.h"
#import "CLEARCommandInfo.h"
#import "RMVCommandInfo.h"
#import "POPCommandInfo.h"
#import "ENDCommandInfo.h"

@interface ReplayManager : NSObject

@property (nonatomic, strong) NSMutableArray *drawCommandArray;
@property (nonatomic, strong) NSMutableArray *redoStack;
@property (nonatomic, strong) NSMutableArray *undoStack;
@property (nonatomic, strong) INITCommandInfo *cofigInfo;

@property (nonatomic, assign) long long datePlayBegin;
@property (nonatomic, assign) long long dateInterval;
@property (nonatomic, strong) ADDCommandInfo *redoStackTopInfo;

- (void) commandListFromJsonArray:(id)json;

- (void) startPlay;
- (void) stopPlay;
- (void) updateStack:(long)interval;

@end
