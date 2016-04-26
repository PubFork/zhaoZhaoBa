//
//  XYHomeNaviBar.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYHomeNaviBar.h"



@implementation XYHomeNaviBar

+ (XYHomeNaviBar *)shareHomeNaviBar
{
    static XYHomeNaviBar * homeNaviBar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeNaviBar = [[XYHomeNaviBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [homeNaviBar layoutViews];
    });
    return homeNaviBar;
}


static NSInteger messageBtn_width = 24;
static NSInteger messageBtn_height = 28;

static NSInteger saoBtn_width = 20;
static NSInteger soaBtn_height = 20;

//没有消息
static NSString * unMessageImageName = @"消息1";
//有消息了的 图片名字
static NSString * messageImageName = @"消息";
//扫一扫 图片名字
static NSString * saoImageName = @"扫一扫";

- (void)layoutViews
{
    
    self.cityBtn = [[XYButton alloc] initWithFrame:CGRectMake(0, 12, 60, 20)];
    [self addSubview:self.cityBtn];
    
    
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.messageBtn.frame = CGRectMake(self.width - 5 - 24, self.height / 2 - messageBtn_height / 2, messageBtn_width, messageBtn_height);
    [self.messageBtn setImage:kImage(unMessageImageName) forState:UIControlStateNormal];
    [self.messageBtn addTarget:self action:@selector(clickMessageBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.messageBtn];
    
    
    self.saoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saoBtn.frame = CGRectMake(self.messageBtn.frame.origin.x - saoBtn_width - 10, self.height / 2 - soaBtn_height / 2, saoBtn_width, soaBtn_height);
    [self.saoBtn setImage:kImage(saoImageName) forState:UIControlStateNormal];
    [self.saoBtn addTarget:self action:@selector(clickSaoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.saoBtn];
    

    self.searchBar = [[XYSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.width - (CGRectGetMaxX(self.cityBtn.frame) + 5) * 2, 30)];
    self.searchBar.center = CGPointMake(self.width / 2, self.height / 2);
    [self addSubview:self.searchBar];

    
    
    
}

#pragma mark -------------------------------------------------------
#pragma mark Click Method

- (void)clickMessageBtn
{
    
}

- (void)clickSaoBtn
{
    
}

- (void)clickCityBtn
{
    
}



@end
