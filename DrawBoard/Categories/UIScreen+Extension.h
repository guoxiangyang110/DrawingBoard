//
//  UIScreen+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Extension)
#define kScreenWidth                       (CGRectGetWidth([[UIScreen mainScreen] bounds]))
#define kScreenHeight                      (CGRectGetHeight([[UIScreen mainScreen] bounds]))
#define kScreenScale  [[UIScreen mainScreen] scale]
#define kNavigationBarHeight 44
#define kStatusBarHeight 20
@end
