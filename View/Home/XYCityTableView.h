//
//  XYCityTableView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectIsShow)(BOOL isShow, NSString * selectCity);

@interface XYCityTableView : UIView

/**
 *  控件的 高度
 */
@property (nonatomic, assign)NSInteger selfHeight;


/**
 *  省
 */
@property (nonatomic, strong)UITableView * provinceTableView;

/**
 *  市
 */
@property (nonatomic, strong)UITableView * municipalityTableView;


@property (nonatomic, copy)selectIsShow selectIsShow;

- (void)isShow:(BOOL)isShow selectIsShow:(void(^)(BOOL isShow, NSString * selectCity))selectIsShow;

@end
