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
import PocketForecast

public class CityDaoTests : XCTestCase {
    
    var cityDao : CityDao!
    
    public override func setUp() {
        let assembly = ApplicationAssembly().activate()
        self.cityDao = assembly.coreComponents.cityDao() as! CityDao
    }
    
    public func test_it_lists_all_cities_alphabetically() {
        let cities = self.cityDao.listAllCities()
        XCTAssertTrue(cities.count > 0)
    }
    
    public func test_it_allows_adding_a_city() {
        self.cityDao.saveCity("Manila")
        let cities : [String!] = self.cityDao.listAllCities() as! [String!]
        
        XCTAssertTrue(cities.filter {$0 == "Manila"}.count == 1)
    }
    
    public func test_adding_same_city_twice_does_not_create_duplicates() {
        self.cityDao.saveCity("Manila")
        self.cityDao.saveCity("Manila")
        
        let cities : [String!] = self.cityDao.listAllCities() as! [String!]
        XCTAssertTrue(cities.filter {$0 == "Manila"}.count == 1)
    }

    public func test_allows_removing_a_city() {
        self.cityDao.deleteCity("Manila")
        let cities : [String!] = self.cityDao.listAllCities() as! [String!]
        XCTAssertTrue(cities.filter {$0 == "Manila"}.count == 0)
    }
  
    
}
