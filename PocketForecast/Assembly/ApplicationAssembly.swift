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

@objc(ApplicationAssembly)
public class ApplicationAssembly: TyphoonAssembly {
    
    var coreComponents : CoreComponents!
    var themeAssembly : ThemeAssembly!
        
    public dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) {
            (definition) in
             
            definition.injectProperty("cityDao", with:self.coreComponents.cityDao())
            definition.injectProperty("rootViewController", with:self.rootViewController())
        }
    }

    
    public dynamic func config() -> AnyObject {

        return TyphoonDefinition.configDefinitionWithResource(
            TyphoonBundleResource.withName("Configuration.properties"))
    }

    public dynamic func rootViewController() -> AnyObject {
        return TyphoonDefinition.withClass(PFRootViewController.self) {
            (definition) in
            
            definition.useInitializer("initWithMainContentViewController:") {
                (initializer) in
                
                initializer.injectParameterWith(self.weatherReportController())
            }
            definition.scope = TyphoonScopeSingleton
        }
    }
    
    public dynamic func citiesListController() -> AnyObject {
        
        return TyphoonDefinition.withClass(PFCitiesListViewController.self) {
            (definition) in
            
            definition.useInitializer("initWithCityDao:theme:") {
                (initializer) in
                
                initializer.injectParameterWith(self.coreComponents.cityDao())
                initializer.injectParameterWith(self.themeAssembly.currentTheme())
            }
            definition.injectProperty("assembly")
        }
        
    }
    
    
    public dynamic func weatherReportController() -> AnyObject {
        
        return TyphoonDefinition.withClass(PFWeatherReportViewController.self) {
            (definition) in
            
            definition.useInitializer("initWithWeatherClient:weatherReportDao:cityDao:theme:assembly:") {
                (initializer) in
                
                initializer.injectParameterWith(self.coreComponents.weatherClient())
                initializer.injectParameterWith(self.coreComponents.weatherReportDao())
                initializer.injectParameterWith(self.coreComponents.cityDao())
                initializer.injectParameterWith(self.themeAssembly.currentTheme())
                initializer.injectParameterWith(self)

            }
        };
    }

    public dynamic func addCityViewController() -> AnyObject {

        return TyphoonDefinition.withClass(PFAddCityViewController.self) {
            (definition) in
            
            definition.useInitializer("initWithNibName:bundle:") {
                (initializer) in
                
                initializer.injectParameterWith("AddCity")
                initializer.injectParameterWith(NSBundle.mainBundle())
            }
            definition.injectProperty("cityDao", with:self.coreComponents.cityDao())
            definition.injectProperty("weatherClient", with:self.coreComponents.weatherClient())
            definition.injectProperty("theme", with:self.themeAssembly.currentTheme())
            definition.injectProperty("rootViewController", with:self.rootViewController())
        }
        
        
    }




}
