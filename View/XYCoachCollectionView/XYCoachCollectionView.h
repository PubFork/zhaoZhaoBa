//
//  XYCoachCollectionView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  教练展示
 */
@interface XYCoachCollectionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionViewFlowLayout * flowLayout;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, copy)NSArray * groupArray;
@end
