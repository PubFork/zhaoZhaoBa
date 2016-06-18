//
//  XYNoviceOfRoadViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNoviceOfRoadViewController.h"
#import "XYNoviceOfRoadTableViewCell.h"
#import "XYNoviceOfRoadTableViewCell1.h"
#import "XYNoviceOfRoadNetTool.h"
#import "XYWebViewViewController.h"

@interface XYNoviceOfRoadViewController ()
@end

static NSString * novice_of_road_cell_key = @"novice_of_road_cell_key";
static NSString * novice_of_road_cell1_key = @"novice_of_road_cell1_key";


@implementation XYNoviceOfRoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"新手上路"];
    
    [self addTableViewIsGroup:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYNoviceOfRoadTableViewCell" bundle:nil] forCellReuseIdentifier:novice_of_road_cell_key];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYNoviceOfRoadTableViewCell1" bundle:nil] forCellReuseIdentifier:novice_of_road_cell1_key];
    
    [self addMJFooter];
    [self addMJHeader];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)requestData
{
    WeakSelf(weakSelf);
    [XYNoviceOfRoadNetTool getNoviceOfRoadListWithPage:self.page isRefresh:NO viewController:self success:^(NSArray * _Nonnull array) {
        [weakSelf handleFooterWithCount:array.count];
        [weakSelf.groupArray addObjectsFromArray:array];
        [weakSelf endRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf endRefresh];
    }];
}

#pragma mark -------------------------------------------------------
#pragma mark TableView Delegate & dataSourece

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
    //156
    return 83;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYNoviceOfRoadTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:novice_of_road_cell_key forIndexPath:indexPath];
    cell.myData = self.groupArray[indexPath.section];
//    XYNoviceOfRoadTableViewCell1 * cell1 = [tableView dequeueReusableCellWithIdentifier:novice_of_road_cell1_key forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYWebViewViewController * webView = [XYWebViewViewController shareXYWebViewViewController];
    webView.url = [NSString stringWithFormat:@"%@%@?nrid=%@",root_URL,@"DrivingSchool/api/noviceroaddetail.htm",self.groupArray[indexPath.section][novice_of_road_nr_id]];
    [webView setTitle:@"新手上路"];
    [self.navigationController pushViewController:webView animated:YES];
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
