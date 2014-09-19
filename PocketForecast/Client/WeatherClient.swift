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

/*
* Weather client protocol. (Currently, injected protocols require the @objc annotation).
*/
@objc public protocol WeatherClient {
    
    func loadWeatherReportFor(city: String!, onSuccess successBlock: ((WeatherReport!) -> Void)!, onError errorBlock: ((String!) -> Void)!)
    
    
    
    
}
