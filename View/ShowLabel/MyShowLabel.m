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


- (void)setText:(NSString *)text position:(int)position
{
    [self setText:text];
    
    self.frame = CGRectMake(0, 0, [self getStringWidthWithString:text] + 10, 40);
    if (position == 1) {
        self.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    }else if(position == -1)
    {
        self.center = CGPointMake(kScreenWidth/2, kScreenHeight - 100);
    }else if (position == 0)
    {
        self.center = CGPointMake(kScreenWidth/2, kScreenHeight - 70);
    } else {
        self.frame = CGRectMake(0, 0, 300, 45);
        self.center = CGPointMake(kScreenWidth / 2, kScreenHeight - 25 - 22.5);
        self.font = [UIFont systemFontOfSize:17];
        self.layer.cornerRadius = 21;
    }
}


/**
 *  没有定时器
 *
 */
- (void)setTextNoTime:(NSString *)text
{
    [super setText:text];
    self.hidden = NO;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (!self.superview) {
        [kWindow addSubview:self];
    } else {
        self.hidden = NO;
    }
    
    
    [self layoutSelf];

    [self.timer invalidate];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeSelf:) userInfo:nil repeats:NO];
}

- (void)removeSelf:(NSTimer *)timer
{
    self.hidden = YES;
//    [self layoutSelf];
}
- (CGFloat)getStringWidthWithString:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(22222, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    return rect.size.width;
}
@end
