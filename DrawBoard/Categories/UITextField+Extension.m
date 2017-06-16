//
//  UITextField+Extension.m
//  iYJ
//
//  Created by 1696477589@qq.com on 16/8/22.
//  Copyright © 2016年 Welstone. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

// 禁用所有输入框功能按钮
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

// 可选择禁用部分功能
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    // 禁用粘贴功能
//    if (action == @selector(paste:))
//        return NO;
//    
//    // 禁用选择功能
//    if (action == @selector(select:))
//        return NO;
//    
//    // 禁用全选功能
//    if (action == @selector(selectAll:))
//        return NO;
//    
//    return [super canPerformAction:action withSender:sender];
//}

@end
