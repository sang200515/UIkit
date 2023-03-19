//
//  RaPCModel.swift
//  fptshop
//
//  Created by Sang Truong on 12/1/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class RaPCItem : Mappable {
    var message : MessagePC?
    var data : [DataRaPC] = []
    var data_XML : String = ""

    required init?(map: Map) {

    }

     func mapping(map: Map) {

        message <- map["message"]
        data <- map["data"]
        data_XML <- map["data_XML"]
    }

}

class DataRaPC : Mappable {
    var docEntry : String = ""
    var docEntry_Request : String = ""
    var status : String = ""
    var itemCode : String = ""
    var itemName : String = ""
    var quantity : String = ""
    var shopCode : String = ""
    var shopName : String = ""
    var finishDate : String = ""
    var createCode : String = ""
    var createName : String = ""
    var updateBy : String = ""
    var updateByName : String = ""
    var createDate : String = ""

    required init?(map: Map) {
    }

     func mapping(map: Map) {

        docEntry <- map["docEntry"]
        docEntry_Request <- map["docEntry_Request"]
        status <- map["status"]
        itemCode <- map["itemCode"]
        itemName <- map["itemName"]
        quantity <- map["quantity"]
        shopCode <- map["shopCode"]
        shopName <- map["shopName"]
        finishDate <- map["finishDate"]
        createCode <- map["createCode"]
        createName <- map["createName"]
        updateBy <- map["updateBy"]
        updateByName <- map["updateByName"]
        createDate <- map["createDate"]
    }
    
    var colorStatus: UIColor {
        switch status {
        case "1":
            return UIColor(red: 56, green: 94, blue: 133)
        case "2":
            return UIColor(red: 244, green: 141, blue: 95)
        case "3":
            return Constants.COLORS.light_green
        case "4":
            return  .red
        default:
            return .black
        }
    }
    
    var statusDes: String {
        switch status {
        case "1":
            return "-Chờ xử lí"
        case "2":
            return "-Đang xử lí"
        case "3":
            return "-Hoàn tất"
        case "4":
            return "-Hủy"
        default:
            return status
        }
    }

}

class MessageRaPC : Mappable {
    var message_Code : Int = 0
    var message_Desc : String  = ""

    required init?(map: Map) {
    }

     func mapping(map: Map) {
        message_Code <- map["message_Code"]
        message_Desc <- map["message_Desc"]
    }

}


//=== details linh kien
class DetailsLinhKien : Mappable {
    var message : MessagePC?
    var data : [LinhKienRaPCDetail]?
    var data_XML : String?

     required init?(map: Map) {

    }

     func mapping(map: Map) {

        message <- map["message"]
        data <- map["data"]
        data_XML <- map["data_XML"]
    }
    
}

class LinhKienRaPCDetail : Mappable {
    var itemCode_PC : String?
    var itemName_PC : String?
    var imei : String?
    var is_Imei : String?
    var WhsCode : String?
    var loai_Kho : String?
    var so_Luong:String?
    required init?(map: Map) {

    }

     func mapping(map: Map) {

        itemCode_PC <- map["itemCode_PC"]
        itemName_PC <- map["itemName_PC"]
        imei <- map["imei"]
        is_Imei <- map["is_Imei"]
         loai_Kho <- map["loai_Kho"]
         WhsCode <- map["WhsCode"]
         so_Luong <- map["so_Luong"]

    }

}

//get details itemCodePC and imei model
class ListLKByImei : Mappable {
    var message : MessagePC?
    var data : [DetailsLinhKienByImei]?
    var data_XML : String?

     required init?(map: Map) {

    }

     func mapping(map: Map) {

        message <- map["message"]
        data <- map["data"]
        data_XML <- map["data_XML"]
    }
    
}

class DetailsLinhKienByImei : Mappable {
    var itemCode_LK : String?
    var itemName_LK : String?
    var imei : String?
    var so_Luong:String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        itemCode_LK <- map["itemCode_LK"]
        itemName_LK <- map["itemName_LK"]
        imei <- map["imei"]
        so_Luong <- map["so_Luong"]
        
    }
    
}
//= insert model
class InsertRaPCItem: Mappable {
    var message : MessagePC?
    var data : DataInsertPC?
    var data_XML : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        message <- map["message"]
        data <- map["data"]
        data_XML <- map["data_XML"]
    }

}

class DataInsertRaPC : Mappable {
    var status : String = ""
    var docEntry_Header : String = ""
    var docEntry_Request : String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        docEntry_Header <- map["docEntry_Header"]
        docEntry_Request <- map["docEntry_Request"]
    }
    
}
