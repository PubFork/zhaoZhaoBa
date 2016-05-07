//
//  XYMyTableViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYMyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;


@property (nonatomic, strong)NSDictionary * myData;

@end
