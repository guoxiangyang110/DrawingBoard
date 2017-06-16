//
//  NSArray+JSONString.h
//  yfd
//
//  Created by yye on 16/8/22.
//  Copyright © 2016年 yj.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JSONString)
- (NSString *)jsonStringWithPrettyPrint:(BOOL)prettyPrint;
@end
