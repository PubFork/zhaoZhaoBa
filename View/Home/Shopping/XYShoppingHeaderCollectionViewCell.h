//
//  XYShoppingHeaderCollectionViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYAddActionView.h"
@interface XYShoppingHeaderCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet XYAddActionView *integralView;
@property (weak, nonatomic) IBOutlet XYAddActionView *exchangeRecordView;

@property (weak, nonatomic) IBOutlet XYAddActionView *integralRuleView;
@end
