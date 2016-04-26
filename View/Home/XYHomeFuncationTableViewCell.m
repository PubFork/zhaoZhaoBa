//
//  XYHomeFuncationTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYHomeFuncationTableViewCell.h"

@implementation XYHomeFuncationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (int i = 0 ; i < 8 ; i ++) {
        UIView * view = [self.contentView viewWithTag:1000 + i];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
            self.clickFuncationCell ? self.clickFuncationCell(self,[sender view].tag - 1000) : 0 ;
        }]];
    }
}

- (void)clickFuncationCell:(void (^)(XYHomeFuncationTableViewCell *, NSInteger))clickFuncationCell
{
    self.clickFuncationCell = clickFuncationCell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
