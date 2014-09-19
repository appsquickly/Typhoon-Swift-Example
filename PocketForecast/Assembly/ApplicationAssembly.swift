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

public class ApplicationAssembly: TyphoonAssembly {
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Bootstrapping
    //-------------------------------------------------------------------------------------------
    
    
    /*
     * These are modules - assemblies collaborate to provie components to this one.  At runtime you
     * can instantiate Typhoon with any assembly tha satisfies the module interface.
     */
    var coreComponents : CoreComponents!
    var themeAssembly : ThemeAssembly!
    
    
    /* 
     * This is the definition for our AppDelegate. Typhoon will inject the specified properties 
     * at application startup. 
     */
    public dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) {
            (definition) in
             
            definition.injectProperty("cityDao", with:self.coreComponents.cityDao())
            definition.injectProperty("rootViewController", with:self.rootViewController())
        }
    }

    
    /*
     * A config definition, referencing properties that will be loaded from a plist. 
     */
    public dynamic func config() -> AnyObject {
        
        return TyphoonDefinition.configDefinitionWithName("Configuration.plist")
    }

    
    //-------------------------------------------------------------------------------------------
    // MARK: - Main Assembly
    //-------------------------------------------------------------------------------------------
    
    public dynamic func rootViewController() -> AnyObject {
        return TyphoonDefinition.withClass(RootViewController.self) {
            (definition) in
            
            definition.useInitializer("initWithMainContentViewController:assembly:") {
                (initializer) in
                
                initializer.injectParameterWith(self.weatherReportController())
                initializer.injectParameterWith(self)
            }
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func citiesListController() -> AnyObject {
        
        return TyphoonDefinition.withClass(CitiesListViewController.self) {
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
        
        return TyphoonDefinition.withClass(WeatherReportViewController.self) {
            (definition) in
            
            definition.useInitializer("initWithView:weatherClient:weatherReportDao:cityDao:assembly:") {
                (initializer) in
                
                initializer.injectParameterWith(self.weatherReportView())
                initializer.injectParameterWith(self.coreComponents.weatherClient())
                initializer.injectParameterWith(self.coreComponents.weatherReportDao())
                initializer.injectParameterWith(self.coreComponents.cityDao())
                initializer.injectParameterWith(self)

            }
        };
    }
    
    public dynamic func weatherReportView() -> AnyObject {
        
        return TyphoonDefinition.withClass(WeatherReportView.self) {
            (definition) in
            
            definition.injectProperty("theme", with:self.themeAssembly.currentTheme())
        }
    }
    
    public dynamic func addCityViewController() -> AnyObject {

        return TyphoonDefinition.withClass(AddCityViewController.self) {
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
