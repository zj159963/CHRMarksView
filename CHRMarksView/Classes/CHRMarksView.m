//
//  CHRMarksView.m
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/3.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import "CHRMarksView.h"
#import "CHRMarkCenterLayer.h"

@interface CHRMarksView ()

@property (nonatomic, strong, readwrite, nonnull) CHRMarkCenterLayer *centerLayer;
@property (nonatomic, strong, readwrite, nullable) CATextLayer *nameLayer;
@property (nonatomic, strong, readwrite, nullable) CATextLayer *rateLayer;
@property (nonatomic, strong, readwrite, nullable) CATextLayer *categoryLayer;

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

#pragma mark - UITapGestureRecognizer Action
- (void)p_tap:(UITapGestureRecognizer *)tap
{
    CGPoint location = [tap locationInView:tap.view];
    if ([self.centerLayer containsPoint:location]) {
        if ([self.delegate respondsToSelector:@selector(marksView:didSelectCenterLayer:)])
            [self.delegate marksView:self didSelectCenterLayer:self.centerLayer];
    } else {
        BOOL flag = [self.delegate respondsToSelector:@selector(marksView:didSelectTextLayer:)];
        CATextLayer *textLayer = nil;
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

    self.centerLayer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

@end