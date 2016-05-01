//
//  XYCityTableView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCityTableView.h"
#import "UIView+MJExtension.h"

@interface XYCityTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak)UITableViewCell * cell;

@property (nonatomic, strong)NSMutableDictionary * groupDic;
@property (nonatomic, strong)NSMutableArray * allKeys;
@end


@implementation XYCityTableView


static UIColor * backgroudColor = nil;

//省 字体颜色
static UIColor * provinceTextColor;
//省 背景颜色
static UIColor * provinceCellBackgroudColor;


//市 字体颜色
static UIColor * municipalityTextColor;
//市 背景颜色
static UIColor * municipalityCellBackgroudColor;





static NSString * cellIndentifier = @"cell";


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            backgroudColor = kRGB(238, 238, 238);
            
            municipalityTextColor = kRGB(160, 160, 160);
            municipalityCellBackgroudColor = [UIColor whiteColor];
            
            provinceTextColor = kRGB(0, 0, 0);
            provinceCellBackgroudColor = kRGB(247, 247, 247);

        });
        
        self.selfHeight = frame.size.height;
        self.backgroundColor = backgroudColor;
        
        
       
        
        [self addSubview:self.provinceTableView];
        [self addSubview:self.municipalityTableView];
        
     
        NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
        
        self.groupDic = @{}.mutableCopy;
        self.allKeys = @[].mutableCopy;

        for (int i = 0 ; i < dic.allKeys.count; i ++) {
            NSDictionary * rootDic = dic[[NSString stringWithFormat:@"%d",i]];
            
            for (NSString * province in rootDic.allKeys) {
                NSDictionary * oneDic = rootDic[province];
                NSMutableArray * cityArray = @[].mutableCopy;
                for (int i = 0 ; i < oneDic.allKeys.count; i ++) {
                    NSDictionary * cityDic = oneDic[[NSString stringWithFormat:@"%d",i]];
                    for (NSString * city  in cityDic.allKeys) {
                        [cityArray addObject:city];
                    }
                }
                [self.groupDic setValue:cityArray forKey:province];
                [self.allKeys addObject:province];
            }
        }
        
        [self.provinceTableView reloadData];
        self.cell = [self.provinceTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        self.cell.backgroundColor = municipalityCellBackgroudColor;
        [self.municipalityTableView reloadData];
    }
    
    
    
    return self;
}

#pragma mark -------------------------------------------------------
#pragma mark Method
- (void)isShow:(BOOL)isShow selectIsShow:(void (^)(BOOL, NSString *))selectIsShow
{
    self.selectIsShow = selectIsShow;
    [self isShow:isShow];
}

- (void)isShow:(BOOL)isShow
{
    NSInteger height = - self.selfHeight;
    if (isShow) {
        height = kNavigationBar_Height;
    }
    
    [UIView animateWithDuration:kHomeCityAnimate_time animations:^{
        self.mj_y = height;
    }];
}




#pragma mark -------------------------------------------------------
#pragma mark TableView DataSourec & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //如果是 市区
    if (tableView == self.municipalityTableView) {
        return [self.groupDic[self.cell.textLabel.text] count];
    }
    return self.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    
    
    // 市
    if (tableView == self.municipalityTableView) {
        cell.backgroundColor = municipalityCellBackgroudColor;
        cell.textLabel.textColor = municipalityTextColor;
        
        cell.textLabel.text = self.groupDic[self.cell.textLabel.text][indexPath.section];

    } else {
        cell.backgroundColor = provinceCellBackgroudColor;
        cell.textLabel.textColor = provinceTextColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = self.allKeys[indexPath.section];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];

    if (tableView == self.municipalityTableView) {
        [self isShow:NO];
        self.selectIsShow ? self.selectIsShow(NO, cell.textLabel.text) : 0 ;
        return;
    }
    
    self.cell.backgroundColor = provinceCellBackgroudColor;
    
    cell.backgroundColor = municipalityCellBackgroudColor;
    self.cell = cell;
    
    [self.municipalityTableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .5;
}

#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (UITableView *)municipalityTableView
{
    if (!_municipalityTableView) {
        _municipalityTableView = [[UITableView alloc] initWithFrame:CGRectMake((NSInteger)(self.width * .38) + 1,
                                                                               0,
                                                                               (NSInteger)(kScreenWidth * (1 - 0.38)) - 1,
                                                                               self.height) style:UITableViewStyleGrouped];
        _municipalityTableView.backgroundColor = backgroudColor;
        _municipalityTableView.dataSource = self;
        _municipalityTableView.delegate = self;
        _municipalityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _municipalityTableView.tableFooterView = [UIView new];
        [_municipalityTableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellIndentifier];
        
        
    }
    return _municipalityTableView;
}


- (UITableView *)provinceTableView
{
    if (!_provinceTableView) {
        _provinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, (NSInteger)(self.width * .38), self.height) style:UITableViewStyleGrouped];
        _provinceTableView.backgroundColor = backgroudColor;
        _provinceTableView.dataSource = self;
        _provinceTableView.delegate = self;
        _provinceTableView.tableFooterView = [UIView new];
        _provinceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;


        [_provinceTableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellIndentifier];

    }
    return _provinceTableView;
}
@end
