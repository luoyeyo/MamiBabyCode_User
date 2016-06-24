//
//  WKHTMLViewController.h
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/15.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "MainViewController.h"
#import "WebItem.h"
#import "HospitalItemModel.h"

@interface WKHTMLViewController : MainViewController
@property (nonatomic, strong) WebItem *webItem;
// 主要记录医院ID  医生ID
@property (nonatomic, strong) HospitalDetailsModel *info;

@end
