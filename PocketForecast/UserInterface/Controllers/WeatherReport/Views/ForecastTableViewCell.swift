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

public class ForecastTableViewCell : UITableViewCell {
    
    private var overlayView : UIImageView!
    public private(set) var dayLabel : UILabel!
    public private(set) var descriptionLabel : UILabel!
    public private(set) var highTempLabel : UILabel!
    public private(set) var lowTempLabel : UILabel!
    public private(set) var conditionsIcon : UIImageView!
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initBackgroundView()
        self.initOverlay()
        self.initConditionsIcon()
        self.initDayLabel()
        self.initDescriptionLabel()
        self.initHighTempLabel()
        self.initLowTempLabel()
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Initialization & Destruction
    //-------------------------------------------------------------------------------------------

    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Private Methods
    //-------------------------------------------------------------------------------------------
    
    private func initBackgroundView() {
        let backgroundView = UIView(frame: self.bounds)
        backgroundView.backgroundColor = UIColor(hexRGB: 0x837758)
        self.backgroundView = backgroundView
    }
    
    private func initOverlay() {
        self.overlayView = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width, 50))
        self.overlayView.image = UIImage(named: "cell_fade")
        self.overlayView.contentMode = UIViewContentMode.ScaleToFill
        self.addSubview(self.overlayView)
    }
    
    private func initConditionsIcon() {
        self.conditionsIcon = UIImageView(frame:CGRectMake(6, 7, 60 - 12, 50 - 12))
        self.conditionsIcon.clipsToBounds = true
        self.conditionsIcon.contentMode = UIViewContentMode.ScaleAspectFit
        self.conditionsIcon.image = UIImage(named: "icon_cloudy")
        self.addSubview(self.conditionsIcon)
    }
    
    private func initDayLabel() {
        self.dayLabel = UILabel(frame: CGRectMake(70, 10, 150, 18))
        self.dayLabel.font = UIFont.applicationFontOfSize(16)
        self.dayLabel.textColor = UIColor.whiteColor()
        self.dayLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(self.dayLabel)
    }
    
    private func initDescriptionLabel() {
        self.descriptionLabel = UILabel(frame:CGRectMake(70, 28, 150, 16))
        self.descriptionLabel.font = UIFont.applicationFontOfSize(13)
        self.descriptionLabel.textColor = UIColor(hexRGB: 0xe9e1cd)
        self.descriptionLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(self.descriptionLabel)
    }
    
    private func initHighTempLabel() {
        self.highTempLabel = UILabel(frame: CGRectMake(210, 10, 55, 30))
        self.highTempLabel.font = UIFont.temperatureFontOfSize(27)
        self.highTempLabel.textColor = UIColor.whiteColor()
        self.highTempLabel.backgroundColor = UIColor.clearColor()
        self.highTempLabel.textAlignment = NSTextAlignment.Right
        self.addSubview(self.highTempLabel)
    }
    
    private func initLowTempLabel() {
        self.lowTempLabel = UILabel(frame: CGRectMake(270, 11.5, 40, 30))
        self.lowTempLabel.font = UIFont.temperatureFontOfSize(20)
        self.lowTempLabel.textColor = UIColor(hexRGB: 0xd9d1bd)
        self.lowTempLabel.backgroundColor = UIColor.clearColor()
        self.lowTempLabel.textAlignment = NSTextAlignment.Right
        self.addSubview(self.lowTempLabel)
    }    
    
}