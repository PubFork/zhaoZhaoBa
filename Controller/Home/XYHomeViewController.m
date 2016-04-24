//
//  XYHomeViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYHomeViewController.h"
#import "XYHomeTableViewCell.h"
#import "XYHomeFuncationTableViewCell.h"

static NSString * funcationCell_key = @"funcationCell_key";
static NSString * cell_key = @"cell_key";

@interface XYHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * groupArray;
@end

@implementation XYHomeViewController
+ (XYHomeViewController *)shareHomeViewController
{
    static XYHomeViewController * homeVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeVC = [[XYHomeViewController alloc] init];
    });
    return homeVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.tableView];
    
    self.title = @"111";
    
    [self setNavigationBar];
    
    self.groupArray = @[].mutableCopy;
    
    for (int i = 0 ; i < 10; i ++) {
        
        [self.groupArray addObject:@(0.1 * i)];
    }
    
}

#pragma mark -------------------------------------------------------
#pragma mark Inner Method
- (void)setNavigationBar
{
    
}



#pragma mark -------------------------------------------------------
#pragma mark tableView Delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return self.groupArray.count;
    }
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section) {
        XYHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_key forIndexPath:indexPath];
        cell.startRateView.scorePercent = [self.groupArray[indexPath.row] floatValue];
        return cell;
    }
    
    XYHomeFuncationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:funcationCell_key forIndexPath:indexPath];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBar_Height - kTabBar_Height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kDefaultBackgroudColor;
        [_tableView registerNib:[UINib nibWithNibName:@"XYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cell_key];
        [_tableView registerNib:[UINib nibWithNibName:@"XYHomeFuncationTableViewCell" bundle:nil] forCellReuseIdentifier:funcationCell_key];
        
    }
    return _tableView;
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