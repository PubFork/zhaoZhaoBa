//
//  XYShoppingCollectionViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYShoppingCollectionViewCell.h"

@implementation XYShoppingCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    self.titleLabel.text = myData[shopping_sm_title];
    self.detailLabel.text = myData[shopping_sm_brief];
    [self.priceBtn setTitle:[kManager getStringWithObj:myData[shopping_sm_price]] forState:UIControlStateNormal];
    [self.shoppingImageView setImageWithURL:[NSURL URLWithString:myData[shopping_sm_img]] placeholder:kDefaultImage];
}

@end
