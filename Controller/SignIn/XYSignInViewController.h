//
//  XYSignInViewController.h
//  zhaoZhaoBa
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYRootViewController.h"

@interface XYSignInViewController : XYRootViewController

+ (XYSignInViewController *)shareSignInViewController;

+ (void)showSignViewControllerWithViewController:(UIViewController *)vc;

@end
