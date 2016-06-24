//
//  FeedbackController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/27.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "FeedbackController.h"
#import "PlaceHolderTextView.h"

@interface FeedbackController ()

@property (strong, nonatomic) IBOutlet PlaceHolderTextView *textFiled;
- (IBAction)confirmChanges:(UIButton *)sender;

@end

@implementation FeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textFiled.placeHolder = @"请输入您对亿苗儿的意见或建议，程序员们会根据您的建议加班加点对产品进行优化和改进哦~~~";
    self.textFiled.placeHolderTextColor = [UIColor colorFromHexRGB:@"979797"];
    self.textFiled.maxLength = 200;
    [self customNavgationBar];
    self.navTitle.text = @"信息反馈";
}

- (IBAction)confirmChanges:(UIButton *)sender {
    if (self.textFiled.text.length == 0) {
        [self.view showToastMessage:@"请输入你的建议后再提交哦"];
        return;
    }
    [self.view showPopupLoading];
    [[[Network_Mine alloc] init] feedbackWith:self.textFiled.text responseBlock:^(LLError *error) {
        [self.view hidePopupLoading];
        if (error) {
            [self.view showToastMessage:error.errormsg];
        } else {
            [self.view showToastMessage:@"提交成功"];
            self.textFiled.text = @"";
        }
    }];
}
@end
