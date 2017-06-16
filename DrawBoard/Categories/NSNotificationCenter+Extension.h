//
//  NSNotificationCenter+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kNotificationAdd(anObserver, aSEL, noteName, anObj)    [[NSNotificationCenter defaultCenter] \
addObserver:(anObserver) \
selector:(aSEL) \
name:(noteName) \
object:(anObj)]

#define kNotificationRemove(anObserver, notifName, anObj)      [[NSNotificationCenter defaultCenter] \
removeObserver:(anObserver) \
name:(notifName) object:(anObj)]

#define kNotificationRemoveObserver(anObserver)				[[NSNotificationCenter defaultCenter] \
removeObserver:(anObserver)]

#define kNotificationPost(notifName, anObj, anUserInfo)		[[NSNotificationCenter defaultCenter] \
postNotificationName:(notifName) \
object:(anObj) \
userInfo:(anUserInfo)]

#define kNotificationPostOnMainThread(notifName, anObj, anUserInfo) dispatch_async(dispatch_get_main_queue(), ^(void){\
[[NSNotificationCenter defaultCenter] \
postNotificationName:(notifName) \
object:(anObj) \
userInfo:(anUserInfo)];\
});\

@interface NSNotificationCenter (Extension)

@end
