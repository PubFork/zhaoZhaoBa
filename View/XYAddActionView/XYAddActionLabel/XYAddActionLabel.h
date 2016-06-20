//
//  XYAddActionLabel.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickLabel)(UILabel * view);

@interface XYAddActionLabel : UILabel
@property (nonatomic, copy)clickLabel clickView;

- (void)clickView:(clickLabel)clickView;
@end
