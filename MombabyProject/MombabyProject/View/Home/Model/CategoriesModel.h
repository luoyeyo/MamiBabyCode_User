//
//  CategoriesModel.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/17.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "HttpResponseData.h"

@interface CategoriesModel : HttpResponseData
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *title;
@end
