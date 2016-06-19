//
//  XYTouchView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYTouchView.h"

@interface XYTouchView ()
@property (nonatomic, strong)UIColor * defaultColor;
@property (nonatomic, strong)UIColor * touchesDownColor;
@end


@implementation XYTouchView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = self.touchesDownColor;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = self.defaultColor;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.backgroundColor = self.defaultColor;
}




- (UIColor *)defaultColor
{
    if (!_defaultColor) {
        _defaultColor = [UIColor whiteColor];
    }
    return _defaultColor;
}

- (UIColor *)touchesDownColor
{
    if (!_touchesDownColor) {
        _touchesDownColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return _touchesDownColor;
}
@end
