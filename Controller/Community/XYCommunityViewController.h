//
//  XYCommunityViewController.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYRootViewController.h"




@interface XYCommunityViewController : XYRootViewController
+ (XYCommunityViewController *)shareCommunityViewController;

@property (nonatomic, strong)NSNumber * dsID;
@property (nonatomic, strong)NSNumber * coachID;

@property (nonatomic, assign)CommunityStyle style;
@end
