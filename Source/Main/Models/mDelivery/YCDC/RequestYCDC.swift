//
//  RequestYCDC.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 21/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct RequestYCDC: Encodable
{
    var user: String
    var shopCode: String
    var header: HeaderRequestYCDC
    var details: [BodyRequestYCDC]
}
struct HeaderRequestYCDC: Encodable
{
    var createBy: String
    var u_ShpCod: String
    var u_ShpRec: String
    var u_EmpNReq: String
    var u_EmpReq: String
    var u_IPAdd: String
    var u_OS: String
    var is5Km: String
    var remark: String
}
struct BodyRequestYCDC: Encodable
{
    var u_ItemCode: String
    var u_ItemName: String
    var u_Qutity: String
    var u_WhsEx: String
    var u_WhsRec: String
    var u_ShpRec_D: String
    var u_ShpEx: String
    var lineID: String
    
    var u_OhanEx: String
    var mansernum: String
    var is5KM_D: String
    var isOver: String
}

