//
//  XYTestQuestionsCollectionViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYTestQuestionsCollectionViewCell.h"

@implementation XYTestQuestionsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    [Manager setImageWithImageUrl:myData[video_ev_cover] imageView:self.imageView];
    self.nameLabel.text = myData[video_ev_title];
    
    self.myLabel.hidden = ![myData[video_ev_exclphotos] boolValue];
}
@end
