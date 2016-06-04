//
//  XYPictureView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYPictureView.h"

@interface XYPictureView ()

@property (nonatomic, strong)NSMutableArray<XYAddActionImageView *> * subviewsArray;
@property (nonatomic, strong)NSMutableArray<UILabel *> * labelsArray;

/**
 *  左右的间距
 */
@property (nonatomic, assign)NSInteger leftOrRightMargin;

/**
 *  图片之间的间距
 */
@property (nonatomic, assign)NSInteger pictureViewMargin;


/**
 *  一行有多少图片
 */
@property (nonatomic, assign)NSInteger numberOfPictureViewInLine;



/**
 *  是否含有 label
 */
@property (nonatomic, assign)BOOL isHasLabel;

@end

@implementation XYPictureView

//232 146



- (void)layout
{
    
    NSInteger pictureViewWidth = (NSInteger)((kScreenWidth - (self.leftOrRightMargin * 2) - (self.pictureViewMargin * (self.numberOfPictureViewInLine - 1))) / self.numberOfPictureViewInLine) + 1;
    
    NSInteger pictureViewHeight = 146.0 / 232 * pictureViewWidth;
    
    
    /**
     *  缓存中所有图片数量
     */
    NSInteger allSubviews = self.imagesArray.count;
    
    NSInteger x = allSubviews % self.numberOfPictureViewInLine;
    NSInteger y = self.subviewsArray.count / self.numberOfPictureViewInLine + (x != 0 ? 1 : 0);
    
    //如果不够就创建
    for (NSInteger i = self.subviewsArray.count; i < allSubviews; i ++) {
        if (i % self.numberOfPictureViewInLine == 0 && x!= 0) {
            x = 0;
            y ++;
        }
        
        XYAddActionImageView * pictureView = [[XYAddActionImageView alloc] initWithFrame:CGRectMake(self.leftOrRightMargin + (pictureViewWidth + self.pictureViewMargin) * x, pictureViewHeight * y, pictureViewWidth, pictureViewHeight)];
        pictureView.backgroundColor = kWhiteColor;
        pictureView.tag = xYPictureView_BaseTag + i;
        [pictureView clickView:^(UIImageView *view) {
            NSLog(@" clickImageView tag = %ld",view.tag - xYPictureView_BaseTag);
        }];
        [self addSubview:pictureView];
        [self.subviewsArray addObject:pictureView];
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(pictureViewWidth - 50, pictureViewHeight - 20, 50, 20)];
        label.text = @"128张";
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = kWhiteColor;
        label.textAlignment = NSTextAlignmentRight;
        [pictureView addSubview:label];
        label.hidden = YES;
        [self.labelsArray addObject:label];
        
        x ++;
    }
    
    //如果给的图片不够 把多余的 hidden
    for (NSInteger i = allSubviews; i < self.subviewsArray.count; i ++) {
        XYAddActionImageView * pictureView = self.subviewsArray[i];
        pictureView.hidden = YES;
    }
    
    
    //给图片赋值
    for (int i = 0 ; i < allSubviews; i ++) {
        XYAddActionImageView * pictureView = self.subviewsArray[i];
        pictureView.hidden = NO;
        
        
        id obj = self.imagesArray[i];
        if ([obj isKindOfClass:[NSDictionary class]] && self.type == XYPictureViewType_DriverSchool) {
            [pictureView setImageWithURL:[NSURL URLWithString:obj[carousePicture_imageUrl]] placeholder:kDefaultImage];
        }
        
        UILabel * label = self.labelsArray[i];
        label.hidden = !self.isHasLabel;
        
    }
    
}



#pragma mark -------------------------------------------------------
#pragma mark Setting Method


- (void)setType:(XYPictureViewType)type
{
    _type = type;
    
    switch (type) {
        case XYPictureViewType_DriverSchool:
        case XYPictureViewType_NewDriver:
        case XYPictureViewType_Community: {
            self.isHasLabel = type == XYPictureViewType_DriverSchool;
            self.leftOrRightMargin = 8;
            self.pictureViewMargin = 5;
            self.numberOfPictureViewInLine = 3;
            break;
        }
        
    }
    
    if (self.imagesArray) {
        [self layout];
    }
}

- (void)setImagesArray:(NSArray *)imagesArray type:(XYPictureViewType)type
{
    self.imagesArray = imagesArray;
    self.type = type;
}




#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (NSMutableArray *)subviewsArray
{
    if (!_subviewsArray) {
        _subviewsArray = @[].mutableCopy;
        self.labelsArray = @[].mutableCopy;
    }
    return _subviewsArray;
}

@end
