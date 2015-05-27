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

public class WeatherReportDaoTests : XCTestCase {
    
    var weatherReportDao : WeatherReportDao!
    
    public override func setUp() {
        let assembly = ApplicationAssembly().activate()
        self.weatherReportDao = assembly.coreComponents.weatherReportDao() as! WeatherReportDao
    }
    
    
    
    
}
