//
//  UserInfoChangeModel.h
//  MomBabyUserProject
//
//  Created by 龙源美生 on 16/7/8.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "HttpResponseData.h"

@interface UserInfoChangeModel : HttpResponseData
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,copy)NSString *introduction;
@end
