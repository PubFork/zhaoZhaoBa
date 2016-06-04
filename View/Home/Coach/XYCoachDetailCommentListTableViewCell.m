//
//  XYCoachDetailCommentListTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCoachDetailCommentListTableViewCell.h"

@implementation XYCoachDetailCommentListTableViewCell

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
    
    [self.imageBtn setImageWithURL:[NSURL URLWithString:myData[community_userimg]] forState:UIControlStateNormal placeholder:kDefaultImage];
    self.nameLabel.text = myData[community_username];
    self.startView.scorePercent = [myData[community_praise_number] floatValue] / 5.0;
    self.contentLabel.text = myData[community_content];
    self.timeLabel.text = myData[community_time];
    
}

@end
