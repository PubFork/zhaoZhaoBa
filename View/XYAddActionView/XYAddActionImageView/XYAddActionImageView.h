//
//  XYAddActionImageView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickView)(UIImageView * view);

@interface XYAddActionImageView : UIImageView
@property (nonatomic, copy)clickView clickView;

- (void)clickView:(clickView)clickView;
@end
