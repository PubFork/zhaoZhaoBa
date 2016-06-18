//
//  XYCarShowAlbumViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCarShowAlbumViewController.h"
#import "XYCarShowAlbumDetailViewController.h"
#import "XYCarShowAlbumCollectionReusableView.h"
#import "XYCareShowNetTool.h"

@interface XYCarShowAlbumViewController ()
@end

static NSString * car_show_album_cell_key = @"car_show_album_cell_key";
static NSString * car_show_album_header_key = @"car_show_album_header_key";

@implementation XYCarShowAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addCollectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XYCarShowAlubumCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:car_show_album_cell_key];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XYCarShowAlbumCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:car_show_album_header_key];
    self.collectionView.backgroundColor = kWhiteColor;
    
    [self addMJHeader];
    [self.collectionView.mj_header beginRefreshing];
}


#pragma mark -------------------------------------------------------
#pragma mark HTTP
- (void)requestData
{
    WeakSelf(weakSelf);
    [XYCareShowNetTool getCareImageListWithCarTypeID:self.carID isRefresh:NO viewController:self success:^(NSDictionary * _Nonnull dic) {
        
        weakSelf.groupArray = dic[@"data"];
        [weakSelf.collectionView reloadData];
        [weakSelf endRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf endRefresh];
    }];
}


#pragma mark -------------------------------------------------------
#pragma mark CollectionView Delegate & dataSources

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.groupArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.groupArray[section][car_show_list] count];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(kScreenWidth / 3 - 1.5, 123);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    XYCarShowAlbumCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:car_show_album_header_key forIndexPath:indexPath];
    view.titleLabel.text = self.groupArray[indexPath.section][car_show_name];
    view.numberLabel.text = [NSString stringWithFormat:@"共%@张",self.groupArray[indexPath.section][car_show_num]];
    return view;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XYCarShowAlubumCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:car_show_album_cell_key forIndexPath:indexPath];
    [cell.imageView setImageWithURL:[NSURL URLWithString:self.groupArray[indexPath.section][car_show_list][indexPath.row]] placeholder:kDefaultImage];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYCarShowAlbumDetailViewController * detailVC = [[XYCarShowAlbumDetailViewController alloc] init];
    detailVC.carTypeID = self.groupArray[indexPath.section][car_show_typeid];
    detailVC.carID = self.carID;
    detailVC.title = self.groupArray[indexPath.section][car_show_name];
    [self.navigationController pushViewController:detailVC animated:YES];
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
