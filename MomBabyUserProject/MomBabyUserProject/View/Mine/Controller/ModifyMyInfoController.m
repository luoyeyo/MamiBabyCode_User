//
//  ModifyMineInfoController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/27.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "ModifyMyInfoController.h"
#import "RightInputCell.h"
#import "ChangeAvatarCell.h"
#import "PhotoActionSheet.h"

@interface ModifyMyInfoController () <UITableViewDelegate,UITableViewDataSource,PhotoActionSheetDelegate> {
    UIImage *_avatar;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIButton *modifyBtn;
@end

@implementation ModifyMyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView addSubview:self.modifyBtn];
    [self customNavgationBar];
    self.navTitle.text = @"修改个人信息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ChangeAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChangeAvatarCell"];
        [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
        return cell;
    }
    RightInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightInputCell"];
    cell.textfiled.MAXLenght = 8;
    [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (indexPath.row == 0) {
        [self showPhotoView];
    }
}

- (void)confirmChanges:(UIButton *)sender {
    RightInputCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (_avatar == nil && [cell.textfiled.text isEqualToString:kUserInfo.nickname]) {
        [self.view showToastMessage:@"您未作出修改"];
        return;
    }
    if (_avatar) {
        [kAppDelegate.window showPopupLoadingWithText:@"正在上传..."];
        [self getQiNiuTokenWithImage:_avatar];
        return;
    }
    if (!_avatar && ![cell.textfiled.text isEqualToString:kUserInfo.nickname]) {
        [self modifyUserAvatarWithImageKey:nil];
        return;
    }
}

/**
 *  图片选择
 */
- (void)showPhotoView {
    
    PhotoActionSheet * myActionSheet = [[PhotoActionSheet alloc] initWithFrame:self.view.bounds];
    myActionSheet.delegate = self;
    [self.view addSubview:myActionSheet];
    [myActionSheet actionShow];
}

#pragma mark - MyActionSheetDelegate

- (void)myActionSheetDelegate:(NSDictionary *)dic {
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotiSubmitAvatar object:nil];
    if (dic) {
        [self changeAvatarWithImage:dic[UIImagePickerControllerEditedImage]];
    }
}

- (void)changeAvatarWithImage:(UIImage *)image {
    ChangeAvatarCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.avatar.image = image;
    _avatar = image;
}

/**
 *  从服务器获取七牛token
 *
 *  @param image
 */
- (void)getQiNiuTokenWithImage:(UIImage *)image {
    [kAppDelegate.window showPopupLoadingWithText:@"正在上传..."];
    [[[Network_Mine alloc] init] requestQiNiuUploadTokenResponseBlock:^(LLError *error, NSString *token) {
        if (!error && ![NSString isEmptyString:token]) {
            [self uploadAvatarToQiNiuWithImage:image token:token];
        } else {
            [kAppDelegate.window showToastMessage:@"头像上传失败"];
            [kAppDelegate.window hidePopupLoadingAnimated:YES];
        }
    }];
}

/**
 *  把图片上传到七牛
 *
 *  @param image
 *  @param token
 */
- (void)uploadAvatarToQiNiuWithImage:(UIImage *)image token:(NSString *)token {
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    double length = [imageData length]/1024;
    if (length > 700) {
        imageData = [image compressedDataToDataLength:7000];
    }
    [[[Network_Mine alloc] init] uploadImageWithQiNiuImageData:imageData token:token response:^(LLError *error, id responseData) {
        if (!error && [responseData isKindOfClass:[NSDictionary class]]) {
            NSString *imageKey = [responseData objectForKey:@"key"];
            [self modifyUserAvatarWithImageKey:imageKey];
        } else {
            [kAppDelegate.window showToastMessage:@"头像上传失败"];
            [kAppDelegate.window hidePopupLoadingAnimated:YES];
        }
    }];
}

/**
 *  把上传成功的key 传给服务器
 *
 *  @param key
 *  @param image
 */
- (void)modifyUserAvatarWithImageKey:(NSString *)key {
    Input_params *params = [[Input_params alloc] init];
    RightInputCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    params.avatar = key;
    params.nickname = cell.textfiled.text;
    [[[Network_Mine alloc] init] modifyMyInfoWith:params responseBlock:^(LLError *error) {
        [kAppDelegate.window hidePopupLoadingAnimated:YES];
        if (!error) {
            [kAppDelegate.window showToastMessage:@"资料修改成功"];
            [kUserInfo updateUserInfo];
            [self popViewController];
        } else {
            [kAppDelegate.window showToastMessage:@"资料修改失败"];
        }
    }];
}

- (UIButton *)modifyBtn {
    if (!_modifyBtn) {
        _modifyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _modifyBtn.frame = CGRectMake(0, 0, 148, 45);
        _modifyBtn.backgroundColor = kColorTheme;
        [_modifyBtn setTitle:@"确认更改" forState:UIControlStateNormal];
        [_modifyBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        _modifyBtn.titleLabel.font = SystemBoldFont(18);
        _modifyBtn.layer.cornerRadius = 22.5;
        _modifyBtn.center = CGPointMake(ScreenWidth / 2, ScreenHeight - 90 - 64);
        [_modifyBtn addTarget:self action:@selector(confirmChanges:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modifyBtn;
}

@end
