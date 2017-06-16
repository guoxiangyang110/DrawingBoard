//
//  UIColor+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 KKStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
+ (UIColor *)colorWithHexColorString:(NSString *)string;
+ (int) colorInt10WithHexColorString:(NSString *)string;
+ (NSString *) colorHexStringWithInt10:(int) num;

@end
