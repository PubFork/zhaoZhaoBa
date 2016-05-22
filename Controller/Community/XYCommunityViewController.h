//
//  XYCommunityViewController.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYRootViewController.h"


/**
 *  评论类型
 */
typedef NS_ENUM(NSInteger, CommunityStyle) {
    /**
     *  社区汇
     */
    CommunityStyle_Default = 0,
    /**
     *  驾校
     */
    CommunityStyle_DriverSchool = 1,
};

@interface XYCommunityViewController : XYRootViewController
+ (XYCommunityViewController *)shareCommunityViewController;

@property (nonatomic, assign)CommunityStyle style;
@end
