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



#import "PFCityDaoUserDefaultsImpl.h"


@implementation PFCityDaoUserDefaultsImpl


static NSString* const pfCitiesListKey = @"pfWeather.cities";
static NSString* const pfCurrentCityKey = @"pfWeather.currentCityKey";


/* ============================================================ Initializers ============================================================ */
- (id)init
{
    self = [super init];
    if (self)
    {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}


/* =========================================================== Protocol Methods ========================================================= */

- (NSArray*)listAllCities
{

    NSArray* cities = [_defaults objectForKey:pfCitiesListKey];
    if (cities == nil)
    {
        cities = @[
            @"Manila",
            @"Madris",
            @"San Francisco",
            @"Phnom Penh",
            @"Omsk"
        ];

        [_defaults setObject:cities forKey:pfCitiesListKey];
    }
    return [cities sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (void)saveCity:(NSString*)name
{
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray* cities = [NSMutableArray arrayWithArray:[_defaults objectForKey:pfCitiesListKey]];
    BOOL canAddCity = YES;
    for (NSString* city in cities)
    {
        if ([city caseInsensitiveCompare:name] == NSOrderedSame)
        {
            canAddCity = NO;
        }
    }
    if (canAddCity)
    {
        [cities addObject:name];
        [_defaults setObject:cities forKey:pfCitiesListKey];
    }
}

- (void)deleteCity:(NSString*)name
{
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray* cities = [NSMutableArray arrayWithArray:[_defaults objectForKey:pfCitiesListKey]];
    NSString* cityToRemove = nil;
    for (NSString* city in cities)
    {
        if ([city caseInsensitiveCompare:name] == NSOrderedSame)
        {
            cityToRemove = city;
        }
    }
    [cities removeObject:cityToRemove];
    [_defaults setObject:cities forKey:pfCitiesListKey];
}

- (void)saveCurrentlySelectedCity:(NSString*)cityName
{
    NSString* trimmed = [cityName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([trimmed length] > 0)
    {
        [_defaults setObject:cityName forKey:pfCurrentCityKey];
    }
}

- (void)clearCurrentlySelectedCity
{
    [_defaults setObject:nil forKey:pfCurrentCityKey];
}


- (NSString*)loadSelectedCity
{
    return [_defaults objectForKey:pfCurrentCityKey];
}


@end