//
//  XYRootViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYRootViewController.h"

@interface XYRootViewController () 
@end

@implementation XYRootViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = kDefaultBackgroudColor;
    
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.activeIV = [[MyActivityIndicatorView alloc]init];
    [self setBackBtn];

    
    [self.view addSubview:self.naviBar];
    
    

}

#pragma mark -------------------------------------------------------
#pragma mark Method

- (void)addTableViewIsGroup:(BOOL)isGroup
{
    UITableViewStyle style = UITableViewStylePlain;
    if (isGroup) {
        style = UITableViewStyleGrouped;
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBar_Height + 1, kScreenWidth, kScreenHeight - kNavigationBar_Height - 1) style:style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kDefaultBackgroudColor;
    _tableView.tableFooterView = [UIView new];

    [self.view addSubview:self.tableView];
}

- (void)setBackBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 30, 25, 25);
    [btn setImage:kImage(@"back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [self.naviBar addSubview:btn];
    self.leftBtn = btn;
}

- (void)removeBackBtn
{
    [self removeView:self.leftBtn];
   
}

- (void)removeTitleLabel
{
    [self removeView:self.titleLabel];
}

- (void)setRightBtnWithText:(NSString *)text
{
    
}
- (void)setRightBtnWithImageName:(NSString *)imageName
{
    
}
- (void)removeRightBtn
{
    [self removeView:self.rightBtn];

}

- (void)setTitleLabelText:(NSString *)text
{
    self.titleLabel.text = text;
}



#pragma mark -------------------------------------------------------
#pragma mark inner Method

- (void)removeView:(UIView *)view
{
    [view removeFromSuperview];
}


- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickRightBtn
{
    
}
#pragma mark ----------------------------------------------------------------------
#pragma mark ----------------------avtive-------------------------------------
#pragma mark ----------------------------------------------------------------------
- (void)addActiveIVToMySelfView
{
    _activeIV.center = CGPointMake(kScreenWidth/2, kScreenHeight/2 - 64);
    [self.view addSubview:_activeIV.clearView];
    [self.view addSubview:_activeIV];
    
}
- (void)addWhiteActiveIVToMySelfView
{
    _activeIV.center = CGPointMake(kScreenWidth/2, kScreenHeight/2 - 64);
    [self.view addSubview:_activeIV.whiteView];
    [self.view addSubview:_activeIV];
}

- (void)removeActiveIVFromSelfView
{
    [_activeIV.whiteView removeFromSuperview];
    [_activeIV.clearView removeFromSuperview];
    [_activeIV removeFromSuperview];
}

- (void)addActiveIVToWindow
{
    _activeIV.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    [kWindow addSubview:_activeIV.clearView];
    [kWindow addSubview:_activeIV];
    
}


#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading
- (UIView *)naviBar
{
    if (!_naviBar) {
        _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _naviBar.backgroundColor = kWhiteColor;
        
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        view.backgroundColor = [UIColor blackColor];
        [_naviBar addSubview:view];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kNavigationBarTextColor;
        _titleLabel.center = CGPointMake(kScreenWidth / 2, 42);
        [_naviBar addSubview:_titleLabel];
    }
    return _naviBar;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
