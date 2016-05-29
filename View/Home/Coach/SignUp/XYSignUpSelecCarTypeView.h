//
//  XYSinUpSelecCarTypeView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectCarTypeBlock)(NSString * carTypeID);


static CGFloat signUpSelectCarType_animalTime = .4;

@class XYAddActionView;
@interface XYSignUpSelecCarTypeView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, copy)NSArray * groupArray;


@property (nonatomic, strong)XYAddActionView * backgroudView;


@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UIButton * sureBtn;
@property (nonatomic, strong)UIButton * cancleBtn;


@property (nonatomic, copy)SelectCarTypeBlock selectCarTypeBlock;
- (void)getSelectCarTypeWithBlock:(SelectCarTypeBlock)block;

/**
 *  添加 这个 View
 *
 *  @param view
 */
- (void)addSignUpSelectCarTypeViewWithSuperView:(UIView *)view;

- (void)hiddenView;
- (void)showView;

@end
