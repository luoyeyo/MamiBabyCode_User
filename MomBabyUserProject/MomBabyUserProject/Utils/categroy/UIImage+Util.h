//
//  UIImage+Util.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/5.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

/** 压缩图片
 *
 * @param imageLength 压缩到指定的字节数 (单位betys)
 *
 */
- (NSData *)compressedDataToDataLength:(NSUInteger)imageLength;

+ (UIImage*)imageWithColor:(UIColor*)color;

+ (UIImage*)imageWithView:(UIView*)view;
@end
