//
//  Command.h
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/8.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Command : NSObject

@property (nonatomic, strong) NSArray *infoList;

- (void) execute;
- (void) undo;
@end
