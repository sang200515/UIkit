//
//  UIFont+Extension.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

extension UIFont {
    static func ultraLightOfSize(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Ultralight", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    static func thinFontOfSize(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Thin", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    static func lightFontOfSize(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Light", size: fontSize) ?? UIFont.systemFont(ofSize:fontSize)
    }
    
    static func regularFontOfSize(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Regular", size: fontSize) ?? UIFont.systemFont(ofSize:fontSize)
    }
    
    static func semiboldFontOfSize(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Semibold", size: fontSize) ?? UIFont.systemFont(ofSize:fontSize)
    }
    
    static func boldCustomFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize:fontSize)
    }
    static func mediumCustomFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Medium", size: fontSize) ?? UIFont.boldSystemFont(ofSize:fontSize)
    }
    
    static func BlackCustomFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Black", size: fontSize) ?? UIFont.boldSystemFont(ofSize:fontSize)
    }
    static func barCodeCustomFont(ofSize fontSize: CGFloat) -> UIFont {
        
        //        return UIFont.init(name: "Oswald-Regular", size: fontSize) ?? UIFont.systemFont(ofSize:fontSize)
        return UIFont(name: "Oswald-Regular",size: fontSize) ?? UIFont.systemFont(ofSize:fontSize)
    }
}
