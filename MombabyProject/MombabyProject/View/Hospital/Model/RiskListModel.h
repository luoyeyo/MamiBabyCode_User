//
//  RiskListModel.h
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/13.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

@interface RiskModel : HttpResponseData

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) PhotoModel *image;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, assign) NSInteger Id;

@end

@protocol RiskModel <NSObject>

@end

@interface RiskListModel : HttpResponseData
@property (nonatomic, copy) NSArray<RiskModel> *list;
@end
