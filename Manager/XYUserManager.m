//
//  XYUserManager.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYUserManager.h"

@implementation XYUserManager
+ (XYUserManager *)shareUserManager
{
    static XYUserManager * userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [XYUserManager modelWithDictionary:[kUserD valueForKey:user_info_key]];
    });
    return userManager;
}

- (BOOL)userIsSign
{
    return [kUserD boolForKey:ns_user_detault_user_is_sign];
}

@end
