//
//  BillboardView.h
//  MombabyProject
//
//  Created by 罗野 on 16/6/24.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillboardView : UIView
+ (BillboardView *)billboardViewWithImage:(UIImage *)image imageUrl:(NSString *)url clickBlock:(void (^)())clickBlock;
@end
