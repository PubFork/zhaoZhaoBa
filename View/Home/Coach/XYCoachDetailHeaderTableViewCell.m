//
//  XYCoachDetailHeaderTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCoachDetailHeaderTableViewCell.h"

@implementation XYCoachDetailHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    [self.imageBtn setImageWithURL:[NSURL URLWithString:myData[coach_c_img]] forState:UIControlStateNormal placeholder:kDefaultImage];
    self.nameLbale.text = myData[coach_c_name];
    self.phoneLabel.text = myData[coach_c_phone];
    self.contentLabel.text = myData[coach_c_profile];
}

@end
