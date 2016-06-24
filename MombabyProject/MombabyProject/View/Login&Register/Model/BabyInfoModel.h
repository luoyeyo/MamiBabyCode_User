//
//  BabyInfoModel.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/12/15.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BabyInfoModel <NSObject>

@end

@interface BabyInfoModel : HttpResponseData

/***  宝贝性别 1男2女 */
@property (nonatomic, strong) NSString * gender;
/***  宝贝 ID*/
@property (nonatomic, strong) NSNumber * Id;
/***  宝贝昵称*/
@property (nonatomic, copy) NSString * nickname;
/***  宝贝生日*/
@property (nonatomic, copy) NSString * birth;
/***  宝贝头像*/
@property (nonatomic, strong) PhotoModel * avatar;

@end
