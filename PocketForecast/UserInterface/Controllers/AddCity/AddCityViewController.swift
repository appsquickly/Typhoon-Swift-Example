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

class AddCityViewController: UIViewController, UITextFieldDelegate, Themeable {
    
    //Typhoon injected properties
    
    var cityDao : CityDao!
    var weatherClient : WeatherClient!
    var theme : Theme!
    var rootViewController : RootViewController!
    
    //Interface Builder injected properties
    
    @IBOutlet var nameOfCityToAdd: UITextField!
    @IBOutlet var validationMessage : UILabel!
    @IBOutlet var spinner : UIActivityIndicatorView!

    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required override init(nibName : String!, bundle : NSBundle!)
    {
        NSLog("yehay!!!!!!!!!!!!!!!!!!!!!")
        super.init(nibName: nibName, bundle: bundle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyTheme()
        
        self.nameOfCityToAdd.font = UIFont.applicationFontOfSize(16)
        self.validationMessage.font = UIFont.applicationFontOfSize(16)
        self.title = "Add City"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneAdding:")
        self.nameOfCityToAdd.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.validationMessage.hidden = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.doneAdding(textField)
        return true
    }
        
    private dynamic func doneAdding(textField : UITextField) {
        if (!self.nameOfCityToAdd.text!.isEmpty) {
            self.validationMessage.text = "Validating city . ."
            self.validationMessage.hidden = false
            self.nameOfCityToAdd.enabled = false
            self.spinner.startAnimating()
            
            self.weatherClient.loadWeatherReportFor(self.nameOfCityToAdd.text, onSuccess: {
                (weatherReport) in
                
                self.cityDao!.saveCity(weatherReport.cityDisplayName)
                self.rootViewController.dismissAddCitiesController()
                
                }, onError: {
                    (message) in
                    
                    self.spinner.stopAnimating()
                    self.nameOfCityToAdd.enabled = true
                    self.validationMessage.text = String(format: "No weather reports for '%@'.", self.nameOfCityToAdd.text!)
            })
        }
        else {
            self.nameOfCityToAdd.resignFirstResponder()
            self.rootViewController.dismissAddCitiesController()
        }
    }
    
    private func applyTheme() {
        print (String(format:"In apply theme: %@", self.theme!))
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.barTintColor = self.theme.navigationBarColor
    }
        
}
