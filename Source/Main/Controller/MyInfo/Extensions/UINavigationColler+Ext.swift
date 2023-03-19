//
//  UINavigationColler+Ext.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setupTitleNavigtaion(_ title: String, textColor: UIColor) {
        let label = UILabel()
        label.text = title
        label.textAlignment = .left
        label.textColor = textColor
        self.navigationItem.titleView = label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: label.superview, attribute: .centerX, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: label.superview, attribute: .width, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: label.superview, attribute: .centerY, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: label.superview, attribute: .height, multiplier: 1, constant: 0))
    }
}
