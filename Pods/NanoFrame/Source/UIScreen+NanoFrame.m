//
//  UIScreen+CKUITools.m
//
//  Created by Constantine Karlis on 11/5/12.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "UIScreen+NanoFrame.h"

@implementation UIScreen (NanoFrame)

-(CGSize)sizeWithOrientation:(int)orientation
{
    return [self rectWithOrientation:orientation].size;
}

-(CGRect)rectWithOrientation:(int)orientation
{
    CGRect r = [self applicationFrame];
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        return CGRectMake(0, 0, r.size.height, r.size.width);
    }
    else
    {
        return CGRectMake(0, 0, r.size.width, r.size.height);
    }
}

-(CGSize)currentSize
{
    return [self sizeWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

-(CGRect)currentRect
{
    CGSize s = [self currentSize];
    return CGRectMake(0, 0, s.width, s.height);
}

-(CGRect)landscapeRect
{
    return [self rectWithOrientation:UIInterfaceOrientationLandscapeRight];
}

-(CGRect)portraitRect
{
    return [self rectWithOrientation:UIInterfaceOrientationPortrait];
}

-(BOOL)isRetina
{
    return ([self respondsToSelector:@selector(scale)] && [self scale] == 2.0);
}

@end
