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

@interface XYMustKnowViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray * groupArray;

@end


static NSString * cellKey = @"cell";

@implementation XYMustKnowViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"必知晓"];
    
    [self addTableViewIsGroup:NO];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"XYMustKnowTableViewCell" bundle:nil] forCellReuseIdentifier:cellKey];
}


#pragma mark -------------------------------------------------------
#pragma mark TableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYMustKnowTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellKey forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYMustKnowDetailViewController * detailVC = [[XYMustKnowDetailViewController alloc] init];
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
