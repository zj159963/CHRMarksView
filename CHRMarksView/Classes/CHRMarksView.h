//
//  CHRMarksView.h
//  CHRMarksView
//
//  Created by 刘成勇 on 16/4/3.
//  Copyright © 2016年 yicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRMarks.h"

@class CHRMarksView;

@protocol CHRMarksViewDelegate <NSObject>

@optional
- (void)marksView:(nonnull CHRMarksView *)marksView didSelectTextLayer:(nonnull CATextLayer *)textLayer;
- (void)marksView:(nonnull CHRMarksView *)marksView didSelectCenterLayer:(nonnull CAShapeLayer *)centerLayer;

@end

@interface CHRMarksView : UIView

@property (nonatomic, copy, readwrite, nonnull) CHRMarks *marks;
@property (nonatomic, weak, readwrite, nullable) IBOutlet id<CHRMarksViewDelegate> delegate;

@end