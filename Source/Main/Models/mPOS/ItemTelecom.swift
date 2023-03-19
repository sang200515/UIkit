//
//  ItemTelecom.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/21/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
public class ItemTelecom:NSObject{
    var id:Int
    var name:String
    var isSelect:Bool
    
    init(id:Int,name:String,isSelect:Bool){
        self.id = id
        self.name = name
        self.isSelect = isSelect
    }
}
