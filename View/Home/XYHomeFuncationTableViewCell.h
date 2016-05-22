//
//  XYHomeFuncationTableViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYCarousePicture.h"

@class XYHomeFuncationTableViewCell;

typedef void(^clickFuncationCell)(XYHomeFuncationTableViewCell * cell, NSInteger clickIndex);

@interface XYHomeFuncationTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet XYCarousePicture *carousePicture;

@property (nonatomic, copy)clickFuncationCell clickFuncationCell;

- (void)clickFuncationCell:(void(^)(XYHomeFuncationTableViewCell * cell, NSInteger clickIndex))clickFuncationCell;


@end
