//
//  XYHomeNaviBar.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSearchBar.h"
#import "XYButton.h"

@interface XYHomeNaviBar : UIView
@property (nonatomic, strong)XYButton * cityBtn;
@property (nonatomic, strong)XYSearchBar * searchBar;
@property (nonatomic, strong)UIButton * saoBtn;
@property (nonatomic, strong)UIButton * messageBtn;

+ (XYHomeNaviBar *)shareHomeNaviBar;
@end
