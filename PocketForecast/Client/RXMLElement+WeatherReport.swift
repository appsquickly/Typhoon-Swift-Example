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

import Foundation

extension RXMLElement {
    
        
    public func asWeatherReport() -> WeatherReport {
        
        assert(self.tag == "data", "Element is not 'data'.")
        
        let city = self.child("request.query").text
        let currentConditions = self.child("current_condition").asCurrentCondition()
        var forecast : Array<ForecastConditions> = []
        for item in self.children("weather") {
            forecast.append(item.asForecastConditions())
        }
        return WeatherReport(city: city, date: NSDate.date(), currentConditions: currentConditions, forecast: forecast)
    }
    
    public func asCurrentCondition() -> CurrentConditions {
        
        assert(self.tag == "current_condition", "Element is not 'current_condition'.")
        
        let summary = self.child("weatherDesc").text
        let temperature = Temperature(fahrenheitString: self.child("temp_F").text)
        let humidity = self.child("humidity").text
        let wind = String(format: "Wind: %@ km %@", self.child("windspeedKmph").text, self.child("winddir16Point").text)
        let imageUri = self.child("weatherIconUrl").text
        return CurrentConditions(summary: summary, temperature: temperature, humidity: humidity, wind: wind, imageUri: imageUri)
    }
    
        
    public func asForecastConditions() -> ForecastConditions {
        
        assert(self.tag == "weather", "Element is not 'weather'.")
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.dateFromString(self.child("date").text)?
        let low = Temperature(fahrenheitString: self.child("tempMinF").text)
        let high = Temperature(fahrenheitString: self.child("tempMaxF").text)
        let description = self.child("weatherDesc").text
        let imageUri = self.child("weatherIconUrl").text
        return ForecastConditions(date: date!, low: low, high: high, summary: description, imageUri: imageUri)
    }
            
}
