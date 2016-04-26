//
//  XYCarousePicture.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCarousePicture : UIView  <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSArray * groupArray;

/**
 *  计时器
 */
@property (nonatomic,strong)NSTimer * timer;
/**
 *  小点
 */
@property (nonatomic,strong)UIPageControl * pageControl;
@end
