//
//  CommandManager.h
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/9.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DrawPath.h"

typedef void (^ToMP3FinishedBlock)();

@interface CommandManager : NSObject

@property (nonatomic, strong) NSMutableArray *drawCommandArray;
@property (nonatomic, assign) long long dateRecordBegin;
@property (nonatomic, copy) NSString *recordAideoPath;
@property (nonatomic, copy) ToMP3FinishedBlock toMP3FinishedBlock;

//- (void) commandInit;
- (void) commandAddWithPath:(DrawPath *)path;
- (void) commandRedoWithId:(long long)identifier time:(long)time;
- (void) commandUndoWithId:(long long)identifier time:(long)time;
- (void) commandClear;
//- (void) commandEnd;


- (void) startRecord;
- (void) stopRecord;
- (NSString *) jsonFromCommandList:(NSArray *)commandList;

@end
