//
//  Manager.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Manager.h"

@implementation Manager

+ (Manager *)shareManager
{
    static Manager * manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[Manager alloc] init];
    });
    return manger;
}

- (void)createAlertOnceSureWithMessage:(NSString *)message title:(NSString *)title
{
    if (!title) {
        title = @"提示";
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}
@end
