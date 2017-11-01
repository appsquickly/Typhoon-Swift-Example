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

public class WeatherReport : NSObject, NSCoding {
    
    public private(set) var city : String
    public private(set) var date : NSDate
    public private(set) var currentConditions : CurrentConditions
    public private(set) var forecast : Array<ForecastConditions>
    
    public var cityDisplayName : String {
        let components : Array<String> = self.city.components(separatedBy: ",")
        if components.count > 1 {
            return components[0]
        }
        return self.city.capitalized
    }
    
    
    public init(city : String, date : NSDate, currentConditions : CurrentConditions,
        forecast : Array<ForecastConditions>) {
        
        self.city = city
        self.date = date
        self.currentConditions = currentConditions
        self.forecast = forecast
    }
    
    public required init?(coder : NSCoder) {
        self.city = coder.decodeObject(forKey: "city") as! String
        self.date = coder.decodeObject(forKey: "date") as! NSDate
        self.currentConditions = coder.decodeObject(forKey: "currentConditions") as! CurrentConditions
        self.forecast = coder.decodeObject(forKey: "forecast") as! Array<ForecastConditions>
    }
    
    public func reportDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd',' yyyy 'at' hh:mm a"
        dateFormatter.locale = NSLocale.current
        return dateFormatter.string(from: self.date as Date)
    }
    
    public override var description: String {
        return String(format: "Weather Report: city=%@, current conditions = %@, forecast=%@", self.city, self.currentConditions, self.forecast )
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.city, forKey:"city")
        coder.encode(self.date, forKey:"date")
        coder.encode(self.currentConditions, forKey:"currentConditions")
        coder.encode(self.forecast, forKey:"forecast")

    }
}
