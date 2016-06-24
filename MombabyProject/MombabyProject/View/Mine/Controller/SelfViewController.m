//
//  SelfViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/19.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "SelfViewController.h"
#import "SelfTableViewCell.h"
//#import "MainPickerView.h"
#import "DYCAddress.h"
#import "DYCAddressPickerView.h"
#import "Address.h"
#import "QiniuSDK.h"

@interface SelfViewController () <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, DYCAddressDelegate, DYCAddressPickerViewDelegate>


//@property (nonatomic, strong) MainPickerView *datePicker;         // 时间选择器

@property (nonatomic, strong) UIView *cityBackView;
@property (nonatomic, strong) UIView *cityBtnView;
@property (nonatomic, strong) DYCAddressPickerView *addressPicker;  // 地址选择器
@property (nonatomic, strong) UIImageView *iconImage;  // 头像

@property (nonatomic, copy) NSString * qiNiuToken;      // 七牛的Key
@property (nonatomic, copy) NSString * imageKey;


@end

@implementation SelfViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"个人信息"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"个人信息"];
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userIcon"];
    if (imageData) {
        self.iconImage.image = [UIImage imageWithData:imageData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavgationBar];
    self.navTitle.text = @"个人信息";
    // 创建UI
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor = COLOR_C4;
    
    NSArray *titleArr = @[@"头像", @"昵称", @"年龄", @"居住地址"];
    NSArray *placeholderArr = @[@"头像", @"输入昵称", @"年龄", @"选择居住地址"];
    
    NSString *ageStr = [NSString stringWithFormat:@"%@", kUserInfo.age];
    NSString *babyName = kUserInfo.currentBaby.nickname.length > 0 ? kUserInfo.currentBaby.nickname : @"";
    NSArray *infoArr;
    if (kUserInfo.isLogined) {
        infoArr = @[kUserInfo.nickname, ageStr, kUserInfo.residence,babyName];
        if (kUserInfo.status == kUserStateChild) {
            // 有宝宝
            titleArr = @[@"头像", @"昵称", @"年龄", @"居住地址", @"宝宝姓名"];
            placeholderArr = @[@"头像", @"输入昵称", @"年龄", @"选择居住地址",@"请输入宝宝姓名"];
        }
    } else {
        infoArr = @[@"", @"", @""];
    }
    
    CGFloat backViewX = 0;
    CGFloat backViewY = 64;
    CGFloat backViewW = ScreenWidth;
    CGFloat backViewH = 49 * titleArr.count;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(backViewX, backViewY, backViewW, backViewH)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    for (int i = 0; i < titleArr.count; i ++) {
        CGFloat titleX = 10;
        CGFloat titleY = (49 - 15) * 0.5 + 49 * i;
        CGFloat titleW = 70;
        CGFloat titleH = 15;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        title.font = UIFONT_H4_15;
        title.tintColor = COLOR_C1;
        title.text = titleArr[i];
        title.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:title];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 49 + 49 * i, ScreenWidth - 15, 0.5)];
        line.backgroundColor = COLOR_LINE;
        [backView addSubview:line];
        
        if (i == 0) {
            
            CGFloat iconImageW = 40;
            CGFloat iconImageX = ScreenWidth - 20 - iconImageW;
            CGFloat iconImageY = (49 - iconImageW) * 0.5;
            CGFloat iconImageH = 40;
            self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(iconImageX, iconImageY, iconImageW, iconImageH)];
            self.iconImage.layer.masksToBounds = YES;
            self.iconImage.layer.cornerRadius = iconImageW * 0.5;
            
            NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userIcon"];
            if (imageData) {
                self.iconImage.image = [UIImage imageWithData:imageData];
            }
            else
            {
                [self.iconImage sd_setImageWithURL:[NSURL URLWithString:kUserInfo.avatar.real] placeholderImage:ImageNamed(@"defaultIcon")];
            }
            self.iconImage.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageAction)];
            [self.iconImage addGestureRecognizer:tap];
            [backView addSubview:self.iconImage];
        }
        else
        {
            CGFloat textFieldX = titleX + titleW + 15;
            CGFloat textFieldY = 49 * i;
            CGFloat textFieldW = ScreenWidth - textFieldX - 15;
            CGFloat textFieldH = 49;
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH)];
            textField.placeholder = placeholderArr[i];
            textField.textColor = COLOR_C1;
            textField.font = UIFONT_H4_15;
            textField.text = infoArr[i - 1];
            textField.delegate = self;
            textField.tag = i;
            if (i == 2)
            {
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }
            [backView addSubview:textField];
        }
        
    }
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat sureBtnX = 10;
    CGFloat sureBtnY = backViewY + backViewH + 20;
    CGFloat sureBtnW = ScreenWidth - sureBtnX * 2;
    CGFloat sureBtnH = 39;
    sureBtn.frame = CGRectMake(sureBtnX, sureBtnY, sureBtnW, sureBtnH);
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = kColorTheme;
    [sureBtn setTitle:@"确定"  forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    
    [self setCitysPicker];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
            
            [self CityViewsHide:YES];
            return YES;
            break;
        case 2:
            if (kUserInfo.userType == kUserTypeVIP) {
                [self.view showToastMessage:@"会员用户修改地址信息请到注册医院修改"];
                return NO;
            }
            [self CityViewsHide:YES];
            return YES;
            break;
        case 3:
            if (kUserInfo.userType == kUserTypeVIP) {
                [self.view showToastMessage:@"会员用户修改地址信息请到注册医院修改"];
                return NO;
            }
            [self.view endEditing:YES];
            if (self.addressPicker.y == ScreenHeight) {
                // 调出地址选择器
                [self CityViewsHide:NO];
            }
            break;
        case 4:
            return YES;
        default:
            break;
    }
    return NO;
}

