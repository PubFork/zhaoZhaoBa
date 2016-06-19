//
//  XYSelectTextView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//


#import "XYAddActionLabel.h"


typedef void(^ SelectTextBlock)(NSInteger index);

@interface XYSelectTextView : UIView
- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray;

@property (nonatomic, strong)UIView * lineView;

@property (nonatomic, copy)NSArray * textArray;

@property (nonatomic, strong)UIColor * selectColor;
@property (nonatomic, strong)UIColor * defaultColor;




@property (nonatomic, copy)SelectTextBlock selectTextBlock;
- (void)selectTextWithBlock:(SelectTextBlock)block;
@end
