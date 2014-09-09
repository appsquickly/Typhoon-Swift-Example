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
#import "PFCityDao.h"
#import "PFCoreComponents.h"
#import "Typhoon.h"

@interface PFCityDoaTests : XCTestCase
@end

@implementation PFCityDoaTests
{
    id <PFCityDao> cityDao;
}

/* ====================================================================================================================================== */
#pragma mark - Invoking create, list, delete methods on the City Data Access object


- (void)setUp
{
    
    TyphoonComponentFactory * factory = [TyphoonBlockComponentFactory factoryWithAssemblies:@[[PFCoreComponents assembly]]];
    
    cityDao = [factory componentForKey:@"cityDao"];
}


- (void)test_should_list_all_cities_alphabetically
{
    NSArray* cities = [cityDao listAllCities];
    assertThat(cities, isNot(isEmpty()));
}


- (void)test_should_allow_adding_a_city
{
    [cityDao saveCity:@"Manila"];

    NSArray* cities = [cityDao listAllCities];
    LogDebug(@"Cities now: %@", cities);
    assertThat(cities, isNot(isEmpty()));

    //Adding the same city twice doesn't add an extra item.
    NSUInteger citiesCount = [cities count];
    [cityDao saveCity:@"Manila"];
    cities = [cityDao listAllCities];
    LogDebug(@"Cities now: %@", cities);
    assertThat(cities, hasCountOf(citiesCount));

}

- (void)test_should_allow_removing_a_city
{
    [cityDao deleteCity:@"Manila"];
    NSArray* cities = [cityDao listAllCities];
    LogDebug(@"Cities now: %@", cities);
    assertThat(cities, isNot(isEmpty()));

    //Deleting a city that doesn't exist just gets ignored.
    [cityDao deleteCity:@"A City In The Sky - Part Coney Island and Part Paris"];

}


@end