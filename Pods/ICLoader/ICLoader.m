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


#import "ICLoader.h"
#import <NanoFrame/NanoFrame.h>

static NSString *icLoaderLogoImageName;
static NSString *icLoaderLabelFontName;

@interface ICLoader ()

@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong, readonly) UIImageView *logoView;
@property(nonatomic, strong, readonly) UIView *centerDot;
@property(nonatomic, strong, readonly) UIView *leftDot;
@property(nonatomic, strong, readonly) UIView *rightDot;
@property(nonatomic, strong, readonly) UILabel *label;

@end

@implementation ICLoader

//-------------------------------------------------------------------------------------------
#pragma mark - Class Methods
//-------------------------------------------------------------------------------------------

+ (instancetype)present
{
    @synchronized (self)
    {
        UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;

        ICLoader *loader = [[ICLoader alloc] initWithWithImageName:icLoaderLogoImageName];
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [controller.view addSubview:loader];
            [controller.view setUserInteractionEnabled:NO];

            [UIView transitionWithView:loader duration:0.33 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^
            {
                [loader setFrame:controller.view.bounds];
            } completion:nil];
        });
        return loader;
    }
}

+ (void)dismiss
{
    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    dispatch_async(dispatch_get_main_queue(), ^
    {
        for (ICLoader *loader in [ICLoader loadersForView:controller.view])
        {
            [UIView transitionWithView:loader duration:0.25 options:UIViewAnimationOptionTransitionFlipFromTop animations:^
            {
                [loader setAlpha:0.0];
            } completion:^(BOOL finished)
            {
                [loader removeFromSuperview];
                [controller.view setUserInteractionEnabled:YES];
            }];
        }
    });
}

+ (NSArray *)loadersForView:(UIView *)view
{
    NSMutableArray *theHUDs = [NSMutableArray array];
    for (UIView *candidate in view.subviews)
    {
        if ([candidate isKindOfClass:[self class]])
        {
            [theHUDs addObject:candidate];
        }
    }
    return [NSArray arrayWithArray:theHUDs];
}

+ (void)setImageName:(NSString *)imageName
{
    icLoaderLogoImageName = imageName;
}

+ (void)setLabelFontName:(NSString *)fontName
{
    icLoaderLabelFontName = fontName;
}


//-------------------------------------------------------------------------------------------
#pragma mark - Initializers
//-------------------------------------------------------------------------------------------

- (id)initWithWithImageName:(NSString *)imageName
{
    if (imageName.length == 0)
    {
        [NSException raise:NSInvalidArgumentException
            format:@"ICLoader requires a logo image. Set with [ICLoader setImageName:anImageName]"];
    }

    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        [_backgroundView setBackgroundColor:[UIColor colorWithHexRGB:0x666677 alpha:0.8]];
        [_backgroundView.layer setCornerRadius:45];
        [_backgroundView setClipsToBounds:YES];
        [self addSubview:_backgroundView];

        [self initLogo:imageName];
        [self initDots];
        [self initLabel];
        [self animateToDot:_rightDot];
    }
    return self;
}



//-------------------------------------------------------------------------------------------
#pragma mark - Overridden Methods
//-------------------------------------------------------------------------------------------

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_backgroundView centerInRect:self.bounds];
}


//-------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//-------------------------------------------------------------------------------------------

- (void)initLogo:(NSString *)logoImageName
{
    UIImage *image = [UIImage imageNamed:logoImageName];
    _logoView = [[UIImageView alloc] initWithImage:image];
    [_logoView setViewSize:image.size];
    [_logoView centerInRect:CGRectMake(0, 7, 90, 45)];

    [_logoView setContentMode:UIViewContentModeScaleAspectFit];
    [_backgroundView addSubview:_logoView];

}

- (void)initDots
{

    CGFloat dodWidth = 5;
    CGFloat centerX = (_backgroundView.frame.size.width - dodWidth) / 2;
    CGFloat dotY = ((_backgroundView.frame.size.height - dodWidth) / 2) + 9;

    _centerDot = [[UIView alloc] initWithFrame:CGRectMake(centerX, dotY, dodWidth, dodWidth)];
    [_centerDot setBackgroundColor:[UIColor whiteColor]];
    [_centerDot.layer setCornerRadius:_centerDot.width / 2];
    [_centerDot.layer setOpacity:1.0];
    [_backgroundView addSubview:_centerDot];

    _leftDot = [[UIView alloc] initWithFrame:CGRectMake(centerX - 11, dotY, dodWidth, dodWidth)];
    [_leftDot setBackgroundColor:[UIColor whiteColor]];
    [_leftDot.layer setCornerRadius:_leftDot.width / 2];
    [_leftDot.layer setOpacity:0.5];
    [_backgroundView addSubview:_leftDot];

    _rightDot = [[UIView alloc] initWithFrame:CGRectMake(centerX + 11, dotY, dodWidth, dodWidth)];
    [_rightDot setBackgroundColor:[UIColor whiteColor]];
    [_rightDot.layer setCornerRadius:_rightDot.width / 2];
    [_rightDot.layer setOpacity:0.5];
    [_backgroundView addSubview:_rightDot];
}

- (void)initLabel
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(2 + (_backgroundView.frame.size.width - 65) / 2, 60, 65, 14)];
    [_label setBackgroundColor:[UIColor clearColor]];
    [_label setTextColor:[UIColor whiteColor]];
    [_label setTextAlignment:NSTextAlignmentCenter];
    [_label setFont:icLoaderLabelFontName ? [UIFont fontWithName:icLoaderLabelFontName size:10] : [UIFont systemFontOfSize:10]];
    [_label setText:@"Loading..."];
    [_backgroundView addSubview:_label];
}


- (void)animateToDot:(UIView *)dot
{
    __weak ICLoader *weakSelf = self;
    __weak UIView *centerDot = _centerDot;
    __weak UIView *leftDot = _leftDot;
    __weak UIView *rightDot = _rightDot;

    [UIView transitionWithView:weakSelf duration:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^
    {
        [centerDot.layer setOpacity:dot == centerDot ? 1.0 : 0.5];
        [rightDot.layer setOpacity:dot == rightDot ? 1.0 : 0.5];
        [leftDot.layer setOpacity:dot == leftDot ? 1.0 : 0.5];
    } completion:^(BOOL complete)
    {
        if (dot == centerDot)
        {
            [weakSelf animateToDot:rightDot];
        }
        else if (dot == rightDot)
        {
            [weakSelf animateToDot:leftDot];
        }
        else
        {
            [weakSelf animateToDot:centerDot];
        }
    }];
}


@end

