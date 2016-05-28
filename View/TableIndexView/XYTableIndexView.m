//
//  XYTableIndexView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYTableIndexView.h"
#import "XYAddActionLabel.h"

@implementation XYTableIndexView

- (void)setAllKeys:(NSArray *)allKeys
{
    _allKeys = allKeys.copy;
    
    
    NSInteger w_h = 15;  //宽和高
    NSInteger h_intervals = w_h;
    
    self.bounds = CGRectMake(0, 0, w_h, h_intervals * allKeys.count);
    WeakSelf(weakSelf);
    
    
    int i = 0;
    for (NSString * key in allKeys) {
        
        XYAddActionLabel * label = [[XYAddActionLabel alloc] initWithFrame:CGRectMake(0, h_intervals * i, w_h, w_h)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kNavigationBarTextColor;
        label.text = key;
        label.font = [UIFont systemFontOfSize:w_h];
        [label clickView:^(UIView *view) {
            NSInteger index = [self.allKeys indexOfObject:((UILabel *)view).text];
            weakSelf.clickIndexLabelBlock ? weakSelf.clickIndexLabelBlock(index) : 0;
        }];
        
        [self addSubview:label];
        i ++;
    }
    
}

- (void)clickIndexLabelWithBlock:(ClickIndexLabelBlock)block
{
    self.clickIndexLabelBlock = block;
}

@end
