//
//  HospitalItemModel.h
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/15.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "HttpResponseData.h"

// 医院工作模块的 数据
@interface HospitalItemModel : HttpResponseData

@property (nonatomic, strong) PhotoModel *iconValid;
@property (nonatomic, strong) PhotoModel *iconInvalid;
@property (nonatomic, assign) BOOL groupId;
@property (nonatomic, assign) BOOL Id;

@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, copy) NSString *itemUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *reason;

@end

// 孕妇在这个医院的详细信息
@interface HospitalDetailsModel : HttpResponseData
@property (nonatomic, assign) NSInteger hospitalId;
@property (nonatomic, copy) NSString *memberLevel;
@property (nonatomic, copy) NSString *hospitalName;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger doctorId;

@property (nonatomic, assign) BOOL isRisk;
@property (nonatomic, strong) PhotoModel *doctorImage;
@property (nonatomic, strong) PhotoModel *hospitalImage;
@property (nonatomic, strong) PhotoModel *logo;
@property (nonatomic, copy) NSString *doctorName;
@property (nonatomic, copy) NSString *doctorTitle;
@property (nonatomic, copy) NSString *goodAt;
@property (nonatomic, copy) NSString *doctorDept;
@property (nonatomic, copy) NSString *Description;
@end

@protocol HospitalItemModel <NSObject>

@end

@protocol HospitalDetailsModel <NSObject>

@end

// 医院工作模块（组） 数据
@interface ItemGroupModel : HttpResponseData
@property (nonatomic, copy) NSArray <HospitalItemModel>*groupOne;
@property (nonatomic, copy) NSArray <HospitalItemModel>*groupTwo;
@property (nonatomic, copy) NSArray <HospitalDetailsModel>*list;
@end


