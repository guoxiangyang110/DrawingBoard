//
//  UIView+Extension.m
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import "UIView+Extension.h"
//#import "KKKHelper.h"

@implementation UIView (Extension)

- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView findAndResignFirstResponder])
            return YES;
    }
    return NO;
}

#pragma mark -

- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController *)viewController {
    /// Finds the view's view controller.
    
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    
    // If the view controller isn't found, return nil.
    return nil;
}



-(void)cornerMe{
    UIBezierPath *maskPath=  [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    self.layer.masksToBounds=YES;
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}



-(void)cornerMeBy20{
    UIBezierPath *maskPath=  [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    self.layer.masksToBounds=YES;
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (instancetype)createFromNibFile {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)grayMaskMe{
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
}

- (void)showInfo:(NSString *)infoString{
   // UIViewController *vc = [self viewController];
    
    
    /*
    [KKKHelper showToViewController:vc withTitle:@"提示" andInfo:infoString];
    
    */
    
}


/**
 *  @brief  震动动画
 */
-(void)ShakeView
{
    self.translatesAutoresizingMaskIntoConstraints = YES;
    CALayer *lbl = [self layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.04];
    [animation setRepeatCount:6];
    [lbl addAnimation:animation forKey:nil];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

/**
 *  给视图添加响应事件
 */
-(void)addClikTarget:(id)target action:(SEL)selecter
{
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:selecter];
      [self addGestureRecognizer:tap];
}

/**
 *  获取UIView的UIViewController
 */
- (UIViewController*)getViewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    
    return nil;
}
@end
