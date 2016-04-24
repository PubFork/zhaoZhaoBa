//
//  XYRootTabBarViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYRootTabBarViewController.h"
#import "XYMyViewController.h"
#import "XYHomeViewController.h"
#import "XYCommunityViewController.h"

#import "XYRootNavigationController.h"

@interface XYRootTabBarViewController ()

@end

@implementation XYRootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    XYRootNavigationController * homeNV = [self createrViewControllerWithViewController:[XYHomeViewController shareHomeViewController] name:@"首页" unSelectImageName:@"" selectImageName:@""];
    
    XYRootNavigationController * communityNV = [self createrViewControllerWithViewController:[XYCommunityViewController shareCommunityViewController] name:@"社区汇" unSelectImageName:@"" selectImageName:@""];
    
    XYRootNavigationController * myNV = [self createrViewControllerWithViewController:[XYMyViewController shareMyViewController] name:@"我的" unSelectImageName:@"" selectImageName:@""];
    
    
    self.viewControllers = @[homeNV,communityNV,myNV];
    
}
- (XYRootNavigationController *)createrViewControllerWithViewController:(UIViewController *)viewController name:(NSString *)name unSelectImageName:(NSString *)unSelectImageName selectImageName:(NSString *)selectImageName
{
    XYRootNavigationController * nv = [[XYRootNavigationController alloc]initWithRootViewController:viewController];
    nv.tabBarItem.title = name;
    nv.tabBarItem.image = kImage(unSelectImageName);
    nv.tabBarItem.selectedImage = [kImage(selectImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return nv;
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
