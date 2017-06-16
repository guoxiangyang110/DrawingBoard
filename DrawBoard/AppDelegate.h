//
//  AppDelegate.h
//  DrawBoard
//
//  Created by 1696477589@qq.com on 2017/6/16.
//  Copyright © 2017年 com.yqj.guoxiangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

