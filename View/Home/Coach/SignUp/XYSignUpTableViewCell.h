//
//  XYSinUpTableViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSignUpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;


@property (nonatomic, strong)NSDictionary * myData;
@end
