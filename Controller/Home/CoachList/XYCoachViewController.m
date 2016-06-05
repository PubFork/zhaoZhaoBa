//
//  XYCoachViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCoachViewController.h"
#import "XYCoachDetailViewController.h"
#import "XYCoachTableViewCell.h"
#import "XYCoachNetTool.h"

@interface XYCoachViewController ()
@property (nonatomic, copy)NSString * sortType;
@property (nonatomic, assign)BOOL rule;
@end

@implementation XYCoachViewController

- (void)viewDidLoad {
    
    //tableView 在最下面
    [self addTableViewIsGroup:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYCoachTableViewCell" bundle:nil] forCellReuseIdentifier:select_cell_key];
    self.tableView.mj_y = CGRectGetMaxY(self.selectView.frame);
    self.tableView.height = kScreenHeight - self.tableView.mj_y;
    
    WeakSelf(weakSelf);
    [self addMJFooter];
    [self addMJHeader];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.selectView setArray:@[coach_list_chinese_type_default,
                                coach_list_chinese_type_praisenumber,
                                coach_list_chinese_type_distance]];
    
    self.sortType = coach_list_type_default;
    self.rule = DrvierSchoolSortRule_desc;
    
    [self getSelectSort_name_with_block:^(NSString *sortName, BOOL isShow) {
        weakSelf.rule = isShow;
        weakSelf.sortType = [kManager getCoachSortTypeWithChineseSortType:sortName];
        
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    
    [self setTitleLabelText:@"教练榜"];
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)requestData
{
    WeakSelf(weakSelf);
    NSString * rule = self.rule ? DrvierSchoolSortRule_asc : DrvierSchoolSortRule_desc;

    [XYCoachNetTool getCoachWithSortType:self.sortType rule:rule page:self.page isRefresh:NO viewController:self success:^(NSArray * _Nonnull array) {
        
        [weakSelf.groupArray addObjectsFromArray:array];
        
        
        [weakSelf handleFooterWithCount:array.count];

        [weakSelf endRefresh];

        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf endRefresh];
       [weakSelf handleFooterWithCount:0];
    }];
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
    return 80;
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
    XYCoachTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:select_cell_key forIndexPath:indexPath];
    cell.myData = self.groupArray[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCoachDetailViewController * coachDetailVC = [[XYCoachDetailViewController alloc] init];
    coachDetailVC.coachID = self.groupArray[indexPath.section][coach_c_id];

    [self.navigationController pushViewController:coachDetailVC animated:YES];
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
