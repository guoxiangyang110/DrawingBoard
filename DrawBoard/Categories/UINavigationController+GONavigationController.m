//
//  UINavigationController+GONavigationController.m
//  yfd
//
//  Created by yye on 16/11/11.
//  Copyright © 2016年 yj.com. All rights reserved.
//

#import "UINavigationController+GONavigationController.h"

@implementation UINavigationController (GONavigationController)
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock{
    if (!lock || self.topViewController == lock)
    {
        [self pushViewController:viewController animated:animated];
    }
}
- (id)navigationlock
{
    return self.topViewController;
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock{
    if (!lock || self.topViewController == lock)
    {
        [self popToViewController:viewController animated:animated];
    }
    return @[];
}
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)lock
{
    if (!lock || self.topViewController == lock)
    {
        [self popToRootViewControllerAnimated:animated];
    }
    return @[];
}
@end
