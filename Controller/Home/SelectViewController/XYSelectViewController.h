//
//  XYSelectViewController.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYRootViewController.h"
#import "XYButton.h"
#import "XYSelectView.h"
#import "XYDriverSchoolSelectTableView.h"
#import "XYAddActionView.h"



/**
 *  返回点击的 label 如果isShow是YES 箭头是朝下的
 */
typedef void(^selectSort_name_block)(NSString * sortName, BOOL isShow);



/**
 *  选中了 某一个排序 条件
 */
typedef void(^selectSort_block)(NSString * key);

/**
 *  主 tableView 的 cellkey
 */
static NSString * select_cell_key = @"cell";




/**
 *  含有 选择 下拉按钮的 控制器  是一个 二级跟控制器
 附近驾校 、 驾校好评 、 教练榜 都继承自它
 */
@interface XYSelectViewController : XYRootViewController
/**
 *  放选择 按钮的 view
 */
@property (nonatomic, strong)XYSelectView * selectView;


@property (nonatomic, strong)XYDriverSchoolSelectTableView * selectTableView;

/**
 *  数据
    @[
        @[@"",@""],
        @[@"",@""]
    ]
 */
@property (nonatomic, strong)NSArray * selectTableViewArray;


@property (nonatomic, weak)XYButton * oldBtn;
/**
 *  处于 显示 模式的btn
 */
@property (nonatomic, weak)XYButton * showBtn;




/**
 *  选中了 某一个排序 条件
 */
@property (nonatomic, copy)selectSort_block selectSort_block;
- (void)selectSort_blockWithBlock:(void(^)(NSString * key))selectSort_block;




@property (nonatomic, copy)selectSort_name_block selectSort_name_block;
- (void)getSelectSort_name_with_block:(selectSort_name_block)block;
@end



