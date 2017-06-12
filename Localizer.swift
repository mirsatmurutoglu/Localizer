//
//  Localizer.swift
//  Mirsat Murutoglu
//
//  Created by Mirsat Murutoglu on 06/06/17.
//  Copyright © 2017 Mirsat Murutoglu. All rights reserved.
//

import Foundation
import UIKit

class Localizer: NSObject {
    static let APPLE_LANGUAGE_KEY = "AppleLanguages"
    
    class func DoTheSwizzling() {
        MethodSwizzleGivenClassName(NSBundle.self, originalSelector: #selector(NSBundle.localizedStringForKey(_:value:table:)), overrideSelector: #selector(NSBundle.specialLocalizedStringForKey(_:value:table:)))
    }
    
    class func currentAppleLanguage() -> String{
        let userdef = NSUserDefaults.standardUserDefaults()
        let langArray = userdef.objectForKey(APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let currentWithoutLocale = current.substringToIndex(current.startIndex.advancedBy(2))
        return currentWithoutLocale

    }
    /// set language to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = NSUserDefaults.standardUserDefaults()
        userdef.setObject([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}

extension NSBundle {
    func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        var currentLanguage = Localizer.currentAppleLanguage()
        
        if currentLanguage == "zh" {
            currentLanguage = currentLanguage + "-Hans" // add this append method if language name has more than 2 letters like Chinese 'zh-Hans'
        }
        
        var bundle = NSBundle();
        if let _path = NSBundle.mainBundle().pathForResource(currentLanguage, ofType: "lproj") {
            bundle = NSBundle(path: _path)!
        } else {
            let _path = NSBundle.mainBundle().pathForResource("Base", ofType: "lproj")!
            bundle = NSBundle(path: _path)!
        }
        return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
    }
}

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: COpaquePointer = class_getInstanceMethod(cls, originalSelector);
    let overrideMethod: COpaquePointer = class_getInstanceMethod(cls, overrideSelector);
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}