//
//  CHRMarkTextLayer.h
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/3.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSUInteger, CHRMarkTextLayerStyle)
{
    CHRMarkTextLayerStyleSharpLeft,
    CHRMarkTextLayerStyleSharpRight,
};

@interface CHRMarkTextLayer : CALayer

@property (nonatomic, copy, readwrite, nonnull) NSString *text; // Defualt is @""
@property (nonatomic, assign, readwrite, nonnull) CGColorRef textColor; // Default is white
@property (nonatomic, assign, readwrite) CHRMarkTextLayerStyle sharpStyle; // Default is Left
@property (nonatomic, assign, readwrite) CGFloat fontSize;

@end