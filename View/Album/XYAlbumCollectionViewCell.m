//
//  XYAlbumCollectionViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYAlbumCollectionViewCell.h"

@interface XYAlbumCollectionViewCell ()
{
    UITapGestureRecognizer *tap;
    UITapGestureRecognizer *doubleTap;
}
@end

@implementation XYAlbumCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self){
        
        _scroll = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scroll.minimumZoomScale = 1;
        _scroll.maximumZoomScale = 2;
        _scroll.delegate = self;
        _scroll.directionalLockEnabled = YES;
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleAction:)];
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.delegate = self;
        [_scroll addGestureRecognizer:doubleTap];
        [_scroll addSubview:_imageView];
        [self.contentView addSubview:_scroll];
        
        

        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleAction:)];
        tap.delegate = self;
        [_scroll addGestureRecognizer:tap];

        
        [tap requireGestureRecognizerToFail:doubleTap];

    }
    return self;
}


- (void)getClickViewWithBlock:(ClickViewBlock)block
{
    self.clickViewBlock = block;
}

- (void)setImgName:(NSString *)imgName{
    _imgName = imgName;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _scroll.zoomScale = 1;
//    UIImage *img = [UIImage imageNamed:_imgName];
    
    
    _scroll.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBar_Height);
    _scroll.contentSize = CGSizeMake(kScreenWidth, kScreenHeight - kNavigationBar_Height);
    
    _imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBar_Height);
//    [_imageView setImage:img];
    
}

- (void)doubleAction:(UITapGestureRecognizer *)tap{
    
    if (tap == doubleTap) {
        [UIView animateWithDuration:.2 animations:^{
            if(_scroll.zoomScale != 1){
                _scroll.zoomScale = 1;
            }else{
                _scroll.zoomScale = 2;
            }
        }];
        
        [self contentScroller];

    } else {
        self.clickViewBlock ? self.clickViewBlock(): 0;
    }
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    [self contentScroller];
    
}

- (void)contentScroller{
    CGRect f = _imageView.frame;
    CGSize size = _scroll.frame.size;
    
    if(f.size.width < size.width){
        f.origin.x = (kScreenWidth - f.size.width)/2;
    }else{
        f.origin.x = 0.0f;
    }
    if(f.size.height < size.height){
        f.origin.y = (kScreenHeight - f.size.height)/2;
    }else{
        f.origin.y = 0.0f;
    }
    _imageView.frame = f;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return _imageView;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    NSLog(@" -- %@",touch.view);
//    if ([touch.view isKindOfClass:[UIScrollView class]])
//    {
//        return NO;
//    }
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([touch.view isKindOfClass:XYAlbumCollectionViewCell.class]) {
//        return NO;
//    }
//    return YES;
//}

@end
