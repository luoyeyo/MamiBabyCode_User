//
//  WebItem.h
//  testsss
//
//  Created by 罗野 on 16/4/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>


// html跳转传参的模型
@interface WebItem : NSObject

@property (nonatomic, copy) NSString *labelTitle;
@property (nonatomic, copy) NSString *labelItemTitle;
@property (nonatomic, copy) NSString *labelItemUrl;

// 主Url
@property (nonatomic, copy) NSString *defaultUrl;
+ (WebItem *)createWebItemWithUrl:(NSString *)url;


@end
