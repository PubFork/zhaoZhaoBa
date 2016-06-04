
//
//  XYShoppingViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYShoppingViewController.h"
#import "XYShoppingCollectionViewCell.h"
#import "XYShoppingHeaderCollectionViewCell.h"

@interface XYShoppingViewController ()
@end


static NSString * shopping_header_cell_key = @"shopping_header_cell_key";
static NSString * shopping_cell_key = @"shopping_cell_key";

@implementation XYShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"积分商城"];
    
    
    [self addCollectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XYShoppingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:shopping_cell_key];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XYShoppingHeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:shopping_header_cell_key];

    [self.view addSubview:self.collectionView];
    
    
}


#pragma mark -------------------------------------------------------
#pragma mark CollectionView DataSources & Delegate


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 10;
    return self.groupArray.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 215);
    }
    return CGSizeMake(kScreenWidth / 2 - 1.5, 123);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XYShoppingHeaderCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopping_header_cell_key forIndexPath:indexPath];
        return cell;
    }
    
    XYShoppingCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopping_cell_key forIndexPath:indexPath];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(1, 1, 1, 1);
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
