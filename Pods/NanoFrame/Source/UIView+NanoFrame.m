//
//  UIView+Position.m
//
//  Created by Constantine Karlis on 7/28/12.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "UIView+NanoFrame.h"

@implementation UIView (NanoFrame)

-(void)setPosition:(CGPoint)position
{
    [self setCenter:CGPointMake(position.x + self.bounds.size.width/2.0f, position.y + self.bounds.size.height/2.0f)];
}

-(CGPoint)position
{
    return self.frame.origin;
}

-(void)setViewSize:(CGSize)size
{
    CGRect r = self.bounds;
    r.size = size;
    self.bounds = r;
}

-(CGSize)viewSize
{
    return self.bounds.size;
}

-(void)setWidth:(float)width
{
    CGRect r = self.bounds;
    r.size.width = width;
    self.bounds = r;
}

-(float)width
{
    return self.bounds.size.width;
}

-(void)setHeight:(float)height
{
    CGRect r = self.bounds;
    r.size.height = height;
    self.bounds = r;
}

-(float)height
{
    return self.bounds.size.height;
}

-(void)setX:(float)value
{
    [self setFrame:CGRectMake(value, self.y, self.bounds.size.width, self.bounds.size.height)];
}

-(float)x
{
    return self.frame.origin.x;
}

-(void)setY:(float)value
{
    [self setFrame:CGRectMake(self.x, value, self.bounds.size.width, self.bounds.size.height)];
}

-(float)y
{
    return self.frame.origin.y;
}

-(void)setRight:(float)value
{
    [self setCenter:CGPointMake(value - self.bounds.size.width / 2.0f, self.center.y)];
}

-(float)right
{
    return CGRectGetMaxX(self.frame);
}

-(void)setBottom:(float)value
{
    [self setCenter:CGPointMake(self.center.x, value - self.bounds.size.height / 2.0f)];
}

-(float)bottom
{
    return CGRectGetMaxY(self.frame);
}

-(void)centerInRect:(CGRect)rect
{
    [self centerHorizontallyInRect:rect];
    [self centerVerticallyInRect:rect];
}

- (void)centerVerticallyInRect:(CGRect)rect
{
    self.y = rect.origin.y + (rect.size.height - self.bounds.size.height)/2.0f;
}

- (void)centerHorizontallyInRect:(CGRect)rect
{
    self.x = rect.origin.x + (rect.size.width - self.bounds.size.width)/2.0f;
}

- (void)centerInSuperView
{
    self.center = CGPointMake(self.superview.bounds.size.width/2.0f, self.superview.bounds.size.height/2.0f);
}

- (void)centerVerticallyInSuperView
{
    self.y = (self.superview.bounds.size.height - self.bounds.size.height)/2.0f;
}

- (void)centerHorizontallyInSuperView
{
    self.x = (self.superview.bounds.size.width - self.bounds.size.width)/2.0f;
}

- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding
{
    self.y = CGRectGetMaxY(view.frame) + padding;
    self.x = view.x + (view.bounds.size.width - self.bounds.size.width)/2.0f;
}

- (void)centerHorizontallyBelow:(UIView *)view
{
    [self centerHorizontallyBelow:view padding:0.0f];
}

-(void)alignLeftHorizontallyBelow:(UIView *)view padding:(CGFloat)padding
{
    self.y = CGRectGetMaxY(view.frame) + padding;
    self.x = view.x;
}

-(void)alignLeftHorizontallyBelow:(UIView *)view
{
    [self alignLeftHorizontallyBelow:view padding:0.0f];
}

-(void)alignRightHorizontallyBelow:(UIView *)view padding:(CGFloat)padding
{
    self.y = CGRectGetMaxY(view.frame) + padding;
    self.right = view.right;
}

-(void)alignRightHorizontallyBelow:(UIView *)view
{
    [self alignRightHorizontallyBelow:view padding:0.0];
}

-(void)snapPosition
{
//    if we have a retina screen snap to nearest 0.5
    CGRect f = self.frame;
    if ([self screenIsRetina])
    {
        f.origin = CGPointMake((CGFloat)(roundf(f.origin.x*2.0)/2.0), (CGFloat)(roundf(f.origin.y*2.0)/2.0));
    }
    else
    {
        
        f.origin = CGPointMake(roundf(f.origin.x) , roundf(f.origin.y));
    }
    self.frame = f;
}

-(void)snapSize
{
    //    if we have a retina screen snap to nearest 0.5
    CGRect f = self.frame;
    if ([self screenIsRetina])
    {
        f.size = CGSizeMake((CGFloat)(roundf(f.size.width*2.0)/2.0), (CGFloat)(roundf(f.size.height*2.0)/2.0));
    }
    else
    {
        f.size = CGSizeMake(roundf(f.size.width) , roundf(f.size.height));
    }
    self.frame = f;
}

-(void)snapFrame
{
    if ([self screenIsRetina])
    {
        CGRect f = self.frame;
        f.size = CGSizeMake((CGFloat)(roundf(f.size.width*2.0)/2.0), (CGFloat)(roundf(f.size.height*2.0)/2.0));
        f.origin = CGPointMake((CGFloat)(roundf(f.origin.x*2.0)/2.0), (CGFloat)(roundf(f.origin.y*2.0)/2.0));
        self.frame = f;
    }
    else
    {
        self.frame = CGRectIntegral(self.frame);
    }
}

-(BOOL)screenIsRetina
{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0);
}

@end
