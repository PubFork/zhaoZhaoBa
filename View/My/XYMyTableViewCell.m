//
//  XYMyTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYMyTableViewCell.h"

@implementation XYMyTableViewCell

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
    
    self.myImageView.image = kImage(myData[my_vc_custom_imageUrl]);
    self.titleLabel.text = myData[my_vc_custom_title];
    
    if (myData[my_vc_custom_prompt]) {
        self.promptLabel.hidden = NO;
        self.promptLabel.text = myData[my_vc_custom_prompt];
    } else {
        self.promptLabel.hidden = YES;
    }
}


@end
