//
//  XYCarShowTableViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCarShowTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *carName;


@property (nonatomic, strong)NSDictionary * myData;
@end
