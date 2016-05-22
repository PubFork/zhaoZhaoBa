//
//  XYSelectViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYSelectViewController.h"



@interface XYSelectViewController ()

@end

@implementation XYSelectViewController

- (void)viewDidLoad {
    
    
//    [self.view addSubview:self.selectTableView.backgroudView];
    
//    [self.selectTableView.backgroudView clickView:^(UIView *view) {
//        [self.showBtn touchesEnded:[NSSet set] withEvent:nil];
//    }];
    
//    [self.view addSubview:self.selectTableView];
    

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.selectView];

}


- (void)selectSort_blockWithBlock:(void (^)(NSString *))selectSort_block
{
    self.selectSort_block = selectSort_block;
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
}


#pragma mark -------------------------------------------------------
#pragma mark LazyLoading
- (XYSelectView *)selectView
{
    if (!_selectView) {
        _selectView = [[XYSelectView alloc] initWithFrame:CGRectMake(0, kNavigationBar_Height, kScreenWidth, 30)];
        
        WeakSelf(weakSelf);
        [_selectView clickSelectView_blockWithBlock:^(XYButton *btn) {
            
            if (btn.isShow) {
                self.showBtn = btn;
                self.selectTableView.backgroudView.hidden = NO;
                
                weakSelf.selectTableView.groupArray = self.selectTableViewArray[btn.tag - buttonTag];
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

- (XYDriverSchoolSelectTableView *)selectTableView
{
    if (!_selectTableView) {
        _selectTableView = [[XYDriverSchoolSelectTableView alloc] initWithFrame:CGRectMake(0, - kScreenHeight, kScreenWidth, kScreenHeight - kNavigationBar_Height)];
        
        WeakSelf(weakSelf);
        [_selectTableView didSelectRowWithBlock:^(XYDriverSchoolSelectTableView *tableView, NSIndexPath *indexPath) {
            
            [weakSelf.showBtn touchesEnded:[NSSet set] withEvent:nil];
            
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            
            [weakSelf.showBtn setTitle:cell.textLabel.text];

            
            weakSelf.selectSort_block ? weakSelf.selectSort_block(cell.textLabel.text) : 0;
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
