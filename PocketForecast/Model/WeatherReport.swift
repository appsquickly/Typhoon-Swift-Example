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
        var displayName : String
        let components : Array<String> = self.city.componentsSeparatedByString(",")
        if (components.count > 1) {
            displayName = components[0]
        }
        else {
            displayName = self.city.capitalizedString
        }
        
        return displayName
    }
    
    
    public init(city : String, date : NSDate, currentConditions : CurrentConditions,
        forecast : Array<ForecastConditions>) {
        
        self.city = city
        self.date = date
        self.currentConditions = currentConditions
        self.forecast = forecast
    }
    
    public required init?(coder : NSCoder) {
        self.city = coder.decodeObjectForKey("city") as! String
        self.date = coder.decodeObjectForKey("date") as! NSDate
        self.currentConditions = coder.decodeObjectForKey("currentConditions") as! CurrentConditions
        self.forecast = coder.decodeObjectForKey("forecast") as! Array<ForecastConditions>
    }
    
    public func reportDateAsString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd',' yyyy 'at' hh:mm a"
        dateFormatter.locale = NSLocale.currentLocale()
        return dateFormatter.stringFromDate(self.date)
    }
    
    public override var description: String {
        return String(format: "Weather Report: city=%@, current conditions = %@, forecast=%@", self.city, self.currentConditions, self.forecast )
    }
    
    public func encodeWithCoder(coder : NSCoder) {
        coder.encodeObject(self.city, forKey:"city")
        coder.encodeObject(self.date, forKey:"date")
        coder.encodeObject(self.currentConditions, forKey:"currentConditions")
        coder.encodeObject(self.forecast, forKey:"forecast")

    }

    

    
}
