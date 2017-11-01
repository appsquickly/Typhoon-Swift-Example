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

public class WeatherReportView : UIView, UITableViewDelegate, UITableViewDataSource, Themeable {
    
    private var backgroundView : UIImageView!
    private var cityNameLabel : UILabel!
    private var conditionsDescriptionLabel : UILabel!
    private var conditionsIcon : UIImageView!

    private var temperatureLabelContainer : UIView!
    private var temperatureLabel : UILabel!
    
    private var lastUpdateLabel : UILabel!
    private var tableView : UITableView!
    
    public var toolbar : UIToolbar!
    
    public var weatherReport : WeatherReport? {
        willSet(weatherReport) {
            
            if let weatherReport = weatherReport {
                self.tableView.isHidden = false
                self.conditionsIcon.isHidden = false
                self.temperatureLabelContainer.isHidden = false
                self.tableView.reloadData()
                self.cityNameLabel.text = weatherReport.cityDisplayName
                self.temperatureLabel.text = weatherReport.currentConditions.temperature!.asShortStringInDefaultUnits()
                self.conditionsDescriptionLabel.text = weatherReport.currentConditions.longSummary()
                self.lastUpdateLabel.text = "Updated \(weatherReport.reportDateAsString())"

            }
        }
    }
    
    public var theme : Theme! {
        willSet(theme) {
            DispatchQueue.main.async() {
                self.toolbar.barTintColor = theme.forecastTintColor
                self.backgroundView.image = UIImage(named: theme.backgroundResourceName!)
                self.tableView.reloadData()
            }
        }
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Initialization & Destruction
    //-------------------------------------------------------------------------------------------
    
    public override init(frame : CGRect) {
        super.init(frame : frame)
        
        self.initBackgroundView()
        self.initCityNameLabel()
        self.initConditionsDescriptionLabel()
        self.initConditionsIcon()
        self.initTemperatureLabel()
        self.initTableView()
        self.initToolbar()
        self.initLastUpdateLabel()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Overridden methods
    //-------------------------------------------------------------------------------------------

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundView.frame = self.bounds.insetBy(dx: -10, dy: -10)
        
        self.cityNameLabel.frame = CGRect(x: 0, y: 60, width: self.frame.size.width, height: 40)
        self.conditionsDescriptionLabel.frame = CGRect(x: 0, y: 90, width: 320, height: 50)
        self.conditionsIcon.frame = CGRect(x: 40, y: 143, width: 130, height: 120)
        self.temperatureLabelContainer.frame = CGRect(x: 180, y: 155, width: 88, height: 88)
        
        self.toolbar.frame = CGRect(x: 0, y: self.frame.size.height - self.toolbar.frame.size.height, width: self.frame.size.width, height: self.toolbar.frame.size.height)
        self.tableView.frame = CGRect(x: 0, y: self.frame.size.height - self.toolbar.frame.size.height - 150, width: 320, height: 150)
        self.lastUpdateLabel.frame = self.toolbar.bounds

        
    }
    
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - UITableViewDelegate & UITableViewDataSource
    //-------------------------------------------------------------------------------------------
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "weatherForecast"
        var cell : ForecastTableViewCell
        if let dequeueCell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ForecastTableViewCell {
            cell = dequeueCell
        } else {
            cell = ForecastTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        }
        
        if let weatherReport = self.weatherReport, weatherReport.forecast.count > indexPath.row {
            let forecastConditions : ForecastConditions = weatherReport.forecast[indexPath.row]
            cell.dayLabel.text = forecastConditions.longDayOfTheWeek()
            cell.descriptionLabel.text = forecastConditions.summary
            
            if let low = forecastConditions.low {
                cell.lowTempLabel.text = low.asShortStringInDefaultUnits()
            }
            
            if let high = forecastConditions.high {
                cell.highTempLabel.text = high.asShortStringInDefaultUnits()
            }
            
            cell.conditionsIcon.image = self.uiImageForImageUri(imageUri: forecastConditions.imageUri)
            cell.backgroundView?.backgroundColor = self.colorForRow(row: indexPath.row)
        }
        return cell
    }
    

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
 
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
       cell.backgroundColor = .clear
    }
  
        
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Private Methods
    //-------------------------------------------------------------------------------------------
    
    private func initBackgroundView() {
        self.backgroundView = UIImageView(frame: .zero)
        self.backgroundView.contentMode = .scaleToFill
        self.backgroundView.parallaxIntensity = 20
        self.addSubview(self.backgroundView)
    }
    
    private func initCityNameLabel() {
        self.cityNameLabel = UILabel(frame: .zero)
        self.cityNameLabel.font = UIFont.applicationFontOfSize(size: 35)
        self.cityNameLabel.textColor = UIColor(hexRGB: 0xf9f7f4)
        self.cityNameLabel.backgroundColor = .clear
        self.cityNameLabel.textAlignment = .center
        self.addSubview(self.cityNameLabel)
    }
    
    private func initConditionsDescriptionLabel() {
        self.conditionsDescriptionLabel = UILabel(frame: .zero)
        self.conditionsDescriptionLabel.font = UIFont.applicationFontOfSize(size: 16)
        self.conditionsDescriptionLabel.textColor = UIColor(hexRGB: 0xf9f7f4)
        self.conditionsDescriptionLabel.backgroundColor = .clear
        self.conditionsDescriptionLabel.textAlignment = .center
        self.conditionsDescriptionLabel.numberOfLines = 0
        self.addSubview(self.conditionsDescriptionLabel)
    }
    
    private func initConditionsIcon() {
        self.conditionsIcon = UIImageView(frame: .zero)
        self.conditionsIcon.image = UIImage(named: "icon_cloudy")
        self.conditionsIcon.isHidden = true
        self.addSubview(self.conditionsIcon)
    }
    
    private func initTemperatureLabel() {
        self.temperatureLabelContainer = UIView(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        self.addSubview(self.temperatureLabelContainer)
        
        let labelBackground = UIImageView(frame: self.temperatureLabelContainer.bounds)
        labelBackground.image = UIImage(named: "temperature_circle")
        self.temperatureLabelContainer.addSubview(labelBackground)
        
        self.temperatureLabel = UILabel(frame: self.temperatureLabelContainer.bounds)
        self.temperatureLabel.font = UIFont.temperatureFontOfSize(size: 35)
        self.temperatureLabel.textColor = UIColor(hexRGB: 0x7f9588)
        self.temperatureLabel.backgroundColor = .clear
        self.temperatureLabel.textAlignment = .center
        self.temperatureLabelContainer.addSubview(temperatureLabel)
        
        self.temperatureLabelContainer.isHidden = true
    }
    
    private func initTableView() {
        self.tableView = UITableView(frame: .zero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear
        self.tableView.isUserInteractionEnabled = false
        self.tableView.isHidden = true
        self.addSubview(self.tableView)
    }
    
    private func initToolbar() {
        self.toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        self.addSubview(self.toolbar)
    }
    
    private func initLastUpdateLabel() {
        self.lastUpdateLabel = UILabel(frame: .zero)
        self.lastUpdateLabel.font = UIFont.applicationFontOfSize(size: 10)
        self.lastUpdateLabel.textColor = UIColor(hexRGB: 0xf9f7f4)
        self.lastUpdateLabel.backgroundColor = .clear
        self.lastUpdateLabel.textAlignment = .center
        self.toolbar.addSubview(self.lastUpdateLabel)
    }
    
    private func colorForRow(row : Int) -> UIColor {
        switch (row) {
        case 0:
            return self.theme.forecastTintColor!.withAlphaComponent(0.55)
        case 1:
            return self.theme.forecastTintColor!.withAlphaComponent(0.75)
        default:
            return self.theme.forecastTintColor!.withAlphaComponent(0.95)
        }
    }
    
    //TODO: Make this proper Swift
    private func uiImageForImageUri(imageUri : String) -> UIImage? {
        if imageUri.count > 0 {
            
            if imageUri.hasSuffix("sunny.png") {
                return UIImage(named:"icon_sunny")
            }
            else if imageUri.hasSuffix("partly_cloudy.png") ||
                    imageUri.hasSuffix("sunny_intervals.png") ||
                    imageUri.hasSuffix("low_cloud.png") {
                return UIImage(named:"icon_cloudy")
            }
            else if imageUri.hasSuffix("light_rain_showers.png") ||
                    imageUri.hasSuffix("heavy_rain_showers.png") {
                return UIImage(named:"icon_rainy")
            }
        }
        return UIImage(named: "icon_sunny")
    }
        
}
