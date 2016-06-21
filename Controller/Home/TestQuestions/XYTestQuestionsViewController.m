//
//  XYTestQuestionsViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYTestQuestionsViewController.h"
#import "XYCarousePicture.h"
#import "XYTouchView.h"
#import "XYTestQuestionsNetTool.h"
#import "XYAddActionLabel.h"
#import "XYSelectTextView.h"
#import "XYTestQuestionsCollectionViewCell.h"
#import "XYVideoViewController.h"
#import "XYVideoListViewController.h"
#import "XYCommunityViewController.h"

static NSInteger community_top_detault = 394;
static NSInteger community_top_height = 476;

static NSString * test_questions_cell_key = @"test_questions_cell_key";

@interface XYTestQuestionsViewController ()


////////////////////////////////// Header ////////////////////////////////////////

@property (weak, nonatomic) IBOutlet XYSelectTextView *headerView;




@property (weak, nonatomic) IBOutlet XYCarousePicture *carousePictureView;


@property (weak, nonatomic) IBOutlet UIView *testQuestionsView;

@property (weak, nonatomic) IBOutlet UIView *requstionsView;

@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UICollectionView *videoCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *videoViewTitleLabel;

////////////////////////////////// 按钮 ////////////////////////////////////////
/**
 *  顺序练习
 */
@property (weak, nonatomic) IBOutlet XYTouchView *orderTestView;
@property (weak, nonatomic) IBOutlet XYTouchView *randomTestView;
@property (weak, nonatomic) IBOutlet XYTouchView *sepcialTestView;
@property (weak, nonatomic) IBOutlet XYTouchView *excludeTestView;

@property (weak, nonatomic) IBOutlet XYTouchView *memoryQuestionsView;
@property (weak, nonatomic) IBOutlet XYTouchView *myErrorQiestionsView;
@property (weak, nonatomic) IBOutlet XYTouchView *questionsSkillView;
@property (weak, nonatomic) IBOutlet XYTouchView *myActivityView;

@property (weak, nonatomic) IBOutlet XYAddActionView *communityView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *communityTop;



@property (nonatomic, strong)NSMutableArray * subjectTowVideos;
@property (nonatomic, strong)NSMutableArray * subjectThreeVideos;





@end

@implementation XYTestQuestionsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"试题"];
    
    [self requestData];
    
    [self.videoCollectionView registerNib:[UINib nibWithNibName:@"XYTestQuestionsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:test_questions_cell_key];
    
    
    self.subjectTowVideos = @[].mutableCopy;
    self.subjectThreeVideos = @[].mutableCopy;
    
    WeakSelf(weakSelf);
    
    ////////////////////////////////// Header ////////////////////////////////////////
    self.headerView.textArray = @[@"科一",@"科二",@"科三",@"科四"];
    [self.headerView selectTextWithBlock:^(NSInteger index) {
        BOOL isSubjectOneOrFour = (index == 0 || index == 3);
        weakSelf.communityTop.constant = !isSubjectOneOrFour ? community_top_height : community_top_detault;
        
        weakSelf.testQuestionsView.hidden = !isSubjectOneOrFour;
        weakSelf.requstionsView.hidden = !isSubjectOneOrFour;
        weakSelf.videoView.hidden = isSubjectOneOrFour;
        
        weakSelf.groupArray = isSubjectOneOrFour ? weakSelf.groupArray : index == 1 ? weakSelf.subjectTowVideos : weakSelf.subjectThreeVideos;
        
        [weakSelf.videoCollectionView reloadData];
        
        weakSelf.videoViewTitleLabel.text = [NSString stringWithFormat:@"科目%@教学视频",!isSubjectOneOrFour ? index == 1 ? @"二" : @"三" : @""];
    }];
    
    
    
    
    ////////////////////////////////// 按钮 ////////////////////////////////////////

    
    
    
    [self.communityView clickView:^(UIView *view) {
        XYCommunityViewController * communityVC = [XYCommunityViewController shareCommunityViewController];
        [weakSelf.navigationController pushViewController:communityVC animated:YES];
    }];
    
    
}

- (void)requestData
{
    
    
    WeakSelf(weakSelf);
    [XYTestQuestionsNetTool getTestQuestionsIsRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
        [weakSelf layoutSubViews:dic];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
    [XYTestQuestionsNetTool getVideoWithPage:1 type:2 isRefresh:NO viewController:self success:^(NSArray * _Nonnull array) {
        for (NSDictionary * dic in array) {
            [weakSelf.subjectTowVideos addObject:dic.mutableCopy];
        }
        [weakSelf.videoCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
    [XYTestQuestionsNetTool getVideoWithPage:1 type:3 isRefresh:NO viewController:self success:^(NSArray * _Nonnull array) {
        for (NSDictionary * dic in array) {
            [weakSelf.subjectThreeVideos addObject:dic.mutableCopy];
        }
        [weakSelf.videoCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

- (void)layoutSubViews:(NSDictionary *)dic
{
    self.carousePictureView.groupArray = dic[test_questions_banner];

    NSArray * usersArray = dic[test_questions_userpiclist];
    
    NSInteger count = 7;
    NSInteger leftRight = 13;
    NSInteger line = 3;
    
    NSInteger widthHeight = (kScreenWidth - leftRight * 2 - line * (count - 1)) / count;
    
    int x = 0;
    for (NSString * imgUrl in usersArray) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftRight + (widthHeight + line) * x, 44, widthHeight, widthHeight)];
        imageView.backgroundColor = kWhiteColor;
        
        [Manager setRadiusImageWithImageUrl:imgUrl imageView:imageView];
        
        [self.communityView addSubview:imageView];
        x ++;
    }
}



#pragma mark -------------------------------------------------------
#pragma mark Click

- (IBAction)clickTestQuestions:(id)sender {
}

- (IBAction)clickWX:(id)sender {
}
- (IBAction)clickFriendCircle:(id)sender {
}
- (IBAction)clickQQ:(id)sender {
}
- (IBAction)clickSpace:(id)sender {
}
- (IBAction)clickDownloadBtn:(id)sender {
    
    XYVideoListViewController * videoList = [[XYVideoListViewController alloc] init];
    videoList.subjectTowVideos = self.subjectTowVideos;
    videoList.subjectThreeVideos = self.subjectThreeVideos;
    [self.navigationController pushViewController:videoList animated:YES];
}



#pragma mark -------------------------------------------------------
#pragma mark Collection Delegate & dataSources
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.groupArray.count > 4 ? 4 : self.groupArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYTestQuestionsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:test_questions_cell_key forIndexPath:indexPath];
    cell.myData = self.groupArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth / 2 - 15, 120);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYVideoViewController * videoVC = self.groupArray[indexPath.row][download_text_key];
    if (videoVC) {
        [self.navigationController pushViewController:videoVC animated:YES];
        return;
    }
    
    videoVC = [[XYVideoViewController alloc] init];
    videoVC.myData = self.groupArray[indexPath.row];
    [self.navigationController pushViewController:videoVC animated:YES];
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
