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
    
    var cities : Array<String>?
    
    init(cityDao : CityDao, theme : Theme) {
        super.init(nibName: "CitiesList", bundle: Bundle.main)
        self.cityDao = cityDao
        self.theme = theme
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public override func viewDidLoad() {
        self.title = "Pocket Forecast"
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CitiesListViewController.addCity))
        self.citiesListTableView.isEditing = true
        self.temperatureUnitsControl.addTarget(self, action: #selector(CitiesListViewController.saveTemperatureUnitPreference), for: .valueChanged)
        if Temperature.defaultUnits() == TemperatureUnits.Celsius {
            self.temperatureUnitsControl.selectedSegmentIndex = celciusSegmentIndex
        }
        else {
            self.temperatureUnitsControl.selectedSegmentIndex = fahrenheitSegmentIndex
        }
        self.applyTheme()
    }
    

    public override func viewWillAppear(_ animated : Bool) {
        super.viewWillAppear(animated)
        self.refreshCitiesList()
        if let cityName = cityDao.loadSelectedCity(), let cities = cities {
            if let index = cities.index(of: cityName) {
                let indexPath = IndexPath(row: index, section: 0)
                self.citiesListTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            }
        }
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cities = cities {
            return cities.count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseId = "Cities"
        let cell : CityTableViewCell
        if let dequeued = tableView.dequeueReusableCell(withIdentifier: reuseId) as? CityTableViewCell {
            cell = dequeued
        } else {
            cell = CityTableViewCell(style: .default, reuseIdentifier: reuseId)
        }
        cell.selectionStyle = .gray
        cell.cityLabel.backgroundColor = .clear
        cell.cityLabel.font = UIFont.applicationFontOfSize(size: 16)
        cell.cityLabel.textColor = .darkGray
        cell.cityLabel.text = cities![indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
  
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cityName : String = cities![indexPath.row]
        cityDao.saveCurrentlySelectedCity(cityName: cityName)
        
        let rootViewController = self.assembly.rootViewController() as! RootViewController
        rootViewController.dismissCitiesListController()
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return .delete
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let city = cities![indexPath.row]
            self.cityDao.deleteCity(name: city)
            self.refreshCitiesList()
        }
    }

    private dynamic func addCity() {
        
        let rootViewController = self.assembly.rootViewController() as! RootViewController
        rootViewController.showAddCitiesController()
    }
    
    private func refreshCitiesList() {
        self.cities = self.cityDao.listAllCities()
        self.citiesListTableView.reloadData()
    }
    
    private dynamic func saveTemperatureUnitPreference() {
        if self.temperatureUnitsControl.selectedSegmentIndex == celciusSegmentIndex {
            Temperature.setDefaultUnits(units: TemperatureUnits.Celsius)
        }
        else {
            Temperature.setDefaultUnits(units: TemperatureUnits.Fahrenheit)
        }
    }
    
    private func applyTheme() {
        self.temperatureUnitsControl.tintColor = self.theme.controlTintColor
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController!.navigationBar.barTintColor = self.theme.navigationBarColor
    }
    

}
