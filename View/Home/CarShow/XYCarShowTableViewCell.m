//
//  XYCarShowTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCarShowTableViewCell.h"

@implementation XYCarShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    [self.carImageView setImageWithURL:[NSURL URLWithString:myData[car_show_logo]] placeholder:kDefaultImage];
    self.carName.text = myData[car_show_typename];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
