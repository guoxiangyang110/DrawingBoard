//
//  UINavigationController+GONavigationController.h
//  yfd
//
//  Created by yye on 16/11/11.
//  Copyright © 2016年 yj.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (GONavigationController)
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock;

- (id)navigationlock;

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock;

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)lock;
@end
