//
//  XYCommunityViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCommunityViewController.h"
#import "XYCommunityTableViewCell.h"
#import "XYCommunityDetailViewController.h"
#import "XYAddCommunityViewController.h"

@interface XYCommunityViewController ()

@property (nonatomic, strong)NSMutableArray * groupArray;

@end

static NSString * community_cell_key = @"community_cell_key";

@implementation XYCommunityViewController
+ (XYCommunityViewController *)shareCommunityViewController
{
    static XYCommunityViewController * communityVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        communityVC = [[self.class alloc] init];
    });
    return communityVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addTableViewIsGroup:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYCommunityTableViewCell" bundle:nil] forCellReuseIdentifier:community_cell_key];
    
    [self.view sendSubviewToBack:self.tableView];
    
    
    if (!self.style) {
        [self removeBackBtn];
        [self setTitleLabelText:@"社区汇"];
        self.tableView.height -= kTabBar_Height;
    } else {
        [self setTitleLabelText:@"评论"];
    }
    
}
- (IBAction)clickAddBtn:(id)sender {
    
    XYAddCommunityViewController * addCommuntiyVC = [[XYAddCommunityViewController alloc] init];
    addCommuntiyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addCommuntiyVC animated:YES];
}

- (IBAction)clickBackTopBtn:(id)sender {
    
    [self.tableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:YES];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCommunityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:community_cell_key forIndexPath:indexPath];
    WeakSelf(weakSelf);
    [cell clickPraiseBtnWithBlock:^{
        
    }];
    
    [cell clickCommunityBtnWithBlock:^{
        
        XYAddCommunityViewController * addCommuntiyVC = [[XYAddCommunityViewController alloc] init];
        addCommuntiyVC.hidesBottomBarWhenPushed = YES;

        [weakSelf.navigationController pushViewController:addCommuntiyVC animated:YES];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 203;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCommunityDetailViewController * communityDetailVC = [[XYCommunityDetailViewController alloc] init];
    communityDetailVC.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:communityDetailVC animated:YES];
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
