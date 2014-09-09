////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The a\uthors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


@objc(CoreComponents)
public class CoreComponents: TyphoonAssembly {
    
    public dynamic func weatherClient() -> AnyObject {
        return TyphoonDefinition.withClass(WeatherClientBasicImpl.self) {
            (definition) in
            
            definition.injectProperty("serviceUrl", with:TyphoonConfig("service.url"))
            definition.injectProperty("apiKey", with:TyphoonConfig("api.key"))
            definition.injectProperty("weatherReportDao", with:self.weatherReportDao())
            
            // TODO: Test injection with Swift primitive structures and other “value-types"
            //definition.injectProperty("daysToRetrieve", with:TyphoonConfig("days.to.retrieve"))
        }
    }
    
    public dynamic func weatherReportDao() -> AnyObject {
        return TyphoonDefinition.withClass(PFWeatherReportDaoFileSystemImpl.self)
    }
    
    public dynamic func cityDao() -> AnyObject {
        return TyphoonDefinition.withClass(PFCityDaoUserDefaultsImpl.self)
    }

    
}
