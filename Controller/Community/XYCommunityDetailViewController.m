//
//  XYCommunityDetailViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCommunityDetailViewController.h"
#import "XYCommunityDetailTableViewCell.h"
#import "XYAddCommunityViewController.h"


@interface XYCommunityDetailViewController ()
@property (nonatomic, strong)NSMutableArray * groupArray;
@end

static NSString * communtiy_detail_cell_key = @"communtiy_detail_cell_key";

@implementation XYCommunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"社区汇"];

    [self addTableViewIsGroup:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYCommunityDetailTableViewCell" bundle:nil] forCellReuseIdentifier:communtiy_detail_cell_key];
    self.tableView.height -= 50;
}
- (IBAction)clickAddCommunity:(id)sender {
    
    XYAddCommunityViewController * addCommuntiyVC = [[XYAddCommunityViewController alloc] init];
    [self.navigationController pushViewController:addCommuntiyVC animated:YES];

}

#pragma mark -------------------------------------------------------
#pragma mark TableView Delegate & dataSources

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
    return self.groupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCommunityDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:communtiy_detail_cell_key forIndexPath:indexPath];
    
    cell.communtiyBtn.hidden = !indexPath.section;
    
    WeakSelf(weakSelf);
    [cell clickCommunityBtnWithBlock:^{
        XYAddCommunityViewController * addCommuntiyVC = [[XYAddCommunityViewController alloc] init];
        [weakSelf.navigationController pushViewController:addCommuntiyVC animated:YES];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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