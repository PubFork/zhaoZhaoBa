//
//  XYShareGetMoneyShareTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYShareGetMoneyShareTableViewCell.h"

@implementation XYShareGetMoneyShareTableViewCell

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
    
    self.myImageView.image = kImage(myData[my_shareGetMoney_vc_shareCell_image]);
    self.titleLabel.text = myData[my_shareGetMoney_vc_shareCell_title];
}

@end
