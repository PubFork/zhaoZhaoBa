//
//  XYCarShowOneTypeTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCarShowOneTypeTableViewCell.h"

@implementation XYCarShowOneTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    [self.carImageView setImageWithURL:[NSURL URLWithString:myData[car_show_type_list_carimg]] placeholder:kDefaultImage];
    self.nameLbael.text = myData[car_show_type_list_cartitle];
    self.priceLabel.text = myData[car_show_type_list_pricerange];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
