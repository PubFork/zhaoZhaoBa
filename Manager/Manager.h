//
//  Manager.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject

+ (Manager *)shareManager;

- (void)createAlertOnceSureWithMessage:(NSString *)message title:(NSString *)title;
@end
