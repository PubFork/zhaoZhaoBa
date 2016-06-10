//
//  MyActivityIndicatorView.m
//  LvCheng
//
//  Created by 中科创奇 on 15/5/11.
//  Copyright (c) 2015年 中科创奇. All rights reserved.
//

#import "MyActivityIndicatorView.h"

@implementation MyActivityIndicatorView


- (instancetype)init
{
    if ([super init]) {
    
        self.frame =  CGRectMake(0, 0, 60, 60);
        self.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    
        
        self.clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.clearView.backgroundColor = [UIColor blackColor];
        self.clearView.alpha = .7;
        
        self.whiteView = [[UIView alloc]initWithFrame:self.clearView.frame];
        _whiteView.backgroundColor = [UIColor whiteColor];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
       
        [self addSubview:imageView];

        NSMutableArray * array = [NSMutableArray array];
    
        for (int i = 1 ; i < 9; i ++) {
            [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"progress_%d",i]]];
        }
        imageView.animationImages = array;
        imageView.animationDuration = .7;//设置动画时间
        imageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
        [imageView startAnimating];//开始播放动画
    
    }
    return self;
    
}



@end
