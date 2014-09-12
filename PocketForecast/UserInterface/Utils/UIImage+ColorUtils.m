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

#import "UIImage+ColorUtils.h"

@implementation UIImage (ColorUtils)

+ (UIImage *)imageWithCALayer:(CALayer *)layer
{
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, [[UIScreen mainScreen] scale]);

    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *out = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return out;
}

+ (UIImage *)imageWithUIView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth([view bounds]), CGRectGetHeight([view bounds])), NO,
        [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage *)imageNamed:(NSString *)name tint:(UIColor *)tint
{
    return [[self imageNamed:name] tint:tint];
}

- (UIImage *)tint:(UIColor *)tint
{
    NSAssert(tint != nil, @"tint must not be nil");

    UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0);
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);

    [tint setFill];

    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (UIColor *)colorAtPixel:(CGPoint)point
{
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point))
    {
        return nil;
    }


    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    // flip it larry
    NSInteger pointY = trunc(self.size.height - point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = CGImageGetWidth(cgImage);
    NSUInteger height = CGImageGetHeight(cgImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {
        0,
        0,
        0,
        0
    };
    CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace,
        kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);

    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, -pointY);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat) width, (CGFloat) height), cgImage);
    CGContextRelease(context);

    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red = (CGFloat) pixelData[0] / 255.0f;
    CGFloat green = (CGFloat) pixelData[1] / 255.0f;
    CGFloat blue = (CGFloat) pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat) pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
