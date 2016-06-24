//
//  ShareManager.h
//  MombabyProject
//
//  Created by 罗野 on 16/6/22.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareManager : NSObject

+ (void)shareTitle:(NSString *)title text:(NSString *)text url:(NSString *)url;

@end
