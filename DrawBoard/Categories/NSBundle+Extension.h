//
//  NSBundle+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MainBundle [NSBundle mainBundle]
#define kAPPDisplayName                            [MainBundle \
objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define kAppBundleIdentifier                       [MainBundle \
objectForInfoDictionaryKey:@"CFBundleIdentifier"]
#define kAppReleaseVersionNumber                   [HttpRequestManager GetVersionCode]
#define kAppBuildVersionNumber                     [MainBundle objectForInfoDictionaryKey:@"CFBundleVersion"]

@interface NSBundle (Extension)

@end
