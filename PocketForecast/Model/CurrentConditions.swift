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

public class CurrentConditions : NSObject, NSCoding {
    
    private(set) var summary : String?
    private(set) var temperature : Temperature?
    private(set) var humidity : String?
    private(set) var wind : String?
    private(set) var imageUri : String?
    
    public init(summary : String, temperature : Temperature, humidity : String, wind : String, imageUri : String) {
        self.summary = summary
        self.temperature = temperature
        self.humidity = humidity
        self.wind = wind
        self.imageUri = imageUri
    }
    
    public required init(coder : NSCoder) {
        self.summary = coder.decodeObjectForKey("summary") as? String
        self.temperature = coder.decodeObjectForKey("temperature") as? Temperature
        self.humidity = coder.decodeObjectForKey("humidity") as? String
        self.wind = coder.decodeObjectForKey("wind") as? String
        self.imageUri = coder.decodeObjectForKey("imageUri") as? String
    }
    
    public func longSummary() -> String {
        return String(format: "%@. %@.", self.summary!, self.wind!)
    }
    
    public func description() -> String {
        return String(format: "Current Conditions: summary=%@, temperature=%@", self.summary!, self.temperature!)
    }
    
    public func encodeWithCoder(coder : NSCoder) {
        
        coder.encodeObject(self.summary!, forKey:"summary")
        coder.encodeObject(self.temperature!, forKey:"temperature")
        coder.encodeObject(self.humidity!, forKey:"humidity")
        coder.encodeObject(self.wind!, forKey:"wind")
        coder.encodeObject(self.imageUri!, forKey:"imageUri")
    }
}