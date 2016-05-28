//
//  XYTableIndexView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickIndexLabelBlock)(NSInteger index);

@interface XYTableIndexView : UIView

@property (nonatomic, copy)NSArray * allKeys;


@property (nonatomic, copy)ClickIndexLabelBlock clickIndexLabelBlock;

- (void)clickIndexLabelWithBlock:(ClickIndexLabelBlock)block;
@end
