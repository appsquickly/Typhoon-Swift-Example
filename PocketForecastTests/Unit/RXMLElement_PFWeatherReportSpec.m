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
#import "RXMLElement+PFWeatherReport.h"
#import "PFWeatherReport.h"
#import "PFCurrentConditions.h"
#import "PFForecastConditions.h"
#import "PFTemperature.h"
#import "TyphoonBundleResource.h"

@interface RXMLElement_PFWeatherReportTests : XCTestCase
@end

@implementation RXMLElement_PFWeatherReportTests
{
    NSString* sampleReportString;
}


- (void)setUp
{
    sampleReportString = [[TyphoonBundleResource withName:@"SampleForecast.xml" inBundle:[NSBundle bundleForClass:[self class]]] asString];
}




/* ====================================================================================================================================== */
#pragma mark - Parsing weather report data


- (void)test_should_be_able_to_tranform_the_weather_node_to_a_PFWeatherReport_object
{

    RXMLElement* weather = [RXMLElement elementFromXMLString:sampleReportString encoding:NSUTF8StringEncoding];

    PFWeatherReport* weatherReport = [weather asWeatherReport];
    assertThat(weatherReport, notNilValue());
    assertThat(weatherReport.city, equalTo(@"Manila, Philippines"));
    assertThat(weatherReport.cityDisplayName, equalTo(@"Manila"));
    assertThat(weatherReport.date, notNilValue());
    LogDebug(@"Report date: %@", [weatherReport reportDateAsString]);


    PFCurrentConditions* currentConditions = [weatherReport currentConditions];
    assertThat(currentConditions, notNilValue());
    assertThat(currentConditions.summary, equalTo(@"Partly Cloudy"));
    assertThat([currentConditions.temperature asShortStringInFahrenheit], equalTo(@"77°"));
    assertThat(currentConditions.humidity, notNilValue());
    assertThat(currentConditions.wind, notNilValue());
    assertThat(currentConditions.imageUri, notNilValue());

    for (PFForecastConditions* forecastConditions in [weatherReport forecast])
    {
        LogDebug(@"Forecast: %@", forecastConditions);
        assertThat(forecastConditions, notNilValue());
        assertThat(forecastConditions.low, notNilValue());
        assertThat(forecastConditions.high, notNilValue());
        assertThat(forecastConditions.imageUri, notNilValue());
        assertThat(forecastConditions.summary, notNilValue());
        assertThat(forecastConditions.date, notNilValue());
        assertThat(forecastConditions.longDayOfTheWeek, notNilValue());
    }

}


@end