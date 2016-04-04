//
//  CHRMarkConnectionLayer.h
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/4.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CHRMarkConnectionLayer : CAShapeLayer

+ (nonnull instancetype)layerWithStartPoint:(CGPoint)startPoint controlPoint:(CGPoint)controlPoint endPoint:(CGPoint)endPoint;
- (nonnull instancetype)initWithStartPoint:(CGPoint)startPoint controlPoint:(CGPoint)controlPoint endPoint:(CGPoint)endPoint;

@end