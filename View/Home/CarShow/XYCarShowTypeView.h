//
//  XYCarShowTypeView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCarTypeLabelBlock)(NSInteger index, BOOL isHighlighted);

static NSInteger car_show_type_label_tag = 100009;

@interface XYCarShowTypeView : UIView

@property (nonatomic, copy)ClickCarTypeLabelBlock clickCarTypeLabel;

- (void)ClickCarTypeLabelWithBlock:(ClickCarTypeLabelBlock)block;

@end
