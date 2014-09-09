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



#import "RXMLElement+PFWeatherReport.h"
#import "PocketForecast-Swift.h"


@implementation RXMLElement (PFWeatherReport)

- (WeatherReport *)asWeatherReport
{
    if (![self.tag isEqualToString:@"data"])
    {
        [NSException raise:NSInvalidArgumentException format:@"Element is not 'data'."];
    }

    NSString *city = [[self child:@"request.query"] text];
    CurrentConditions *currentConditions = [[self child:@"current_condition"] asCurrentCondition];

    NSMutableArray *forecast = [[NSMutableArray alloc] init];
    for (RXMLElement *e in [self children:@"weather"])
    {
        [forecast addObject:[e asForecastConditions]];
    }

    return [[WeatherReport alloc] initWithCity:city date:[NSDate date] currentConditions:currentConditions forecast:forecast];
}

- (CurrentConditions *)asCurrentCondition
{
    if (![self.tag isEqualToString:@"current_condition"])
    {
        [NSException raise:NSInvalidArgumentException format:@"Element is not 'current_condition'."];
    }

    NSString *summary = [[self child:@"weatherDesc"] text];
    Temperature *temp = [[Temperature alloc] initWithFahrenheitString:[[self child:@"temp_F"] text]];
    NSString *humidity = [[self child:@"humidity"] text];
    NSString
        *wind = [NSString stringWithFormat:@"Wind: %@ km %@", [[self child:@"windspeedKmph"] text], [[self child:@"winddir16Point"] text]];
    NSString *imageUri = [[self child:@"weatherIconUrl"] text];

    return [[CurrentConditions alloc] initWithSummary:summary temperature:temp humidity:humidity wind:wind imageUri:imageUri];
}

- (ForecastConditions *)asForecastConditions
{
    if (![self.tag isEqualToString:@"weather"])
    {
        [NSException raise:NSInvalidArgumentException format:@"Element is not 'weather'."];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:[[self child:@"date"] text]];
    Temperature *low = [[Temperature alloc] initWithFahrenheitString:[[self child:@"tempMinF"] text]];
    Temperature *high = [[Temperature alloc] initWithFahrenheitString:[[self child:@"tempMaxF"] text]];
    NSString *description = [[self child:@"weatherDesc"] text];
    NSString *imageUri = [[self child:@"weatherIconUrl"] text];

    return [[ForecastConditions alloc] initWithDate:date low:low high:high summary:description imageUri:imageUri];
}


@end