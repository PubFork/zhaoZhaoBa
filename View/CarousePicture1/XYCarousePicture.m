//
//  XYCarousePicture.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCarousePicture.h"
#import "XYCarousePictureCollectionCell.h"

@implementation XYCarousePicture

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

- (void)moveCollectionView
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
- (void)nextImage:(NSTimer *)timer
{
    //当前位置
    int page = self.collectionView.contentOffset.x / self.width;
    
    page ++;
    
    //如果到了最后一张
    if (page >= self.groupArray.count) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage = page - 1;
    }
    
    NSLog(@" ---- %d --- %d",page,self.groupArray.count);
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    
    if (page == self.groupArray.count - 1) {
        [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(moveCollectionView) userInfo:nil repeats:NO];
    }
}


#pragma mark ----------------------------------------------------------------------
#pragma mark ----------------------Collection Delegate-------------------------------------
#pragma mark ----------------------------------------------------------------------


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.groupArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XYCarousePictureCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"a" forIndexPath:indexPath];
    [cell.imageView setImageWithURL:[NSURL URLWithString:self.groupArray[indexPath.row][carousePicture_imageUrl]] placeholder:kDefaultImage];

    cell.myData = self.groupArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYCarousePictureCollectionCell * cell = (XYCarousePictureCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.clickPicture ? self.clickPicture(cell.myData[carousePicture_link]) : 0;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.width, self.height);
}


- (void)setGroupArray:(NSArray *)groupArray
{
    if (!groupArray || ![groupArray isKindOfClass:NSArray.class] ||  groupArray.count == 0) {
        return;
    }
    
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:groupArray];
    
    [array insertObject:array.lastObject atIndex:0];
    [array insertObject:array[1] atIndex:array.count];
    
    _groupArray = [array copy];
    
    self.pageControl.numberOfPages = array.count - 2;
    
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage:) userInfo:nil repeats:YES];
    
}

- (void)carousePictureClickPictureWithBlock:(CarousePictureClickPicture)clickPicture
{
    self.clickPicture = clickPicture;
}


#pragma mark ----------------------------------------------------------------------
#pragma mark ----------------------scrollView Delegate-------------------------------------
#pragma mark ----------------------------------------------------------------------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    
    NSInteger page = scrollView.contentOffset.x / self.width;
    if (page == 0) {
        page = self.groupArray.count;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:page - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
    }
    if (page == self.groupArray.count - 1) {
        page = 1;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    page --;
    
    self.pageControl.currentPage = page;
    
}
#pragma mark ----------------------------------------------------------------------
#pragma mark ----------------------Lazy Loading-------------------------------------
#pragma mark ----------------------------------------------------------------------

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor orangeColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"XYCarousePictureCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"a"];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.collectionView.frame.size.height - 20, self.width, 20)];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = kNavigationBarTextColor;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}

@end
