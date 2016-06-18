//
//  XYPickerView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYPickerView.h"

@interface XYPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong)NSMutableArray * groupArray;

@property (nonatomic, copy)NSString * selectString;
@end

@implementation XYPickerView

+ (XYPickerView *)sharePickerView
{
    static XYPickerView * pickerView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pickerView = [[XYPickerView alloc] init];
    });
    return pickerView;
}
- (instancetype)init
{
    if ([super init]) {
        
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 240);
        self.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
        
        [self addSubview:self.cancleBtn];
        [self addSubview:self.sureBtn];
        [self addSubview:self.pickerView];
        
        
    }
    return self;
}

- (void)setType:(PickerViewType)type
{
    _type = type;
    
    switch (type) {
        case PickerViewType_Age: {
            self.groupArray = @[].mutableCopy;
            for (int i = 5 ; i < 150; i ++) {
                [self.groupArray addObject:[NSString stringWithFormat:@"%d",i]];
            }
            self.selectString = @"5";
            break;
        }
        case PickerViewType_Sex: {
            self.groupArray = @[@"男",@"女",@"未知"].mutableCopy;
            self.selectString = @"男";
            break;
        }
    }
    
    [self.pickerView reloadAllComponents];
}


#pragma mark -----------------------------------------------------------
#pragma mark - Inner Method

- (void)moveSelfIsShow:(BOOL)isShow
{
    
    NSInteger y = isShow ? self.mj_y - self.frame.size.height : kScreenHeight;
    [UIView animateWithDuration:.4 animations:^{
        self.backgroudView.alpha = isShow ? .7 : 0;
        
        self.frame = CGRectMake(0, y, kScreenWidth, 240);
    }];
}


#pragma mark -----------------------------------------------------------
#pragma mark - Method


- (void)selectCityWithBlock:(SelectStringBlock)block
{
    self.selectCityBlock = block;
}

- (void)show
{
    [self moveSelfIsShow:YES];
}
- (void)hidden
{
    [self moveSelfIsShow:NO];
}

- (void)addViewWithSuperView:(UIView *)view
{
    [view addSubview:self.backgroudView];
    [view addSubview:self];
}


#pragma mark -----------------------------------------------------------
#pragma mark - Click

- (void)clickCancleBtn
{
    [self hidden];
}

- (void)clickSureBtn
{
    self.selectCityBlock ? self.selectCityBlock(self.selectString, self.type) : 0;
    
    [self hidden];
}



#pragma mark -----------------------------------------------------------
#pragma mark - PickerView Delegate & DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.groupArray.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.groupArray[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectString = self.groupArray[row];
}



#pragma mark -----------------------------------------------------------
#pragma mark - Lazy Loading
- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 200)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        
    }
    return _pickerView;
}


- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(20, 10, 40, 20);
        _cancleBtn.backgroundColor = self.backgroundColor;
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(clickCancleBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(kScreenWidth - 60, 10, 40, 20);
        _sureBtn.backgroundColor = self.backgroundColor;
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (XYAddActionView *)backgroudView
{
    if (!_backgroudView) {
        _backgroudView = [[XYAddActionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _backgroudView.backgroundColor = [UIColor blackColor];
        _backgroudView.alpha = 0;
        [_backgroudView clickView:^(UIView *view) {
            [self hidden];
        }];
    }
    return _backgroudView;
}


@end
