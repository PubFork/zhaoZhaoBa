//
//  XYNearDriverSchoolViewController.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSelectViewController.h"

/**
 *  驾校类型
 */
typedef NS_ENUM(NSInteger, driverSchoolType) {
    /**
     *  附近驾校
     */
    driverSchoolType_Near   = 0x01,
    /**
     *  驾校好评
     */
    driverSchoolType_Praise = 0x11,
    
};


@interface XYDriverSchoolViewController : XYSelectViewController
@property (nonatomic, assign)driverSchoolType type;
@end
