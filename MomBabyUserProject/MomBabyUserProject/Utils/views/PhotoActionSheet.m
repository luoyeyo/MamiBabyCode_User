//
//  MyActionSheet.m
//  艺术蜥蜴
//
//  Created by admin on 15/3/10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "PhotoActionSheet.h"
#import <AVFoundation/AVFoundation.h>


@interface PhotoActionSheet ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation PhotoActionSheet


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (void)actionShow{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"选取照片", nil];
    action.tag = 808;
    [action showInView:kAppDelegate.window];
}

- (void)removeView{
    [self removeFromSuperview];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2){
        [self dismisSheet];
    } else {
        [self takePhotoWithIndex:buttonIndex];
    }
    
}

//
//#pragma mark - 选取照片和拍照
- (void)takePhotoWithIndex:(NSInteger )index
{
    
    
    // 判断设备是否支持相册
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        return ;
    }
    //判断设备是否支持照相机
    
    UIImagePickerController * mipc = [[UIImagePickerController alloc] init];
    switch (index) {
        case 1:
            mipc.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        case 0:
            if (![self checkCameraAccess]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"请打开应用对相机的访问权限"
                                                               delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [self dismisSheet];
                return;
            }
            mipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
            break;
        case 2:
            break;
        default:
            break;
    }
    mipc.delegate = self;//委托
    mipc.allowsEditing = YES;//是否可编辑照片
    mipc.mediaTypes=[NSArray arrayWithObjects:@"public.image",nil];
    [kAppDelegate.window.rootViewController presentViewController:mipc animated:YES completion:nil];
}

#pragma mark - <UIImagePickerControllerDelegate>代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [_delegate myActionSheetDelegate:info];
    [kAppDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    [self removeFromSuperview];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [_delegate myActionSheetDelegate:nil];
    [kAppDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    [self removeFromSuperview];
}
/**
 *  检测相机的使用权
 *
 *  @return
 */
- (BOOL)checkCameraAccess {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        return NO;
    }
    return YES;
}

- (void)dismisSheet {
    [_delegate myActionSheetDelegate:nil];
    [self removeFromSuperview];
}


@end
