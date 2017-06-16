//
//  UIButton+Extension.m
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
- (void)setTitle:(NSString *)title
{
    if (title)
    {
        NSString* newTitle = NSLocalizedString(title, nil);
        [self setTitle:newTitle forState:UIControlStateNormal];
        [self setTitle:newTitle forState:UIControlStateHighlighted];
        [self setTitle:newTitle forState:UIControlStateSelected];
        [self setTitle:newTitle forState:UIControlStateDisabled];
    }
}

- (void)setImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateHighlighted];
    [self setImage:image forState:UIControlStateSelected];
    [self setImage:image forState:UIControlStateDisabled];
}

- (void)setBackgroundImage:(UIImage *)image
{
    if (image)
    {
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
        [self setBackgroundImage:image forState:UIControlStateSelected];
        [self setBackgroundImage:image forState:UIControlStateDisabled];
    }
}

-(void)setTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateSelected];
    [self setTitleColor:color forState:UIControlStateDisabled];
}
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    //    CGSize titleSize = [title sizeWithFont:HELVETICANEUEMEDIUM_FONT(12.0f)];
    NSDictionary *attribute = @{NSFontAttributeName: self.titleLabel.font};
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(320,2000) options:NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size ;
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(30.0,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}

+ (instancetype)createBarButtonItem:(UIBarButtonItem **)item
                          withImage:(UIImage *)image
                             target:(id)target
                             action:(SEL)action
{
    return [self createBarButtonItem:item
                      withButtonSize:CGSizeMake(32, 32)
                               image:image
                              target:target
                              action:action];
}

///
+ (instancetype)createBarButtonItem:(UIBarButtonItem **)item
                     withButtonSize:(CGSize)size
                              image:(UIImage *)image
                             target:(id)target
                             action:(SEL)action {
    
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    if (image != nil) {
        button.imageView.layer.cornerRadius = size.width/2;
        button.imageView.layer.masksToBounds = YES;
        [button setImage:image forState:UIControlStateNormal];
    }
    
    if (item) {
        *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    return button;
}


#pragma mark - VerticallyLayout
- (void)centerVertically {
    const CGFloat kDefaultPadding = 6.0f;
    [self centerVerticallyWithPadding:kDefaultPadding];
}

- (void)centerVerticallyWithPadding:(float)padding {
    CGSize imageSize = CGSizeMake(CGRectGetWidth(self.imageView.bounds),
                                  CGRectGetHeight(self.imageView.bounds));
    CGSize titleSize = CGSizeMake(CGRectGetWidth(self.titleLabel.bounds),
                                  CGRectGetHeight(self.titleLabel.bounds));
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                            0.0f,
                                            0.0f,
                                            - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            - imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0f);
    
}


@end
