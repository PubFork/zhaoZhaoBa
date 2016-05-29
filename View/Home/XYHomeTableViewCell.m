//
//  XYHomeTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYHomeTableViewCell.h"

@implementation XYHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    self.nameLaebl.text = myData[driverSchool_schoolname];
    [self.pictureImageView setImageWithURL:[NSURL URLWithString:[myData[driverSchool_school_logo] stringByReplacingOccurrencesOfString:@" " withString:@""]] placeholder:kDefaultImage];
    
    self.priceLabel.text = [kManager getStringWithObj:myData[driverSchool_school_fee]];
    self.numberLabel.text = [kManager getStringAddNumberWithObj:myData[driverSchool_school_number]];
    self.distanceLabel.text = [kManager getStringAddKMWithObj:myData[driverSchool_school_distance]];
    
    self.startRateView.scorePercent = [myData[driverScholl_school_str] floatValue] / 5.0;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
