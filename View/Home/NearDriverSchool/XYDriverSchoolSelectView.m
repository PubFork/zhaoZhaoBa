//
//  XYNearDriverSchoolSelectView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYDriverSchoolSelectView.h"
#import "XYButton.h"

@implementation XYDriverSchoolSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self layoutViews];
    }
    return self;
}
- (void)layoutViews
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1)];
    view.backgroundColor = kDefaultBackgroudColor;
    [self addSubview:view];
    
}

- (void)setArray:(NSArray *)array
{
    self.backgroundColor = kDefaultBackgroudColor;
    
    NSInteger width = (NSInteger)((self.width - 3) / 4);
    WeakSelf(weakSelf);
    
    for (int i = 0 ; i < array.count ; i ++) {
        XYButton * btn = [[XYButton alloc] initWithFrame:CGRectMake((width + 1) * i, 1, width, self.height - 1)];
        [btn setTitle:array[i]];
        btn.titleLabel.textColor = [UIColor blackColor];
        btn.tag = 100000 + i;
        
        [btn clickCityBtn_block_xyButton:^(XYButton *view) {
            weakSelf.clickSelectView_block ? weakSelf.clickSelectView_block(view) : 0 ;
        }];
        
        [self addSubview:btn];
    }

}

- (void)clickSelectView_blockWithBlock:(void (^)(XYButton *))clickSelectView_block
{
    self.clickSelectView_block = clickSelectView_block;
}
@end
