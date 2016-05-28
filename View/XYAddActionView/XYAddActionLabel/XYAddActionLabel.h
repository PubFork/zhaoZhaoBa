//
//  XYAddActionLabel.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickView)(UIView * view);

@interface XYAddActionLabel : UILabel
@property (nonatomic, copy)clickView clickView;

- (void)clickView:(void(^)(UIView * view))clickView;
@end
