//
//  XYCityTableView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCityTableView.h"

@interface XYCityTableView () <UITableViewDelegate, UITableViewDataSource>


@end


@implementation XYCityTableView


static NSString * cellIndentifier = @"cell";


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.selfHeight = frame.size.height;
        self.backgroundColor = [UIColor whiteColor];
        
        ;
        
        
        [self addSubview:self.provinceTableView];
        [self addSubview:self.municipalityTableView];
        
    }
    return self;
}



#pragma mark -------------------------------------------------------
#pragma mark TableView DataSourec & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //如果是 市区
    if (tableView == self.municipalityTableView) {
        return 10;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    
    
    //省 字体颜色
    static UIColor * provinceTextColor;
    //省 背景颜色
    static UIColor * provinceCellBackgroudColor;
    
    //市 字体颜色
    static UIColor * municipalityTextColor;
    //市 背景颜色
    static UIColor * municipalityCellBackgroudColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        provinceTextColor = kRGB(160, 160, 160);
        provinceCellBackgroudColor = [UIColor whiteColor];
        
        municipalityTextColor = kRGB(0, 0, 0);
        municipalityCellBackgroudColor = kRGB(247, 247, 247);
    });
    
    
    if (tableView == self.municipalityTableView) {
        cell.backgroundColor = provinceCellBackgroudColor;
        cell.textLabel.textColor = provinceTextColor;
    } else {
        cell.backgroundColor = municipalityCellBackgroudColor;
        cell.textLabel.textColor = municipalityTextColor;
    }
    
    cell.textLabel.text = @"asdasdasd";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}



#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (UITableView *)municipalityTableView
{
    if (_municipalityTableView) {
        _municipalityTableView = [[UITableView alloc] initWithFrame:CGRectMake((NSInteger)(self.width * .38), 0,  (NSInteger)(kScreenWidth * (1 - 0.38)), self.height)];
        _municipalityTableView.backgroundColor = kWhiteColor;
        _municipalityTableView.dataSource = self;
        _municipalityTableView.delegate = self;
        
        _municipalityTableView.tableFooterView = [UIView new];
        [_municipalityTableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellIndentifier];
        
        
    }
    return _municipalityTableView;
}


- (UITableView *)provinceTableView
{
    if (!_provinceTableView) {
        _provinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, (NSInteger)(self.width * .38), self.height)];
        _provinceTableView.backgroundColor = kWhiteColor;
        _provinceTableView.dataSource = self;
        _provinceTableView.delegate = self;
        _provinceTableView.tableFooterView = [UIView new];

        [_provinceTableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellIndentifier];

    }
    return _provinceTableView;
}
@end
