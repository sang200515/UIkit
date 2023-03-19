//
//  ReportItem.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 7/29/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
public class ReportItem:NSObject{
    var id:String
    var name:String
    var icon:UIImage?
    
    init(id:String,name:String,icon:UIImage?){
        self.id = id
        self.name = name
        self.icon = icon
    }
}
