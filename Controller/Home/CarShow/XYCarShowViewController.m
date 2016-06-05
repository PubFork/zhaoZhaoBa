//
//  XYCarShowViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCarShowViewController.h"
#import "XYCarShowTypeView.h"
#import "XYCarShowTableViewCell.h"
#import "XYTableIndexView.h"
#import "XYCarShowOneTypeTableView.h"
#import "XYCarShowAlbumViewController.h"
#import "XYCareShowNetTool.h"


@interface XYCarShowViewController ()
@property (nonatomic, strong)XYCarShowTypeView * carShowTypeView;
@property (nonatomic, strong)XYTableIndexView * tableIndexView;
@property (nonatomic, strong)XYCarShowOneTypeTableView * showOneTableView;

@property (nonatomic, copy)NSDictionary * groupDic;
@property (nonatomic, copy)NSArray * allKeys;


@property (nonatomic, strong)NSNumber * selectCarID;
@end


static NSString * car_show_cell_key = @"car_show_cell_key";

@implementation XYCarShowViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.showOneTableView deselectRowAtIndexPath:[self.showOneTableView indexPathForSelectedRow] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleLabelText:@"车展"];
    
    [self addTableViewIsGroup:YES];
    self.tableView.mj_y += 30;
    self.tableView.height -= 30;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYCarShowTableViewCell" bundle:nil] forCellReuseIdentifier:car_show_cell_key];
    
    
    [self.view addSubview:self.carShowTypeView];
    [self.view addSubview:self.tableIndexView];
    [self.view addSubview:self.showOneTableView];
    
    
    [self addMJHeader];
    [self.tableView.mj_header beginRefreshing];
    
    
    WeakSelf(weakSelf);
    self.showOneTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestTypeData];
    }];
}
- (void)requestData
{
    WeakSelf(weakSelf);
    [XYCareShowNetTool getCareShowIsRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
        
        NSMutableDictionary * newDic = @{}.mutableCopy;
        for (NSString * key in dic.allKeys) {
            NSArray * array = dic[key];
            array.count ? [newDic setValue:array forKey:key] : 0;
        }
        
        weakSelf.groupDic = newDic;
        weakSelf.allKeys = [newDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
        weakSelf.tableIndexView.allKeys = weakSelf.allKeys;

        [weakSelf endRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf endRefresh];
    }];
}

- (void)requestTypeData
{
    WeakSelf(weakSelf);
    [XYCareShowNetTool getCareShowTypeWithCarID:self.selectCarID isRefresh:NO viewController:self success:^(NSDictionary * _Nonnull dic) {
        [weakSelf.showOneTableView.mj_header endRefreshing];
        weakSelf.showOneTableView.groupDic = dic;
        [weakSelf.showOneTableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf.showOneTableView.mj_header endRefreshing];
        [weakSelf.showOneTableView reloadData];
    }];
}

#pragma mark -------------------------------------------------------
#pragma mark TableView Delegate & dataSources

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groupDic[self.allKeys[section]] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.allKeys[section];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCarShowTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:car_show_cell_key forIndexPath:indexPath];
    cell.myData = self.groupDic[self.allKeys[indexPath.section]][indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.showOneTableView show];
    
    NSNumber * selectCarID = self.groupDic[self.allKeys[indexPath.section]][indexPath.row][car_show_typeid];
    if (selectCarID.integerValue != self.selectCarID.integerValue) {
        self.selectCarID = selectCarID;
        [self.showOneTableView.mj_header beginRefreshing];
    }
}


#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (XYCarShowTypeView *)carShowTypeView
{
    if (!_carShowTypeView) {
        _carShowTypeView = [[XYCarShowTypeView alloc] initWithFrame:CGRectMake(0, kNavigationBar_Height, kScreenWidth, 30)];
        [_carShowTypeView ClickCarTypeLabelWithBlock:^(NSInteger index, BOOL isHighlighted) {
            [self.showOneTableView hidden];
            //如果点击的不是高亮的，那么做数据的处理，如果是高亮 不做任何动作
            if (!isHighlighted) {
                NSLog(@"处理数据。。。 --- %ld",(long)index);

            }
        }];
    }
    return _carShowTypeView;
}


- (XYTableIndexView *)tableIndexView
{
    if (!_tableIndexView) {
        _tableIndexView = [[XYTableIndexView alloc] init];
        _tableIndexView.center = CGPointMake(kScreenWidth - 20, kScreenHeight / 2);
        
        WeakSelf(weakSelf);
        [_tableIndexView clickIndexLabelWithBlock:^(NSInteger index) {
            [weakSelf.tableView scrollToRow:0 inSection:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }];
    }
    return _tableIndexView;
}

- (XYCarShowOneTypeTableView *)showOneTableView
{
    if (!_showOneTableView) {
        _showOneTableView = [[XYCarShowOneTypeTableView alloc] initWithFrame:CGRectMake(kScreenWidth, self.tableView.mj_y, kScreenWidth - 80, self.tableView.height)];
        WeakSelf(weakSelf);
        [_showOneTableView getDidSelectItemWtihBlock:^(XYCarShowOneTypeTableView *carShowOneTypeTV) {
            
            XYCarShowAlbumViewController * vc = [[XYCarShowAlbumViewController alloc] init];
            
            [weakSelf.navigationController pushViewController:vc animated:YES];

        }];
        
        
        
    }
    return _showOneTableView;
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
