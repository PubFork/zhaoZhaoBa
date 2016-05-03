//
//  XYNearDriverSchoolViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNearDriverSchoolViewController.h"
#import "XYNearDriverSchoolDetailViewController.h"
#import "XYNearDriverSchoolSelectView.h"
#import "XYNearDriverSchoolSelectTableView.h"
#import "XYAddActionView.h"


#import "XYHomeTableViewCell.h"
#import "XYButton.h"

@interface XYNearDriverSchoolViewController ()
@property (nonatomic, strong)NSMutableArray * groupArray;
@property (nonatomic, strong)XYNearDriverSchoolSelectView * selectView;

@property (nonatomic, strong)XYNearDriverSchoolSelectTableView * selectTableView;


@property (nonatomic, weak)XYButton * oldBtn;
/**
 *  处于 显示 模式的btn
 */
@property (nonatomic, weak)XYButton * showBtn;

@end

static NSString * cell_key = @"cell";

@implementation XYNearDriverSchoolViewController

- (void)viewDidLoad {
    
    //tableView 在最下面
    [self addTableViewIsGroup:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cell_key];
    self.tableView.mj_y = CGRectGetMaxY(self.selectView.frame) + 1;
    
    [self.view addSubview:self.selectTableView.backgroudView];
    [self.selectTableView.backgroudView clickView:^(UIView *view) {
        [self.showBtn touchesEnded:[NSSet set] withEvent:nil];
    }];
    
    [self.view addSubview:self.selectTableView];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"附近驾校"];
    [self.view addSubview:self.selectView];
    
}

#pragma mark -------------------------------------------------------
#pragma mark Innder Method

- (void)clickSelectViewWithBth:(XYButton *)btn
{
    NSInteger y = self.tableView.mj_y;
    if (!btn.isShow) {
        y = - self.selectTableView.height;
    }
    [UIView animateWithDuration:kHomeCityAnimate_time animations:^{
        self.selectTableView.mj_y = y;
    }];
    
    self.oldBtn = btn;
    
    
    self.selectTableView.backgroudView.hidden = !self.showBtn.isShow;
    if (!self.showBtn) {
        self.selectTableView.backgroudView.hidden = NO;
    }
}


#pragma mark -------------------------------------------------------
#pragma mark TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
    return self.groupArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_key forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYNearDriverSchoolDetailViewController * nearDriverSchoolDetailVC = [[XYNearDriverSchoolDetailViewController alloc] init];
    [self.navigationController pushViewController:nearDriverSchoolDetailVC animated:YES];
}


#pragma mark -------------------------------------------------------
#pragma mark LazyLoading
- (XYNearDriverSchoolSelectView *)selectView
{
    if (!_selectView) {
        _selectView = [[XYNearDriverSchoolSelectView alloc] initWithFrame:CGRectMake(0, kNavigationBar_Height, kScreenWidth, 30)];
        
        
        WeakSelf(weakSelf);
        [_selectView clickSelectView_blockWithBlock:^(XYButton *btn) {
           
            
            if (btn.isShow) {
                self.showBtn = btn;
                self.selectTableView.backgroudView.hidden = NO;
                NSLog(@" -- %@",btn.titleLabel.text);

                NSMutableArray * array = @[@"asdds",@"sdsd"].mutableCopy;
                
                for (int i = 0 ; i < arc4random()% 100; i ++) {
                    [array addObject:[NSString stringWithFormat:@"%d",i]];
                }
                
                weakSelf.selectTableView.groupArray = array.mutableCopy;
            }
           
            
            if (self.oldBtn != btn && self.oldBtn.isShow) {
                [self.oldBtn touchesEnded:[NSSet set] withEvent:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kHomeCityAnimate_time / 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf clickSelectViewWithBth:btn];
                    
                });
            } else {
                [weakSelf clickSelectViewWithBth:btn];
            }
            
        }];
    }
    return _selectView;
}

- (XYNearDriverSchoolSelectTableView *)selectTableView
{
    if (!_selectTableView) {
        _selectTableView = [[XYNearDriverSchoolSelectTableView alloc] initWithFrame:CGRectMake(0, - kScreenHeight, kScreenWidth, kScreenHeight - kNavigationBar_Height)];
        
        [_selectTableView didSelectRowWithBlock:^(XYNearDriverSchoolSelectTableView *tableView, NSIndexPath *indexPath) {
            
        }];
    }
    return _selectTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
