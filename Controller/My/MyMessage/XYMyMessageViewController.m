//
//  XYMyMessageViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYMyMessageViewController.h"
#import "XYPickerView.h"
#import "UIImage+Utility.h"
#import "XYUpdateNetTool.h"
#import "XYUserNetTool.h"


@interface XYMyMessageViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (nonatomic, strong)NSData * files;

@end

@implementation XYMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleLabelText:@"个人信息"];
    [[XYPickerView sharePickerView] addViewWithSuperView:self.view];

    [self setRightBtnWithText:@"完成"];
    
    WeakSelf(weakSelf);
    [[XYPickerView sharePickerView] selectCityWithBlock:^(NSString *string, PickerViewType type) {
        switch (type) {
            case PickerViewType_Sex: weakSelf.sexLabel.text = string; break;
            case PickerViewType_Age: weakSelf.ageLabel.text = string; break;
        }
    }];
    
    [self reloadData];
    
    self.imageView.layer.cornerRadius = 20;
    self.imageView.layer.masksToBounds = YES;
    
}

- (void)reloadData
{
    NSDictionary * userInfo = [kUserD valueForKey:user_info_key];

    [self.imageView setImageWithURL:[NSURL URLWithString:userInfo[user_info_au_img]] placeholder:kDefaultImage];
    self.nameTF.text = userInfo[user_info_au_name];
    self.sexLabel.text = userInfo[user_info_au_sex];
    self.ageLabel.text = userInfo[user_info_au_age];
    
}

#pragma mark -------------------------------------------------------
#pragma mark click

- (void)clickRightBtn
{
    WeakSelf(weakSelf);
    [XYUserNetTool updateUserInfoWithToken:@(012321321)
                                     files:self.files
                                   au_name:self.nameTF.text
                                    au_sex:self.sexLabel.text
                                    au_age:self.ageLabel.text
                                 isRefresh:YES
                            viewController:self
                                   success:^(NSDictionary * _Nonnull dic) {
                                       [kShowLabel setText:@"更改成功"];
                                       [kUserD setValue:dic forKey:user_info_key];
                                       [kUserD synchronize];
                                       
                                       [weakSelf reloadData];
                                 } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                     
                                 }];
}

- (IBAction)clickAvatar:(id)sender {
    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [editActionSheet showInView:self.view];
}

- (IBAction)clickSex:(id)sender {
    [XYPickerView sharePickerView].type = PickerViewType_Sex;
    [[XYPickerView sharePickerView] show];
}
- (IBAction)clickAge:(id)sender {
    [XYPickerView sharePickerView].type = PickerViewType_Age;
    [[XYPickerView sharePickerView] show];
}



#pragma mark -------------------------------------------------------
#pragma mark Action Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0 && buttonIndex != 1) {
        return;
    }
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    
    //相册
    if (buttonIndex) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [kManager createAlertOnceSureWithMessage:@"相册不可用" title:nil];
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [kManager createAlertOnceSureWithMessage:@"相机不可用" title:nil];
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [[picker navigationBar] setTintColor:kWhiteColor];
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}





- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage * image = info[@"UIImagePickerControllerEditedImage"];
    
    
    image = [image resize:CGSizeMake(200, 200)];
    
    
    self.imageView.image = image;
    self.files = UIImageJPEGRepresentation(image, .8);
    
    
//    [self addActiveIVToMySelfView];
//
//    [XYUpdateNetTool uploadWithImageData:UIImageJPEGRepresentation(image, .8) success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
   

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
