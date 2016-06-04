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



//////////////////////////////////支付说明////////////////////////////
@property (weak, nonatomic) IBOutlet UILabel *payContentLabel;

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
    WeakSelf(weakSelf);
    [XYDriverSchoolNetTool getDriverSchoolDetailWithID:self.driverSchoolID
                                             isRefresh:YES
                                        viewController:self
                                               success:^(NSDictionary * _Nonnull dic) {
                                                   [weakSelf layout:dic];
                                               } failure:nil];
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

    
    
    self.scrollViewContentHeight.constant = CGRectGetMaxY(self.payContentLabel.superview.frame);
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
