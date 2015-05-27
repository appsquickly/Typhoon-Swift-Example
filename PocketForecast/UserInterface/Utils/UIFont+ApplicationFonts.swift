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

extension UIFont {
    
    public class func applicationFontOfSize(size : CGFloat) -> UIFont {
        return UIFont(name: "Varela Round", size: size)!
    }
    
    public class func temperatureFontOfSize(size : CGFloat) -> UIFont {
        return UIFont(name: "Questrial", size: size)!
    }
        
}
