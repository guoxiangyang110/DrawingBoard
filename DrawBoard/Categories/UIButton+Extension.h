//
//  UIButton+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import <UIKit/UIKit.h>

//block
typedef void(^buttonBlock)();

@interface UIButton (Extension)
- (void)setTitle:(NSString*)title;
- (void)setImage:(UIImage*)image;
- (void)setBackgroundImage:(UIImage*)image;
- (void)setTitleColor:(UIColor *)color;

- (void)setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
#pragma mark -
// with size (32, 32)
+ (instancetype)createBarButtonItem:(UIBarButtonItem **)item
                          withImage:(UIImage *)image
                             target:(id)target
                             action:(SEL)action;

+ (instancetype)createBarButtonItem:(UIBarButtonItem **)item
                     withButtonSize:(CGSize)size
                              image:(UIImage *)image
                             target:(id)target
                             action:(SEL)action;

#pragma mark - VerticallyLayout
- (void)centerVertically;
- (void)centerVerticallyWithPadding:(float)padding;


@end
