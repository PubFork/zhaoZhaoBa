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

@property (nonatomic, assign)NSInteger page;
@end

@implementation XYDriverSchoolViewController

- (void)viewDidLoad {
    
    //tableView 在最下面
    [self addTableViewIsGroup:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:select_cell_key];
    self.tableView.mj_y = CGRectGetMaxY(self.selectView.frame) + 1;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:[self getTitle]];
    [self.selectView setArray:[self getArray]];
    
    
    
    [self selectSort_blockWithBlock:^(NSString *key) {
        NSLog(@"-- %@",key);
    }];
    
    
    
    WeakSelf(weakSelf);
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf.groupArray removeAllObjects];
        [weakSelf requestData];
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    
    [self.tableView.header beginRefreshing];

}

- (void)requestData
{
    WeakSelf(weakSelf);
    [XYDriverSchoolNetTool getDriverSchoolWithSortType:DriverSchoolSortType_default
                                            isSortRule:DrvierSchoolSortRule_desc
                                                  page:self.page
                                             isRefresh:NO
                                        viewController:self
                                               success:^(NSArray * _Nonnull array) {
                                                   [weakSelf.groupArray addObjectsFromArray:array];
                                                   
                                                   [weakSelf endRefresh];
                                               } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                   [weakSelf endRefresh];
                                               }];
}

#pragma mark -------------------------------------------------------
#pragma mark Innder Method

- (NSArray *)getArray
{
    switch (self.type) {
        case driverSchoolType_Near  : return @[@"默认排序",@"价格",@"距离",@"报名人数"];
        case driverSchoolType_Praise: return @[@"默认排序",@"服务",@"环境",@"车辆"];
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
    driverSchoolDetailVC.driverSchoolID = 
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
