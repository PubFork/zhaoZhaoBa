//
//  XYCommunityDetailTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCommunityDetailTableViewCell.h"

static NSInteger content_left_default = 0;
static NSInteger content_left_list = 48;

@implementation XYCommunityDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    self.contentLabelLeft.constant = !self.communtiyBtn.hidden ? content_left_list : content_left_default;
    
    if (self.communtiyBtn.hidden) {
        self.contentLabel.text = myData[community_content];
        self.nameLabel.text = myData[community_username];
        [self.userImageView setImageWithURL:[NSURL URLWithString:myData[community_userimg]] forState:UIControlStateNormal placeholder:kDefaultImage];
        self.timeLabel.text = myData[community_time];
        return;
    }
    
    NSString * bei_reply = myData[community_reply_bereplyusername];
    
    if (bei_reply) {
        
        NSString * string = [NSString stringWithFormat:@"回复%@:%@",bei_reply,myData[community_reply_replycontent]];
        
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:string];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:attString.rangeOfAll];
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, bei_reply.length + 3)];
        self.contentLabel.attributedText = attString;
    } else {
        self.contentLabel.text = myData[community_reply_replycontent];

    }
    
    
    
    self.nameLabel.text = myData[community_reply_replyusername];
    [self.userImageView setImageWithURL:[NSURL URLWithString:myData[community_reply_replyuserimg]] forState:UIControlStateNormal placeholder:kDefaultImage];
    self.timeLabel.text = myData[community_reply_replytime];

}

- (void)clickCommunityBtnWithBlock:(clickCommunityBtnBlock)block
{
    self.clickCommunityBtnBlock = block;
}

- (IBAction)clickCommuntiyBtn:(id)sender {
    self.clickCommunityBtnBlock ? self.clickCommunityBtnBlock(self.myData[community_reply_replyuserid]) : 0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
