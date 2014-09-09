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




#import <Foundation/Foundation.h>
#import "PFWeatherClient.h"
#import "PFWeatherReportViewDelegate.h"

@class WeatherReport;
@protocol PFWeatherReportDao;
@protocol PFCityDao;
@class Theme;
@class TyphoonComponentFactory;
@class ApplicationAssembly;
@class PFRootViewController;


@interface PFWeatherReportViewController : UIViewController <PFWeatherReportViewDelegate>
{

    WeatherReport *_weatherReport;
    NSString *_cityName;
}

#pragma mark - Injected w/ initializer

@property(nonatomic, strong, readonly) id <PFWeatherClient> weatherClient;
@property(nonatomic, strong, readonly) id <PFWeatherReportDao> weatherReportDao;
@property(nonatomic, strong, readonly) id <PFCityDao> cityDao;
@property(nonatomic, strong, readonly) Theme *theme;
@property(nonatomic, strong, readonly) ApplicationAssembly *assembly;


- (id)initWithWeatherClient:(id <PFWeatherClient>)weatherClient weatherReportDao:(id <PFWeatherReportDao>)weatherReportDao
    cityDao:(id <PFCityDao>)cityDao theme:(Theme *)theme assembly:(ApplicationAssembly *)assembly;


@end