//
//  XYAddActionLabel.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYAddActionLabel.h"

@implementation XYAddActionLabel

- (void)clickView:(void (^)(UIView *))clickView
{
    self.userInteractionEnabled = YES;
    self.clickView = clickView;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.clickView ? self.clickView(self) : 0;
}
@end
