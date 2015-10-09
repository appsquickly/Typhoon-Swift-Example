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
import PocketForecast

public class WeatherReportParsing : XCTestCase {
    
    public func test_parses_valid_report() {
        
        let jsonData = TyphoonBundleResource.withName("SampleForecast.json", inBundle: NSBundle(forClass: self.classForCoder)).data
        
        let dictionary = (try! NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers))
            as! NSDictionary
        let weatherReport : WeatherReport = dictionary.toWeatherReport()
        
    }
    
    public func test_parses_error_report() {
        let jsonData = TyphoonBundleResource.withName("ErrorForecast.json", inBundle: NSBundle(forClass: self.classForCoder)).data
        let dictionary = (try! NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers))
           as! NSDictionary
        
        let error : NSError! = dictionary.parseError()
        XCTAssertEqual(error!.rootCause(),
            "Unable to find any matching weather location to the query submitted!")

    }
    
    public func test_parse_error_returns_nil_for_valid_report() {
        
        let jsonData = TyphoonBundleResource.withName("SampleForecast.json", inBundle: NSBundle(forClass: self.classForCoder)).data
        
        let dictionary = (try! NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers))
            as! NSDictionary
        
        let error : NSError? = dictionary.parseError()
        
        XCTAssertNil(error)
        
    }
    
    
    
}
