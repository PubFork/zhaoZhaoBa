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

#import "XYCommunityNetTool.h"
#import "XYDriverSchoolNetTool.h"

@interface XYCommunityViewController ()

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
    
    [self addMJHeader];
    [self addMJFooter];
    
    if (!self.style) {
        [self setTitleLabelText:@"社区汇"];
    } else {
        [self setTitleLabelText:@"评论"];
    }
    
    [self.tableView.mj_header beginRefreshing];

}


- (void)requestData
{
    WeakSelf(weakSelf);
    
    if (self.style == CommunityStyle_Default) {
        [XYCommunityNetTool getCommunityListWithPage:self.page isRefresh:NO viewController:self success:^(NSArray * _Nonnull array) {
            
            [weakSelf reloadArray:array];
            
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            [weakSelf handleFooterWithCount:0];

            [weakSelf endRefresh];
        }];
        
        
        return;
    }
    
    
    [XYDriverSchoolNetTool getDSCommunityListWithPage:self.page isRefresh:NO dsid:self.dsID viewController:self success:^(NSArray * _Nonnull array) {
        [weakSelf reloadArray:array];

    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf handleFooterWithCount:0];
        
        [weakSelf endRefresh];
    }];
    
    
    
}


- (void)reloadArray:(NSArray *)array
{
    NSMutableArray * newArr = @[].mutableCopy;
    for (NSDictionary * dic in array) {
        NSString * content = dic[community_content];
        NSInteger height = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 16, 22222) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height + 100;
        NSMutableDictionary * dics = dic.mutableCopy;
        [dics setValue:@(height) forKey:@"cell_height"];
        [newArr addObject:dics];
    }
    
    [self.groupArray addObjectsFromArray:newArr];
    [self handleFooterWithCount:array.count];

    [self endRefresh];

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
    return self.groupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCommunityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:community_cell_key forIndexPath:indexPath];
    
    cell.myData = self.groupArray[indexPath.section];
    
    WeakSelf(weakSelf);
    [cell clickPraiseBtnWithBlock:^{
        
    }];
    
    [cell clickCommunityBtnWithBlock:^{
        
        XYAddCommunityViewController * addCommuntiyVC = [[XYAddCommunityViewController alloc] init];
        addCommuntiyVC.hidesBottomBarWhenPushed = YES;
        addCommuntiyVC.style = self.style;
        [weakSelf.navigationController pushViewController:addCommuntiyVC animated:YES];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.groupArray[indexPath.section][@"cell_height"] integerValue];
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
    
    if (self.style == CommunityStyle_Default) {
        communityDetailVC.communityID = self.groupArray[indexPath.section][community_communityid];

    } else {
        communityDetailVC.communityID = self.groupArray[indexPath.section][@"pdid"];

    }
    communityDetailVC.style = self.style;
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
