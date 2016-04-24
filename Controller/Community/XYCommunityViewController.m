//
//  XYCommunityViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCommunityViewController.h"

@interface XYCommunityViewController ()

@end

@implementation XYCommunityViewController
+ (XYCommunityViewController *)shareCommunityViewController
{
    static XYCommunityViewController * communityVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        communityVC = [[self.class alloc] init];
    });
    return communityVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
