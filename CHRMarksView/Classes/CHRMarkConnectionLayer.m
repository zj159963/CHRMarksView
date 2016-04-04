//
//  CHRMarkConnectionLayer.m
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/4.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import "CHRMarkConnectionLayer.h"
#import <UIKit/UIKit.h>

static CGFloat const kCHRMarkConnectionLayerEndOvalRadius = 2.0;

@implementation CHRMarkConnectionLayer

+ (nonnull instancetype)layerWithStartPoint:(CGPoint)startPoint controlPoint:(CGPoint)controlPoint endPoint:(CGPoint)endPoint
{
    return [[self alloc] initWithStartPoint:startPoint controlPoint:controlPoint endPoint:endPoint];
}
- (nonnull instancetype)initWithStartPoint:(CGPoint)startPoint controlPoint:(CGPoint)controlPoint endPoint:(CGPoint)endPoint
{
    self = [super init];
    if (self) {
        self.fillColor = nil;
        self.strokeColor = [UIColor darkGrayColor].CGColor;
        self.lineWidth = 1.0;

        CGPoint strokeEndPoint;
        CGPoint arcCenter;
        if (startPoint.x < endPoint.x) {
            strokeEndPoint = CGPointMake(endPoint.x - kCHRMarkConnectionLayerEndOvalRadius * 2 , endPoint.y);
            arcCenter = CGPointMake(endPoint.x - kCHRMarkConnectionLayerEndOvalRadius, endPoint.y);
        } else {
            strokeEndPoint = CGPointMake(endPoint.x + kCHRMarkConnectionLayerEndOvalRadius * 2, endPoint.y);
            arcCenter = CGPointMake(endPoint.x + kCHRMarkConnectionLayerEndOvalRadius, endPoint.y);
        }

        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:startPoint];
        [path addLineToPoint:controlPoint];
        [path addLineToPoint:strokeEndPoint];

        UIBezierPath *oval = [UIBezierPath bezierPath];
        [oval addArcWithCenter:arcCenter radius:kCHRMarkConnectionLayerEndOvalRadius startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [path appendPath:oval];

        self.path = path.CGPath;

        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        anim.fromValue = @0.0;
        anim.toValue = @1.0;
        anim.duration = 1.0;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [self addAnimation:anim forKey:nil];
    }
    return self;
}

@end