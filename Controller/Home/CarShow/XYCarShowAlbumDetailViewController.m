//
//  XYCarShowAlbumDetailViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCarShowAlbumDetailViewController.h"

@interface XYCarShowAlbumDetailViewController ()

@end
static NSString * car_show_album_detail_cell_key = @"car_show_album_detail_cell_key";

@implementation XYCarShowAlbumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCollectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XYCarShowAlubumCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:car_show_album_detail_cell_key];
}


#pragma mark -------------------------------------------------------
#pragma mark CollectionView Delegate & dataSources

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(kScreenWidth / 3 - 1.5, 123);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XYCarShowAlubumCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:car_show_album_detail_cell_key forIndexPath:indexPath];
    cell.imageView.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
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
