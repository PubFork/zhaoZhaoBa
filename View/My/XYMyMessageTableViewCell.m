//
//  XYMyMessageTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYMyMessageTableViewCell.h"

@implementation XYMyMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userImageView.layer.cornerRadius = 20;
    self.userImageView.layer.masksToBounds = YES;
    
}

- (void)reloadData
{
    NSDictionary * userInfo = [kUserD valueForKey:user_info_key];
    
    [self.userImageView setImageWithURL:[NSURL URLWithString:userInfo[user_info_au_img]] placeholder:kDefaultImage];
    self.nameLabel.text = userInfo[user_info_au_name];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
