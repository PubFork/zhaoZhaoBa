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

@interface XYRootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UIView * naviBar;

@property (nonatomic, strong)UIButton * rightBtn;
@property (nonatomic, strong)UIButton * leftBtn;
@property (nonatomic, strong)UILabel * titleLabel;


@property (nonatomic, strong)UITableView * tableView;
- (void)addTableViewIsGroup:(BOOL)isGroup;


- (void)setBackBtn;
- (void)removeBackBtn;

- (void)removeTitleLabel;

- (void)setRightBtnWithText:(NSString *)text;
- (void)setRightBtnWithImageName:(NSString *)imageName;
- (void)removeRightBtn;

- (void)clickLeftBtn;
- (void)clickRightBtn;


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
