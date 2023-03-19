//
//  Utils.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog
import Kingfisher

func printLog(function :  String?, json : Any?) {
    #if PRODUCTION
    #else
    print("\n==========\(String(describing: function))===========\n")
    if let jsonStr = json as? String,
        let str = jsonStr.data(using: .utf8)?.prettyPrintedJSONString {
        print(str)
    } else if let jsonStr = json {
        print("\n\(jsonStr)\n")
    }
    #endif
}


func UIColorFromRGB(_ rgbValue: UInt, alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(
        red:    CGFloat((rgbValue   & 0xFF0000  ) >> 16)    / 0xFF,
        green:  CGFloat((rgbValue   & 0x00FF00  ) >> 8)     / 0xFF,
        blue:   CGFloat(rgbValue    & 0x0000FF  )           / 0xFF,
        alpha:  CGFloat(alpha                   )
    )
}

func getImageWithURL(urlImage: String = "", placeholderImage : UIImage? = UIImage(named: "ic_default_avatar"),
                     imgView: UIImageView, shouldCache : Bool = false, contentMode: UIView.ContentMode = .scaleAspectFill){
    if let str = urlImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
        imgView.kf.indicatorType = .activity
        if let urlImage = URL.init(string: str) {
            imgView.contentMode = contentMode
            imgView.kf.setImage(with: urlImage, placeholder: placeholderImage, options: [
                shouldCache ? .cacheOriginalImage : .forceRefresh,
                .transition(.fade(0.6))
            ], progressBlock: nil)
        }else {
            imgView.contentMode = contentMode
            imgView.image = placeholderImage
        }
    }
}



