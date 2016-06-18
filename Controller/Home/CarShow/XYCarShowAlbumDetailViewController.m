//
//  XYCarShowAlbumDetailViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCarShowAlbumDetailViewController.h"
#import "XYAlbumViewController.h"
#import "XYCareShowNetTool.h"

@interface XYCarShowAlbumDetailViewController ()

@end
static NSString * car_show_album_detail_cell_key = @"car_show_album_detail_cell_key";

@implementation XYCarShowAlbumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCollectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XYCarShowAlubumCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:car_show_album_detail_cell_key];
    self.collectionView.backgroundColor = kWhiteColor;
    
    [self addMJHeader];
    [self addMJFooter];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark -------------------------------------------------------
#pragma mark HTTP
- (void)requestData
{
    WeakSelf(weakSelf);
    [XYCareShowNetTool getCareImageTypeWithCarTypeID:self.carID page:self.page imageListID:self.carTypeID isRefresh:NO viewController:self success:^(NSDictionary * _Nonnull dic) {
        [weakSelf.groupArray addObjectsFromArray:dic[car_show_piclist]];
        [weakSelf handleFooterWithCount:[dic[car_show_piclist] count]];
        [weakSelf endRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf endRefresh];
    }];
}



#pragma mark -------------------------------------------------------
#pragma mark CollectionView Delegate & dataSources

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.groupArray.count;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(kScreenWidth / 3 - 8, 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XYCarShowAlubumCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:car_show_album_detail_cell_key forIndexPath:indexPath];
    [cell.imageView setImageWithURL:[NSURL URLWithString:self.groupArray[indexPath.row]] placeholder:kDefaultImage];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 5, 2, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYAlbumViewController * albumVC = [XYAlbumViewController shareXYAlbumViewController];
    albumVC.groupArray = self.groupArray;
    albumVC.index = indexPath.row;
    [self.navigationController pushViewController:albumVC animated:YES];
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
