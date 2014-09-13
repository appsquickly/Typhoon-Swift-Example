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


public class CoreComponents: TyphoonAssembly {
    
    public dynamic func weatherClient() -> AnyObject {
        return TyphoonDefinition.withClass(WeatherClientBasicImpl.self) {
            (definition) in
            
            definition.injectProperty("serviceUrl", with:TyphoonConfig("service.url"))
            definition.injectProperty("apiKey", with:TyphoonConfig("api.key"))
            definition.injectProperty("weatherReportDao", with:self.weatherReportDao())
            definition.injectProperty("daysToRetrieve", with:TyphoonConfig("days.to.retrieve"))
        }
    }
    
    public dynamic func weatherReportDao() -> AnyObject {
        return TyphoonDefinition.withClass(WeatherReportDaoFileSystemImpl.self)
    }
    
    public dynamic func cityDao() -> AnyObject {
        
        return TyphoonDefinition.withClass(CityDaoUserDefaultsImpl.self) {
            (definition) in
            
            definition.useInitializer("initWithDefaults:") {
                (initializer) in
                
                initializer.injectParameterWith(NSUserDefaults.standardUserDefaults())
            }
        }        
    }

    
}
