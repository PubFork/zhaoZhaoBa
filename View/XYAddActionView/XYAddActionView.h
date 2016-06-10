//
//  XYAddActionView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickView)(UIView * view);

@interface XYAddActionView : UIView
@property (nonatomic, copy)ClickView clickView;

- (void)clickView:(ClickView)clickView;
@end
