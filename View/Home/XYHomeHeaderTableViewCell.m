//
//  XYHomeHeaderTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYHomeHeaderTableViewCell.h"

@implementation XYHomeHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.carousePicture = [[XYCarousePicture alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    [self.contentView addSubview:self.carousePicture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
