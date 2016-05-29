//
//  XYWebViewViewController.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYRootViewController.h"

@interface XYWebViewViewController : XYRootViewController

+ (XYWebViewViewController *)shareXYWebViewViewController;

@property (nonatomic, copy)NSString * url;
@end
