//
//  XYCommunityTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCommunityTableViewCell.h"

@implementation XYCommunityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)clickPraiseBtnWithBlock:(clickPraiseBtnBlock)block
{
    self.clickPraiseBtnBlock = block;
}

- (void)clickCommunityBtnWithBlock:(clickCommunityBtnBlock)block
{
    self.clickCommunityBtnBlock = block;
}


- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    [self.userImageView setImageWithURL:[NSURL URLWithString:myData[community_userimg]] forState:UIControlStateNormal placeholder:kDefaultImage];
    self.nameLabel.text = myData[community_username];
    self.timeLabel.text = myData[community_time];
    self.contentLabel.text = myData[community_content];
    self.driverSchoolLabel.text = myData[driverSchool_schoolname];
    
    NSString * praise = [kManager getStringWithObj:myData[community_praise_number]];
    if (praise.integerValue > 999) {
        praise = @"999+";
    }
    [self.praiseBtn setTitle:praise forState:UIControlStateNormal];
    
    praise = [kManager getStringWithObj:myData[community_replynumber]];
    if (praise.integerValue > 999) {
        praise = @"999+";
    }
    
    [self.communityBtn setTitle:praise forState:UIControlStateNormal];
}

- (IBAction)clickPraiseBtn:(id)sender {
    
    self.clickPraiseBtnBlock ? self.clickPraiseBtnBlock() : 0;
}
- (IBAction)clickCommityBtn:(id)sender {
    self.clickCommunityBtnBlock ? self.clickCommunityBtnBlock() : 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
