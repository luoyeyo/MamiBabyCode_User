//
//  Network_ParentingClass.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/12.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "NetworkManager.h"
#import "HospitalItemModel.h"
#import "RiskListModel.h"
#import "HospitalListModel.h"
#import "AssayReportModel.h"
#import "ImageReportModel.h"
#import "ReportsModel.h"

@interface Network_Hospital : NetworkManager

/**
 *  获取孕期产检信息
 *
 *  @param responseBlock 
 */
- (void)getPregancyDeliveryrWithParams:(Input_params *)params isMum:(BOOL)isMum ResponseBlock:(void (^)(LLError *error,NSArray *list))responseBlock;

/**
 *  获取高危列表
 *
 *  @param page
 *  @param responseBlock
 */
- (void)getRiskListWithPage:(Input_params *)page ResponseBlock:(void (^)(LLError *error, NSArray *responseData))responseBlock;

/**
 *  医院详细信息
 *
 *  @param Id
 *  @param responseBlock
 */
- (void)getHospitalDetailsInfoHospitalId:(NSString *)Id ResponseBlock:(void (^)(LLError *error, ItemGroupModel *info))responseBlock;
/**
 *  医院图片
 *
 *  @param Id
 *  @param responseBlock
 */
- (void)gethospitalsImagesWithHospitalsId:(NSInteger)Id ResponseBlock:(void (^)(LLError *error, NSArray *responseData))responseBlock;

/**
 *  医列表
 *
 *  @param params
 *  @param responseBlock 
 */
- (void)getHospitalListInfoWithParams:(Input_params *)params ResponseBlock:(void (^)(LLError *error, NSArray *info))responseBlock;

/**
 *  获取用户产检报告列表
 *
 *  @param params
 *  @param responseBlock
 */
- (void)requestReportListWithParams:(Input_params *)params responseBlock:(void (^)(LLError *error,NSArray *responseData))responseBlock;

@end
