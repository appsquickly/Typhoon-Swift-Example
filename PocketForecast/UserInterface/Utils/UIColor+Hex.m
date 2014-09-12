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

#import "UIColor+Hex.h"


@implementation UIColor (Hex)

+ (UIColor *)colorWithHexRGB:(NSUInteger)rgbValue
{
    return [UIColor colorWithRed:((CGFloat) ((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((CGFloat) ((rgbValue & 0xFF00) >> 8)) / 255.0
        blue:((CGFloat) (rgbValue & 0xFF)) / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithHexRGB:(NSUInteger)rgbValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((CGFloat) ((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((CGFloat) ((rgbValue & 0xFF00) >> 8)) / 255.0
        blue:((CGFloat) (rgbValue & 0xFF)) / 255.0 alpha:alpha];
}

@end