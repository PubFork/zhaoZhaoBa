//
//  XYCarShowOneTypeTableView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DidSelectItemBlock)(NSIndexPath * indexPatch);

@interface XYCarShowOneTypeTableView : UITableView

@property (nonatomic, assign)BOOL isShow;

- (void)show;
- (void)hidden;



@property (nonatomic, copy)DidSelectItemBlock didSelectItemBlock;

- (void)getDidSelectItemWtihBlock:(DidSelectItemBlock)block;
@end
