//
//  XYPickerView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYAddActionView.h"

typedef NS_ENUM(NSInteger, PickerViewType) {
    PickerViewType_Age = 0x01,
    PickerViewType_Sex = 0x11,
};

typedef void(^ SelectStringBlock)(NSString * string, PickerViewType type);

@interface XYPickerView : UIView

+ (XYPickerView *)sharePickerView;

@property (nonatomic, assign)PickerViewType type;

@property (nonatomic, strong)UIPickerView * pickerView;
@property (nonatomic, strong)UIButton * cancleBtn;
@property (nonatomic, strong)UIButton * sureBtn;

@property (nonatomic, strong)XYAddActionView * backgroudView;


- (void)show;
- (void)hidden;

- (void)addViewWithSuperView:(UIView *)view;

@property (nonatomic, copy)SelectStringBlock selectCityBlock;
- (void)selectCityWithBlock:(SelectStringBlock)block;

@end
