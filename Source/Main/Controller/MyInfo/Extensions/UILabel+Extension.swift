//
//  UILabel+Extension.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

extension UILabel {
    func loadWith(text : String? = nil,
                  textColor : UIColor? = nil,
                  font : UIFont? = nil,
                  textAlignment : NSTextAlignment? = nil
    ) {
        if (text != nil){
            self.text = text
        }
        
        if let value = textColor{
            self.textColor = value
        }
        if let value = font{
            self.font = value
        }
        if let value = textAlignment{
            self.textAlignment = value
        }
    }
    
    
    func AutoScaleHeightForLabel (){
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.sizeToFit()
    }
    func appendAttributedRedString(title:String) {
        let nameSpLabelAttri1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: Common.Size(s: 12)), NSAttributedString.Key.foregroundColor : UIColor.black]

             let nameSpLabelAttri2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: Common.Size(s: 12)), NSAttributedString.Key.foregroundColor : UIColor.systemPink]

        let attributedString1 = NSMutableAttributedString(string:"\(title)", attributes:nameSpLabelAttri1)

             let attributedString2 = NSMutableAttributedString(string:" (*)", attributes:nameSpLabelAttri2)

        attributedString1
            .append(attributedString2)
        self.attributedText! = attributedString1
        self.textAlignment = .left
    }
}