#pragma mark - 调出地址选择器
- (void)setCitysPicker
{
    DYCAddress *address = [[DYCAddress alloc] init];
    address.dataDelegate = self;
    [address handlerAddress];
}

- (void)addressList:(NSArray *)array
{
    self.cityBackView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight - 249)];
    self.cityBackView.backgroundColor = [UIColor blackColor];
    self.cityBackView.alpha = 0.3;
    [self.view addSubview:self.cityBackView];
    
    self.cityBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 49)];
    self.cityBtnView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cityBtnView];
    NSArray *btnTextArr = @[@"清除", @"确定"];
    for (int i = 0; i < btnTextArr.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            button.frame = CGRectMake(10, 10, 80, 29);
        }
        else
        {
            button.frame = CGRectMake(ScreenWidth - 10 - 80, 10, 80, 29);
        }
        button.backgroundColor = kColorTheme;
        button.titleLabel.font = UIFONT_H3_14;
        button.tag = 1 + i;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 3;
        [button setTitle:btnTextArr[i] forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.cityBtnView addSubview:button];
    }
    self.addressPicker = [[DYCAddressPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 200) withAddressArray:array];
    self.addressPicker.DYCDelegate = self;
    self.addressPicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.addressPicker];
}

-(void)selectAddressProvince:(Address *)province andCity:(Address *)city andCounty:(Address *)county
{
    UITextField *addTextField = (UITextField *)[self.view viewWithTag:3];
    addTextField.text = [NSString stringWithFormat:@"%@%@%@", province.name, city.name, county.name];
}
- (void)btnAction:(UIButton *)button
{
    if (button.tag == 1) {
        UITextField *addTextField = (UITextField *)[self.view viewWithTag:4];
        addTextField.text = @"";
        [self CityViewsHide:YES];
        
    }
    else
    {
        [self CityViewsHide:YES];
    }
}

#pragma mark - 调出图片选择器
- (void)iconImageAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选取", @"相机拍照", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
    }
    else if (buttonIndex == 0)
    { // 从相册选择
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    { // 调取相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.iconImage.image = info[UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 获取七牛token
- (void)getQiNiuToken {
    [self.view showPopupLoading];
    [[Network_Mine new] requestQiNiuUploadTokenResponseBlock:^(LLError *error, NSString *token) {
        if (!error) {
            self.qiNiuToken = [NSString stringWithString:token];
            [self uploadImage];
        } else {
            [self.view hidePopupLoading];
            [self.view showToastMessage:error.errormsg];
        }
    }];
}

- (void)uploadImage {
    
    NSData * imageData = UIImageJPEGRepresentation(self.iconImage.image, 0.1);
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption * opt = [[QNUploadOption alloc] initWithMime:@"text/plain"
                                                progressHandler:^(NSString *key, float percent) { }
                                                         params:nil
                                                       checkCrc:YES
                                             cancellationSignal:nil];
    
    [upManager putData:imageData
                   key:nil
                 token:self.qiNiuToken
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  if ([resp objectForKey:@"key"]){
                      self.imageKey = resp[@"key"];
                      
                      [self updateUserInfo];
                  }
                  else
                  {
                      [self.view showToastMessage:@"头像上传有误"];
                      [self.view hidePopupLoading];
                  }
                  
              } option:opt];
}

#pragma mark - 确定按钮上传用户信息
- (void)sureBtnAction
{
    [self.addressPicker removeFromSuperview];
    
    [self getQiNiuToken];
}

- (void)updateUserInfo
{
    
    UITextField *nickNameTF = (UITextField *)[self.view viewWithTag:1];
    UITextField *ageTF = (UITextField *)[self.view viewWithTag:2];
    UITextField *residenceTF = (UITextField *)[self.view viewWithTag:3];
    UITextField *babyNameTF = (UITextField *)[self.view viewWithTag:4];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"token"] = kUserInfo.token;
    parameters[@"avatar"] = self.imageKey;
    parameters[@"nickname"] = nickNameTF.text;
    parameters[@"age"] = ageTF.text;
    parameters[@"residence"] = residenceTF.text;
    parameters[@"babyNickname"] = babyNameTF.text;
    
    [[Network_Mine new] modifyMyInfoWith:parameters responseBlock:^(LLError *error) {
        [self.view hidePopupLoading];
        if (!error) {
            kUserInfo.nickname = nickNameTF.text;
            kUserInfo.age = @(ageTF.text.intValue);
            kUserInfo.residence = residenceTF.text;
            kUserInfo.currentBaby.nickname = babyNameTF.text;
            [kUserInfo synchronize];
            
            if (self.iconImage.image) {
                NSData *imageData = UIImageJPEGRepresentation(self.iconImage.image, 1);
                [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"userIcon"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [self.view showToastMessage:@"资料修改成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotiModifyUserInfo object:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else {
            [self.view showToastMessage:error.errormsg];
        }
    }];
}

- (void)CityViewsHide:(BOOL)hide
{
    if (hide == YES) {
        [UIView animateWithDuration:0.3 animations:^{
            self.cityBackView.y = ScreenHeight;
            self.cityBtnView.y = ScreenHeight;
            self.addressPicker.y = ScreenHeight;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.cityBackView.y = 0;
            self.cityBtnView.y = ScreenHeight - 249;
            self.addressPicker.y = ScreenHeight- 200;
        }];
    }
}


// 键盘收回
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self CityViewsHide:YES];
    [self.view endEditing:YES];
}

@end
