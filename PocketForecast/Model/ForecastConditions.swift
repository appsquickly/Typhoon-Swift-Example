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
    
	private(set) var date : Date?
    private(set) var low : Temperature?
	private(set) var high : Temperature?
	private(set) var summary : String
	private(set) var imageUri : String
    
    public init(date : Date, low : Temperature?, high : Temperature?, summary : String, imageUri : String) {
        self.date = date
        self.low = low
        self.high = high
        self.summary = summary
        self.imageUri = imageUri
    }
    
    public required init?(coder : NSCoder) {
        self.date = coder.decodeObject(forKey: "date") as? Date
        self.low = coder.decodeObject(forKey: "low") as? Temperature
        self.high = coder.decodeObject(forKey: "high") as? Temperature
        self.summary = coder.decodeObject(forKey: "summary") as! String
        self.imageUri = coder.decodeObject(forKey: "imageUri") as! String
    }
    
    public func longDayOfTheWeek() -> String? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self.date!)
    }
    
    public override var description: String {
        if self.low != nil && self.high != nil {
            return String(format: "Forecast : day=%@, low=%@, high=%@", self.longDayOfTheWeek()!, self.low!, self.high!)
        } else {
            return String(format: "Forecast : day=%@, low=%@, high=%@", self.longDayOfTheWeek()!, "", "")
        }
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.date, forKey:"date")
        coder.encode(self.low, forKey:"low")
        coder.encode(self.high, forKey:"high")
        coder.encode(self.summary, forKey:"summary")
        coder.encode(self.imageUri, forKey:"imageUri")
    }
    
}
