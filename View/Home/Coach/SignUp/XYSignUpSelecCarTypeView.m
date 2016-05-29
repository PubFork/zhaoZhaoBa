//
//  XYSinUpSelecCarTypeView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSignUpSelecCarTypeView.h"
#import "XYSignUpTableViewCell.h"
#import "XYAddActionView.h"

@interface XYSignUpSelecCarTypeView ()

@end

static NSString * signUp_cell_key = @"signUp_cell_key";


@implementation XYSignUpSelecCarTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = kDefaultBackgroudColor;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.tableView];
        [self addSubview:self.cancleBtn];
        [self addSubview:self.sureBtn];
        
    }
    return self;
}



#pragma mark -------------------------------------------------------
#pragma mark Method

- (void)addSignUpSelectCarTypeViewWithSuperView:(UIView *)view
{
    [view addSubview:self.backgroudView];
    [view addSubview:self];
}


- (void)hiddenView
{
    self.backgroudView.hidden = YES;
    [UIView animateWithDuration:signUpSelectCarType_animalTime animations:^{
        self.mj_y = kScreenHeight;
    }];
}

- (void)showView
{
    self.backgroudView.hidden = NO;
    [UIView animateWithDuration:signUpSelectCarType_animalTime animations:^{
        self.mj_y = kScreenHeight - self.height;
    }];
}

- (void)getSelectCarTypeWithBlock:(SelectCarTypeBlock)block
{
    self.selectCarTypeBlock = block;
}

#pragma mark -------------------------------------------------------
#pragma mark Setting Method

- (void)setGroupArray:(NSArray *)groupArray
{
    _groupArray = groupArray;
    [self.tableView reloadData];
}




#pragma mark -------------------------------------------------------
#pragma mark Inner Method

- (void)clickCancleBtn
{
    [self hiddenView];
}

- (void)clickSureBtn
{
    [self hiddenView];
}


#pragma mark -------------------------------------------------------
#pragma mark TableView DataSource * Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSignUpTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:signUp_cell_key forIndexPath:indexPath];
    cell.titleLabel.text = self.groupArray[indexPath.row][sign_up_ct_title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectCarTypeBlock ? self.selectCarTypeBlock([kManager getStringWithObj:self.groupArray[indexPath.row][sign_up_ct_id]]) : 0;
}



#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 44 * 3 - 2) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
        
        [_tableView registerNib:[UINib nibWithNibName:@"XYSignUpTableViewCell" bundle:nil] forCellReuseIdentifier:signUp_cell_key];

        
    }
    return _tableView;
}

- (XYAddActionView *)backgroudView
{
    if (!_backgroudView) {
        _backgroudView = [[XYAddActionView alloc] initWithFrame:CGRectMake(0, kNavigationBar_Height, kScreenWidth, kScreenHeight - kNavigationBar_Height)];
        _backgroudView.alpha = .7;
        _backgroudView.backgroundColor = [UIColor blackColor];
        _backgroudView.hidden = YES;
        
        WeakSelf(weakSelf);
        [_backgroudView clickView:^(UIView *view) {
            [weakSelf hiddenView];
        }];
    }
    return _backgroudView;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
        _titleLabel.backgroundColor = kDefaultBackgroudColor;
        _titleLabel.text = @"选择车型";
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame) + 1, kScreenWidth / 2 - 1, 30);
        _cancleBtn.backgroundColor = kWhiteColor;
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
        _sureBtn.frame = CGRectMake(kScreenWidth / 2 + 1, CGRectGetMaxY(self.tableView.frame) + 1, kScreenWidth / 2 - 1, 30);
        _sureBtn.backgroundColor = kWhiteColor;
        [_sureBtn setTitleColor:kNavigationBarTextColor forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}



@end
