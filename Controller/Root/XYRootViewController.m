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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.activeIV = [[MyActivityIndicatorView alloc]init];
    [self setBackBtn];

    
    [self.navigationController.navigationBar addSubview:self.naviBar];
    
    

}

#pragma mark -------------------------------------------------------
#pragma mark Method

- (void)setBackBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 20, 25, 25);
    [btn setImage:kImage(@"back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    
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
        _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
        _naviBar.backgroundColor = kWhiteColor;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kNavigationBarTextColor;
        _titleLabel.center = CGPointMake(kScreenWidth / 2, 22);
        
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
