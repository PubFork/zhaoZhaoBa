//
//  XYNearDriverSchoolViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYDriverSchoolViewController.h"
#import "XYDriverSchoolDetailViewController.h"
#import "XYHomeTableViewCell.h"

#import "XYDriverSchoolNetTool.h"

@interface XYDriverSchoolViewController ()



@property (nonatomic, copy)NSString * sortType;
@property (nonatomic, assign)BOOL rule;

@end




@implementation XYDriverSchoolViewController

- (void)viewDidLoad {
    
    
    self.sortType = DriverSchoolSortType_default;
    self.rule = DrvierSchoolSortRule_desc;
    self.groupArray = @[].mutableCopy;
    
    //tableView 在最下面
    [self addTableViewIsGroup:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:select_cell_key];
    self.tableView.mj_y = CGRectGetMaxY(self.selectView.frame);
    self.tableView.height = kScreenHeight - self.tableView.mj_y;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:[self getTitle]];
    [self.selectView setArray:[self getArray]];
    
    WeakSelf(weakSelf);

    
    [self selectSort_blockWithBlock:^(NSString *key) {
        NSLog(@"-- %@",key);
    }];
    
    
    [self getSelectSort_name_with_block:^(NSString *sortName, BOOL isShow) {
        weakSelf.rule = isShow;
        weakSelf.sortType = [kManager getDriverSchoolSortTypeWithChineseSortType:sortName];
        
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf.groupArray removeAllObjects];
        [weakSelf requestData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestData];
    }];
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)requestData
{
    WeakSelf(weakSelf);
    
    NSString * rule = self.rule ? DrvierSchoolSortRule_asc : DrvierSchoolSortRule_desc;
    
    [XYDriverSchoolNetTool getDriverSchoolWithSortType:self.sortType
                                            isSortRule:rule
                                                  page:self.page
                                             isRefresh:NO
                                        viewController:self
                                               success:^(NSArray * _Nonnull array) {
                                                   [weakSelf.groupArray addObjectsFromArray:array];
                                                   
                                                   [weakSelf endRefresh];
                                                   [weakSelf handleFooterWithCount:array.count];
                                                   
                                               } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                   [weakSelf endRefresh];
                                                   [weakSelf handleFooterWithCount:0];

                                               }];
}

#pragma mark -------------------------------------------------------
#pragma mark Innder Method



- (NSArray *)getArray
{
    switch (self.type) {
        case driverSchoolType_Near  : return @[driver_school_sort_type_default,
                                               driver_school_sort_type_price,
                                               driver_school_sort_type_distance,
                                               driver_school_sort_type_sign_up_number];
        case driverSchoolType_Praise: return @[driver_school_sort_type_default,
                                               driver_school_sort_type_service,
                                               driver_school_sort_type_environment,
                                               driver_school_sort_type_car];
    }
}
- (NSString *)getTitle
{
    switch (self.type) {
        case driverSchoolType_Near  : return @"附近驾校";
        case driverSchoolType_Praise: return @"驾校好评";
    }
}


#pragma mark -------------------------------------------------------
#pragma mark TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:select_cell_key forIndexPath:indexPath];
    cell.myData = self.groupArray[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYDriverSchoolDetailViewController * driverSchoolDetailVC = [[XYDriverSchoolDetailViewController alloc] init];
    driverSchoolDetailVC.driverSchoolID = [self.groupArray[indexPath.row][driverSchool_school_id] integerValue];
    [self.navigationController pushViewController:driverSchoolDetailVC animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
