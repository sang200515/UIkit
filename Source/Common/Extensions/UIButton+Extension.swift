//
//  UIButton+Extension.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 13/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

extension UIButton {
    func underline(title:String) {
        let attrs = NSAttributedString(string: title,
                                       attributes:
                                        [NSAttributedString.Key.foregroundColor: UIColor.blue,
                                         NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 15),
                                         NSAttributedString.Key.underlineColor:  UIColor.blue,
                                         NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        self.setAttributedTitle(attrs, for: .normal)
    }
    
    
}
