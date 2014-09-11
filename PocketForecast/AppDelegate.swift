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
    var cityDao: PFCityDao?
    var rootViewController: PFRootViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName : UIFont.applicationFontOfSize(20),
            NSForegroundColorAttributeName : UIColor.whiteColor()
        ]
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = self.rootViewController
        self.window?.makeKeyAndVisible()
        
        let selectedCity : String! = cityDao?.loadSelectedCity()
        if (selectedCity == nil) {
            rootViewController?.showCitiesListController()
        }
        
                
        return true
    }
    

    
}

