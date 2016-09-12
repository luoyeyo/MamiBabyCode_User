//
//  ReportCardViewController.m
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/18.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "ReportCardViewController.h"
#import "inspectionReportView.h"

@interface ReportCardViewController ()<inspectionReportViewDelegate> {
    NSMutableArray *_list;
}

@property (nonatomic, strong) inspectionReportView * inspectionRView; //检查报告


@end

@implementation ReportCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _list = [NSMutableArray array];
    [self inspectionReportConnect];
}

#pragma mark - 获取检查信息数据
- (void)inspectionReportConnect {
    
    BOOL isMum = YES;
    // 根据用户类型决定显示类型
    if (kUserInfo.status == kUserStateMum) {
        self.navTitle.text = @"产检程序";
    } else {
        isMum = NO;
        self.navTitle.text = @"儿童保健项目";
    }
    Input_params *params = [[Input_params alloc] init];
    params.page = @1;
    params.limit = @10;
    params.hospitalId = self.hospitalId;
    [self.view showPopupLoading];
    [[[Network_Hospital alloc] init] getPregancyDeliveryrWithParams:params isMum:isMum ResponseBlock:^(LLError *error, NSArray *list) {
        [self.view hidePopupLoading];
        if (!error) {
            [_list addObjectsFromArray:list];
            [self createInspectionReportView];
        } else {
            [self.view showToastMessage:@"暂未获取到信息"];
        }
    }];
}

- (void)createInspectionReportView{
    self.inspectionRView = [[inspectionReportView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) allArr:_list];
    self.inspectionRView.delegate = self;
    [self.view addSubview:self.inspectionRView];
}

- (void)topAndNext:(NSString *)tex{
    if ([tex isEqualToString:@"第一"]) {
        [self.view showToastMessage:@"已经是第一张啦"];
    }
    else{
        [self.view showToastMessage:@"已经是最后一张啦"];
    }
}

@end
