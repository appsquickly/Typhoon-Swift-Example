////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

import Foundation

/*
* City DAO (persistence) protocol.
* (Currently, injected protocols require the @objc annotation).
*/
@objc public protocol CityDao {
    
    /**
    * Returns an array containing the names of all cities to report weather for.
    */
    func listAllCities() -> [AnyObject]!
    
    /**
    * Adds a new city to the list of cities to report weather for. If the city already exists in 
    * the list, it is ignored.
    */
    func saveCity(name: String!)
    
    /**
    * Removes the city with the specified name from the list of cities to report weather for. If 
    * the city doesn't exist in the list, it will be ignored.
    */
    func deleteCity(name: String!)
    
    /**
    * Used to store the last page that the user visits.
    */
    func saveCurrentlySelectedCity(cityName: String!)
    
    /**
    * Clears out the currently selected city.
    */
    func clearCurrentlySelectedCity()
    
    /**
    * Used to retrieve the last page that the user has visited, or nil if first use.
    */
    func loadSelectedCity() -> String?
    
}