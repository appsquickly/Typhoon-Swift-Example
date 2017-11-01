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

public class CityDaoUserDefaultsImpl : NSObject, CityDao {
    
    var defaults : UserDefaults
    let citiesListKey = "pfWeather.cities"
    let currentCityKey = "pfWeather.currentCityKey"
    
    let defaultCities = [
        "Manila",
        "Madrid",
        "San Francisco",
        "Phnom Penh",
        "Omsk"
    ]
    
    
    init(defaults : UserDefaults) {
        self.defaults = defaults
    }
    
    public func listAllCities() -> [String] {
        
        var cities : Array? = self.defaults.array(forKey: self.citiesListKey)
        if cities == nil {
            cities = defaultCities;
            self.defaults.set(cities, forKey:self.citiesListKey)
        }
        return (cities as! [String]).sorted {
            return $0 < $1
        }
    }
    
    public func saveCity(name: String) {

        let trimmedName = name.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        let savedCities : Array? = self.defaults.array(forKey: self.citiesListKey)
        
        let cities: [String] = (savedCities != nil) ? savedCities as! [String] : defaultCities
        
        for city in cities {
            if city.lowercased() == trimmedName.lowercased() {
                return
            }
        }
        
        self.defaults.set(cities + [trimmedName], forKey: self.citiesListKey)
    }
    
    public func deleteCity(name: String) {
        
        let trimmedName = name.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        var cities: [String] = self.defaults.array(forKey: self.citiesListKey) as! [String]
        
        for (index, city) in cities.enumerated() {
            if city.lowercased() == trimmedName.lowercased() {
                self.defaults.set(cities.remove(at: index), forKey: self.citiesListKey)
            }
        }

    }
    
    public func saveCurrentlySelectedCity(cityName: String) {
        
        let trimmed = cityName.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if !trimmed.isEmpty {
            self.defaults.set(trimmed, forKey: self.currentCityKey)
        }
    }
    
    
    public func clearCurrentlySelectedCity() {
        
        self.defaults.set(nil, forKey: self.currentCityKey)
        
    }
    
    public func loadSelectedCity() -> String? {
        
        return self.defaults.string(forKey: self.currentCityKey)
    }

    
}
