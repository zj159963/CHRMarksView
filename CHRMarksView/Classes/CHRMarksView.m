//
//  CHRMarksView.m
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/3.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import "CHRMarksView.h"
#import "CHRMarkCenterLayer.h"
#import "CHRMarkTextLayer.h"
#import "CHRMarkConnectionLayer.h"

@interface CHRMarksView ()

@property (nonatomic, strong, readwrite, nonnull) CHRMarkCenterLayer *centerLayer;
@property (nonatomic, strong, readwrite, nullable) CHRMarkTextLayer *nameLayer;
@property (nonatomic, strong, readwrite, nullable) CHRMarkTextLayer *rateLayer;
@property (nonatomic, strong, readwrite, nullable) CHRMarkTextLayer *categoryLayer;

@end

@implementation CHRMarksView

#pragma mark - Initializers
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self p_initialize];
    }
    return self;
}

- (void)p_initialize
{
    _centerLayer = [CHRMarkCenterLayer layer];
    [self.layer addSublayer:_centerLayer];
    _centerLayer.frame = CGRectMake(0, 0, 10, 10);

    _nameLayer = [CHRMarkTextLayer layer];
    _nameLayer.text = @"Chris";
    [self.layer addSublayer:_nameLayer];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_tap:)];
    [self addGestureRecognizer:tap];
}

#pragma mark - Access Methods
- (void)setMarks:(CHRMarks *)marks
{
    _marks = [marks copy];

}

- (void)p_mapMarks:(CHRMarks *)marks
{

}

- (void)p_connect
{
    CGPoint startPoint = {CGRectGetMaxX(self.centerLayer.frame), self.centerLayer.frame.origin.y + self.centerLayer.frame.size.height / 2};
    CGPoint controlPont = {CGRectGetMinX(self.nameLayer.frame) - 40, self.nameLayer.frame.origin.y + self.nameLayer.frame.size.height / 2};
    CGPoint endPoint = {controlPont.x + 38.0, controlPont.y};
    CHRMarkConnectionLayer *connectionLayer = [CHRMarkConnectionLayer layerWithStartPoint:startPoint controlPoint:controlPont endPoint:endPoint];
    [self.layer addSublayer:connectionLayer];
}

#pragma mark - UITapGestureRecognizer Action
- (void)p_tap:(UITapGestureRecognizer *)tap
{
    CGPoint location = [tap locationInView:tap.view];
    if ([self.centerLayer containsPoint:location]) {
        if ([self.delegate respondsToSelector:@selector(marksView:didSelectCenterLayer:)])
            [self.delegate marksView:self didSelectCenterLayer:self.centerLayer];
    } else {
        BOOL flag = [self.delegate respondsToSelector:@selector(marksView:didSelectTextLayer:)];
        CHRMarkTextLayer *textLayer = nil;
        if ([self.nameLayer containsPoint:location]) {
            textLayer = self.nameLayer;
        } else if ([self.rateLayer containsPoint:location]) {
            textLayer = self.rateLayer;
        } else if ([self.categoryLayer containsPoint:location]) {
            textLayer = self.categoryLayer;
        }
        if (flag && textLayer) {
            [self.delegate marksView:self didSelectTextLayer:textLayer];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.nameLayer.frame = CGRectMake(self.bounds.size.width - self.nameLayer.preferredFrameSize.width, self.bounds.size.height - self.nameLayer.preferredFrameSize.height, self.nameLayer.preferredFrameSize.width, self.nameLayer.preferredFrameSize.height);
    self.centerLayer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    [self p_connect];
}

@end