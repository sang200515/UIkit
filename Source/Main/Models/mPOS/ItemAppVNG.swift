//
//  ItemAppVNG.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/19/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
public class ItemAppVNG:NSObject{
    var id:String
    var name:String
    var isSelect:Bool
    var icon:UIImage
    
    init(id:String,name:String,isSelect:Bool,icon:UIImage){
        self.id = id
        self.name = name
        self.isSelect = isSelect
        self.icon = icon
    }
}

