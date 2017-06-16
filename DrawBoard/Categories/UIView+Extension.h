//
//  UIView+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kBackGrayAlpha 0.4
@interface UIView (Extension)

- (BOOL)findAndResignFirstResponder;
- (UIViewController *)viewController;
- (void)removeAllSubviews;
-(void)cornerMe;
-(void)cornerMeBy20;
- (instancetype)createFromNibFile;
- (void)grayMaskMe;
- (void)showInfo:(NSString *)infoString;

/**
 *  @brief  震动动画
 */
-(void)ShakeView;

/**
 *  给视图添加响应事件
 */
-(void)addClikTarget:(id)target action:(SEL)selecter;

/**
 *  获取UIView的UIViewController
 */
-(UIViewController *)getViewController;

@end
