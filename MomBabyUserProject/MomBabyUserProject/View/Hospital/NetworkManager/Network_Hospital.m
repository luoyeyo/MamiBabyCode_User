//
//  Network_ParentingClass.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/12.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "Network_Hospital.h"


@implementation Network_Hospital

- (void)getPregancyDeliveryrWithParams:(Input_params *)params isMum:(BOOL)isMum ResponseBlock:(void (^)(LLError *error,NSArray *list))responseBlock {
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    NSString *url;
    if (isMum == YES) {
        url = kGET_PREGNANCY_DELIVERY;
    } else {
        url = kGET_KID_DELIVERY;
    }
    [self get:kGET_PREGNANCY_DELIVERY params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            
            responseBlock(nil,[responseData objectForKey:@"list"]);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)getRiskListWithPage:(Input_params *)page ResponseBlock:(void (^)(LLError *error, NSArray *responseData))responseBlock {
    
    NSDictionary *params = [NSDictionary dictionaryFromPropertyObject:page];
    [self get:kGET_HIGHRISHLIST params:params additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            RiskListModel *data = [[RiskListModel alloc] initWithDictionary:responseData error:nil];
            responseBlock(nil,data.list);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)gethospitalsImagesWithHospitalsId:(NSInteger)Id ResponseBlock:(void (^)(LLError *error, NSArray *responseData))responseBlock {
    NSString *url = [NSString stringWithFormat:@"%@/%ld",kGET_hospitalsImages,Id];
    [self get:url params:nil additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            HospitalImageListModel *data = [[HospitalImageListModel alloc] initWithDictionary:responseData error:nil];
            responseBlock(nil,data.list);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)getHospitalDetailsInfoHospitalId:(NSString *)Id ResponseBlock:(void (^)(LLError *error, ItemGroupModel *info))responseBlock {
    [self get:kGET_HospitalsInfo params:@{@"hospitalId":Id} additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            ItemGroupModel *data = [[ItemGroupModel alloc] initWithDictionary:responseData error:nil];
            responseBlock(nil,data);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)getHospitalListInfoWithParams:(Input_params *)params ResponseBlock:(void (^)(LLError *error, NSArray *info))responseBlock {
    
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    [self get:kGET_HospitalsList params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            HospitalListModel *data = [[HospitalListModel alloc] initWithDictionary:responseData error:nil];
            responseBlock(nil,data.list);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)requestReportListWithParams:(Input_params *)params responseBlock:(void (^)(LLError *,NSArray *))responseBlock {
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    [self get:kApiReports params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            if (params.checkType.integerValue == kReportTypeImage) {
                ImageReportListModel *model = [[ImageReportListModel alloc] initWithDictionary:responseData error:nil];
                responseBlock(nil,model.list);
            } else if (params.checkType.integerValue == kReportTypeAssay) {
                AssayReportListModel *model = [[AssayReportListModel alloc] initWithDictionary:responseData error:nil];
                responseBlock(nil,model.list);
            } else {
                ReportsListModel *model = [[ReportsListModel alloc] initWithDictionary:responseData error:nil];
                responseBlock(nil,model.list);
            }
        } else {
            responseBlock(error,nil);
        }
    }];
}

@end
