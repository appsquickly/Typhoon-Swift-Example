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

public enum TemperatureUnits : Int {
    case Celsius
    case Fahrenheit
}


public class Temperature : NSObject, NSCoding {
    
    private var _temperatureInFahrenheit : NSDecimalNumber
    private var _shortFormatter : NSNumberFormatter
    private var _longFormatter : NSNumberFormatter

    public class func defaultUnits() -> TemperatureUnits {
        return TemperatureUnits(rawValue: NSUserDefaults.standardUserDefaults().integerForKey("pf.default.units"))!
    }

    public class func setDefaultUnits(units : TemperatureUnits) {
        NSUserDefaults.standardUserDefaults().setInteger(units.rawValue, forKey: "pf.default.units")
    }
    

  
    public init(temperatureInFahrenheit : NSDecimalNumber) {
        _temperatureInFahrenheit = temperatureInFahrenheit;
        
        _shortFormatter = NSNumberFormatter()
        _shortFormatter.minimumFractionDigits = 0;
        _shortFormatter.maximumFractionDigits = 0;
        
        _longFormatter = NSNumberFormatter()
        _longFormatter.minimumFractionDigits = 0
        _longFormatter.maximumFractionDigits = 1
        
    }
    
    public convenience init(fahrenheitString : String) {
        self.init(temperatureInFahrenheit:NSDecimalNumber(string: fahrenheitString))
    }
    
    public convenience init(celciusString : String) {
        let fahrenheit = NSDecimalNumber(string: celciusString)
            .decimalNumberByMultiplyingBy(9)
            .decimalNumberByDividingBy(5)
            .decimalNumberByAdding(32)
        self.init(temperatureInFahrenheit : fahrenheit)
    }
    
    public required convenience init(coder : NSCoder) {
        let temp = coder.decodeObjectForKey("temperatureInFahrenheit") as NSDecimalNumber
        self.init(temperatureInFahrenheit: temp)
        
    }
    
    public func inFahrenheit() -> NSNumber {
        return _temperatureInFahrenheit;
    }
    
    public func inCelcius() -> NSNumber {
        return _temperatureInFahrenheit
            .decimalNumberBySubtracting(32)
            .decimalNumberByMultiplyingBy(5)
            .decimalNumberByDividingBy(9)
    }
    
    public func asShortStringInDefaultUnits() -> String {
        if (Temperature.defaultUnits() == TemperatureUnits.Celsius) {
            return self.asShortStringInCelsius()
        }
        else {
            return self.asShortStringInFahrenheit()
        }
    }
    
    public func asLongStringInDefualtUnits() -> String {
        if (Temperature.defaultUnits() == TemperatureUnits.Celsius) {
            return self.asLongStringInCelsius()
        }
        else {
            return self.asLongStringInFahrenheit()
        }
    }
    
    public func asShortStringInFahrenheit() -> String {
        return _shortFormatter.stringFromNumber(self.inFahrenheit())! + "°"
    }
    

    public func asLongStringInFahrenheit() -> String {
        return _longFormatter.stringFromNumber(self.inFahrenheit())! + "°"
    }
    
    public func asShortStringInCelsius() -> String {
        return _shortFormatter.stringFromNumber(self.inCelcius())! + "°"
    }
    
    public func asLongStringInCelsius() -> String {
        return _longFormatter.stringFromNumber(self.inCelcius())! + "°"
    }
    
    public func description() -> String {
        return NSString(format: "Temperature: %@f [%@ celsius]", self.asShortStringInFahrenheit(),
            self.asShortStringInCelsius())
    }
    
    public func encodeWithCoder(coder : NSCoder) {
        coder.encodeObject(_temperatureInFahrenheit, forKey:"temperatureInFahrenheit");
    }
    
    
}