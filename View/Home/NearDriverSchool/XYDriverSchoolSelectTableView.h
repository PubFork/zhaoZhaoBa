//
//  XYNearDriverSchoolSelectTableView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYDriverSchoolSelectTableView, XYAddActionView;
typedef void(^ didSelctRow)(XYDriverSchoolSelectTableView * tableView, NSIndexPath * indexPath);

@interface XYDriverSchoolSelectTableView : UITableView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray * groupArray;

@property (nonatomic, strong)XYAddActionView * backgroudView;


@property (nonatomic, copy)didSelctRow didSelctRow;
- (void)didSelectRowWithBlock:(void(^)(XYDriverSchoolSelectTableView * tableView, NSIndexPath * indexPath))didSelctRow;
@end
