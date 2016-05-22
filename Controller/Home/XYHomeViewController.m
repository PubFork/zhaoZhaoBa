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
#import "XYDriverSchoolViewController.h"
#import "XYCoachViewController.h"
#import "XYNoviceOfRoadViewController.h"

#import <CoreLocation/CoreLocation.h>


#import "XYHomeNetTool.h"








static NSString * home_funcationCell_key = @"home_funcationCell_key";
static NSString * home_cell_key = @"home_cell_key";
static NSString * home_headerCell_key = @"home_headerCell_key";

@interface XYHomeViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

/**
 *  列表数组
 */
@property (nonatomic, strong)NSMutableArray * listArray;

/**
 *  首页轮播图
 */
@property (nonatomic, copy)NSArray * homeCarousePictureImagesArray;

/**
 *  首页小轮播图
 */
@property (nonatomic, copy)NSArray * homeSmallCarousePictureImagesArray;

@property (nonatomic, strong)XYHomeNaviBar * homeNaviBar;
@property (nonatomic, strong)XYCityTableView * cityTableView;



@property (nonatomic, strong)CLLocationManager * locationManager;

/**
 *  请求数量
 */
@property (nonatomic, assign)NSInteger requestNumber;

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
        [tableview registerNib:[UINib nibWithNibName:@"XYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:home_cell_key];
        [tableview registerNib:[UINib nibWithNibName:@"XYHomeFuncationTableViewCell" bundle:nil] forCellReuseIdentifier:home_funcationCell_key];
        [tableview registerNib:[UINib nibWithNibName:@"XYHomeHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:home_headerCell_key];
        
        tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [homeVC requestData];
        }];
        
//        tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        }];
        
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
    
    self.listArray = @[].mutableCopy;
    
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    if (iOS8) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    

    [self.tableView.header beginRefreshing];
}

- (void)requestData
{
    
    self.requestNumber = 3;
    
    
    WeakSelf(weakSelf);
    
    [XYHomeNetTool getCarousePictureWithBannerType:CarousePictureBannerType_home isRefresh:NO viewController:self success:^(NSArray * _Nonnull array) {
        weakSelf.homeCarousePictureImagesArray = array;
        
        [self isEndRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self isEndRefresh];
    }];
    
    [XYHomeNetTool getCarousePictureWithBannerType:CarousePictureBannerType_home_small isRefresh:NO viewController:self success:^(NSArray * _Nonnull array) {
        weakSelf.homeSmallCarousePictureImagesArray = array;
        
        [self isEndRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self isEndRefresh];
    }];
    
    
    [XYDriverSchoolNetTool getDriverSchoolWithSortType:DriverSchoolSortType_recommend
                                            isSortRule:DrvierSchoolSortRule_desc
                                                  page:1
                                             isRefresh:NO
                                        viewController:self
                                               success:^(NSArray * _Nonnull array) {
        [weakSelf.listArray addObjectsFromArray:array];
        
        [self isEndRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self isEndRefresh];
    }];
    
}

- (void)isEndRefresh
{
    if (!(-- self.requestNumber)) {
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    }
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
        [kShowLabel setText:@"没有摄像头或摄像头不可用"];
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
        return self.listArray.count;
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
        XYHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:home_cell_key forIndexPath:indexPath];
        cell.myData = self.listArray[indexPath.row];
        return cell;
    }
    
    if (indexPath.section == 1) {
        XYHomeFuncationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:home_funcationCell_key forIndexPath:indexPath];
        
        cell.carousePicture.groupArray = self.homeSmallCarousePictureImagesArray;
        [cell.carousePicture carousePictureClickPictureWithBlock:^(NSString *url) {
            NSLog(@" -- %@",url);
        }];
        
        
        [cell clickFuncationCell:^(XYHomeFuncationTableViewCell *cell, NSInteger clickIndex) {
            UIViewController * vc = nil;
            switch (clickIndex) {
                case 0: {
                    vc = [[XYMustKnowViewController alloc] init];
                    break;
                }
                case 1: {
                    vc = [[XYDriverSchoolViewController alloc] init];
                    [(XYDriverSchoolViewController *)vc setType:driverSchoolType_Near];
                    break;
                }
                case 2: {
                    vc = [[XYDriverSchoolViewController alloc] init];
                    [(XYDriverSchoolViewController *)vc setType:driverSchoolType_Praise];
                    break;
                }
                case 3: {
                    vc = [[XYCoachViewController alloc] init];
                    break;
                }
                case 6: {
                    vc = [[XYNoviceOfRoadViewController alloc] init];
                    break;
                }
                case 7:{
                    break;
                }
            }
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;
    }
    
    XYHomeHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:home_headerCell_key forIndexPath:indexPath];
    cell.carousePicture.groupArray = self.homeCarousePictureImagesArray;


    [cell.carousePicture carousePictureClickPictureWithBlock:^(NSString *url) {
        NSLog(@" -- %@",url);
    }];
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
//    [manager stopUpdatingLocation];
    
    
    [kUserD setValue:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] forKey:kLocation_latitude];
    [kUserD setValue:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] forKey:kLocation_longitude];

    
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
         [kShowLabel setText:@"请您去设置里打开定位服务"];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        [kShowLabel setText:@"无法获取位置信息"];
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
