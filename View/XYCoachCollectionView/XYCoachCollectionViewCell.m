//
//  XYCoachCollectionViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCoachCollectionViewCell.h"

@implementation XYCoachCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData.copy;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:myData[coach_c_img]] placeholder:kDefaultImage];
    self.nameLabel.text = myData[coach_c_name];
    self.coachDetail.text = myData[coach_c_type];
    [self.praiseBtn setTitle:[kManager getStringWithObj:myData[coach_like]] forState:UIControlStateNormal];
    [self.unPraisaBtn setTitle:[kManager getStringWithObj:myData[coach_unlike]] forState:UIControlStateNormal];
    
}

@end
