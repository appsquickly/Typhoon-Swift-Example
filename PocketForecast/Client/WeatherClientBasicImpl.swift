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

public class WeatherClientBasicImpl : NSObject, WeatherClient {
    
    var weatherReportDao : WeatherReportDao?
    var serviceUrl : NSURL?
    var daysToRetrieve : NSNumber?
    
    var apiKey : String? {
        willSet(newValue) {
            assert(newValue != "$$YOUR_API_KEY_HERE$$", "Please get an API key from: http://free.worldweatheronline.com, and then edit 'Configuration.properties'")
        }
    }
    
    public func loadWeatherReportFor(city: String!, onSuccess successBlock: ((WeatherReport!) -> Void)!, onError errorBlock: ((String!) -> Void)!) {
        
                
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            let url = self.queryURL(city)
            let data = NSData(contentsOfURL: url)
            
            let dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            
            if let error = dictionary.parseError() {
                dispatch_async(dispatch_get_main_queue()) {
                    errorBlock(error.rootCause())
                    return
                }
            }
            else {
                let weatherReport : WeatherReport = dictionary.toWeatherReport()
                self.weatherReportDao!.saveReport(weatherReport)
                dispatch_async(dispatch_get_main_queue()) {
                    successBlock(weatherReport)
                    return
                }
            }
        }
    }
    
    
    private func queryURL(city : String) -> NSURL {
        
        let serviceUrl : NSURL = self.serviceUrl!
        let url : NSURL = serviceUrl.uq_URLByAppendingQueryDictionary([
            "q" : city,
            "format" : "json",
            "num_of_days" : daysToRetrieve!.stringValue,
            "key" : apiKey!
            ])
        
        return url
    }
    
    
}