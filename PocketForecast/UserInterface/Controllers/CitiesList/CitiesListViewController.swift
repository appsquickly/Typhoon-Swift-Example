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

public class CitiesListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, Themeable {
    
    let celciusSegmentIndex = 0
    let fahrenheitSegmentIndex = 1
    
    //Typhoon injected properties
    var cityDao : CityDao!
    public var theme : Theme!
    private dynamic var assembly : ApplicationAssembly!
    
    
    //Interface Builder injected properties
    @IBOutlet var citiesListTableView : UITableView!
    @IBOutlet var temperatureUnitsControl : UISegmentedControl!
    
    var cities : NSArray?
    
    init(cityDao : CityDao, theme : Theme) {
        super.init(nibName: "CitiesList", bundle: NSBundle.mainBundle())
        self.cityDao = cityDao
        self.theme = theme
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public override func viewDidLoad() {
        self.title = "Pocket Forecast"
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addCity")
        self.citiesListTableView.editing = true
        self.temperatureUnitsControl.addTarget(self, action: "saveTemperatureUnitPreference", forControlEvents: UIControlEvents.ValueChanged)
        if (Temperature.defaultUnits() == TemperatureUnits.Celsius) {
            self.temperatureUnitsControl.selectedSegmentIndex = celciusSegmentIndex
        }
        else {
            self.temperatureUnitsControl.selectedSegmentIndex = fahrenheitSegmentIndex
        }
        self.applyTheme()
    }
    

    public override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        self.refreshCitiesList()
        let cityName : String? = cityDao.loadSelectedCity()
        if (cityName != nil) {
            
            let indexPath = NSIndexPath(forRow: cities!.indexOfObject(cityName!), inSection: 0)
            self.citiesListTableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
        }
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (cities != nil) {
            return cities!.count
        }
        return 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseId = "Cities"
        var cell : CityTableViewCell? = tableView.dequeueReusableCellWithIdentifier(reuseId) as? CityTableViewCell
        if (cell == nil) {
            cell = CityTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseId)
        }
        cell!.selectionStyle = UITableViewCellSelectionStyle.Gray
        cell!.cityLabel.backgroundColor = UIColor.clearColor()
        cell!.cityLabel.font = UIFont.applicationFontOfSize(16)
        cell!.cityLabel.textColor = UIColor.darkGrayColor()
        cell!.cityLabel.text = cities!.objectAtIndex(indexPath.row) as? String
        cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell!
    }
  
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cityName : String = cities!.objectAtIndex(indexPath.row) as! String
        cityDao.saveCurrentlySelectedCity(cityName)
        
        let rootViewController = self.assembly.rootViewController() as! RootViewController
        rootViewController.dismissCitiesListController()
    }
    
    public func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.Delete
    }

    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let city = cities!.objectAtIndex(indexPath.row) as! String
            self.cityDao.deleteCity(city)
            self.refreshCitiesList()
        }
    }

    private dynamic func addCity() {
        
        let rootViewController = self.assembly.rootViewController() as! RootViewController
        rootViewController.showAddCitiesController()
    }
    
    private func refreshCitiesList() {
        self.cities = self.cityDao.listAllCities() as? Array<String>
        self.citiesListTableView.reloadData()
    }
    
    private dynamic func saveTemperatureUnitPreference() {
        if (self.temperatureUnitsControl.selectedSegmentIndex == celciusSegmentIndex) {
            Temperature.setDefaultUnits(TemperatureUnits.Celsius)
        }
        else {
            Temperature.setDefaultUnits(TemperatureUnits.Fahrenheit)
        }
    }
    
    private func applyTheme() {
        self.temperatureUnitsControl.tintColor = self.theme.controlTintColor
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.barTintColor = self.theme.navigationBarColor
    }
    

}
