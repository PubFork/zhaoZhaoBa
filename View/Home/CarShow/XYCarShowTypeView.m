//
//  XYCarShowTypeView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCarShowTypeView.h"
#import "XYSelectLabel.h"

@interface XYCarShowTypeView ()

@property (nonatomic, weak)UIView * oldView;

@end

@implementation XYCarShowTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        [self layout];
    }
    return self;
}

- (void)layout
{
    
    
    NSInteger width = 80;
    
    
    NSArray * array = @[@"新车",@"二手车",@"二手房",@"如何选车"];
    
    NSInteger x = self.width / 2 - array.count / 2.0 * width;
    
    WeakSelf(weakSelf);
    int i = 0;
    for (NSString * name in array) {
        
        XYSelectLabel * label = [[XYSelectLabel alloc] initWithFrame:CGRectMake(x + width * i, 5, width, 20)];
        label.text = name;
        label.tag = car_show_type_label_tag + i;
        
        if (i == 0) {
            [label touchesEnded:[NSSet set] withEvent:nil];
            self.oldView = label;
        }
        [label clickView:^(UIView *view) {
            if (weakSelf.oldView != view) {
                ((XYSelectLabel *)weakSelf.oldView).isHighlighted = NO;
                weakSelf.oldView = view;
            }
           
            
            weakSelf.clickCarTypeLabel ? weakSelf.clickCarTypeLabel(view.tag - car_show_type_label_tag,[(XYSelectLabel *)view isHighlighted]) : 0;
        }];
        [self addSubview:label];
        
        i ++;
    }

}


- (void)ClickCarTypeLabelWithBlock:(ClickCarTypeLabelBlock)block
{
    self.clickCarTypeLabel = block;
}

@end

