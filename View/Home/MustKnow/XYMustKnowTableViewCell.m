//
//  XYMustKnowTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYMustKnowTableViewCell.h"

@implementation XYMustKnowTableViewCell

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
    NSLog(@" -- %@",myData);
    
    self.titleLabel.text = myData[mustKown_mk_Title];
    [self.myImageView setImageWithURL:[NSURL URLWithString:[myData[mustKnow_mk_img] stringByReplacingOccurrencesOfString:@" " withString:@""]] placeholder:kDefaultImage];
}

@end
