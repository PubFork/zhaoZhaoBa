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

@interface XYCoachViewController ()

@end

@implementation XYCoachViewController

- (void)viewDidLoad {
    
    //tableView 在最下面
    [self addTableViewIsGroup:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYCoachTableViewCell" bundle:nil] forCellReuseIdentifier:select_cell_key];
    self.tableView.mj_y = CGRectGetMaxY(self.selectView.frame) + 1;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.selectView setArray:@[@"好评",@"点赞次数",@"最近教练"]];
    
    
    
    NSMutableArray * array = @[].mutableCopy;
    
    for (int i = 0 ; i < 3; i ++) {
        NSMutableArray * a = @[].mutableCopy;
        for (int i = 0 ; i < arc4random()% 40; i ++) {
            [a addObject:[NSString stringWithFormat:@"%d",arc4random()% 100]];
        }
        [array addObject:a];
    }
    
    self.selectTableViewArray = array.copy;
    
    
    [self selectSort_blockWithBlock:^(NSString *key) {
        NSLog(@"-- %@",key);
    }];
    
    [self setTitleLabelText:@"教练榜"];
}


#pragma mark -------------------------------------------------------
#pragma mark TableView Delegate & DataSource
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCoachDetailViewController * coachDetailVC = [[XYCoachDetailViewController alloc] init];
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
