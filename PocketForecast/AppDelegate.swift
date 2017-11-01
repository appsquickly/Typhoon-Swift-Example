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


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var cityDao: CityDao?
    var rootViewController: RootViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        ICLoader.setImageName("cloud_icon.png")
        ICLoader.setLabelFontName(UIFont.applicationFontOfSize(size: 10).fontName)
        
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName : UIFont.applicationFontOfSize(size: 20),
            NSForegroundColorAttributeName : UIColor.white
        ]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.rootViewController
        self.window?.makeKeyAndVisible()
        
        let selectedCity : String! = cityDao!.loadSelectedCity()
        if selectedCity == nil {
            rootViewController?.showCitiesListController()
        }
        
                
        return true
    }
    

    
}

