//
//  CHRMarkCenterLayer.m
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/3.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import "CHRMarkCenterLayer.h"
#import <UIKit/UIKit.h>

@interface CHRMarkCenterLayer ()

@property (nonatomic, strong, readwrite, nonnull) CAShapeLayer *shapeLayer;
@property (nonatomic, strong, readwrite, nonnull) CAShapeLayer *animationLayer;
@property (nonatomic, strong, readwrite, nonnull) CAShapeLayer *backgroundLayer;

@end

@implementation CHRMarkCenterLayer

#pragma mark - Dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Initializers
- (instancetype)init
{
    self = [super init];
    if (self) {
        _innerOvalRadiusFractor = 0.8;
        _shapeColor = [UIColor redColor].CGColor;
        _breathingColor = _shapeColor;
        _backgroundLayerColor = [UIColor whiteColor].CGColor;
        self.backgroundColor = [UIColor clearColor].CGColor;
        
        _animationLayer = [CAShapeLayer layer];
        _animationLayer.fillColor = self.breathingColor;
        [self addSublayer:_animationLayer];

        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.fillColor = _backgroundLayerColor;
        [self addSublayer:_backgroundLayer];

        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = self.breathingColor;
        [self addSublayer:_shapeLayer];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_handleApplicationWillEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

#pragma mark - Access Methods
- (void)setShapeColor:(CGColorRef)shapeColor
{
    _shapeColor = shapeColor;
    self.shapeLayer.fillColor = shapeColor;
}

- (void)setBreathingColor:(CGColorRef)breathingColor
{
    _breathingColor = breathingColor;
    self.animationLayer.fillColor = breathingColor;
}

- (void)setBackgroundLayerColor:(CGColorRef)backgroundLayerColor
{
    _backgroundLayerColor = backgroundLayerColor;
    _backgroundLayer.fillColor = backgroundLayerColor;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    self.path = nil;
    self.shapeLayer.path = nil;
    self.animationLayer.path = nil;
    self.backgroundLayer.path = nil;
    [self.animationLayer removeAllAnimations];

    self.path = [UIBezierPath bezierPathWithOvalInRect:frame].CGPath;

    self.backgroundLayer.frame = self.bounds;
    self.backgroundLayer.path = [UIBezierPath bezierPathWithOvalInRect:frame].CGPath;

    self.animationLayer.frame = self.bounds;
    self.animationLayer.path = [UIBezierPath bezierPathWithOvalInRect:frame].CGPath;

    [self.animationLayer addAnimation:[self p_makeBreathingAnimation] forKey:nil];

    self.shapeLayer.frame = CGRectInset(frame, frame.size.width * (1.0 -self.innerOvalRadiusFractor),  frame.size.height * (1.0 - self.innerOvalRadiusFractor));
    self.shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.shapeLayer.bounds].CGPath;
}

- (CAAnimationGroup *)p_makeBreathingAnimation
{
    CAAnimationGroup *breathing = [CAAnimationGroup animation];
    breathing.fillMode = kCAFillModeBackwards;
    breathing.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    breathing.duration = 1.0;
    breathing.repeatCount = NSIntegerMax;
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @1.0;
    scale.toValue = @1.5;
    CABasicAnimation *gradient = [CABasicAnimation animationWithKeyPath:@"opacity"];
    gradient.fromValue = @0.1;
    gradient.toValue = @0.25;

    breathing.animations = @[scale, gradient];
    return breathing;
}

#pragma mark - UIApplicationWillEnterForegroundNotification
- (void)p_handleApplicationWillEnterForegroundNotification:(NSNotification *)notification
{
    [self.animationLayer addAnimation:[self p_makeBreathingAnimation] forKey:nil];
}

@end