//
//  ItemApp.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/27/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
public class ItemApp:NSObject{
    var id:String
    var name:String
    var type:String
    var icon:UIImage
    var rightIcon: UIImage? = nil
    
    init(id:String,name:String,type:String,icon:UIImage,rightIcon:UIImage? = nil){
        self.id = id
        self.name = name
        self.type = type
        self.icon = icon
        self.rightIcon = rightIcon
    }
}

