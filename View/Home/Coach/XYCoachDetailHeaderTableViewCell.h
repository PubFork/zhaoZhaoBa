//
//  XYCoachDetailHeaderTableViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCoachDetailHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLbale;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelWidth;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeight;

@end
