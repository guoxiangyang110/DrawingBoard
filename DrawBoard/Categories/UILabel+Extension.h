//
//  UILabel+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
- (void)adjust;
- (CGSize)boundingRectWithSize:(CGSize)size;
//计算文字frame
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
@end
