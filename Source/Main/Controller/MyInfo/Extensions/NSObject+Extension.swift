//
//  NSObject+Extension.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

extension NSObject{
    
    var className: String {
        return String(describing: type(of: self))
    }
}

extension String {
    func trimAllSpace() -> String {
        //        return self.trimmingCharacters(in: .whitespaces)
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    var stripped: String { // Remove Specical Characters
        //        let txt = text.folding(options: .diacriticInsensitive, locale: .current).replacingOccurrences(of: " ", with: "%20")
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return self.filter {okayChars.contains($0)}.folding(options: .diacriticInsensitive, locale: .current).replacingOccurrences(of: " ", with: "%20")
    }
}
