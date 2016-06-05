//
//  XYNoviceOfRoadDetailViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNoviceOfRoadDetailViewController.h"
#import "XYNoviceOfRoadNetTool.h"

@interface XYNoviceOfRoadDetailViewController ()

@end

@implementation XYNoviceOfRoadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self requestData];
}

- (void)requestData
{
    [XYNoviceOfRoadNetTool getNoviceOfRoadDetailWithID:self.noviceOfRoadID isRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
        NSLog(@" -- %@",dic);
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
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
