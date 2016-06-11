//
//  XYCommunityTableViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPictureView.h"

typedef void(^clickPraiseBtnBlock)(id communityID);
typedef void(^clickCommunityBtnBlock)(id communityID);


@interface XYCommunityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@property (weak, nonatomic) IBOutlet XYPictureView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *driverSchoolLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *communityBtn;

@property (nonatomic, assign)CommunityStyle style;
@property (nonatomic, strong)NSDictionary * myData;


@property (nonatomic, copy)clickPraiseBtnBlock clickPraiseBtnBlock;
- (void)clickPraiseBtnWithBlock:(clickPraiseBtnBlock)block;

@property (nonatomic, copy)clickCommunityBtnBlock clickCommunityBtnBlock;
- (void)clickCommunityBtnWithBlock:(clickCommunityBtnBlock)block;
@end
