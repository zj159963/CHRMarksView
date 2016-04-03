//
//  CHRMarks.m
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/3.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import "CHRMarks.h"

@implementation CHRMarks

#pragma mark - Convenience
+ (nonnull instancetype)marksWithName:(nullable NSString *)name
                                 rate:(nullable NSString *)rate
                             category:(nullable NSString *)category
                    anchorPointString:(nonnull NSString *)anchorPointString
{
    return [[self alloc] initWithName:name rate:rate category:category anchorPointString:anchorPointString];
}

#pragma mark - Initializers
- (nonnull instancetype)initWithName:(nullable NSString *)name
                                rate:(nullable NSString *)rate
                            category:(nullable NSString *)category
                   anchorPointString:(nonnull NSString *)anchorPointString
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _rate = [rate copy];
        _category = [category copy];
        _anchorPointString = [anchorPointString copy];
        _style = CHRMarksStyleRateRight;
    }
    return self;
}

#pragma mark - NSCoping
- (id)copyWithZone:(NSZone *)zone
{
    CHRMarks *copy = [[[self class] allocWithZone:zone] initWithName:_name rate:_rate category:_category anchorPointString:_anchorPointString];
    copy.style = self.style;
    return copy;
}

@end