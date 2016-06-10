//
//  XYShoppingCollectionViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYShoppingCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shoppingImageView;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;


@property (nonatomic, strong)NSDictionary * myData;
@end
