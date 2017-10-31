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

public class WeatherReportDaoFileSystemImpl : NSObject, WeatherReportDao {
        
    public func getReportForCityName(cityName: String) -> WeatherReport? {
        
        let filePath = self.filePathFor(cityName: cityName)
        let weatherReport : WeatherReport? = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? WeatherReport
        return weatherReport
    }
    
    public func saveReport(weatherReport: WeatherReport!) {
        
        NSKeyedArchiver.archiveRootObject(weatherReport, toFile: self.filePathFor(cityName: weatherReport.cityDisplayName))
    }

    
    private func filePathFor(cityName : String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let filePath = documentsDirectory + "weatherReport~>$\(cityName)"
        return filePath
    }
}
