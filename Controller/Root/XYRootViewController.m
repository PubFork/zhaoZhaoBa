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

    

}

#pragma mark -------------------------------------------------------
#pragma mark Method

- (void)setBackBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 25, 25);
    [btn setImage:kImage(@"back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)removeBackBtn
{
    self.navigationItem.leftBarButtonItem = nil;
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
