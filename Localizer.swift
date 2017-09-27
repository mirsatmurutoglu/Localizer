//
//  Localizer.swift
//  Mirsat Murutoglu
//
//  Created by Mirsat Murutoglu on 25/06/17.
//  Copyright © 2017 Mirsat Murutoglu. All rights reserved.
//

import Foundation
import UIKit

class Localizer: NSObject {
    static let APPLE_LANGUAGE_KEY = "AppleLanguages"

    class func DoTheSwizzling() {
        MethodSwizzleGivenClassName(Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
    }

    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let currentWithoutLocale = current.substring(to: current.characters.index(current.startIndex, offsetBy: 2))
        return currentWithoutLocale

    }
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(_ lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}

extension Bundle {
    func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        var currentLanguage = Localizer.currentAppleLanguage()
        if currentLanguage == "zh" {
            currentLanguage = currentLanguage + "-Hans"
        }
        var bundle = Bundle();
        if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
        return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
    }
}
/// Exchange the implementation of two methods for the same Class
func MethodSwizzleGivenClassName(_ cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: OpaquePointer = class_getInstanceMethod(cls, originalSelector);
    let overrideMethod: OpaquePointer = class_getInstanceMethod(cls, overrideSelector);
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}
