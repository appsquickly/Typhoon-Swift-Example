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


public class WeatherReportViewController: UIViewController {

    public var weatherReportView : WeatherReportView {
        get {
            return self.view as WeatherReportView
        }
        set {
            self.view = newValue
        }
    }
    
    public private(set) var weatherClient : WeatherClient
    public private(set) var weatherReportDao : WeatherReportDao
    public private(set) var cityDao : CityDao
    public private(set) var assembly : ApplicationAssembly
    
    private var cityName : String?
    private var weatherReport : WeatherReport?
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Initialization & Destruction
    //-------------------------------------------------------------------------------------------
    
    public dynamic init(view: WeatherReportView, weatherClient : WeatherClient, weatherReportDao : WeatherReportDao, cityDao : CityDao, assembly : ApplicationAssembly) {
        
        self.weatherClient = weatherClient
        self.weatherReportDao = weatherReportDao
        self.cityDao = cityDao
        self.assembly = assembly
            
        super.init(nibName: nil, bundle: nil)
        
        self.weatherReportView = view
                    
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Overridden Methods
    //-------------------------------------------------------------------------------------------
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBarHidden = true

        self.cityName = self.cityDao.loadSelectedCity()
        if (self.cityName != nil) {
            self.weatherReport = self.weatherReportDao.getReportForCityName(self.cityName)
            if (self.weatherReport != nil) {
                self.weatherReportView.weatherReport = self.weatherReport
            }
            else if (self.cityName != nil) {
                self.refreshData()
            }
        }
    }

    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.cityName != nil) {
            
            let cityListButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks, target: self, action: "presentMenu")
            cityListButton.tintColor = UIColor.whiteColor()
            
            let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            
            let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "refreshData")
            refreshButton.tintColor = UIColor.whiteColor()
            
            self.weatherReportView.toolbar.items = [
                cityListButton,
                space,
                refreshButton
            ]
        }
    }

    
    public override func viewWillDisappear(animated: Bool) {
        self.navigationController!.navigationBarHidden = false
        super.viewWillDisappear(animated)
    }
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Private Methods
    //-------------------------------------------------------------------------------------------

    private dynamic func refreshData() {
        ICLoader.present()
        
        self.weatherClient.loadWeatherReportFor(self.cityName, onSuccess: {
            (weatherReport) in
            
            self.weatherReportView.weatherReport = weatherReport
            ICLoader.dismiss()
            
            }, onError: {
                (message) in
                
                ICLoader.dismiss()
                println ("Error" + message)
                
                
        })
    }
    
    private dynamic func presentMenu() {
        let rootViewController = self.assembly.rootViewController() as RootViewController
        rootViewController.toggleSideViewController()
    }

   

}
