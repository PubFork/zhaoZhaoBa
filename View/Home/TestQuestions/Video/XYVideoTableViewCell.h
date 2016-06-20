//
//  XYVideoTableViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYAddActionImageView.h"

@interface XYVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;
@property (weak, nonatomic) IBOutlet UIView *downloadSpeedView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downloadSpeedViewWidth;

@property (weak, nonatomic) IBOutlet XYAddActionImageView *playImageView;


@property (nonatomic, strong)NSMutableDictionary * myData;

@end
