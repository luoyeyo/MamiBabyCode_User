//
//  HospitalListModel.h
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/15.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "HttpResponseData.h"

@interface HospitalEntryModel : HttpResponseData
@property (nonatomic, assign) NSInteger starLevel;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) BOOL isBookbuilding;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *gradeLevel;
@property (nonatomic, copy) NSString *gradeLevelName;
@property (nonatomic, strong) PhotoModel *image;
@property (nonatomic, strong) PhotoModel *logo;
@end

@protocol HospitalEntryModel <NSObject>

@end

@interface HospitalListModel : HttpResponseData
@property (nonatomic, copy) NSArray<HospitalEntryModel> *list;
@end

@interface HospitalImageListModel : HttpResponseData
@property (nonatomic, copy) NSArray<PhotoModel> *list;
@end
