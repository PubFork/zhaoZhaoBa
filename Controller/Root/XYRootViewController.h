//
//  XYRootViewController.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyActivityIndicatorView.h"
#import "MJRefresh.h"

@interface XYRootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong)UIView * naviBar;

@property (nonatomic, strong)UIButton * rightBtn;
@property (nonatomic, strong)UIButton * leftBtn;
@property (nonatomic, strong)UILabel * titleLabel;


@property (nonatomic, strong)UITableView * tableView;




////////////////////////////////// 网络请求相关 ////////////////////////////////////////
- (void)endRefresh;

- (void)hiddenFooter;
- (void)showFooter;

/**
 *  处理 footer 看是否需要 隐藏 如果不需要隐藏 那么返回1 如果隐藏 返回0
 *  举个栗子：  weakSelf.page += [weakSelf handleFooterWithCount:array.count];
 */
- (NSInteger)handleFooterWithCount:(NSInteger)count;

////////////////////////////////// 界面 相关 ////////////////////////////////////////
/**
 *  添加 TableView
 *
 *  @param isGroup 是否是 group type
 */
- (void)addTableViewIsGroup:(BOOL)isGroup;


- (void)setBackBtn;
- (void)removeBackBtn;

- (void)removeTitleLabel;

- (void)setRightBtnWithText:(NSString *)text;
- (void)setRightBtnWithImageName:(NSString *)imageName;
- (void)removeRightBtn;


- (void)clickLeftBtn;
- (void)clickRightBtn;


/**
 *  设置 title  别用系统的
 *
 *  @param text
 */
- (void)setTitleLabelText:(NSString *)text;

@property (nonatomic,strong)MyActivityIndicatorView * activeIV;
/**
 *  添加一个 菊花  透明背景
 */
- (void)addActiveIVToMySelfView;
- (void)addActiveIVToWindow;
/**
 *  添加一个 菊花 白色背景
 */
- (void)addWhiteActiveIVToMySelfView;


/**
 *  移除 菊花
 */
- (void)removeActiveIVFromSelfView;
@end
