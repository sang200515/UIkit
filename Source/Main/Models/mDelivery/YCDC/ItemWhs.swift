//
//  ItemWhs.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 08/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class ItemWhs: NSObject {
    var whsCode : String
    var whsName: String
    var u_WHS_TYPE : String
    var u_Code_SH : String
    
    init(whsCode:String,whsName:String,u_WHS_TYPE:String,u_Code_SH:String){
        self.whsCode = whsCode
        self.whsName = whsName
        self.u_WHS_TYPE = u_WHS_TYPE
        self.u_Code_SH = u_Code_SH
    }
}
