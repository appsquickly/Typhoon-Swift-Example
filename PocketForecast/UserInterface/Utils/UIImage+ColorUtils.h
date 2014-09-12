////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (ColorUtils)

+ (UIImage *)imageWithUIView:(UIView *)view;

+ (UIImage *)imageWithCALayer:(CALayer *)layer;

+ (UIImage *)imageNamed:(NSString *)name tint:(UIColor *)tint;

- (UIImage *)tint:(UIColor *)tint;

- (UIColor *)colorAtPixel:(CGPoint)point;

@end
