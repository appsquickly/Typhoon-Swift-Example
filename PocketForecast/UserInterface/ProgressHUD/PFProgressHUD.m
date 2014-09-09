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


#import "PFProgressHUD.h"
#import "PFRootViewController.h"
#import "UIFont+ApplicationFonts.h"

@implementation PFProgressHUD
{
    UIView* _contentView;
    UIImageView* _backgroundView;
    UIImageView* _centerDot;
    UIImageView* _leftDot;
    UIImageView* _rightDot;
    UILabel* _label;
}

/* ====================================================================================================================================== */
#pragma mark - Class Methods

+ (instancetype)present
{
    PFRootViewController* controller = (PFRootViewController*) [UIApplication sharedApplication].keyWindow.rootViewController;
    [controller showProgressHUD];
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [controller.progressHUD withLabelText:@"Loading..."];
    });
    return controller.progressHUD;
}

+ (void)dismiss
{
    PFRootViewController* controller = (PFRootViewController*) [UIApplication sharedApplication].keyWindow.rootViewController;
    [controller dismissProgressHUD];
}


+ (NSArray*)allHUDsForView:(UIView*)view
{
    NSMutableArray* theHUDs = [NSMutableArray array];
    for (UIView* candidate in view.subviews)
    {
        if ([candidate isKindOfClass:[self class]])
        {
            [theHUDs addObject:candidate];
        }
    }
    return [NSArray arrayWithArray:theHUDs];
}
/* ====================================================================================================================================== */
#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width - 90) / 2, (frame.size.height - 90) / 2, 90, 90)];
        [self addSubview:_contentView];

        [self initBackground];
        [self initDots];
        [self initLabel];
        [self animateToDot:_rightDot];
    }
    return self;
}


- (void)dealloc
{
    LogDebug(@"*** %@ in dealloc ***", NSStringFromClass([self class]));
}

/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)withLabelText:(NSString*)text
{
    [_label setText:text];
}


/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (void)initBackground
{
    UIImage* backgroundImage = [UIImage imageNamed:@"loader-bg.png"];
    _backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    [_backgroundView setFrame:_contentView.bounds];
    [_contentView addSubview:_backgroundView];
}

- (void)initDots
{
    UIImage* dotImage = [UIImage imageNamed:@"loader-dot.png"];

    CGFloat centerX = (_contentView.frame.size.width - dotImage.size.width) / 2;
    CGFloat dotY = ((_contentView.frame.size.height - dotImage.size.height) / 2) + 7;

    _centerDot = [[UIImageView alloc] initWithImage:dotImage];
    [_centerDot setFrame:CGRectMake(centerX, dotY, dotImage.size.width, dotImage.size.height)];
    [_centerDot.layer setOpacity:1.0];
    [_contentView addSubview:_centerDot];

    _leftDot = [[UIImageView alloc] initWithImage:dotImage];
    [_leftDot setFrame:CGRectMake(centerX - 11, dotY, dotImage.size.width, dotImage.size.height)];
    [_leftDot.layer setOpacity:0.5];
    [_contentView addSubview:_leftDot];

    _rightDot = [[UIImageView alloc] initWithImage:dotImage];
    [_rightDot setFrame:CGRectMake(centerX + 11, dotY, dotImage.size.width, dotImage.size.height)];
    [_rightDot.layer setOpacity:0.5];
    [_contentView addSubview:_rightDot];
}

- (void)initLabel
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake((_contentView.frame.size.width - 65) / 2, 60, 65, 14)];
    [_label setBackgroundColor:[UIColor clearColor]];
    [_label setTextColor:[UIColor whiteColor]];
    [_label setTextAlignment:NSTextAlignmentCenter];
    [_label setFont:[UIFont applicationFontOfSize:10]];
    [_contentView addSubview:_label];
}


- (void)animateToDot:(UIImageView*)dot
{
    __weak PFProgressHUD* weakSelf = self;
    __weak UIImageView* centerDot = _centerDot;
    __weak UIImageView* leftDot = _leftDot;
    __weak UIImageView* rightDot = _rightDot;

    [UIView transitionWithView:weakSelf duration:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^
    {
        [centerDot.layer setOpacity: dot == centerDot ? 1.0 : 0.5];
        [rightDot.layer setOpacity: dot == rightDot ? 1.0 : 0.5];
        [leftDot.layer setOpacity: dot == leftDot ? 1.0 : 0.5];
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