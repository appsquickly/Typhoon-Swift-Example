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



#import <XCTest/XCTest.h>
#import "PFTemperature.h"

@interface PFTemperatureTests : XCTestCase
@end

@implementation PFTemperatureTests

/* ====================================================================================================================================== */
#pragma mark - Object initialization



- (void)test_should_allow_initialization_with_a_fahrenheit_value
{

    PFTemperature* temperature = [PFTemperature temperatureWithFahrenheitString:@"81"];
    assertThat(temperature, notNilValue());
}

- (void)test_should_allow_initialization_with_a_celsius_value
{
    PFTemperature* temperature = [PFTemperature temperatureWithCelsiusString:@"27.5"];
    assertThat(temperature, notNilValue());
}



/* ====================================================================================================================================== */
#pragma mark - Converting values.


- (void)test_should_allow_converting_from_celsius_to_fahrenheit
{

    PFTemperature* temperature = [PFTemperature temperatureWithCelsiusString:@"27.5"];
    assertThat([temperature asShortStringInFahrenheit], equalTo(@"82°"));
    assertThat([temperature asLongStringInFahrenheit], equalTo(@"81.5°"));
    LogDebug(@"Temperature in fahrenheit: %@", [temperature asShortStringInFahrenheit]);
}

- (void)test_should_allow_converting_from_fahrenheit_to_celsius
{
    PFTemperature* temperature = [PFTemperature temperatureWithFahrenheitString:@"81"];
    assertThat([temperature asShortStringInCelsius], equalTo(@"27°"));
    assertThat([temperature asLongStringInCelsius], equalTo(@"27.2°"));
    LogDebug(@"Temperature in celsius: %@", [temperature asShortStringInCelsius]);
}


@end