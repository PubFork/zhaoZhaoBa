//
//  XYCommunityDetailTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCommunityDetailTableViewCell.h"

@implementation XYCommunityDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
