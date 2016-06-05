//
//  XYNoviceOfRoadTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNoviceOfRoadTableViewCell.h"

@implementation XYNoviceOfRoadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    self.titleLabel.text = myData[novice_of_road_nr_Title];
    [self.myImageView setImageWithURL:[NSURL URLWithString:myData[novice_of_road_nr_img]] placeholder:kDefaultImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
