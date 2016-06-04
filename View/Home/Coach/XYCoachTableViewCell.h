//
//  XYCoachTableViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCoachTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coach_imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *unPraiseBtn;
@property (weak, nonatomic) IBOutlet UILabel *coachHistory;
@property (weak, nonatomic) IBOutlet UILabel *passPro;
@property (weak, nonatomic) IBOutlet UIButton *distanceBtn;


@property (nonatomic, strong)NSDictionary * myData;

@end
