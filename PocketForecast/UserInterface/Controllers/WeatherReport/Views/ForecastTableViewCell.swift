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

    
    required public init?(coder aDecoder: NSCoder) {
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
        self.overlayView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 50))
        self.overlayView.image = UIImage(named: "cell_fade")
        self.overlayView.contentMode = .scaleToFill
        self.addSubview(self.overlayView)
    }
    
    private func initConditionsIcon() {
        self.conditionsIcon = UIImageView(frame:CGRect(x: 6, y: 7, width: 60 - 12, height: 50 - 12))
        self.conditionsIcon.clipsToBounds = true
        self.conditionsIcon.contentMode = .scaleAspectFit
        self.conditionsIcon.image = UIImage(named: "icon_cloudy")
        self.addSubview(self.conditionsIcon)
    }
    
    private func initDayLabel() {
        self.dayLabel = UILabel(frame: CGRect(x: 70, y: 10, width: 150, height: 18))
        self.dayLabel.font = UIFont.applicationFontOfSize(size: 16)
        self.dayLabel.textColor = .white
        self.dayLabel.backgroundColor = .clear
        self.addSubview(self.dayLabel)
    }
    
    private func initDescriptionLabel() {
        self.descriptionLabel = UILabel(frame:CGRect(x: 70, y: 28, width: 150, height: 16))
        self.descriptionLabel.font = UIFont.applicationFontOfSize(size: 13)
        self.descriptionLabel.textColor = UIColor(hexRGB: 0xe9e1cd)
        self.descriptionLabel.backgroundColor = .clear
        self.addSubview(self.descriptionLabel)
    }
    
    private func initHighTempLabel() {
        self.highTempLabel = UILabel(frame: CGRect(x: 210, y: 10, width: 55, height: 30))
        self.highTempLabel.font = UIFont.temperatureFontOfSize(size: 27)
        self.highTempLabel.textColor = .white
        self.highTempLabel.backgroundColor = .clear
        self.highTempLabel.textAlignment = .right
        self.addSubview(self.highTempLabel)
    }
    
    private func initLowTempLabel() {
        self.lowTempLabel = UILabel(frame: CGRect(x: 270, y: 11.5, width: 40, height: 30))
        self.lowTempLabel.font = UIFont.temperatureFontOfSize(size: 20)
        self.lowTempLabel.textColor = UIColor(hexRGB: 0xd9d1bd)
        self.lowTempLabel.backgroundColor = .clear
        self.lowTempLabel.textAlignment = .right
        self.addSubview(self.lowTempLabel)
    }    
    
}
