//
//  DetailYCDC.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 22/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class DetailYCDC: NSObject {
    var docEntry : String
    var u_ShpCod: String
    var u_ShpRec : String
    var u_ItmCod : String
    var u_ItmNam: String
    var lineId : String
    var u_WhsEx : String
    var u_WhsRec: String
    var u_Qutity: String
    var quantity_Ap: Int
    var u_WhsCodeEx: String
    var u_WhsCodeRec: String
    
    init(docEntry : String,u_ShpCod: String,u_ShpRec : String, u_ItmCod : String, u_ItmNam: String,lineId : String,u_WhsEx : String, u_WhsRec: String, u_Qutity: String, quantity_Ap: Int,u_WhsCodeEx: String,u_WhsCodeRec: String){
        self.docEntry = docEntry
        self.u_ShpCod = u_ShpCod
        self.u_ShpRec = u_ShpRec
        self.u_ItmCod = u_ItmCod
        self.u_ItmNam = u_ItmNam
        self.lineId = lineId
        self.u_WhsEx = u_WhsEx
        self.u_WhsRec = u_WhsRec
        self.u_Qutity = u_Qutity
        self.quantity_Ap = quantity_Ap
        self.u_WhsCodeEx = u_WhsCodeEx
        self.u_WhsCodeRec = u_WhsCodeRec
    }
}
