//
//  XYAddCommunityViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYAddCommunityViewController.h"
#import "XYAddCommunityUpdatePictureView.h"
#import "XYCommunityNetTool.h"
#import "XYDriverSchoolNetTool.h"

@interface XYAddCommunityViewController ()  <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet XYAddCommunityUpdatePictureView *updatePictureView;

@property (nonatomic, strong)NSData * files;

@property (nonatomic, strong)UIImageView * selectImageView;
@end

@implementation XYAddCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleLabelText:@"社区汇"];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    WeakSelf(weakSelf);
    [self.updatePictureView clickImageViewWithBlock:^(UIImageView *view) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您确定要删除这张图片吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
        weakSelf.selectImageView = view;
    }];
    
    [self.updatePictureView clickAddImageViewWithBlock:^{
        UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
        [editActionSheet showInView:self.view];
    }];
}

- (void)upLoad
{
    
    NSLog(@" ---- ===> %@",self.updatePictureView.currentImageViews);
 
    if (self.style == CommunityStyle_Default) {
        switch (self.type) {
            case AddCommunityType_Release: {
                [XYCommunityNetTool releaseCommunityWithContent:self.textView.text files:self.files isRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
                    
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    
                }];
                break;
            }
            case AddCommunityType_Reply: {
                [XYCommunityNetTool repleCommunityWithContent:self.textView.text communityID:self.communityID repleUserID:self.repleUserID isRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
                    
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    
                }];
                break;
            }
        }

        
        return;
    }
    
    
    switch (self.type) {
        case AddCommunityType_Release: {
            [XYDriverSchoolNetTool releaseDSCommunityWithContent:self.textView.text files:self.files pd_dsid:self.communityID isRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
            }];
            
            break;
        }
        case AddCommunityType_Reply: {
            [XYDriverSchoolNetTool repleDSCommunityWithContent:self.textView.text communityID:self.communityID repleUserID:self.repleUserID isRefresh:YES viewController:self success:^(NSDictionary * _Nonnull dic) {
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
            }];
            break;
        }
    }

    
   
    
    
}

#pragma mark -------------------------------------------------------
#pragma mark AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    if (buttonIndex) {
        [self.updatePictureView removeImageWithImageView:self.selectImageView];
    }
    
}



#pragma mark ----------------------------------------------------------------------
#pragma mark ----------------------ActionSheet Delegate-------------------------------------
#pragma mark ----------------------------------------------------------------------

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
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark -------------------------------------------------------
#pragma mark PictureController Delegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage * image = info[@"UIImagePickerControllerEditedImage"];
    
    [self.updatePictureView addImageViewWithImage:image];
    
//    CGSize size;
//    CGRect crop;
//    
//    CGFloat image_height = image.size.height;
//    CGFloat image_width  = image.size.width;
    
//    CGFloat imageView_height = self.imageView.frame.size.height;
//    CGFloat imageView_width  = self.imageView.frame.size.width;
//    
//    if ((image_width / image_height) > (imageView_width / imageView_height)) {
//        size = CGSizeMake(image_height * (imageView_width / imageView_height), image_height);
//        crop.origin = CGPointMake(image_width / 2 - size.width / 2, 0);
//    } else {
//        size = CGSizeMake(image_width, image_width * (imageView_height / imageView_width));
//        crop.origin = CGPointMake(0, image_height  / 2 - size.height / 2);
//    }
//    
//    crop.size = size;
//    image = [image imageByCropToRect:crop];
    
    
//    [kAFAddHttpHeaderManager POST:[kManager getUrlWithUrl:kUpdatePicture_MOKA_URL] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        NSData *imageData = UIImageJPEGRepresentation(image, 1);
//        NSString *fileName = @"aaa.jpg";
//        
//        // 上传图片，以文件流的格式
//        [formData appendPartWithFileData:imageData name:kUpdatePicture_MOKA_picturefile fileName:fileName mimeType:@"image/jpeg"];
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//        [self removeActiveIVFromSelfView];
//        if ([kManager showRequestIsSucceedWithDictionary:responseObject]) {
//            
//            NSDictionary * deleteDic = nil;
//            for (NSDictionary * dic in self.imagesArray) {
//                if ([dic[kMOKA_pos] intValue] == self.imageView.tag - 10086) {
//                    deleteDic = dic;
//                }
//            }
//            [self.imagesArray removeObject:deleteDic];
//            [self.imagesArray addObject:@{kMOKA_pos:[NSString stringWithFormat:@"%ld",self.imageView.tag - 10086],
//                                          kMOKA_url:responseObject[@"data"]}];
//            
//            self.imageView.image = image;
//            //            for (UIView * view in self.imageView.subviews) {
//            //                [view removeFromSuperview];
//            //            }
//            
//            if (self.isEdit) {
//                [self addActiveIVToMySelfView];
//                
//                NSArray * array = self.moKaDic[kMOKA_content];
//                NSDictionary * moka = @{kMOKA_pos:[NSString stringWithFormat:@"%ld",self.imageView.tag - 10086],
//                                        kMOKA_url:responseObject[@"data"]};
//                NSMutableArray * newArray = [NSMutableArray array];
//                for (NSDictionary * mokaDic in array) {
//                    if ([mokaDic[kMOKA_pos] isEqual:moka[kMOKA_pos]]) {
//                        NSMutableDictionary * newMoKaDic = [NSMutableDictionary dictionaryWithDictionary:mokaDic];
//                        [newMoKaDic setValue:moka[kMOKA_url] forKey:kMOKA_url];
//                        [newArray addObject:newMoKaDic];
//                    } else {
//                        [newArray addObject:mokaDic];
//                    }
//                }
//                
//                NSData * data = [NSJSONSerialization dataWithJSONObject:newArray options:0 error:nil];
//                NSString * string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                NSDictionary * dic = @{
//                                       kMOKA_content :string,
//                                       kMOKA_id      :self.moKaDic[kMOKA_id]};
//                
//                [kAFAddHttpHeaderManager POST:[kManager getUrlWithUrl:kEditMoKa_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                    [self removeActiveIVFromSelfView];
//                    
//                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                    [self removeActiveIVFromSelfView];
//                    [kManager showNetworkError];
//                }];
//            }
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self removeActiveIVFromSelfView];
//        [kManager showNetworkError];
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
