//
//  XYCommunityDetailTableViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickCommunityBtnBlock)();


@interface XYCommunityDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *communtiyBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelLeft;

@property (nonatomic, strong)NSDictionary * myData;

@property (nonatomic, copy)clickCommunityBtnBlock clickCommunityBtnBlock;
- (void)clickCommunityBtnWithBlock:(clickCommunityBtnBlock)block;
@end
