//
//  XYMyViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYMyViewController.h"

@interface XYMyViewController ()

@end

@implementation XYMyViewController
+ (XYMyViewController *)shareMyViewController
{
    static XYMyViewController * myVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myVC = [[self.class alloc] init];
    });
    return myVC;
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
