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

public class WeatherClientBasicImpl: NSObject, WeatherClient {

    var weatherReportDao: WeatherReportDao?
    var serviceUrl: NSURL?
    var daysToRetrieve: NSNumber?

    var apiKey: String? {
        willSet(newValue) {
            assert(newValue != "$$YOUR_API_KEY_HERE$$", "Please get an API key (v2) from: http://free.worldweatheronline.com, and then " +
                    "edit 'Configuration.plist'")
        }
    }

    public func loadWeatherReportFor(city: String!, onSuccess successBlock: @escaping ((WeatherReport) -> Void), onError errorBlock: @escaping ((String) -> Void)) {


        DispatchQueue.global(priority: .high).async() {
            let url = self.queryURL(city: city)
            let data : Data! = try! Data(contentsOf: url)
            
            let dictionary = (try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary

            if let error = dictionary.parseError() {
                DispatchQueue.main.async() {
                    errorBlock(error.rootCause())
                    return
                }
            } else {
                let weatherReport: WeatherReport = dictionary.toWeatherReport()
                self.weatherReportDao!.saveReport(weatherReport: weatherReport)
                DispatchQueue.main.async() {
                    successBlock(weatherReport)
                    return
                }
            }
        }
    }


    private func queryURL(city: String) -> URL {

        let serviceUrl: NSURL = self.serviceUrl!
        return serviceUrl.uq_URL(byAppendingQueryDictionary: [
            "q": city,
            "format": "json",
            "num_of_days": daysToRetrieve!.stringValue,
            "key": apiKey!
        ])
    }


}
