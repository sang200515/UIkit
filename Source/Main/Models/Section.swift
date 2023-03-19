//
//  Section.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/17/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class Section: NSObject {
    var sectionName: String
    var arrayItems = [ItemApp]()
    
    init(name: String, arrayItems: [ItemApp]) {
        self.sectionName = name
        self.arrayItems = arrayItems
    }
}
