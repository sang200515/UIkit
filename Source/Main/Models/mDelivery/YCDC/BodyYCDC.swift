//
//  BodyYCDC.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 21/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class BodyYCDC: NSObject {
    var docEntry : String
    var createDate: String
    var u_ShpCod : String
    var u_ShpRec : String
    var createBy: String
    var updateBy : String
    var statusName : String
    var statusCode: String
    var u_WhsEx:String
    var u_WhsRec: String
    var remarks: String
    var shpRec: String
    var shpCod: String
    
    init(docEntry : String, createDate: String, u_ShpCod : String, u_ShpRec : String, createBy: String, updateBy : String, statusName : String, statusCode: String,u_WhsEx:String,u_WhsRec: String,remarks:String,shpRec: String, shpCod: String){
        self.docEntry = docEntry
        self.createDate = createDate
        self.u_ShpCod = u_ShpCod
        self.u_ShpRec = u_ShpRec
        self.createBy = createBy
        self.updateBy = updateBy
        self.statusName = statusName
        self.statusCode = statusCode
        self.u_WhsEx = u_WhsEx
        self.u_WhsRec = u_WhsRec
        self.remarks = remarks
        self.shpRec = shpRec
        self.shpCod = shpCod
    }
}
