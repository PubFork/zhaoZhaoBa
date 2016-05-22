//
//  XYAddCommunityUpdatePictureView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYAddCommunityUpdatePictureView.h"

@interface XYAddCommunityUpdatePictureView ()

@property (nonatomic, strong)NSMutableArray * allImageViews;
@property (nonatomic, strong)NSMutableArray * currentImageViews;
@property (nonatomic, assign)NSInteger widthOrHeight;
@end

@implementation XYAddCommunityUpdatePictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self creatImageView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self creatImageView];
}

#pragma mark -------------------------------------------------------
#pragma mark Inner Method





- (void)creatImageView
{
    self.widthOrHeight = 70;

    self.allImageViews = @[].mutableCopy;
    self.currentImageViews = @[].mutableCopy;
    
    [self addSubview:self.addImageView];
    
    WeakSelf(weakSelf);
    
    for (int i = 0 ; i < 3 ; i ++) {
        XYAddActionImageView * imageView = [[XYAddActionImageView alloc] initWithFrame:CGRectMake(20 + (self.widthOrHeight + 10)* i, 0, self.widthOrHeight, self.widthOrHeight)];
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        imageView.hidden = YES;
        [self.allImageViews addObject:imageView];
        
        [imageView clickView:^(UIImageView *view) {
            weakSelf.clickImageViewBlock ? weakSelf.clickImageViewBlock(view) : 0;
        }];
        [self addSubview:imageView];
    }
}

- (void)updateAddImageViewFrame
{
    self.addImageView.mj_x = self.currentImageViews.count * (self.widthOrHeight + 10) + 20;
}

- (void)updateAllImageViewsFrame
{
    for (int i = 0 ; i < self.allImageViews.count ; i ++) {
        UIView * view = self.allImageViews[i];
        view.mj_x = 20 + (self.widthOrHeight + 10)* i;
    }
}



#pragma mark -------------------------------------------------------
#pragma mark Method

- (void)addImageViewWithImage:(UIImage *)image
{
    
    XYAddActionImageView * imageView = self.allImageViews[self.currentImageViews.count];
    imageView.hidden = NO;
    imageView.image = image;
    
    
    [self.currentImageViews addObject:imageView];
    
    [self updateAddImageViewFrame];

    
}

- (void)removeImageWithImageView:(UIImageView *)imageView
{
    imageView.hidden = YES;
    
    if ([self.allImageViews indexOfObject:imageView] != self.currentImageViews.count - 1) {
        [self.allImageViews removeObject:imageView];
        [self.allImageViews addObject:imageView];
    }
    
    [self.currentImageViews removeObject:imageView];
    [self updateAddImageViewFrame];
    [self updateAllImageViewsFrame];
}

- (void)clickAddImageViewWithBlock:(clickAddImageViewBlock)block
{
    self.clickAddImageViewBlock = block;
}

- (void)clickImageViewWithBlock:(clickImageViewBlock)block
{
    self.clickImageViewBlock = block;
}

#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (XYAddActionImageView *)addImageView
{
    if (!_addImageView) {
        _addImageView = [[XYAddActionImageView alloc] initWithFrame:CGRectMake(20, 10, 50, 50)];
        _addImageView.image = kImage(@"添加图片");
        WeakSelf(weakSelf);
        [_addImageView clickView:^(UIImageView *view) {
            if (weakSelf.currentImageViews.count >= 3) {
                [kShowLabel setText:@"最多只能添加三张"];
                return ;
            }
            weakSelf.clickAddImageViewBlock ? weakSelf.clickAddImageViewBlock() : 0;
        }];
    }
    return _addImageView;
}

@end
