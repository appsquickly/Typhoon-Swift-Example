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



@protocol PFCityDao<NSObject>

/**
* Returns an array containing the names of all cities to report weather for.
*/
- (NSArray*) listAllCities;

/**
* Adds a new city to the list of cities to report weather for. If the city already exists in the list, it will be
* ignored.
*/
- (void) saveCity:(NSString*)name;

/**
* Removes the city with the specified name from the list of cities to report weather for. If the city doesn't exist
* in the list, it will be ignored.
*/
- (void) deleteCity:(NSString*)name;

/**
* Used to store the last page that the user visits.
*/
- (void) saveCurrentlySelectedCity:(NSString*)cityName;

/**
* Clears out the currently selected city.
*/
- (void) clearCurrentlySelectedCity;

/**
* Used to retrieve the last page that the user has visited, or nil if first use.
*/
- (NSString*)loadSelectedCity;


@end