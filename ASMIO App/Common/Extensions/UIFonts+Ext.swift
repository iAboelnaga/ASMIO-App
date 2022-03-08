//
//  UIFonts+Ext.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

struct AppFontName {
    static let regular = "Poppins"
    static let bold = "Poppins-Bold"
    static let medium = "Poppins-Medium"
    static let semiBold = "Poppins-Semibold"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    @objc class func poppinsRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }

    @objc class func poppinsBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!

    }
    
    @objc class func poppinsFontWithWeight(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        switch weight {
        case .semibold:
            return UIFont(name: AppFontName.semiBold, size: size)!
        case .bold:
            return UIFont(name: AppFontName.bold, size: size)!
        case .medium:
            return UIFont(name: AppFontName.medium, size: size)!
        default:
            return UIFont(name: AppFontName.regular, size: size)!
        }
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
            self.init(myCoder: aDecoder)
            return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
        case "CTFontMediumUsage":
            fontName = AppFontName.medium
        case "CTFontDemiUsage":
            fontName = AppFontName.semiBold
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideInitialize() {
        guard self == UIFont.self else { return }

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(poppinsRegular(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(poppinsBold(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        if let mySystemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:weight:))),
            let myFontMethod = class_getClassMethod(self, #selector(poppinsFontWithWeight(ofSize:weight:))) {
            method_exchangeImplementations(mySystemFontMethod, myFontMethod)
        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
