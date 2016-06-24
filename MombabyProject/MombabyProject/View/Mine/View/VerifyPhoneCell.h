//
//  VerifyPhoneCell.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/26.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyPhoneCell : UITableViewCell

/**
 *  发送验证码 按钮回调
 */
@property (nonatomic, copy) void(^sendVerifyBlock)(NSString *phone);
@property (strong, nonatomic) IBOutlet UIButton *verifyBtn;
@property (strong, nonatomic) IBOutlet InputLimitField *phoneTF;
@property (assign, nonatomic) BOOL needVerify;
- (IBAction)sendVerify:(UIButton *)sender;
@end
