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
#import "XYHomeHeaderTableViewCell.h"

#import "XYHomeNaviBar.h"
#import "XYCityTableView.h"
#import "QRViewController.h"

//各个模块
#import "XYMustKnowViewController.h"
#import "XYNearDriverSchoolViewController.h"

#import <CoreLocation/CoreLocation.h>


static NSString * funcationCell_key = @"funcationCell_key";
static NSString * cell_key = @"cell_key";
static NSString * headerCell_key = @"headerCell_key";

@interface XYHomeViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (nonatomic, strong)NSMutableArray * groupArray;
@property (nonatomic, strong)XYHomeNaviBar * homeNaviBar;
@property (nonatomic, strong)XYCityTableView * cityTableView;



@property (nonatomic, strong)CLLocationManager * locationManager;

@end

@implementation XYHomeViewController
+ (XYHomeViewController *)shareHomeViewController
{
    static XYHomeViewController * homeVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeVC = [[XYHomeViewController alloc] init];
        
        
        UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBar_Height, kScreenWidth, kScreenHeight - kNavigationBar_Height - kTabBar_Height) style:UITableViewStyleGrouped];
        tableview.delegate = homeVC;
        tableview.dataSource = homeVC;
        tableview.backgroundColor = kDefaultBackgroudColor;
        [tableview registerNib:[UINib nibWithNibName:@"XYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cell_key];
        [tableview registerNib:[UINib nibWithNibName:@"XYHomeFuncationTableViewCell" bundle:nil] forCellReuseIdentifier:funcationCell_key];
        [tableview registerNib:[UINib nibWithNibName:@"XYHomeHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:headerCell_key];
        
        homeVC.tableView = tableview;
    });
    return homeVC;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.cityTableView];

    [self setNavigationBar];
    
    self.groupArray = @[].mutableCopy;
    for (int i = 0 ; i < 10; i ++) {
        [self.groupArray addObject:@(0.1 * i)];
    }
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    if (iOS8) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    

}

#pragma mark -------------------------------------------------------
#pragma mark Inner Method
- (void)setNavigationBar
{
    [self removeBackBtn];
    [self removeTitleLabel];
    [self.naviBar removeFromSuperview];

    self.homeNaviBar = [XYHomeNaviBar shareHomeNaviBar];
    [self.view addSubview:self.homeNaviBar];
  
    
    WeakSelf(weakSelf);
    
    [self.homeNaviBar clickCityBtn_block:^(XYHomeNaviBar *homeNavBar) {
        [weakSelf.cityTableView isShow:homeNavBar.cityBtn.isShow selectIsShow:^(BOOL isShow, NSString * selectCity) {
            homeNavBar.cityBtn.isShow = isShow;
            [homeNavBar.cityBtn setTitle:selectCity];
        }];
    }];
    
    [self.homeNaviBar clickSaoBtn_block:^(XYHomeNaviBar *homeNavBar) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
            [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            
            QRViewController *qrVC = [[QRViewController alloc] init];
            qrVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:qrVC animated:YES];
        }
        [kShowLabel setText:@"没有摄像头或摄像头不可用" position:1];
    }];

    
    [self.homeNaviBar clickMessageBtn_block:^(XYHomeNaviBar *homeNavBar) {
        
    }];
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
    if (indexPath.section == 2) {
        XYHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_key forIndexPath:indexPath];
        cell.startRateView.scorePercent = [self.groupArray[indexPath.row] floatValue];
        return cell;
    }
    
    if (indexPath.section == 1) {
        XYHomeFuncationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:funcationCell_key forIndexPath:indexPath];
        
        [cell clickFuncationCell:^(XYHomeFuncationTableViewCell *cell, NSInteger clickIndex) {
            UIViewController * vc = nil;
            switch (clickIndex) {
                case 0: {
                    vc = [[XYMustKnowViewController alloc] init];
                    break;
                }
                case 1: {
                    vc = [[XYNearDriverSchoolViewController alloc] init];
                }
            }
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;
    }
    
    XYHomeHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:headerCell_key forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }
    if (indexPath.section == 1) {
        return 242;
    }
    return 75;
}

#pragma mark -------------------------------------------------------
#pragma mark CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *newLocation = [locations lastObject];
    [manager stopUpdatingLocation];
    
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * place = placemarks.firstObject;
        [kUserD setValue:place.locality forKey:kLocationCityName_Key];
        [kUserD synchronize];
        self.homeNaviBar.cityBtn.titleLabel.text = place.locality;
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.homeNaviBar.cityBtn setTitle:[kUserD objectForKey:kLocationCityName_Key]];
    
    if ([error code] == kCLErrorDenied) {
        //访问被拒绝
         [kShowLabel setText:@"请您去设置里打开定位服务" position:1];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        [kShowLabel setText:@"无法获取位置信息" position:1];
    }
    NSLog(@"定位失败 -- %@",error);
}
#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (XYCityTableView *)cityTableView
{
    if (!_cityTableView) {
        _cityTableView = [[XYCityTableView alloc] initWithFrame:CGRectMake(0, kNavigationBar_Height, kScreenWidth, kScreenHeight - kNavigationBar_Height - kTabBar_Height)];
        _cityTableView.mj_y = -_cityTableView.selfHeight;
    }
    return _cityTableView;
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
