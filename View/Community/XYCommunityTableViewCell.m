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
