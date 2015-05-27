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

extension NSError {
    
    
    public convenience init(message : String) {
        self.init(domain: "PocketForecast", code: 0, userInfo: ["userInfo" : message])
    }
    
    public func rootCause() -> String {

        if let infoDict = self.userInfo as? Dictionary<String, String> {
            if let cause : String = infoDict["userInfo"] {
                return cause
            }
        }
        return self.localizedDescription
    }
    


    
}
