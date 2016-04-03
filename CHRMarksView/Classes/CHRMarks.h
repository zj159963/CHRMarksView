//
//  CHRMarks.h
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/3.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CHRMarksStyle)
{
    CHRMarksStyleRateRight,
    CHRMarksStyleRateLeft,
    CHRMarksStyleAllLeft,
    CHRMarksStyleAllRight,
};

@interface CHRMarks : NSObject <NSCopying>

@property (nonatomic, copy, readonly, nullable) NSString *name;
@property (nonatomic, copy, readonly, nullable) NSString *rate;
@property (nonatomic, copy, readonly, nullable) NSString *category;
@property (nonatomic, copy, readonly, nonnull) NSString *anchorPointString;
@property (nonatomic, assign, readwrite) CHRMarksStyle style; // Default is CHRMarksStyleRateRight

- (nonnull instancetype)initWithName:(nullable NSString *)name
                                rate:(nullable NSString *)rate
                            category:(nullable NSString *)category
                   anchorPointString:(nonnull NSString *)anchorPointString;
+ (nonnull instancetype)marksWithName:(nullable NSString *)name
                                 rate:(nullable NSString *)rate
                             category:(nullable NSString *)category
                    anchorPointString:(nonnull NSString *)anchorPointString;

@end