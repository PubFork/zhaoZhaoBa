//
//  XYCommunityDetailTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCommunityDetailTableViewCell.h"

static NSInteger content_left_default = 8;
static NSInteger content_left_list = 56;

@implementation XYCommunityDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    self.contentLabelLeft.constant = self.communtiyBtn.hidden ? content_left_list : content_left_default;
    
    
    
    self.contentLabel.text = myData[community_content];
    self.nameLabel.text = myData[community_username];
    [self.userImageView setImageWithURL:[NSURL URLWithString:myData[community_userimg]] forState:UIControlStateNormal placeholder:kDefaultImage];
    self.timeLabel.text = myData[community_time];
//    [self.communtiyBtn setTitle:[kManager getStringWithObj:myData[community_praise_number]] forState:UIControlStateNormal];
    
}

- (void)clickCommunityBtnWithBlock:(clickCommunityBtnBlock)block
{
    self.clickCommunityBtnBlock = block;
}

- (IBAction)clickCommuntiyBtn:(id)sender {
    self.clickCommunityBtnBlock ? self.clickCommunityBtnBlock() : 0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
