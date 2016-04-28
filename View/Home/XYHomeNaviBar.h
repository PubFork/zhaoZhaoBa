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
#import "XYAddActionView.h"

@class XYHomeNaviBar;

typedef void(^clickMessageBtn_block)(XYHomeNaviBar * homeNavBar);
typedef void(^clickSaoBtn_block)(XYHomeNaviBar * homeNavBar);
typedef void(^clickCityBtn_block)(XYHomeNaviBar * homeNavBar);



@interface XYHomeNaviBar : UIView
@property (nonatomic, strong)XYButton * cityBtn;
@property (nonatomic, strong)XYSearchBar * searchBar;
@property (nonatomic, strong)UIButton * saoBtn;
@property (nonatomic, strong)UIButton * messageBtn;


@property (nonatomic, strong)XYAddActionView * backgourdView;
+ (XYHomeNaviBar *)shareHomeNaviBar;



@property (nonatomic, copy)clickMessageBtn_block clickMessageBtn_block;
@property (nonatomic, copy)clickSaoBtn_block clickSaoBtn_block;
@property (nonatomic, copy)clickCityBtn_block clickCityBtn_block;

- (void)clickMessageBtn_block:(void(^)(XYHomeNaviBar * homeNavBar))clickMessageBtn_block;
- (void)clickSaoBtn_block:(void(^)(XYHomeNaviBar * homeNavBar))clickSaoBtn_block;
- (void)clickCityBtn_block:(void(^)(XYHomeNaviBar * homeNavBar))clickCityBtn_block;
@end
