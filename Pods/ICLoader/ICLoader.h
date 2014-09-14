////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@class FXBlurView;


@interface ICLoader : UIView

+ (instancetype)present;

+ (void)dismiss;

+ (NSArray*)loadersForView:(UIView*)view;

/**
* Sets logo image to present.
*/
+ (void)setImageName:(NSString*)imageName;

/**
* Sets the label font name.
*/
+ (void)setLabelFontName:(NSString*)fontName;

@end
