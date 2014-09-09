////////////////////////////////////////////////////////////////////////////////
//
//  AppsQuick.ly
//  Copyright 2012 AppsQuick.ly
//  All Rights Reserved.
//
//  NOTICE: AppsQuick.ly permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////



#import "PFCityLabelTableViewCell.h"


@implementation PFCityLabelTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 45, 0)];
        [self addSubview:_cityLabel];
    }
    return self;
}

@end