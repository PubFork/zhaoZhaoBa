//
//  XYNearDriverSchoolDetailViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYDriverSchoolDetailViewController.h"
#import "XYPictureView.h"
#import "XYCoachCollectionView.h"


#import "XYDriverSchoolNetTool.h"
#import "XYCommunityViewController.h"
#import "XYCoachViewController.h"

#import "XYAlbumViewController.h"
#import "XYSignUpViewController.h"

#import <BaiduMapKit/BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapKit/BaiduMapAPI_Base/BMKBaseComponent.h>

#import "UIImage+Rotate.h"

#import "XYSignInViewController.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end


@interface XYDriverSchoolDetailViewController () <BMKMapViewDelegate, BMKRouteSearchDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet XYPictureView *pictureView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureViewHeight;


//////////////////////////////////驾校信息////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *personNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;


//////////////////////////////////评论////////////////////////////
@property (weak, nonatomic) IBOutlet UILabel *commentTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *commentHeadBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentContentHeight;


//////////////////////////////////教练展示////////////////////////////

@property (weak, nonatomic) IBOutlet XYCoachCollectionView *coachCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;



//////////////////////////////////驾校 说明////////////////////////////
//简介
@property (weak, nonatomic) IBOutlet UILabel *schoolProfilesLabel;

//优势特色
@property (weak, nonatomic) IBOutlet UILabel *schoolVotesLabel;

//说明
@property (weak, nonatomic) IBOutlet UILabel *schoolExplanLabel;

//////////////////////////////////地图////////////////////////////

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (nonatomic, strong)BMKRouteSearch * routesearch;;

//////////////////////////////////支付说明////////////////////////////
@property (weak, nonatomic) IBOutlet UILabel *payContentLabel;


@property (weak, nonatomic) IBOutlet UIButton *studyTimePatBtn;
@property (weak, nonatomic) IBOutlet UIButton *allPriceBtn;
@property (weak, nonatomic) IBOutlet UIButton *feedBtn;


@end

@implementation XYDriverSchoolDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _routesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _routesearch.delegate = nil; // 不用时，置nil
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleLabelText:@"驾校详情"];
    
    self.routesearch = [[BMKRouteSearch alloc]init];

    WeakSelf(weakSelf);
    [self.pictureView clickImageWithBlock:^(NSArray *imagesArray, NSInteger index) {
        XYAlbumViewController * albumVC = [XYAlbumViewController shareXYAlbumViewController];
        albumVC.groupArray = imagesArray.mutableCopy;
        albumVC.index = index;
        [weakSelf.navigationController pushViewController:albumVC animated:YES];
    }];
    
    
    [self requestData];
    
    
    
    self.studyTimePatBtn.layer.cornerRadius = 5;
    self.studyTimePatBtn.layer.masksToBounds = YES;
    
    self.allPriceBtn.layer.cornerRadius = 5;
    self.allPriceBtn.layer.masksToBounds = YES;
    
    self.feedBtn.layer.cornerRadius = 5;
    self.feedBtn.layer.masksToBounds = YES;
}

#pragma mark -------------------------------------------------------
#pragma mark HTTP

- (void)requestData
{
    WeakSelf(weakSelf);
    if (self.driverSchoolID) {
        [XYDriverSchoolNetTool getDriverSchoolDetailWithID:self.driverSchoolID
                                                 isRefresh:YES
                                            viewController:self
                                                   success:^(NSDictionary * _Nonnull dic) {
                                                       [weakSelf layout:dic];
                                                   } failure:nil];

        return;
    }
    
    if (self.token) {
        [XYDriverSchoolNetTool getMyDriverSchoolWithToken:self.token isRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
             [weakSelf layout:dic];
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            
        }];
    }
    
}

