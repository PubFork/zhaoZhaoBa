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
}


#pragma mark -------------------------------------------------------
#pragma mark CollectionView Delegate & dataSources

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
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
    return view;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XYCarShowAlubumCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:car_show_album_cell_key forIndexPath:indexPath];
    cell.imageView.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYCarShowAlbumDetailViewController * detailVC = [[XYCarShowAlbumDetailViewController alloc] init];
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
