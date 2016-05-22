//
//  XYCoachDetailCommentListTableViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@interface XYCoachDetailCommentListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet CWStarRateView *startView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeight;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
