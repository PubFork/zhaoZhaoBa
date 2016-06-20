//
//  XYSelectTextView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSelectTextView.h"

@interface XYSelectTextView ()
@property (nonatomic, weak)XYAddActionLabel * selectLabel;
@end

static NSInteger tag_label = 1000920;

@implementation XYSelectTextView


- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray
{
    if ([super initWithFrame:frame]) {
        [self addSubview:self.lineView];

        self.textArray = textArray;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    

    [self addSubview:self.lineView];
}

- (void)setTextArray:(NSArray *)textArray
{
    _textArray = textArray.copy;
    
    WeakSelf(weakSelf);
    
    for (int i = 0 ; i < textArray.count; i ++) {
        XYAddActionLabel * label = [[XYAddActionLabel alloc] initWithFrame:CGRectMake(kScreenWidth / textArray.count * i , 5, kScreenWidth / textArray.count, 20)];
        label.textColor = i ? self.defaultColor : self.selectColor;
        self.selectLabel = i ? self.selectLabel : label;
        label.text = textArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.tag = tag_label + i;
        [label clickView:^(UIView *view) {
            [(UILabel *)view setTextColor:self.selectColor];
            weakSelf.selectLabel.textColor = self.defaultColor;
            weakSelf.selectLabel = (XYAddActionLabel *)view;
            
            [UIView animateWithDuration:.4 animations:^{
                weakSelf.lineView.centerX = view.centerX;
            }];
            
            weakSelf.selectTextBlock ? weakSelf.selectTextBlock(view.tag - tag_label) : 0;
        }];
        [self addSubview:label];
    }
    
}


- (void)selectTextWithBlock:(SelectTextBlock)block
{
    self.selectTextBlock = block;
}


#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading
- (UIColor *)defaultColor
{
    if (!_defaultColor) {
        _defaultColor = [UIColor blackColor];
    }
    return _defaultColor;
}

- (UIColor *)selectColor
{
    if (!_selectColor) {
        _selectColor = kNavigationBarTextColor;
    }
    return _selectColor;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 1)];
        _lineView.backgroundColor = self.selectColor;
        _lineView.center = CGPointMake(kScreenWidth / 8,30);
    }
    return _lineView;
}

@end
