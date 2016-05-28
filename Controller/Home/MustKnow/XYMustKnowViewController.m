//
//  XYMustKnowViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYMustKnowViewController.h"
#import "XYMustKnowTableViewCell.h"
#import "XYMustKnowDetailViewController.h"
#import "XYMustKnowNetTool.h"

@interface XYMustKnowViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray * groupArray;

@property (nonatomic, assign)NSInteger page;
@end


static NSString * cellKey = @"cell";

@implementation XYMustKnowViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"必知晓"];
    
    self.groupArray = @[].mutableCopy;
    
    [self addTableViewIsGroup:NO];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYMustKnowTableViewCell" bundle:nil] forCellReuseIdentifier:cellKey];
    
    WeakSelf(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf.groupArray removeAllObjects];
        [weakSelf requestData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark -------------------------------------------------------
#pragma mark requestData

- (void)requestData
{
    WeakSelf(weakSelf);
    [XYMustKnowNetTool getMustKnowWithPage:self.page isRefresh:NO viewController:self success:^(NSArray * _Nonnull array) {
        [weakSelf endRefresh];
        
        [weakSelf.groupArray addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
        
        weakSelf.page += [weakSelf handleFooterWithCount:array.count];
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf endRefresh];
    }];
}


#pragma mark -------------------------------------------------------
#pragma mark TableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYMustKnowTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellKey forIndexPath:indexPath];
    cell.myData = self.groupArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYMustKnowDetailViewController * detailVC = [[XYMustKnowDetailViewController alloc] init];
    detailVC.mustKnowID = [self.groupArray[indexPath.row][mustKown_mk_id] integerValue];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}



#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading



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
