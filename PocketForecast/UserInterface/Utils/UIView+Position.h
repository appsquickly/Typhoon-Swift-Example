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

@interface UIView (Position)

@property CGPoint position;
@property float x;
@property float y;
@property float right;
@property float bottom;
@property CGSize viewSize;
@property float width;
@property float height;

// some of these methods are inspired by Kevin O'Neill's UsefulBits UIView+Positioning methods
// https://github.com/kevinoneill/Useful-Bits/tree/master/UsefulBits/UIKit

- (void)centerInRect:(CGRect)rect;

- (void)centerVerticallyInRect:(CGRect)rect;

- (void)centerHorizontallyInRect:(CGRect)rect;

- (void)centerInSuperView;

- (void)centerVerticallyInSuperView;

- (void)centerHorizontallyInSuperView;

- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;

- (void)centerHorizontallyBelow:(UIView *)view;

- (void)alignLeftHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;

- (void)alignLeftHorizontallyBelow:(UIView *)view;

- (void)alignRightHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;

- (void)alignRightHorizontallyBelow:(UIView *)view;

- (void)snapPosition;

- (void)snapSize;

- (void)snapFrame;

@end
