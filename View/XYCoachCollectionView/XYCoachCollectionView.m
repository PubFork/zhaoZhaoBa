//
//  XYCoachCollectionView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCoachCollectionView.h"
#import "XYCoachCollectionViewCell.h"

static NSString * coachCollectionView_cell_key = @"coachCollectionView_cell_key";

@implementation XYCoachCollectionView



- (void)layoutSubviews
{
    [self.collectionView reloadData];
}



#pragma mark -------------------------------------------------------
#pragma mark CollectionView Delegate & Sources


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
    return self.groupArray.count > 4 ? 4 : self.groupArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYCoachCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:coachCollectionView_cell_key forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth / 4 - 1, 125);
}



#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.flowLayout.minimumInteritemSpacing = 1;
        self.flowLayout.minimumLineSpacing = 1;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kWhiteColor;
        [_collectionView registerNib:[UINib nibWithNibName:@"XYCoachCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:coachCollectionView_cell_key];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}




@end
