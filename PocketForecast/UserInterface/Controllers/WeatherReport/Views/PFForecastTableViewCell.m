////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2013 Jasper Blues
//  All Rights Reserved.
//
//  NOTICE: Jasper Blues permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import "PFForecastTableViewCell.h"
#import "UIFont+ApplicationFonts.h"
#import "PocketForecast-Swift.h"


@implementation PFForecastTableViewCell

/* ============================================================ Initializers ============================================================ */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initBackgroundView];
        [self initOverlay];
        [self initConditionsIcon];
        [self initDayLabel];
        [self initDescriptionLabel];
        [self initHighTempLabel];
        [self initLowTempLabel];
    }
    return self;
}


/* ========================================================== Interface Methods ========================================================= */
- (void)layoutIfNeeded
{
    [super layoutSubviews];
    _overlayView.frame = self.bounds;
}


/* ============================================================ Private Methods ========================================================= */
- (void)initBackgroundView
{
    UIView* backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    [backgroundView setBackgroundColor:UIColorFromRGB(0x837758)];
    [self setBackgroundView:backgroundView];
}

- (void)initOverlay
{
    _overlayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    [_overlayView setImage:[UIImage imageNamed:@"cell_fade"]];
    [_overlayView setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:_overlayView];
}

- (void)initConditionsIcon
{
    _conditionsIcon = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 60 - 12, 50 - 12)];
    [_conditionsIcon setClipsToBounds:YES];
    [_conditionsIcon setContentMode:UIViewContentModeScaleAspectFit];
    [_conditionsIcon setImage:[UIImage imageNamed:@"icon_cloudy"]];
    [self addSubview:_conditionsIcon];
}

- (void)initDayLabel
{
    _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 150, 18)];
    [_dayLabel setFont:[UIFont applicationFontOfSize:16]];
    [_dayLabel setTextColor:UIColorFromRGB(0xffffff)];
    [_dayLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_dayLabel];
}

- (void)initDescriptionLabel
{
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 28, 150, 16)];
    [_descriptionLabel setFont:[UIFont applicationFontOfSize:13]];
    [_descriptionLabel setTextColor:UIColorFromRGB(0xe9e1cd)];
    [_descriptionLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_descriptionLabel];
}

- (void)initHighTempLabel
{
    _highTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 10, 55, 30)];
    [_highTempLabel setFont:[UIFont temperatureFontOfSize:27]];
    [_highTempLabel setTextColor:UIColorFromRGB(0xffffff)];
    [_highTempLabel setBackgroundColor:[UIColor clearColor]];
    [_highTempLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_highTempLabel];
}

- (void)initLowTempLabel
{
    _lowTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 11.5, 40, 30)];
    [_lowTempLabel setFont:[UIFont temperatureFontOfSize:20]];
    [_lowTempLabel setTextColor:UIColorFromRGB(0xd9d1bd)];
    [_lowTempLabel setBackgroundColor:[UIColor clearColor]];
    [_lowTempLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_lowTempLabel];
}



@end