//
//  CHRMarkTextLayer.m
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/3.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import "CHRMarkTextLayer.h"
#import <UIKit/UIKit.h>

static CGFloat kCHRMarkTextLayerAddtionHeight = 10.0;
static CGFloat kCHRMarkTextLayerAddtionWidth = 25.0;

@interface CHRMarkTextLayer ()

@property (nonatomic, strong, readwrite, nonnull) CATextLayer *textLayer;

@end

@implementation CHRMarkTextLayer

#pragma mark - Initializers
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor].CGColor;
        _sharpStyle = CHRMarkTextLayerStyleSharpLeft;
        _fontSize = 10.0;
        _text = @"";
        _textColor = [UIColor whiteColor].CGColor;
        _textLayer = [CATextLayer layer];
        _textLayer.font = (__bridge CFTypeRef _Nullable)(@"Verdana");
        _textLayer.string = _text;
        _textLayer.fontSize = _fontSize;
        _textLayer.foregroundColor = _textColor;
        _textLayer.alignmentMode = kCAAlignmentCenter;
        _textLayer.contentsScale = [UIScreen mainScreen].scale;
        [self addSublayer:_textLayer];
    }
    return self;
}

#pragma mark - Access Methods
- (void)setText:(NSString *)text
{
    _text = [text copy];
    self.textLayer.string = _text;
}

- (void)setTextColor:(CGColorRef)textColor
{
    _textColor = textColor;
    self.textLayer.foregroundColor = textColor;
}

- (void)setSharpStyle:(CHRMarkTextLayerStyle)sharpStyle
{
    _sharpStyle = sharpStyle;
    [self layoutIfNeeded];
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    self.textLayer.fontSize = fontSize;
}

- (CALayer *)p_createMaskForSharpStyle:(CHRMarkTextLayerStyle)style
{
    CGSize size = self.bounds.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat radius = ceil(size.height / 2.0);
    CGFloat startAngle;
    CGFloat endAngle;
    CGPoint sharpPoint;
    CGPoint sharpTopPoint;
    CGPoint arcTopPoint;
    CGPoint arcCenter;
    CGPoint arcBottomPoint;
    CGPoint sharpBottomPoint;
    if (style == CHRMarkTextLayerStyleSharpLeft) {
        sharpPoint = CGPointMake(0, radius);
        sharpTopPoint = CGPointMake(radius, 0);
        arcTopPoint = CGPointMake(width - radius, 0);
        arcCenter = CGPointMake(arcTopPoint.x, radius);
        arcBottomPoint = CGPointMake(arcTopPoint.x, height);
        sharpBottomPoint = CGPointMake(radius, height);
        startAngle = M_PI_2;
        endAngle = -startAngle;
    } else {
        sharpPoint = CGPointMake(width, radius);
        sharpTopPoint = CGPointMake(width - radius, 0);
        arcTopPoint = CGPointMake(radius, 0);
        arcCenter = CGPointMake(radius, radius);
        arcBottomPoint = CGPointMake(radius, height);
        sharpBottomPoint = CGPointMake(sharpTopPoint.x, height);
        startAngle = -M_PI_2;
        endAngle = -startAngle;
    }

    UIBezierPath *square = [UIBezierPath bezierPath];
    [square moveToPoint:sharpPoint];
    [square addLineToPoint:sharpTopPoint];
    [square addLineToPoint:arcTopPoint];
    [square addLineToPoint:arcBottomPoint];
    [square addLineToPoint:sharpBottomPoint];
    [square addLineToPoint:sharpPoint];
    [square closePath];

    UIBezierPath *arc = [UIBezierPath bezierPath];
    [arc moveToPoint:arcTopPoint];
    [arc addLineToPoint:arcBottomPoint];
    [arc moveToPoint:arcCenter];
    [arc addArcWithCenter:arcCenter radius:radius startAngle:startAngle endAngle:endAngle clockwise:NO];
    [arc closePath];

    [square appendPath:arc];

    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = square.CGPath;
    return mask;
}

#pragma mark - Layout Methods
- (CGSize)preferredFrameSize
{
    CGSize textSize = self.textLayer.preferredFrameSize;
    return CGSizeMake(textSize.width + kCHRMarkTextLayerAddtionWidth, textSize.height + kCHRMarkTextLayerAddtionHeight);
}

- (void)layoutSublayers
{
    [super layoutSublayers];

    self.textLayer.frame = (CGRect){0, 0, self.textLayer.preferredFrameSize};
    self.textLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    self.mask = [self p_createMaskForSharpStyle:self.sharpStyle];
}

@end