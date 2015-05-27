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

/*
* Weather report DAO (persistence) protocol.
* (Currently, injected protocols require the @objc annotation).
*/
@objc public protocol WeatherReportDao {
    
    func getReportForCityName(cityName: String!) -> WeatherReport?
    
    func saveReport(weatherReport: WeatherReport!)
        
}
