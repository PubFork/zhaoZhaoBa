//
//  XYButton.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYButton.h"

@implementation XYButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self layoutViews];
    }
    return self;
}

- (void)layoutViews
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width - 12, self.height)];
    _titleLabel.textColor = kNavigationBarTextColor;
    _titleLabel.font = [UIFont systemFontOfSize:10];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"呼和浩特";
    
    [self addSubview:self.titleLabel];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel.width, self.height / 2 - 3, 12, 6)];
    self.imageView.image = kImage(@"下角标");
    [self addSubview:self.imageView];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [UIView animateWithDuration:kHomeCityAnimate_time animations:^{
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI);
    }];
}

@end
