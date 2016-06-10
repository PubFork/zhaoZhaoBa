//
//  XYAddCommunityViewController.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYRootViewController.h"


/**
 *  发帖子
 */
typedef NS_ENUM(NSInteger, AddCommunityType) {
    /**
     *  发布帖子
     */
    AddCommunityType_Release = 0x01,
    /**
     *  回复帖子
     */
    AddCommunityType_Reply = 0x11,
};

@interface XYAddCommunityViewController : XYRootViewController
@property (nonatomic, assign)AddCommunityType type;

@property (nonatomic, assign)CommunityStyle style;


@property (nonatomic, strong)id communityID;
@property (nonatomic, strong)id repleUserID;

@end
