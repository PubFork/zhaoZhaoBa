//
//  XYVideoListViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/6/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYVideoListViewController.h"
#import "XYVideoTableViewCell.h"
#import "XYTestQuestionsNetTool.h"
#import "XYSelectLabel.h"
#import "XYVideoViewController.h"

@interface XYVideoListViewController ()
@property (nonatomic, strong)XYSelectLabel * subjectTowLabel;
@property (nonatomic, strong)XYSelectLabel * subjectThreeLabel;


@property (nonatomic, assign)NSInteger type;

@property (nonatomic, assign)NSInteger subjectTowPage;
@property (nonatomic, assign)NSInteger subjectThreePage;
@end

static NSString * video_cell_key = @"video_cell_key";

@implementation XYVideoListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addTableViewIsGroup:NO];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYVideoTableViewCell" bundle:nil] forCellReuseIdentifier:video_cell_key];
    [self addMJFooter];
    
    [self layoutSubviews];
    
    
    self.subjectTowPage = 2;
    self.subjectThreePage = 2;
    self.page = 2;
}

- (void)layoutSubviews
{
    self.titleLabel.hidden = YES;

    [self.naviBar addSubview:self.subjectTowLabel];
    [self.naviBar addSubview:self.subjectThreeLabel];
    
    self.groupArray = self.subjectTowVideos;
    [self.tableView reloadData];
    
    
    WeakSelf(weakSelf);
    [self.subjectTowLabel clickView:^(UIView *view) {
        weakSelf.subjectThreeLabel.isHighlighted = NO;
        weakSelf.groupArray = weakSelf.subjectTowVideos;
        weakSelf.type = 2;
        weakSelf.page = weakSelf.subjectTowPage;
        [weakSelf.tableView reloadData];
    }];
    
    [self.subjectThreeLabel clickView:^(UIView *view) {
        weakSelf.subjectTowLabel.isHighlighted = NO;
        weakSelf.groupArray = weakSelf.subjectThreeVideos;
        weakSelf.type = 3;
        weakSelf.page = weakSelf.subjectThreePage;
        [weakSelf.tableView reloadData];
    }];
    
    
}


- (void)requestData
{
    
    WeakSelf(weakSelf);
    [XYTestQuestionsNetTool getVideoWithPage:self.page type:self.type isRefresh:NO viewController:self success:^(NSArray * _Nonnull array) {
        
        for (NSDictionary * dic in array) {
            [self.groupArray addObject:dic.mutableCopy];
        }
        [weakSelf handleFooterWithCount:array.count];
        [weakSelf.tableView reloadData];
        [weakSelf endRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark -------------------------------------------------------
#pragma mark TableView Delegate & DataSources

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:video_cell_key forIndexPath:indexPath];
    cell.myData = self.groupArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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



#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (XYSelectLabel *)subjectTowLabel
{
    if (!_subjectTowLabel) {
        _subjectTowLabel = [[XYSelectLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _subjectTowLabel.highlightedColor = kNavigationBarTextColor;
        _subjectTowLabel.center = CGPointMake(kScreenWidth / 4, 20 + 44 / 2);
        _subjectTowLabel.text = @"科二";
        _subjectTowLabel.isHighlighted = YES;
    }
    return _subjectTowLabel;
}


- (XYSelectLabel *)subjectThreeLabel
{
    if (!_subjectThreeLabel) {
        _subjectThreeLabel = [[XYSelectLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _subjectThreeLabel.highlightedColor = kNavigationBarTextColor;
        _subjectThreeLabel.center = CGPointMake(kScreenWidth / 4 * 3, 20 + 44 / 2);
        _subjectThreeLabel.text = @"科三";
    }
    return _subjectThreeLabel;
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
