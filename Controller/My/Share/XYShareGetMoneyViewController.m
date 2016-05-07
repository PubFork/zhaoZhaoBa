//
//  XYShareGetMoneyViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYShareGetMoneyViewController.h"
#import "XYShareGetMoneyShareTableViewCell.h"
#import "XYShareGetMoneyTableViewCell.h"




@interface XYShareGetMoneyViewController ()

@property (nonatomic, strong)NSArray * shareArray;
@end

static NSString * share_get_money_cell_key = @"share_get_money_cell_key";
static NSString * share_get_money_cell_share_key = @"share_get_money_cell_share_key";


@implementation XYShareGetMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setRightBtnWithText:@"分享赚现金"];
    
    [self addTableViewIsGroup:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYShareGetMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:share_get_money_cell_key];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYShareGetMoneyShareTableViewCell" bundle:nil] forCellReuseIdentifier:share_get_money_cell_share_key];
    
    
    self.shareArray = @[
                        @{my_shareGetMoney_vc_shareCell_image:@"",
                          my_shareGetMoney_vc_shareCell_title:@"微信好友"},
                        
                        @{my_shareGetMoney_vc_shareCell_image:@"",
                          my_shareGetMoney_vc_shareCell_title:@"微信朋友圈"},
                        
                        @{my_shareGetMoney_vc_shareCell_image:@"",
                          my_shareGetMoney_vc_shareCell_title:@"QQ好友"},
                        
                        @{my_shareGetMoney_vc_shareCell_image:@"",
                          my_shareGetMoney_vc_shareCell_title:@"人人网"},
                        
                        @{my_shareGetMoney_vc_shareCell_image:@"",
                          my_shareGetMoney_vc_shareCell_title:@"新浪微博"},
                        
                        @{my_shareGetMoney_vc_shareCell_image:@"",
                          my_shareGetMoney_vc_shareCell_title:@"手机通讯录联系人"},
                        
                        @{my_shareGetMoney_vc_shareCell_image:@"",
                          my_shareGetMoney_vc_shareCell_title:@"邮箱"}
                        ];
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
    return self.shareArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section) {
        return @"分享到";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 136;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XYShareGetMoneyTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:share_get_money_cell_key forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    XYShareGetMoneyShareTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:share_get_money_cell_share_key forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.myData = self.shareArray[indexPath.row];
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        
    }
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
