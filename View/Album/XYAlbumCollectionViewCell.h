//
//  XYAlbumCollectionViewCell.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickViewBlock)();

@interface XYAlbumCollectionViewCell : UICollectionViewCell <UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic,copy)NSString *imgName;


@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIScrollView *scroll;


@property (nonatomic, copy)ClickViewBlock clickViewBlock;

- (void)getClickViewWithBlock:(ClickViewBlock)block;
@end
