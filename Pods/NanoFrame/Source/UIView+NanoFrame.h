//
//  UIView+Position.h
//
//  Created by Constantine Karlis on 7/28/12.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import <UIKit/UIKit.h>

@interface UIView (NanoFrame)

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
