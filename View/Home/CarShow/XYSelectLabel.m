//
//  XYSelectLabel.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSelectLabel.h"

@implementation XYSelectLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        
        self.normalFont = [UIFont systemFontOfSize:13];
        self.normalColor = [UIColor grayColor];
        
        self.highlightedFont = [UIFont systemFontOfSize:15];
        self.highlightedColor = [UIColor blackColor];
        
        
        self.isHighlighted = NO;
    }
    return self;
}



- (void)setIsHighlighted:(BOOL)isHighlighted
{
    _isHighlighted = isHighlighted;
    
    if (isHighlighted) {
        self.font = self.highlightedFont;
        self.textColor = self.highlightedColor;
    } else {
        self.font = self.normalFont;
        self.textColor = self.normalColor;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];

    if (!self.isHighlighted) {
        self.isHighlighted = YES;
    }
    

}


@end
