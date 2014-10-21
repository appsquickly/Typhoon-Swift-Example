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

public class ThemeFactory : NSObject {
    
    private var _sequentialTheme : Theme?
    private(set) var themes : Array<Theme>
    
    init(themes : Array<Theme>) {
        self.themes = themes
        assert(themes.count > 0, "ThemeFactory requires at least one theme in collection")
    }
    
    public func sequentialTheme() -> Theme {
        if (_sequentialTheme == nil) {
            
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentsDirectory = paths[0] as String
            let indexFileName = documentsDirectory.stringByAppendingPathComponent("PF_CURRENT_THEME_INDEX")
            var index = NSString(contentsOfFile: indexFileName, encoding: NSUTF8StringEncoding, error: nil)?.integerValue
            if (index == nil || index > themes.count - 1) {
                index = 0
            }
            _sequentialTheme = themes[index!]
            NSString(format: "%i", (index! + 1)).writeToFile(indexFileName, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
        }
        return _sequentialTheme!
    }
    

    
}