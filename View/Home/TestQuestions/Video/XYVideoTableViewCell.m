//
//  XYVideoTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYVideoTableViewCell.h"
#import "XYDownloadNetTool.h"

static NSInteger download_speed_view_width = 117;

@implementation XYVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization codes
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WeakSelf(weakSelf);
    
    [self.playImageView clickView:^(UIImageView *view) {
        XYDownloadModel * model = [XYDownloadModel downloadModelWithDic:weakSelf.myData];
        [model clickImageViewWithPlayBlock:nil suspendBlock:nil downloadBlock:nil finishBolick:nil];
    }];
}


- (void)setMyData:(NSMutableDictionary *)myData
{
    _myData = myData;
    
    XYDownloadModel * model = [XYDownloadModel downloadModelWithDic:myData];
    
    [self.videoImageView setImageWithURL:[NSURL URLWithString:myData[video_ev_cover]] placeholder:kDefaultImage];
    self.nameLabel.text = myData[video_ev_title];
    
    
    self.downloadLabel.text = model.downloadSpeed;
    
    self.downloadSpeedViewWidth.constant = isnan(model.speed) ? 0 : model.speed * download_speed_view_width;
    
    if (model.isFinish) {
        self.downloadLabel.text = @"完成";
        self.downloadSpeedViewWidth.constant = download_speed_view_width;
    }
    
    model.speedViewWidth = self.downloadSpeedViewWidth;
    model.label = self.downloadLabel;
    model.imageView = self.playImageView;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
