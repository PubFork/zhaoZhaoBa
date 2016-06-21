//
//  XYUserManager.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYUserManager : NSObject

+ (XYUserManager *)shareUserManager;
- (BOOL)userIsSign;
@end
