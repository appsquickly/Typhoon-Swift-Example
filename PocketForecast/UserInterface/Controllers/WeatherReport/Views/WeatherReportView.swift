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
            
            if (weatherReport != nil) {
                self.tableView.hidden = false
                self.conditionsIcon.hidden = false
                self.temperatureLabelContainer.hidden = false
                let indexPaths = [
                    NSIndexPath(forRow: 0, inSection: 0),
                    NSIndexPath(forRow: 1, inSection: 0),
                    NSIndexPath(forRow: 2, inSection: 0)
                ]
                self.tableView.reloadData()
                self.cityNameLabel.text = weatherReport!.cityDisplayName
                self.temperatureLabel.text = weatherReport!.currentConditions.temperature!.asShortStringInDefaultUnits()
                self.conditionsDescriptionLabel.text = weatherReport!.currentConditions.longSummary()
                self.lastUpdateLabel.text = NSString(format: "Updated %@", weatherReport!.reportDateAsString())

            }
        }
    }
    
    public var theme : Theme! {
        willSet(theme) {
            dispatch_async(dispatch_get_main_queue()) {
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
    
    public convenience override init() {
        self.init(frame: CGRectZero)
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Overridden methods
    //-------------------------------------------------------------------------------------------

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundView.frame = CGRectInset(self.bounds, -10, -10)
        
        self.cityNameLabel.frame = CGRectMake(0, 60, self.frame.size.width, 40)
        self.conditionsDescriptionLabel.frame = CGRectMake(0, 90, 320, 50)
        self.conditionsIcon.frame = CGRectMake(40, 143, 130, 120)
        self.temperatureLabelContainer.frame = CGRectMake(180, 155, 88, 88)
        
        self.toolbar.frame = CGRectMake(0, self.frame.size.height - self.toolbar.frame.size.height, self.frame.size.width, self.toolbar.frame.size.height)
        self.tableView.frame = CGRectMake(0, self.frame.size.height - self.toolbar.frame.size.height - 150, 320, 150)
        self.lastUpdateLabel.frame = self.toolbar.bounds

        
    }
    
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - UITableViewDelegate & UITableViewDataSource
    //-------------------------------------------------------------------------------------------
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "weatherForecast"
        var cell : ForecastTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? ForecastTableViewCell
        if (cell == nil) {
            cell = ForecastTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        }
        
        if (self.weatherReport != nil && self.weatherReport!.forecast.count > indexPath.row) {
            let forecastConditions : ForecastConditions = self.weatherReport!.forecast[indexPath.row]
            cell!.dayLabel.text = forecastConditions.longDayOfTheWeek()
            cell!.descriptionLabel.text = forecastConditions.summary
            cell!.lowTempLabel.text = forecastConditions.low!.asShortStringInDefaultUnits()
            cell!.highTempLabel.text = forecastConditions.high!.asShortStringInDefaultUnits()
            cell!.conditionsIcon.image = self.uiImageForImageUri(forecastConditions.imageUri)
            cell!.backgroundView?.backgroundColor = self.colorForRow(indexPath.row)
        }
        return cell!
    }
    

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
 
    public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
       cell.backgroundColor = UIColor.clearColor()
    }
  
        
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Private Methods
    //-------------------------------------------------------------------------------------------
    
    private func initBackgroundView() {
        self.backgroundView = UIImageView(frame: CGRectZero)
        self.backgroundView.contentMode = UIViewContentMode.ScaleToFill
        self.backgroundView.parallaxIntensity = 20
        self.addSubview(self.backgroundView)
    }
    
    private func initCityNameLabel() {
        self.cityNameLabel = UILabel(frame: CGRectZero)
        self.cityNameLabel.font = UIFont.applicationFontOfSize(35)
        self.cityNameLabel.textColor = UIColor(hexRGB: 0xf9f7f4)
        self.cityNameLabel.backgroundColor = UIColor.clearColor()
        self.cityNameLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(self.cityNameLabel)
    }
    
    private func initConditionsDescriptionLabel() {
        self.conditionsDescriptionLabel = UILabel(frame:CGRectZero)
        self.conditionsDescriptionLabel.font = UIFont.applicationFontOfSize(16)
        self.conditionsDescriptionLabel.textColor = UIColor(hexRGB: 0xf9f7f4)
        self.conditionsDescriptionLabel.backgroundColor = UIColor.clearColor()
        self.conditionsDescriptionLabel.textAlignment = NSTextAlignment.Center
        self.conditionsDescriptionLabel.numberOfLines = 0
        self.addSubview(self.conditionsDescriptionLabel)
    }
    
    private func initConditionsIcon() {
        self.conditionsIcon = UIImageView(frame: CGRectZero)
        self.conditionsIcon.image = UIImage(named: "icon_cloudy")
        self.conditionsIcon.hidden = true
        self.addSubview(self.conditionsIcon)
    }
    
    private func initTemperatureLabel() {
        self.temperatureLabelContainer = UIView(frame: CGRectMake(0, 0, 88, 88))
        self.addSubview(self.temperatureLabelContainer)
        
        let labelBackground = UIImageView(frame: self.temperatureLabelContainer.bounds)
        labelBackground.image = UIImage(named: "temperature_circle")
        self.temperatureLabelContainer.addSubview(labelBackground)
        
        self.temperatureLabel = UILabel(frame: self.temperatureLabelContainer.bounds)
        self.temperatureLabel.font = UIFont.temperatureFontOfSize(35)
        self.temperatureLabel.textColor = UIColor(hexRGB: 0x7f9588)
        self.temperatureLabel.backgroundColor = UIColor.clearColor()
        self.temperatureLabel.textAlignment = NSTextAlignment.Center
        self.temperatureLabelContainer.addSubview(temperatureLabel)
        
        self.temperatureLabelContainer.hidden = true
    }
    
    private func initTableView() {
        self.tableView = UITableView(frame: CGRectZero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.userInteractionEnabled = false
        self.tableView.hidden = true
        self.addSubview(self.tableView)
    }
    
    private func initToolbar() {
        self.toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 44))
        self.addSubview(self.toolbar)
    }
    
    private func initLastUpdateLabel() {
        self.lastUpdateLabel = UILabel(frame: CGRectZero)
        self.lastUpdateLabel.font = UIFont.applicationFontOfSize(10)
        self.lastUpdateLabel.textColor = UIColor(hexRGB: 0xf9f7f4)
        self.lastUpdateLabel.backgroundColor = UIColor.clearColor()
        self.lastUpdateLabel.textAlignment = NSTextAlignment.Center
        self.toolbar.addSubview(self.lastUpdateLabel)
    }
    
    private func colorForRow(row : Int) -> UIColor {
        switch (row) {
        case 0:
            return self.theme.forecastTintColor!.colorWithAlphaComponent(0.55)
        case 1:
            return self.theme.forecastTintColor!.colorWithAlphaComponent(0.75)
        default:
            return self.theme.forecastTintColor!.colorWithAlphaComponent(0.95)
        }
    }
    
    //TODO: Make this proper Swift
    private func uiImageForImageUri(imageUri : NSString?) -> UIImage {
        var result: UIImage?
        if (imageUri != nil && imageUri!.length > 0) {
            
            if (imageUri!.hasSuffix("sunny.png"))
            {
                result = UIImage(named:"icon_sunny")
            }
            else if (imageUri!.hasSuffix("sunny_intervals.png"))
            {
                result =  UIImage(named:"icon_cloudy")
            }
            else if (imageUri!.hasSuffix("partly_cloudy.png"))
            {
                result =  UIImage(named:"icon_cloudy")
            }
            else if (imageUri!.hasSuffix("low_cloud.png"))
            {
                result =  UIImage(named:"icon_cloudy")
            }
            else if (imageUri!.hasSuffix("light_rain_showers.png"))
            {
                result =  UIImage(named:"icon_rainy")
            }
            else if (imageUri!.hasSuffix("heavy_rain_showers.png"))
            {
                result =  UIImage(named:"icon_rainy")
            }
        }
        
        if result == nil {
            result = UIImage(named: "icon_sunny")
        }
        
        return result!

    }
        
}