//
//  XYSelectLabel.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYAddActionLabel.h"

@interface XYSelectLabel : XYAddActionLabel

@property (nonatomic, strong)UIColor * normalColor;
@property (nonatomic, strong)UIFont * normalFont;

@property (nonatomic, strong)UIColor * highlightedColor;
@property (nonatomic, strong)UIFont * highlightedFont;

@property (nonatomic, assign)BOOL isHighlighted;
@end
