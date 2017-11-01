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

public class ThemeAssembly : TyphoonAssembly {
    

    /**
     * Current-theme is emitted from the theme-factory, which increments the theme on each run of the application.
     */
    public dynamic func currentTheme() -> AnyObject {

        return TyphoonDefinition.withFactory(self.themeFactory(), selector: "sequentialTheme") as AnyObject
    }

    /**
    * The theme factory contains a collection of each theme. Individual themes are using Typhoon's type-converter system to convert the
    * string representation of properties to their required runtime type.
    */
    public dynamic func themeFactory() -> AnyObject {
        return TyphoonDefinition.withClass(ThemeFactory.self) {
            definition in

            definition!.useInitializer("initWithThemes:") {
                initializer in
                
                initializer!.injectParameter(with: [
                    self.cloudsOverTheCityTheme(),
                    self.lightsInTheRainTheme(),
                    self.beachTheme(),
                    self.sunsetTheme()
                    ])
            }
            definition!.scope = TyphoonScope.singleton
        } as AnyObject
    }


    public dynamic func cloudsOverTheCityTheme() -> AnyObject {
        return TyphoonDefinition.withClass(Theme.self) {
            definition in

                definition!.injectProperty("backgroundResourceName", with:"bg3.png")
                definition!.injectProperty("navigationBarColor", with:UIColor(hexRGB:0x641d23))
                definition!.injectProperty("forecastTintColor", with:UIColor(hexRGB:0x641d23))
                definition!.injectProperty("controlTintColor", with:UIColor(hexRGB:0x7f9588))
        } as AnyObject
    }


    public dynamic func lightsInTheRainTheme() -> AnyObject {
        return TyphoonDefinition.withClass(Theme.self) {
            definition in

                definition!.injectProperty("backgroundResourceName", with:"bg4.png")
                definition!.injectProperty("navigationBarColor", with:UIColor(hexRGB:0xeaa53d))
                definition!.injectProperty("forecastTintColor", with:UIColor(hexRGB:0x722d49))
                definition!.injectProperty("controlTintColor", with:UIColor(hexRGB:0x722d49))
        } as AnyObject
    }


    public dynamic func beachTheme() -> AnyObject {
        return TyphoonDefinition.withClass(Theme.self) {
            definition in

                definition!.injectProperty("backgroundResourceName", with:"bg5.png")
                definition!.injectProperty("navigationBarColor", with:UIColor(hexRGB:0x37b1da))
                definition!.injectProperty("forecastTintColor", with:UIColor(hexRGB:0x37b1da))
                definition!.injectProperty("controlTintColor", with:UIColor(hexRGB:0x0043a6))
        } as AnyObject
    }

    public dynamic func sunsetTheme() -> AnyObject {
        return TyphoonDefinition.withClass(Theme.self) {
            definition in

                definition!.injectProperty("backgroundResourceName", with:"sunset.png")
                definition!.injectProperty("navigationBarColor", with:UIColor(hexRGB:0x0a1d3b))
                definition!.injectProperty("forecastTintColor", with:UIColor(hexRGB:0x0a1d3b))
                definition!.injectProperty("controlTintColor", with:UIColor(hexRGB:0x606970))
        } as AnyObject
    }
    
}
