//
//  XYAddActionImageView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYAddActionImageView.h"

@implementation XYAddActionImageView

- (void)clickView:(clickView)clickView
{
    self.userInteractionEnabled = YES;
    self.clickView = clickView;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.clickView ? self.clickView(self) : 0;
}
@end
