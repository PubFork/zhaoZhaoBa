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


@interface XYCoachDetailViewController ()
@property (nonatomic, strong)NSMutableArray * groupArray;
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
}
- (IBAction)clickSignUp:(id)sender {
    
    XYSignUpViewController * signVc = [[XYSignUpViewController alloc] init];
    [self.navigationController pushViewController:signVc animated:YES];

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
    
    return 10;
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XYCoachDetailHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:coachDetail_header_cell_key forIndexPath:indexPath];
        return cell;
    }
    
    XYCoachDetailCommentListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:coachDetail_comment_cell_key forIndexPath:indexPath];
    
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
        return 166;
    }
    return 128;
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
