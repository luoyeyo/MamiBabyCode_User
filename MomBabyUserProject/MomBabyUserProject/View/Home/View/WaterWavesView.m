//
//  WaterWavesView.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "WaterWavesView.h"

// 前面的绿色
#define FrontGreenColor [UIColor colorWithRed:113.0/255.0f green:236.0/255.0f blue:232/255.0f alpha:.4]
// 后面的绿色
#define BackGreenColor [UIColor colorWithRed:113.0/255.0f green:236.0/255.0f blue:232/255.0f alpha:.2]
#define FrontRedColor [UIColor colorWithRed:1.000 green:0.443 blue:0.498 alpha:0.4]
#define BackRedColor [UIColor colorWithRed:1.000 green:0.443 blue:0.498 alpha:0.2]

@interface WaterWavesView () {
    
    float _currentLinePointY;
    
    float a;
    float b;
    
    BOOL jia;
    
    CADisplayLink *_waveDisplaylink;
    // 深色水
    CAShapeLayer  *_waveLayer;
    // 浅色
    CAShapeLayer  *_waveLayerTwo;
    CGFloat offsetX;
    
    // 几率是否需要重绘
//    BOOL _needDraw;
}

@end

@implementation WaterWavesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self defaultConfing];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self defaultConfing];
    }
    return self;
}

- (void)defaultConfing {
    
    
    a = 1.5;
    b = 0;
    jia = NO;
    offsetX = 0;
    _currentLinePointY = 0;
    _high = 0;
//    _needDraw = YES;
    
    self.backgroundColor = FrontGreenColor;
    [_waveLayer removeFromSuperlayer];
    [_waveLayerTwo removeFromSuperlayer];
    [_waveDisplaylink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    _waveLayer = [CAShapeLayer layer];
    _waveLayer.fillColor = FrontGreenColor.CGColor;
    [self.layer addSublayer:_waveLayer];
    
    _waveLayerTwo = [CAShapeLayer layer];
    _waveLayerTwo.fillColor = BackGreenColor.CGColor;
    [self.layer addSublayer:_waveLayerTwo];
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)getCurrentWave:(CADisplayLink *)displayLink {
    [self animateWave];
}

- (void)animateWave {
    if (jia) {
        a += 0.01;
    } else {
        a -= 0.01;
    }
    
    if (a <= 1) {
        jia = YES;
    }
    
    if (a >= 1.5) {
        jia = NO;
    }
    b += 0.1;
    
//    if (_currentLinePointY >= self.height || _currentLinePointY == 0) _needDraw = NO;
    CGMutablePathRef path = CGPathCreateMutable();
    CGMutablePathRef pathTwo = CGPathCreateMutable();
    float y = _currentLinePointY;
    CGPathMoveToPoint(path, NULL, 0, y);
    CGPathMoveToPoint(pathTwo, NULL, 0, y);
    offsetX += 6;
    
    // Y调波浪大小
    for(float x = 0;x <= (NSInteger)self.width;x ++){
        y = sinf((360 / self.width) * ( x * M_PI / 180) - offsetX * M_PI / 180) * 6 + _currentLinePointY;
        CGPathAddLineToPoint(path, nil, x, y);
        CGPathAddLineToPoint(pathTwo, nil, x + 80, y);
    }
    if (_currentLinePointY < self.height * _high) {
        _currentLinePointY += 1;
    }
    
    CGPathAddLineToPoint(path, nil, self.width, self.height);
    CGPathAddLineToPoint(path, nil, 0, self.height);
    CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);
    
    CGPathAddLineToPoint(pathTwo, nil, self.width, self.height);
    CGPathAddLineToPoint(pathTwo, nil, 0, self.height);
    CGPathAddLineToPoint(pathTwo, nil, 0, _currentLinePointY);
    
    _waveLayer.path = path;
    _waveLayerTwo.path = pathTwo;
    
    CGPathRelease(path);
    CGPathRelease(pathTwo);
}

- (void)setHigh:(CGFloat)high {
    [self defaultConfing];
    _high = 1 - high;
    
//    if (high != 0 && high != 1) {
//        _needDraw = NO;
//    }
    self.backgroundColor = kColorWhite;
    // 因为百分比是反着来的  所以之前用1-    小于20%  显示红色
    if (high < .2f) {
        _waveLayer.fillColor = FrontRedColor.CGColor;
        _waveLayerTwo.fillColor = BackRedColor.CGColor;
    } else {
        _waveLayer.fillColor = FrontGreenColor.CGColor;
        _waveLayerTwo.fillColor = BackGreenColor.CGColor;
    }
}
@end
