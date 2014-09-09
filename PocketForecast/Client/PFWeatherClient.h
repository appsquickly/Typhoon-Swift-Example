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



@class WeatherReport;

/**
* Block protocol for handling asynchronous responses from PFWeatherClient
*/

typedef void(^PFWeatherReportReceivedBlock)(WeatherReport* report);

typedef void(^PFWeatherReportErrorBlock)(NSString* message);

/* ====================================================================================================================================== */

/**
* Protocol specifying the retrieval of weather forecast information.
*/
@protocol PFWeatherClient <NSObject>

- (void)loadWeatherReportFor:(NSString*)city onSuccess:(void (^)(WeatherReport *))successBlock
    onError:(void (^)(NSString *))errorBlock;

@end