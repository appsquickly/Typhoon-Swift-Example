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

extension NSDictionary {
   
    public func parseError() -> NSError? {
        
        if let errors = self.value(forKeyPath: "data.error") as? NSArray {
            if let errorDict = errors[0] as? NSDictionary {
                if let message = errorDict["msg"] as? String {
                    return NSError(message: message)
                }
            }
        }
        return nil;
    }
    
    
    public func toWeatherReport() -> WeatherReport {
        
        let city = (self.value(forKeyPath: "data.request.query") as! [String])[0]
        let currentConditions = (self.value(forKeyPath: "data.current_condition") as! [NSDictionary])[0].toCurrentConditions()
        var forecastConditions : Array<ForecastConditions> = []
        for item in self.value(forKeyPath: "data.weather") as! [NSDictionary] {
            forecastConditions.append(item.toForecastConditions())
        }
        return WeatherReport(city: city, date: NSDate(), currentConditions: currentConditions, forecast: forecastConditions)
    }
    
    public func toCurrentConditions() -> CurrentConditions {
        
        let summary = (self.value(forKeyPath: "weatherDesc") as! [NSDictionary])[0]["value"] as! String
        let temperature = Temperature(fahrenheitString: self.value(forKeyPath: "temp_F") as! String)
        let humidity = self.value(forKeyPath: "humidity") as! String
        let wind = String(format: "Wind: %@ km %@", self.value(forKeyPath: "windspeedKmph") as! String,
                          self.value(forKeyPath: "winddir16Point") as! String)
        let imageUri = (self.value(forKeyPath: "weatherIconUrl") as! [NSDictionary])[0]["value"] as! String
        
        return CurrentConditions(summary: summary, temperature: temperature, humidity: humidity, wind: wind, imageUri: imageUri)
    }
    
    public func toForecastConditions() -> ForecastConditions {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: self.value(forKeyPath: "date") as! String)!
        
        var low: Temperature?
        if let temp = self.value(forKeyPath: "mintempF") {
            low = Temperature(fahrenheitString: temp as! String)
        }
                
        var high: Temperature?
        if let temp = self.value(forKey: "maxtempF") {
            high = Temperature(fahrenheitString: temp as! String)
        }
        
        var description = ""
        if let desc = self.value(forKeyPath: "weatherDesc") {
          description = (desc as! [NSDictionary])[0]["value"] as! String
        }
        
        var imageUri = ""
        if let iconUrl = self.value(forKeyPath: "weatherIconUrl") {
            imageUri = (iconUrl as! [NSDictionary])[0]["value"] as! String
        }
        
        return ForecastConditions(date: date, low: low, high: high, summary: description, imageUri: imageUri)
    }
    
}

