//
//  UITabBar+badge.h
//  iYJ
//
//  Created by 1696477589@qq.com on 16/3/2.
//  Copyright © 2016年 Welstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
