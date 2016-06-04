//
//  XYCoachCollectionViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCoachCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coachDetail;

@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *unPraisaBtn;


@property (nonatomic, strong)NSDictionary * myData;
@end
