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

#import <Foundation/Foundation.h>

@interface UIColor (Hex)

/**
* Returns a UIColor from the given hex representation. Example: [UIColor colorWithHexRGB:0x3b789b]
*/
+ (UIColor *)colorWithHexRGB:(NSUInteger)rgb;

+ (UIColor *)colorWithHexRGB:(NSUInteger)rgb alpha:(CGFloat)alpha;

@end