//
//  XYSearchBar.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSearchBar.h"

@implementation XYSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self laoutViews];
    }
    return self;
}

#pragma mark -------------------------------------------------------
#pragma mark Method 

- (void)searchBarEndEdit:(void (^)(XYSearchBar *))searchBarEndEdit
{
    self.searchBarEndEdit = searchBarEndEdit;
}

- (void)searchBarBegainEdit:(void (^)(XYSearchBar *))searchBarBegainEdit
{
    self.searchBarBegainEdit = searchBarBegainEdit;
}



#pragma mark -------------------------------------------------------
#pragma mark inner Method

- (void)laoutViews
{
    
    
    self.layer.cornerRadius = 5;
    self.layer.borderColor = kNavigationBarTextColor.CGColor;
    self.layer.borderWidth = .7;
    self.layer.masksToBounds = NO;
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 14, 14)];
    imageView.image = kImage(@"搜索标签");
    imageView.center = CGPointMake(imageView.centerX, self.height / 2);
    [self addSubview:imageView];
    
    
    
    [self addSubview:self.textField];
}

#pragma mark -------------------------------------------------------
#pragma mark TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.searchBarBegainEdit ? self.searchBarBegainEdit(self) : 0;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.searchBarEndEdit ? self.searchBarEndEdit(self) : 0;
}




#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading


- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, self.height /2 - 10, self.width - 25, 20)];
        _textField.backgroundColor = kWhiteColor;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.delegate = self;
        _textField.placeholder = @"搜索驾校、教练、试题等";
    }
    return _textField;
}


@end
