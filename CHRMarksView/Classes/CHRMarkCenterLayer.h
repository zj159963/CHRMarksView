//
//  CHRMarkCenterLayer.h
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/3.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CHRMarkCenterLayer : CAShapeLayer

@property (nonatomic, assign, readwrite, nonnull) CGColorRef shapeColor;
@property (nonatomic, assign, readwrite, nonnull) CGColorRef breathingColor;
@property (nonatomic, assign, readwrite, nonnull) CGColorRef backgroundLayerColor;
@property (nonatomic, assign, readwrite) CGFloat innerOvalRadiusFractor; // Defualt is 0.8

@end