//
//  CHRMarkTextLayer.m
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/3.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import "CHRMarkTextLayer.h"
#import <UIKit/UIKit.h>

@interface CHRMarkTextLayer ()

@property (nonatomic, strong, readwrite, nonnull) CATextLayer *textLayer;

@end

@implementation CHRMarkTextLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor].CGColor;
        _fontSize = 9.0;
        _text = @"";
        _textColor = [UIColor whiteColor].CGColor;
        _textLayer = [CATextLayer layer];
        _textLayer.string = _text;
        _textLayer.font = (__bridge CFTypeRef _Nullable)([UIFont systemFontOfSize:_fontSize]);
        _textLayer.foregroundColor = _textColor;
        [self addSublayer:_textLayer];
    }
    return self;
}

@end