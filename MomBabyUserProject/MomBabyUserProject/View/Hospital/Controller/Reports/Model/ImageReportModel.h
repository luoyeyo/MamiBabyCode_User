//
//  ImageReportModel.h
//  DoctorProject
//
//  Created by 龙源美生 on 16/8/26.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HttpResponseData.h"

@protocol ImageReportModel <NSObject>

@end

@interface ImageReportModel : HttpResponseData
@property (nonatomic, assign) NSTimeInterval physicalTime;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSArray <PhotoModel>*images;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *designation;
@property (nonatomic, assign) NSInteger weeks;
@end

@interface ImageReportListModel : HttpResponseData
@property (nonatomic, copy) NSArray<ImageReportModel> *list;
@end