- (void)layout:(NSDictionary *)dic
{
    
    self.pictureView.allArray = dic[driverSchool_detail_imglist];
    
    [self.pictureView setImagesArray:[self.pictureView.allArray subarrayWithRange:NSMakeRange(0, self.pictureView.allArray.count > 3 ? 3 : self.pictureView.allArray.count)] type:XYPictureViewType_DriverSchool];
    
    
    //////////////////////////////////驾校信息////////////////////////////

    self.timeLabel.text = dic[driverSchool_detail_lastordertime];
    self.personNumberLabel.text = [kManager getStringWithObj:dic[driverSchool_detail_transnumber]];
    self.allPriceLabel.text = [kManager getStringAddYuanWithObj:dic[driverSchool_detail_transamount]];
    self.oldPriceLabel.text = [kManager getStringWithObj:dic[DriverSchoolSortType_price]];
    self.priceLabel.text = [kManager getStringWithObj:dic[driverSchool_detail_discountprice]];
    self.schoolNameLabel.text = dic[driverSchool_schoolname];
    
    
    //////////////////////////////////评论////////////////////////////

//    self.commentTitleLabel.text = dic[driverSchool_detail_comment];
    NSDictionary * comment = dic[driverSchool_detail_comment];
    self.commentNameLabel.text = comment[comment_username];
    [self.commentHeadBtn setImageWithURL:[NSURL URLWithString:comment[comment_userimg]] forState:UIControlStateNormal placeholder:kDefaultImage];
    self.commentTimeLabel.text = comment[comment_time];
    self.commentContentLabel.text = comment[comment_content];
    
    NSInteger height = [self.commentContentLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 80, 222222) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    self.commentContentHeight.constant = height;
    
    
    //////////////////////////////////教练展示////////////////////////////

    self.coachCollectionView.groupArray = dic[driverSchool_detail_coachlist];
    
    
    //////////////////////////////////驾校 说明////////////////////////////
    //简介
    self.schoolProfilesLabel.text = dic[driverSchool_detail_profile];
    
    //优势特色
    self.schoolVotesLabel.text = dic[driverSchool_detail_characteristic];
    
    //说明
    self.schoolExplanLabel.text = dic[driverSchool_detail_explain];
    
    
    ////////////////////////////////// 支付说明 ////////////////////////////////////////

    self.payContentLabel.text = dic[driverSchool_detail_payinformation];
    
    ////////////////////////////////// 地图 ////////////////////////////////////////
    
    NSString * latitude = [kUserD valueForKey:kLocation_latitude];
    NSString * longitude = [kUserD valueForKey:kLocation_longitude];
    
    latitude = latitude ? latitude : @"39.851333";
    longitude = longitude ? longitude : @"116.33677";
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = {latitude.floatValue,longitude.floatValue};
    

    start.pt = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(start.pt, BMK_COORDTYPE_GPS));

    
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    
    end.pt = {[dic[@"latitude"] floatValue],[dic[@"longitude"] floatValue]};
    
//    end.pt = {[dic[@"longitude"] floatValue],[dic[@"latitude"] floatValue]};

    end.pt = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(end.pt, BMK_COORDTYPE_GPS));
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    drivingRouteSearchOption.drivingRequestTrafficType = BMK_DRIVING_REQUEST_TRAFFICE_TYPE_NONE;//不获取路况信息
    BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
    }
    else
    {
        NSLog(@"car检索发送失败");
    }

    
}

#pragma mark -------------------------------------------------------
#pragma mark Inner Method

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
        }
            break;
        default:
            break;
    }
    
    return view;
}
- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}
//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}


#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}



/**
 *返回驾乘搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKDrivingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }

}
#pragma mark -------------------------------------------------------
#pragma mark Click Method

- (IBAction)clickSeeDetailOfComment:(UIButton *)sender {
    XYCommunityViewController * communityVC = [[XYCommunityViewController alloc] init];
    communityVC.style = CommunityStyle_DriverSchool;
    communityVC.dsID = @(self.driverSchoolID);
    [self.navigationController pushViewController:communityVC animated:YES];
}

- (IBAction)clickSeeDetailOfCollectionView:(id)sender {
    XYCoachViewController * coachVC = [[XYCoachViewController alloc] init];
    coachVC.drvierSchoolID = @(self.driverSchoolID);
    [self.navigationController pushViewController:coachVC animated:YES];
}

- (IBAction)studyTime:(id)sender {
    if ([kUserManager userIsSign]) {
        XYSignUpViewController * signVc = [[XYSignUpViewController alloc] init];
        signVc.su_payselect = 1;
        signVc.driverSchoolID = @(self.driverSchoolID);
        [self.navigationController pushViewController:signVc animated:YES];
    } else {
        [XYSignInViewController showSignViewControllerWithViewController:self];
    }
    
}
- (IBAction)allPrice:(id)sender {
    if ([kUserManager userIsSign]) {
        XYSignUpViewController * signVc = [[XYSignUpViewController alloc] init];
        signVc.su_payselect = 2;
        signVc.driverSchoolID = @(self.driverSchoolID);
        [self.navigationController pushViewController:signVc animated:YES];
    } else {
        [XYSignInViewController showSignViewControllerWithViewController:self];
    }
    
}
- (IBAction)feed:(id)sender {
    if ([kUserManager userIsSign]) {
        
    } else {
        [XYSignInViewController showSignViewControllerWithViewController:self];
    }
}

- (IBAction)upUp:(id)sender {
    [self.scrollView scrollToTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
