//
//  XYCoachViewController.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSelectViewController.h"

typedef void(^SelectCoachBlock) (NSDictionary * coachDic);
/**
 *  教练
 */
@interface XYCoachViewController : XYSelectViewController
@property (nonatomic, strong)NSNumber * drvierSchoolID;

/**
 *  是否是选择模式
 */
@property (nonatomic, assign)BOOL isSelect;


@property (nonatomic, copy)SelectCoachBlock selectCoachBlock;
- (void)selectCoachWithBlock:(SelectCoachBlock)block;
@end
