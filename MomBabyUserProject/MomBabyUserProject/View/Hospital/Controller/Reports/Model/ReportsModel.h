//
//  ReportsModel.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/21.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HttpResponseData.h"
@protocol ReportsResultModel <NSObject>
@end
/**
 *  产检报告中的血压 一类
 */
@interface ReportsResultModel : HttpResponseData
@property (nonatomic, copy) NSString *v;
@property (nonatomic, copy) NSString *k;
@end

@protocol ReportsModel <NSObject>
@end

/**
 *  产检报告单独对象的model
 */
@interface ReportsModel : HttpResponseData
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger checkType;
@property (nonatomic, copy) NSString * hospitalName;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, assign) NSInteger physicalTime;
@property (nonatomic, copy) NSString * publishName;
@property (nonatomic, copy) NSString * realName;
@property (nonatomic, strong) NSArray<ReportsResultModel> * result;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) NSInteger weeks;
@property (nonatomic, assign) NSInteger Id;
@end

@interface ReportsListModel : HttpResponseData
@property (nonatomic, strong) NSArray<ReportsModel> *list;
@end
