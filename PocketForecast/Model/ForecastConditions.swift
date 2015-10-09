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

public class ForecastConditions : NSObject, NSCoding {

	private(set) var date : NSDate?
    private(set) var low : Temperature?
	private(set) var high : Temperature?
	private(set) var summary : String?
	private(set) var imageUri : String?
    
    public init(date : NSDate, low : Temperature?, high : Temperature?, summary : String, imageUri : String) {
        self.date = date
        self.low = low
        self.high = high
        self.summary = summary
        self.imageUri = imageUri
    }
    
    public required init?(coder : NSCoder) {
        self.date = coder.decodeObjectForKey("date") as? NSDate
        self.low = coder.decodeObjectForKey("low") as? Temperature
        self.high = coder.decodeObjectForKey("high") as? Temperature
        self.summary = coder.decodeObjectForKey("summary") as? String
        self.imageUri = coder.decodeObjectForKey("imageUri") as? String
    }
    
    public func longDayOfTheWeek() -> String? {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.stringFromDate(self.date!)
    }
    
    public override var description: String {
        if self.low != nil && self.high != nil {
            return String(format: "Forecast : day=%@, low=%@, high=%@", self.longDayOfTheWeek()!, self.low!, self.high!)
        } else {
            return String(format: "Forecast : day=%@, low=%@, high=%@", self.longDayOfTheWeek()!, "", "")
        }
    }
    
    public func encodeWithCoder(coder : NSCoder) {
        coder.encodeObject(self.date!, forKey:"date")
        coder.encodeObject(self.low, forKey:"low")
        coder.encodeObject(self.high, forKey:"high")
        coder.encodeObject(self.summary!, forKey:"summary")
        coder.encodeObject(self.imageUri!, forKey:"imageUri")
    }
    
}
