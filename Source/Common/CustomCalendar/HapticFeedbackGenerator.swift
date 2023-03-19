//
//  HapticFeedbackGenerator.swift
//  fptshop
//
//  Created by DiemMy Le on 12/1/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

public protocol HapticFeedback {
    func generateFeedback()
}

extension UIControl: HapticFeedback { }

public extension HapticFeedback where Self: UIControl {
    func generateFeedback() {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
}
