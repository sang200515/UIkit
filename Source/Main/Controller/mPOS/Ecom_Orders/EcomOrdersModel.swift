//
//  EcomOrdersModel.swift
//  fptshop
//
//  Created by Ngoc Bao on 09/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class Ecom_Order_Item : Mappable {
    var u_ShpCod : String = ""
    var docNum : Int = 0
    var u_LicTrad : String = ""
    var cardName : String = ""
    var downpayment : Double = 0.0
    var u_TMonBi : Double = 0.0
    var doctal_pay : Double = 0.0
    var so_date : String = ""
    var so_type : String = ""
    var p_allow_action: String = ""
    var employeeCode: String = ""
    var assign_date: String = ""
    var sm_code: String = ""
    var sm_name: String = ""
    var employeeName: String = ""
    var call_date: String = ""
    var status: String = ""
    var p_comment: String = ""
    var p_status_name_call: String = ""
    var p_status_call_code:String = ""
    var p_timeDelivery:String = ""
    var p_addressdelivery:String = ""
    var tinh:String = ""
    var codeTinh:String = ""
    var huyen:String = ""
    var codeHuyen:String = ""
    var xa:String = ""
    var codeXa:String = ""
    var p_Allow_call:String = ""
    required init?(map: Map) {

    }

     func mapping(map: Map) {
         u_ShpCod <- map["u_ShpCod"]
         docNum <- map["docNum"]
         u_LicTrad <- map["u_LicTrad"]
         cardName <- map["cardName"]
         downpayment <- map["downpayment"]
         u_TMonBi <- map["u_TMonBi"]
         doctal_pay <- map["doctal_pay"]
         so_date <- map["so_date"]
         so_type <- map["so_type"]
         p_allow_action <- map["p_allow_action"]
         employeeCode <- map["employeeCode"]
         assign_date <- map["assign_date"]
         sm_code <- map["sm_code"]
         sm_name <- map["sm_name"]
         employeeName <- map["employeeName"]
         call_date <- map["call_date"]
         status  <- map["status"]
         p_comment  <- map["p_comment"]
         p_status_name_call  <- map["p_status_name_call"]
         p_status_call_code <- map["p_status_call_code"]
         p_timeDelivery <- map["p_timeDelivery"]
         p_addressdelivery <- map["p_addressdelivery"]
         tinh <- map["p_Tinh"]
         codeTinh <- map["p_CodeTinh"]
         huyen <- map["p_Huyen"]
         codeHuyen <- map["p_CodeHuyen"]
         xa <- map["p_Xa"]
         codeXa <- map["p_CodeXa"]
         p_Allow_call <- map["p_Allow_call"]
    }
    
    var so_dateFormated: String {
        return so_date.toNewStrDate(withFormat: "yyyy-MM-dd HH:mm:ss", newFormat: "dd/MM/yyyy HH:mm:ss")
    }
    var so_asignDate: String {
        return assign_date.toNewStrDate(withFormat: "yyyy-MM-dd HH:mm:ss", newFormat: "dd/MM/yyyy HH:mm:ss")
    }
    var so_callDate: String {
        return call_date.toNewStrDate(withFormat: "yyyy-MM-dd HH:mm:ss", newFormat: "dd/MM/yyyy HH:mm:ss")
    }
}

class EcomOrderEmploy : Mappable {
    var employeeCode : String = ""
    var employeeName : String = ""

    required init?(map: Map) {}

    func mapping(map: Map) {

        employeeCode <- map["employeeCode"]
        employeeName <- map["employeeName"]
    }
    
    var emomployeeFull: String {
        return "\(employeeCode)-\(employeeName)"
    }

}


class EcomOrderBaseResponse: Mappable {
    var p_status: Int = 0
    var p_messages: String = ""
    
    required init?(map: Map) {}

    func mapping(map: Map) {

        p_status <- map["p_status"]
        p_messages <- map["p_messages"]
    }
}



class DeliveringSuccessItem: Mappable {
    var Result: Int = 0  // 1:Success ; 2:Fail ; 0:Error
    var Description: String = ""
    
    required init?(map: Map) {}

    func mapping(map: Map) {

        Result <- map["Result"]
        Description <- map["Description"]
    }
}

// MARK: - EcomOrderDetailsModel
class EcomOrderDetailsModel: Mappable {
    var tongdonhang:String = ""
    var giamgia:String = ""
    var tienonline:String = ""
    var tongthanhtoan: String = ""
    var dataItem: [EcomOrderDetails] = []
    
    required init?(map: Map) {

    }

     func mapping(map: Map) {
         tongdonhang <- map["tongdonhang"]
         giamgia <- map["giamgia"]
         tienonline <- map["tienonline"]
         tongthanhtoan <- map["tongthanhtoan"]
         dataItem <- map["dataItem"]
    }
}

// MARK: - EcomOrderDetails
class EcomOrderDetails: Mappable {
    var stt:String = ""
    var uItmName:String = ""
    var uImei:String = ""
    var uItemPri: String = ""

    required init?(map: Map) {

    }

     func mapping(map: Map) {
         stt <- map["stt"]
         uItmName <- map["u_ItmName"]
         uImei <- map["u_Imei"]
         uItemPri <- map["u_ItemPri"]
    }
}

class EcomOrderTinhModel: Mappable {
    var value:String = ""
    var tenTinh:String = ""

    required init?(map: Map) {

    }

     func mapping(map: Map) {
         value <- map["value"]
         tenTinh <- map["text"]
    }
}

class EcomOrderQuanHuyenModel: Mappable {
    var value:String = ""
    var tenQuanHuyen:String = ""
    var cityID:String = ""

    required init?(map: Map) {

    }

     func mapping(map: Map) {
         value <- map["value"]
         tenQuanHuyen <- map["text"]
         cityID <- map["cityID"]
    }
}

class EcomOrderPhuongXaModel: Mappable {
    var value:String = ""
    var tenPhuongXa:String = ""
    var quanHuyenID:String = ""

    required init?(map: Map) {

    }

     func mapping(map: Map) {
         value <- map["value"]
         tenPhuongXa <- map["text"]
         quanHuyenID <- map["quanHuyenID"]
    }
}


