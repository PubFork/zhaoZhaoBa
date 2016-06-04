//
//  XYMustKnowDetailViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYMustKnowDetailViewController.h"
#import "XYMustKnowNetTool.h"

@interface XYMustKnowDetailViewController ()

@end

@implementation XYMustKnowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"必知晓"];
    
    [self requestData];
    
    
   
}

- (void)requestData
{
    [XYMustKnowNetTool getMustKnowDetailWithID:1 isRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
        NSLog(@" -- %@",dic[mustKnow_mk_content]);
        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        [self.view addSubview:webView];
        [webView loadHTMLString:dic[mustKnow_mk_content] baseURL:nil];
        
        
    } failure:nil];
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
