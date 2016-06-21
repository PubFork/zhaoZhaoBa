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
#import "XYCommunityNetTool.h"
#import "XYDriverSchoolNetTool.h"
#import "XYCoachNetTool.h"
#import "XYSignInViewController.h"

@interface XYCommunityDetailViewController ()
@property (nonatomic, strong)NSMutableDictionary * groupDic;

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
    
    [self addMJHeader];
    [self addMJFooter];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)requestData
{
    WeakSelf(weakSelf);
    
    if (self.style == CommunityStyle_Default) {
        [XYCommunityNetTool getCommunityDetailWithID:self.communityID page:self.page isRefresh:NO viewController:self success:^(NSDictionary * _Nonnull dic) {
            
            
            NSMutableDictionary * newDic = [kManager addCellHeightWithDic:dic key:community_content width:kScreenWidth - 16 - 48 size:14 otherHeight:66];
            weakSelf.groupDic = newDic;

            NSMutableArray * newArray = [kManager addCellHrightWithArray:dic[@"replylist"] key:community_reply_replycontent width:kScreenWidth - 16 size:14 otherHeight:66];
            [newArray insertObject:newDic atIndex:0];
            [weakSelf.groupArray addObjectsFromArray:newArray];

            [weakSelf endRefresh];
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            [weakSelf endRefresh];
        }];
        
        return;
    }
    
    if (self.style == CommunityStyle_DriverSchool) {
        
        [XYDriverSchoolNetTool getDSCommunityDetailWithID:self.communityID page:self.page isRefresh:NO viewController:self success:^(NSDictionary * _Nonnull dic) {
            
            NSMutableDictionary * newDic = [kManager addCellHeightWithDic:dic key:community_content width:kScreenWidth - 16 - 48 size:14 otherHeight:66];
            weakSelf.groupDic = newDic;
            
            NSMutableArray * newArray = [kManager addCellHrightWithArray:dic[@"replylist"] key:community_reply_replycontent width:kScreenWidth - 16 size:14 otherHeight:66];
            [newArray insertObject:newDic atIndex:0];
            [weakSelf.groupArray addObjectsFromArray:newArray];
            
            [weakSelf endRefresh];
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            
            [weakSelf endRefresh];
        }];

        return;
    }
    
    
    [XYCoachNetTool getDSCommunityDetailWithID:self.communityID page:self.page isRefresh:NO viewController:self success:^(NSDictionary * _Nonnull dic) {
        NSMutableDictionary * newDic = [kManager addCellHeightWithDic:dic key:community_content width:kScreenWidth - 16 - 48 size:14 otherHeight:66];
        weakSelf.groupDic = newDic;
        
        NSMutableArray * newArray = [kManager addCellHrightWithArray:dic[@"replylist"] key:community_reply_replycontent width:kScreenWidth - 16 size:14 otherHeight:66];
        [newArray insertObject:newDic atIndex:0];
        [weakSelf.groupArray addObjectsFromArray:newArray];
        
        [weakSelf endRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf endRefresh];

    }];
    
    
   
}

- (IBAction)clickAddCommunity:(id)sender {
    
    if ([kUserManager userIsSign]) {
        
        XYAddCommunityViewController * addCommuntiyVC = [[XYAddCommunityViewController alloc] init];
        addCommuntiyVC.style = self.style;
        addCommuntiyVC.communityID = self.communityID;
        addCommuntiyVC.type = AddCommunityType_Reply;
        [self.navigationController pushViewController:addCommuntiyVC animated:YES];
    } else {
        [XYSignInViewController showSignViewControllerWithViewController:self];
    }
    

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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.groupArray[indexPath.section][cell_height_key] integerValue];
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
    cell.myData = self.groupArray[indexPath.section];
    
    WeakSelf(weakSelf);
    [cell clickCommunityBtnWithBlock:^(NSNumber *replyID) {
        
        if ([kUserManager userIsSign]) {
            XYAddCommunityViewController * addCommuntiyVC = [[XYAddCommunityViewController alloc] init];
            addCommuntiyVC.style = weakSelf.style;
            addCommuntiyVC.communityID = weakSelf.communityID;
            addCommuntiyVC.repleUserID = replyID;
            addCommuntiyVC.type = AddCommunityType_Reply;
            [weakSelf.navigationController pushViewController:addCommuntiyVC animated:YES];
        } else {
            [XYSignInViewController showSignViewControllerWithViewController:weakSelf];
        }
        
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
