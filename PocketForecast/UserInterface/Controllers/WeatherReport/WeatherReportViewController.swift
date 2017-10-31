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

import UIKit


public class WeatherReportViewController: UIViewController {

    public var weatherReportView : WeatherReportView {
        get {
            return self.view as! WeatherReportView
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
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Overridden Methods
    //-------------------------------------------------------------------------------------------
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.isNavigationBarHidden = true

        if let cityName = self.cityDao.loadSelectedCity() {
            self.cityName = cityName
            if let weatherReport = self.weatherReportDao.getReportForCityName(cityName: cityName) {
                self.weatherReport = weatherReport
                self.weatherReportView.weatherReport = self.weatherReport
            }
            else  {
                self.refreshData()
            }
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.cityName != nil {
            
            let cityListButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: self, action: #selector(WeatherReportViewController.presentMenu))
            cityListButton.tintColor = .white
            
            let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            
            let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(WeatherReportViewController.refreshData))
            refreshButton.tintColor = .white
            
            self.weatherReportView.toolbar.items = [
                cityListButton,
                space,
                refreshButton
            ]
        }
    }

    
    public override func viewWillDisappear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = false
        super.viewWillDisappear(animated)
    }
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Private Methods
    //-------------------------------------------------------------------------------------------

    private dynamic func refreshData() {
        ICLoader.present()
        
        self.weatherClient.loadWeatherReportFor(city: self.cityName!, onSuccess: {
            weatherReport in
            
            self.weatherReportView.weatherReport = weatherReport
            ICLoader.dismiss()
            
            }, onError: {
                message in
                
                ICLoader.dismiss()
                print ("Error" + message)
                
                
        })
    }
    
    private dynamic func presentMenu() {
        let rootViewController = self.assembly.rootViewController() as! RootViewController
        rootViewController.toggleSideViewController()
    }

   

}
