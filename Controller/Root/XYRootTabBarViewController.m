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

@interface XYRootTabBarViewController () <UITabBarDelegate,UITabBarControllerDelegate>
@property (nonatomic, strong)XYRootNavigationController * homeNV;
@end

@implementation XYRootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.homeNV = [self createrViewControllerWithViewController:[XYHomeViewController shareHomeViewController] name:@"首页" unSelectImageName:@"首页" selectImageName:@"首页"];
    
    UIViewController * vc1 = [[UIViewController alloc] init];
    UIViewController * vc2 = [[UIViewController alloc] init];
    
    XYRootNavigationController * communityNV = [self createrViewControllerWithViewController:vc1 name:@"社区汇" unSelectImageName:@"社区汇" selectImageName:@""];
    
    XYRootNavigationController * myNV = [self createrViewControllerWithViewController:vc2 name:@"我的" unSelectImageName:@"我的" selectImageName:@""];
    
    
    
    
    
    self.viewControllers = @[_homeNV,communityNV,myNV];
    self.delegate = self;
    
}
- (XYRootNavigationController *)createrViewControllerWithViewController:(UIViewController *)viewController name:(NSString *)name unSelectImageName:(NSString *)unSelectImageName selectImageName:(NSString *)selectImageName
{
    XYRootNavigationController * nv = [[XYRootNavigationController alloc]initWithRootViewController:viewController];
    nv.tabBarItem.title = name;
    nv.tabBarItem.image = kImage(unSelectImageName);
    nv.tabBarItem.selectedImage = [kImage(selectImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigationBarTextColor} forState:UIControlStateHighlighted];
    return nv;
}



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([item.title isEqualToString:@"社区汇"]) {
        [XYCommunityViewController shareCommunityViewController].hidesBottomBarWhenPushed = YES;
        [self.homeNV pushViewController: [XYCommunityViewController shareCommunityViewController] animated:YES];
    } else if ([item.title isEqualToString:@"我的"]) {
        [XYMyViewController shareMyViewController].hidesBottomBarWhenPushed = YES;
        [self.homeNV pushViewController: [XYMyViewController shareMyViewController] animated:YES];
    }
    
    
    self.selectedIndex = 0;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{
    return NO;
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
