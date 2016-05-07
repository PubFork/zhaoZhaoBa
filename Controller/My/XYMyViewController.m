//
//  XYMyViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYMyViewController.h"
#import "XYMyTableViewCell.h"
#import "XYMyMessageTableViewCell.h"
#import "XYShareGetMoneyViewController.h"

@interface XYMyViewController ()
/**
 *  section 1
 */
@property (nonatomic, strong)NSArray * sectionOneArray;
@property (nonatomic, strong)NSArray * sectionTwoArray;

@end


static NSString * my_cell_key = @"my_cell_key";
static NSString * myMessage_cell_key = @"myMessage_cell_key";

@implementation XYMyViewController
+ (XYMyViewController *)shareMyViewController
{
    static XYMyViewController * myVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myVC = [[self.class alloc] init];
    });
    return myVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"我的"];
    [self addTableViewIsGroup:YES];
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYMyTableViewCell" bundle:nil] forCellReuseIdentifier:my_cell_key];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYMyMessageTableViewCell" bundle:nil] forCellReuseIdentifier:myMessage_cell_key];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kWhiteColor;
    
    self.sectionOneArray = @[
                              @{my_vc_custom_imageUrl:@"",
                                my_vc_custom_title:@"我的驾校",
                                my_vc_custom_prompt:@"未报考驾校"},
                              
                              @{my_vc_custom_imageUrl:@"",
                                my_vc_custom_title:@"积分商城"},
                              
                              @{my_vc_custom_imageUrl:@"",
                                my_vc_custom_title:@"分享赚现金"},
                          ];
    
    
    self.sectionTwoArray = @[
                             @{my_vc_custom_imageUrl:@"",
                               my_vc_custom_title:@"我的消息"},
                             
                             @{my_vc_custom_imageUrl:@"",
                               my_vc_custom_title:@"一键清理"},
                             
                             @{my_vc_custom_imageUrl:@"",
                               my_vc_custom_title:@"我们在这"},
                             
                             @{my_vc_custom_imageUrl:@"",
                               my_vc_custom_title:@"版本介绍"},
                             
                             @{my_vc_custom_imageUrl:@"",
                               my_vc_custom_title:@"在线反馈"}
                             ];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.sectionOneArray.count;
    }
    return  self.sectionTwoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XYMyMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:myMessage_cell_key forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    
    XYMyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:my_cell_key forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    NSDictionary * dic = nil;
    if (indexPath.section == 1) {
        dic = self.sectionOneArray[indexPath.row];
    } else {
        dic = self.sectionTwoArray[indexPath.row];
    }
    cell.myData = dic;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = kDefaultBackgroudColor;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = kDefaultBackgroudColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController * vc = nil;
    
    switch (indexPath.section) {
        case 0: {
            
            break;
        }
        case 1: {
            
            switch (indexPath.row) {
                case 0: {
                    
                    break;
                }
                case 1: {
                   
                    break;
                }
                case 2: {
                    vc = [[XYShareGetMoneyViewController alloc] init];
                    break;
                }
            }
            
            break;
        }
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    
                    break;
                }
                case 1: {
                    
                    break;
                }
                case 2: {
                    
                    break;
                }
                case 3: {
                    
                    break;
                }
                case 4: {
                    
                    break;
                }
            }
            break;
        }
    }
    if(vc) {
        [self.navigationController pushViewController:vc animated:YES];
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
