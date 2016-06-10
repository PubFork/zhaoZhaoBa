//
//  XYCoachDetailViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCoachDetailViewController.h"
#import "XYSignUpViewController.h"
#import "XYCoachDetailHeaderTableViewCell.h"
#import "XYCoachDetailCommentListTableViewCell.h"
#import "XYSignUpViewController.h"
#import "XYDriverSchoolDetailViewController.h"


#import "XYCoachNetTool.h"

@interface XYCoachDetailViewController ()
@property (nonatomic, strong)NSDictionary * coachDic;

@end

static NSString * coachDetail_header_cell_key = @"coachDetail_header_cell_key";
static NSString * coachDetail_comment_cell_key = @"coachDetail_comment_cell_key";


@implementation XYCoachDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"教练详情"];
    
    [self addTableViewIsGroup:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYCoachDetailHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:coachDetail_header_cell_key];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYCoachDetailCommentListTableViewCell" bundle:nil] forCellReuseIdentifier:coachDetail_comment_cell_key];

    self.tableView.height -= 50;
    
    [self requestCoachData];
    
    
    [self addMJHeader];
    [self addMJFooter];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)requestData
{
    WeakSelf(weakSelf);
    
   
    [XYCoachNetTool getCoachCommentWithID:self.coachID page:self.page isRefresh:NO viewController:self success:^(NSArray * _Nonnull array) {
        
        NSMutableArray * newArr = @[].mutableCopy;
        for (NSDictionary * dic in array) {
            NSString * content = dic[community_content];
            NSInteger height = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 74, 22222) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height + 95;
            NSMutableDictionary * dics = dic.mutableCopy;
            [dics setValue:@(height) forKey:@"cell_height"];
            [newArr addObject:dics];
        }
        
        [weakSelf.groupArray addObjectsFromArray:newArr];
        [weakSelf handleFooterWithCount:array.count];

        [weakSelf endRefresh];

    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf endRefresh];
        [weakSelf handleFooterWithCount:0];
    }];

}

- (void)requestCoachData
{
    WeakSelf(weakSelf);
    
    [XYCoachNetTool getCoachDetailWithID:self.coachID isRefresh:NO viewController:self success:^(NSDictionary * _Nonnull dic) {
        weakSelf.coachDic = dic;
        [weakSelf.tableView reloadData];
    } failure:nil];
}


- (IBAction)clickSignUp:(id)sender {
    XYDriverSchoolDetailViewController * dsdVC = [[XYDriverSchoolDetailViewController alloc] init];
    dsdVC.driverSchoolID = [self.coachDic[coach_c_dsid] integerValue];
    [self.navigationController pushViewController:dsdVC animated:YES];

  

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XYCoachDetailHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:coachDetail_header_cell_key forIndexPath:indexPath];
        cell.myData = self.coachDic;
        return cell;
    }
    
    XYCoachDetailCommentListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:coachDetail_comment_cell_key forIndexPath:indexPath];
    cell.myData = self.groupArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        view.backgroundColor = kDefaultBackgroudColor;

        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 30)];
        label.backgroundColor = kWhiteColor;
        label.text = @"   学员点评";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString * content = self.coachDic[coach_c_profile];
        NSInteger height = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 16, 22222) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        
        return 130 + height;
    }
    return [self.groupArray[indexPath.section][@"cell_height"] integerValue];
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
