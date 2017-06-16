//
//  UIAlertController+SupportedInterfaceOrientations.m
//  yfd
//
//  Created by yye on 16/8/4.
//  Copyright © 2016年 yj.com. All rights reserved.
//

#import "UIAlertController+SupportedInterfaceOrientations.h"

@implementation UIAlertController (SupportedInterfaceOrientations)
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations; {
    return UIInterfaceOrientationMaskPortrait;
}
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
#endif
@end
