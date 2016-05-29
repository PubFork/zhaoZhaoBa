//
//  XYWebViewViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYWebViewViewController.h"

@interface XYWebViewViewController () <UIWebViewDelegate>
@property (nonatomic, strong)UIWebView * webView;
@end

@implementation XYWebViewViewController
+ (XYWebViewViewController *)shareXYWebViewViewController
{
    static XYWebViewViewController * wbVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wbVC = [[XYWebViewViewController alloc] init];
    });
    return wbVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavigationBar_Height, kScreenWidth, kScreenHeight - kNavigationBar_Height)];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
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
