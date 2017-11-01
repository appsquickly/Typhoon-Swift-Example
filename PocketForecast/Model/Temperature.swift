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

public enum TemperatureUnits : Int {
    case Celsius
    case Fahrenheit
}


public class Temperature : NSObject, NSCoding {
    
    private var _temperatureInFahrenheit : NSDecimalNumber
    private var _shortFormatter : NumberFormatter
    private var _longFormatter : NumberFormatter

    public class func defaultUnits() -> TemperatureUnits {
        return TemperatureUnits(rawValue: UserDefaults.standard.integer(forKey: "pf.default.units"))!
    }

    public class func setDefaultUnits(units : TemperatureUnits) {
        UserDefaults.standard.set(units.rawValue, forKey: "pf.default.units")
    }
    

  
    public init(temperatureInFahrenheit : NSDecimalNumber) {
        _temperatureInFahrenheit = temperatureInFahrenheit;
        
        _shortFormatter = NumberFormatter()
        _shortFormatter.minimumFractionDigits = 0;
        _shortFormatter.maximumFractionDigits = 0;
        
        _longFormatter = NumberFormatter()
        _longFormatter.minimumFractionDigits = 0
        _longFormatter.maximumFractionDigits = 1
        
    }
    
    public convenience init(fahrenheitString : String) {
        self.init(temperatureInFahrenheit:NSDecimalNumber(string: fahrenheitString))
    }
    
    public convenience init(celciusString : String) {
        let fahrenheit = NSDecimalNumber(string: celciusString)
            .multiplying(by: 9)
            .dividing(by: 5)
            .adding(32)
        self.init(temperatureInFahrenheit : fahrenheit)
    }
    
    public required convenience init?(coder : NSCoder) {
        let temp = coder.decodeObject(forKey: "temperatureInFahrenheit") as! NSDecimalNumber
        self.init(temperatureInFahrenheit: temp)
        
    }
    
    public func inFahrenheit() -> NSNumber {
        return _temperatureInFahrenheit;
    }
    
    public func inCelcius() -> NSNumber {
        return _temperatureInFahrenheit
            .subtracting(32)
            .multiplying(by: 5)
            .dividing(by: 9)
    }
    
    public func asShortStringInDefaultUnits() -> String {
        if Temperature.defaultUnits() == TemperatureUnits.Celsius {
            return self.asShortStringInCelsius()
        }
        return self.asShortStringInFahrenheit()
    }
    
    public func asLongStringInDefualtUnits() -> String {
        if Temperature.defaultUnits() == TemperatureUnits.Celsius {
            return self.asLongStringInCelsius()
        }
        return self.asLongStringInFahrenheit()
    }
    
    public func asShortStringInFahrenheit() -> String {
        return _shortFormatter.string(from: self.inFahrenheit())! + "°"
    }
    

    public func asLongStringInFahrenheit() -> String {
        return _longFormatter.string(from: self.inFahrenheit())! + "°"
    }
    
    public func asShortStringInCelsius() -> String {
        return _shortFormatter.string(from: self.inCelcius())! + "°"
    }
    
    public func asLongStringInCelsius() -> String {
        return _longFormatter.string(from: self.inCelcius())! + "°"
    }
    
    public override var description: String {
        return "Temperature: \(self.asShortStringInFahrenheit())f [\(self.asShortStringInCelsius()) celsius]"
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(_temperatureInFahrenheit, forKey:"temperatureInFahrenheit");
    }
    
    
}
