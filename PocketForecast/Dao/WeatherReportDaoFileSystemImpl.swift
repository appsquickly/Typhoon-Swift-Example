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

public class WeatherReportDaoFileSystemImpl : NSObject, WeatherReportDao {
        
    public func getReportForCityName(cityName: String!) -> WeatherReport? {
        
        let filePath = self.filePathFor(cityName)
        let weatherReport : WeatherReport? = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? WeatherReport
        return weatherReport
    }
    
    public func saveReport(weatherReport: WeatherReport!) {
        
        NSKeyedArchiver.archiveRootObject(weatherReport, toFile: self.filePathFor(weatherReport.cityDisplayName))
    }

    
    private func filePathFor(cityName : String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0] as String
        let weatherReportKey = String(format: "weatherReport~>$%@", cityName)
        let filePath = documentsDirectory.stringByAppendingString(weatherReportKey)
        return filePath
    }
}
