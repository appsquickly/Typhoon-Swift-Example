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
import PocketForecast

public class WeatherClientTests : XCTestCase {
    
    var weatherClient: WeatherClient!
    
    public override func setUp() {

        let assembly = ApplicationAssembly().activate()

        let configurer = TyphoonConfigPostProcessor()
        configurer.useResourceWithName("Configuration.plist")
        assembly.attachPostProcessor(configurer)
        self.weatherClient = assembly.coreComponents.weatherClient() as! WeatherClient
    }
    
    public func test_it_receives_a_wather_report_given_a_valid_city() {
        
        var receivedReport : WeatherReport?
        
        self.weatherClient.loadWeatherReportFor("Manila", onSuccess: {
            (weatherReport) in
            
            receivedReport = weatherReport
            
            }, onError: {
                (message) in
                
                print("Unexpected error: " + message)
        })

   
        TyphoonTestUtils.waitForCondition( { () -> Bool in
            return receivedReport != nil
            }, andPerformTests: {
                print(String(format: "Got report: %@", receivedReport!))
                
        })
    }
    
    public func test_it_invokes_error_block_given_invalid_city() {
        
        var receivedMessage : String?
        
        self.weatherClient.loadWeatherReportFor("Foobarville", onSuccess: nil, onError: {
                (message) in
            
                receivedMessage = message
                print("Got message: " + message)
        })
        
        
        TyphoonTestUtils.waitForCondition( { () -> Bool in
            return receivedMessage == "Unable to find any matching weather location to the query submitted!"
        })

        
    }
    
    
    
}
