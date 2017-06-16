//
//  UIDevice+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScreen+Extension.h"

#define SystemVersionIs(v)           ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] == NSOrderedSame)
#define SystemVersionAbove(v)        ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] == NSOrderedDescending)
#define SystemVersionAboveOrIs(v)    ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)
#define SystemVersionBelow(v)        ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] == NSOrderedAscending)
#define SystemVersionBelowOrIs(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define kIsiOS7 SystemVersionIs(@"7.0")
#define kIsiOS7OrLater SystemVersionAboveOrIs(@"7.0")
#define kIsiOS8 kSystemVersionIs(@"8.0")
#define kIsiOS8OrLater SystemVersionAboveOrIs(@"8.0")

#define kIsiPhone4AndBelow          (kScreenHeight <= 480)
#define kIsiPhone5                   (kScreenHeight == 568)
#define kIsiPhone6                   (kScreenHeight == 667)
#define kIsiPhone6Plus      (kScreenHeight >= 736)

#define ua  [NSString stringWithFormat:@"%@,%@,%@ %@,%@,IMSI",[HttpRequestManager GetVersionCode],[[UIDevice currentDevice] model],[[UIDevice currentDevice]systemName],[[UIDevice currentDevice]systemVersion],[[[UIDevice currentDevice]identifierForVendor]UUIDString]]

@interface UIDevice (Extension)

+ (NSString*)deviceString;
+ (BOOL)isPhone4;
@end
