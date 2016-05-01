//
//  MyShowLabel.m
//  YiJingTong
//
//  Created by 中科创奇 on 15/4/3.
//  Copyright (c) 2015年 中科创奇. All rights reserved.
//

#import "MyShowLabel.h"

@implementation MyShowLabel

+ (MyShowLabel *)shareShowLabel
{
    static MyShowLabel * showLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        showLabel = [[MyShowLabel alloc]init];
        
    });
    return showLabel;
}

-(instancetype)init
{
    if ([super init]) {
        [self layoutSelf];
    }
    return self;
}
- (void)layoutSelf
{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:14];
    self.alpha = .8;
    
    
    //先 统一放到 屏幕下面
    self.frame = CGRectMake(0, 0, 300, 45);
    self.center = CGPointMake(kScreenWidth / 2, kScreenHeight - 25 - 22.5);
    self.font = [UIFont systemFontOfSize:17];
    self.layer.cornerRadius = 21;
}

- (void)showAgainDoorCard
{
    
    [kShowLabel setText:@"同一天同一门，只能贴一次" position:2];
}

- (void)showAddCardSucceed
{
    [kShowLabel setText:@"成功贴了1个门贴" position:5];
}

- (void)setText:(NSString *)text position:(int)position
{
    [super setText:text];
    
    [kWindow addSubview:self];
    
    [self layoutSelf];
    
    if (position == 5) {
        self.width = 235;
        self.center = CGPointMake(kScreenWidth / 2, kScreenHeight - 25 - 22.5);
    }
    
//    self.frame = CGRectMake(0, 0, [self getStringWidthWithString:text] + 10, 40);
//    if (position == 1) {
//         self.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
//    }else if(position == -1)
//    {
//        self.center = CGPointMake(kScreenWidth/2, kScreenHeight - 100);
//    }else if (position == 0)
//    {
//        self.center = CGPointMake(kScreenWidth/2, kScreenHeight - 70);
//    } else {
//        self.frame = CGRectMake(0, 0, 300, 45);
//        self.center = CGPointMake(XJScreenWidth / 2, XJScreenHeight - 25 - 22.5);
//        self.font = [UIFont systemFontOfSize:17];
//        self.layer.cornerRadius = 21;
//    }
   
   
    
    [self.timer invalidate];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeSelf:) userInfo:nil repeats:NO];
}

- (void)removeSelf:(NSTimer *)timer
{
    [self removeFromSuperview];
    [self layoutSelf];
}
- (CGFloat)getStringWidthWithString:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(22222, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    return rect.size.width;
}
@end
