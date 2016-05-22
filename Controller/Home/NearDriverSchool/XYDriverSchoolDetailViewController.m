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

@interface XYDriverSchoolDetailViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContentHeight;

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

@property (weak, nonatomic) IBOutlet XYCoachCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;



//////////////////////////////////驾校 说明////////////////////////////
//简介
@property (weak, nonatomic) IBOutlet UILabel *schoolProfilesLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *schoolProfilesLabelHeight;

//优势特色
@property (weak, nonatomic) IBOutlet UILabel *schoolVotesLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *schoolVotesLabelHeight;

//简介
@property (weak, nonatomic) IBOutlet UILabel *schoolExplanLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *schoolExplanLabelHeight;

//////////////////////////////////地图////////////////////////////



//////////////////////////////////支付说明////////////////////////////
@property (weak, nonatomic) IBOutlet UILabel *payContentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payContentLabelHeight;

@end

@implementation XYDriverSchoolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleLabelText:@"驾校详情"];
    
    
    self.scrollViewContentHeight.constant = 800;
    
    [self.pictureView setImagesArray:@[@"picture1",@"picture2",@"picture3"] type:XYPictureViewType_DriverSchool];
    
    [self requestData];
}

- (void)requestData
{
    [XYDriverSchoolNetTool getDriverSchoolDetailWithID:self.driverSchoolID
                                             isRefresh:YES
                                        viewController:self
                                               success:^(NSDictionary * _Nonnull dic) {
                                                   NSLog(@" school Detail = %@",dic);
                                               } failure:nil];
}
#pragma mark -------------------------------------------------------
#pragma mark Click Method

- (IBAction)clickPraiseBtn:(UIButton *)sender {
}

- (IBAction)clickSeeDetailOfComment:(UIButton *)sender {
    XYCommunityViewController * communityVC = [[XYCommunityViewController alloc] init];
    communityVC.style = CommunityStyle_DriverSchool;
    [self.navigationController pushViewController:communityVC animated:YES];
}

- (IBAction)clickSeeDetailOfCollectionView:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
