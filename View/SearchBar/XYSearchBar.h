//
//  XYSearchBar.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYSearchBar;

typedef void(^searchBarBegainEdit) (XYSearchBar * searchBar);
typedef void(^searchBarEndEdit) (XYSearchBar * searchBar);

@interface XYSearchBar : UIView <UITextFieldDelegate>
@property (nonatomic, strong)UITextField * textField;


@property (nonatomic, copy)searchBarBegainEdit searchBarBegainEdit;
- (void)searchBarBegainEdit:(void(^)(XYSearchBar * searchBar))searchBarBegainEdit;

@property (nonatomic, copy)searchBarEndEdit searchBarEndEdit;
- (void)searchBarEndEdit:(void(^)(XYSearchBar * searchBar))searchBarEndEdit;
@end
