//
//  AssayReportModel.h
//  DoctorProject
//
//  Created by 龙源美生 on 16/8/26.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HttpResponseData.h"
#import "ReportsModel.h"

@protocol AssayReportModel <NSObject>

@end

@interface AssayReportModel : HttpResponseData
@property (nonatomic, assign) NSTimeInterval physicalTime;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger weeks;
@property (nonatomic, strong) NSArray<ReportsResultModel> * result;
@property (nonatomic, copy) NSString *hint;
@end

@interface AssayReportListModel : HttpResponseData
@property (nonatomic, copy) NSArray<AssayReportModel> *list;
@end