//
//  KiemkequyModel.swift
//  fptshop
//
//  Created by Ngoc Bao on 06/09/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class TongQuyItem {
    
    var message : MessageKiemKe?
    var data : String?
    var data_XML : String?

    init(message: MessageKiemKe?, data: String?, data_XML: String?) {
        self.message = message
        self.data = data
        self.data_XML = data_XML
    }
    
    class func getObjFromDictionary(map:JSON) -> TongQuyItem {
        let message = MessageKiemKe.getObjFromDictionary(map: map["message"])
        let data = map["data"].stringValue
        let data_XML = map["data_XML"].stringValue
        return TongQuyItem(message: message, data: data, data_XML: data_XML)
    }

}

class MessageKiemKe {
    
    let message_Code : Int?
    let message_Desc : String?

    init(message_Code: Int?, message_Desc: String?) {
        self.message_Code = message_Code
        self.message_Desc = message_Desc
    }
    
    class func getObjFromDictionary(map:JSON) -> MessageKiemKe {
        let message_Code = map["message_Code"].intValue
        let message_Desc = map["message_Desc"].stringValue
        return MessageKiemKe(message_Code: message_Code, message_Desc: message_Desc)
    }

}

//====  luu kiem ke quy
class SaveKiemkeItem {
    
    var message : MessageKiemKe?
    var data : DataSaveKiemke?
    var data_XML : String?

    init(message: MessageKiemKe? = nil, data: DataSaveKiemke? = nil, data_XML: String? = nil) {
        self.message = message
        self.data = data
        self.data_XML = data_XML
    }
    
    class func getObjFromDictionary(map:JSON) -> SaveKiemkeItem {
        let message = MessageKiemKe.getObjFromDictionary(map: map["message"])
        let data = DataSaveKiemke.getObjFromDictionary(map: map["data"])
        let data_XML = map["data_XML"].stringValue
        return SaveKiemkeItem(message: message, data: data, data_XML: data_XML)
    }

}
class DataSaveKiemke {
    
    var docentry : String?
    var doc_Status : String?
    var so_Tien_He_Thong : String?
    
    init(docentry: String? = nil, doc_Status: String? = nil, so_Tien_He_Thong: String? = nil) {
        self.docentry = docentry
        self.doc_Status = doc_Status
        self.so_Tien_He_Thong = so_Tien_He_Thong
    }
    
    class func getObjFromDictionary(map:JSON) -> DataSaveKiemke {
        let docentry = map["docentry"].stringValue
        let doc_Status = map["doc_Status"].stringValue
        let so_Tien_He_Thong = map["so_Tien_He_Thong"].stringValue
        return DataSaveKiemke(docentry: docentry, doc_Status: doc_Status, so_Tien_He_Thong: so_Tien_He_Thong)
    }
    
}
//==  load ds chitiet

class KiemKeItem {
    
    var message : MessageKiemKe?
    var data : DataChitiet?
    var data_XML : String?
    
    init(message: MessageKiemKe? = nil, data: DataChitiet? = nil, data_XML: String? = nil) {
        self.message = message
        self.data = data
        self.data_XML = data_XML
    }
    
    class func getObjFromDictionary(map:JSON) -> KiemKeItem {
        let message = MessageKiemKe.getObjFromDictionary(map: map["message"])
        let data = DataChitiet.getObjFromDictionary(map: map["data"])
        let data_XML = map["data_XML"].stringValue
        return KiemKeItem(message: message, data: data, data_XML: data_XML)
    }

}

class DataChitiet {
    var is_Huy_Kiem_Ke: String
    var is_Kiem_Ke: String
    var is_Giai_Trinh: String
    var chi_Tiet : [DetailKiemke] = []
    var header: Detailheaderkk
    var giai_Trinh : [DetailGiaiTrinh] = []

    init(chi_Tiet: [DetailKiemke] = [],header: Detailheaderkk, giai_Trinh: [DetailGiaiTrinh] = [],is_Kiem_Ke: String,is_Giai_Trinh: String,is_Huy_Kiem_Ke: String) {
        self.chi_Tiet = chi_Tiet
        self.giai_Trinh = giai_Trinh
        self.header = header
        self.is_Giai_Trinh = is_Giai_Trinh
        self.is_Kiem_Ke = is_Kiem_Ke
        self.is_Huy_Kiem_Ke = is_Huy_Kiem_Ke
    }
    
    class func getObjFromDictionary(map:JSON) -> DataChitiet {
        let chi_Tiet = DetailKiemke.parseObjfromArray(array: map["chi_Tiet"].arrayValue)
        let giai_Trinh = DetailGiaiTrinh.parseObjfromArray(array:  map["giai_Trinh"].arrayValue)
        let header = Detailheaderkk.getObjFromDictionary(map: map["header"])
        let is_Kiem_Ke = map["is_Kiem_Ke"].stringValue
        let is_Giai_Trinh = map["is_Giai_Trinh"].stringValue
        let is_Huy_Kiem_Ke = map["is_Huy_Kiem_Ke"].stringValue
        return DataChitiet(chi_Tiet: chi_Tiet,header: header, giai_Trinh: giai_Trinh,is_Kiem_Ke: is_Kiem_Ke,is_Giai_Trinh: is_Giai_Trinh,is_Huy_Kiem_Ke:is_Huy_Kiem_Ke)
    }

}

class Detailheaderkk {
    var so_Tien_He_Thong: Double
    var so_Tien_Kiem_Quy: Double
    var so_Tien_Lech: Double
    
    init(so_Tien_He_Thong: Double, so_Tien_Kiem_Quy: Double, so_Tien_Lech: Double) {
        self.so_Tien_He_Thong = so_Tien_He_Thong
        self.so_Tien_Kiem_Quy = so_Tien_Kiem_Quy
        self.so_Tien_Lech = so_Tien_Lech
    }
    
    class func getObjFromDictionary(map:JSON) -> Detailheaderkk {
        let so_Tien_He_Thong = map["so_Tien_He_Thong"].doubleValue
        let so_Tien_Kiem_Quy = map["so_Tien_Kiem_Quy"].doubleValue
        let so_Tien_Lech = map["so_Tien_Lech"].doubleValue
        return Detailheaderkk(so_Tien_He_Thong: so_Tien_He_Thong, so_Tien_Kiem_Quy: so_Tien_Kiem_Quy, so_Tien_Lech: so_Tien_Lech)
    }
}

class DetailKiemke {
    
    var menh_Gia : Double
    var so_To : Int
    var thanh_Tien : Double

    
    init(menh_Gia: Double, so_To: Int, thanh_Tien: Double) {
        self.menh_Gia = menh_Gia
        self.so_To = so_To
        self.thanh_Tien = thanh_Tien
    }

    class func getObjFromDictionary(map:JSON) -> DetailKiemke {
        let menh_Gia = map["menh_Gia"].doubleValue
        let so_To = map["so_To"].intValue
        let thanh_Tien = map["thanh_Tien"].doubleValue
        return DetailKiemke(menh_Gia: menh_Gia, so_To: so_To, thanh_Tien: thanh_Tien)
    }

    
    class func parseObjfromArray(array:[JSON])->[DetailKiemke]{
        var list:[DetailKiemke] = []
        for item in array {
            list.append(self.getObjFromDictionary(map: item))
        }
        return list
    }
}

class DetailGiaiTrinh {
    
    var docentry : String?
    var reason_Code : String?
    var reason_Content : String?
    var total : String?
    var url_Image : String?

    init(docentry: String? = nil, reason_Code: String? = nil, reason_Content: String? = nil, total: String? = nil, url_Image: String? = nil) {
        self.docentry = docentry
        self.reason_Code = reason_Code
        self.reason_Content = reason_Content
        self.total = total
        self.url_Image = url_Image
    }

    class func getObjFromDictionary(map:JSON) -> DetailGiaiTrinh {
        let docentry = map["docentry"].stringValue
        let reason_Code = map["reason_Code"].stringValue
        let reason_Content = map["reason_Content"].stringValue
        let total = map["total"].stringValue
        let url_Image = map["url_Image"].stringValue
        return DetailGiaiTrinh(docentry: docentry, reason_Code: reason_Code, reason_Content: reason_Content, total: total, url_Image: url_Image)
    }
    
    class func parseObjfromArray(array:[JSON])->[DetailGiaiTrinh]{
        var list:[DetailGiaiTrinh] = []
        for item in array {
            list.append(self.getObjFromDictionary(map: item))
        }
        return list
    }
    
}

//== search kiem ke

class SearchKiemkeItem {
    
    var message : MessageKiemKe?
    var data : [SearchKiemKeDetail]
    var data_XML : String?
    
    init(message: MessageKiemKe? = nil, data: [SearchKiemKeDetail], data_XML: String? = nil) {
        self.message = message
        self.data = data
        self.data_XML = data_XML
    }
    
    class func getObjFromDictionary(map:JSON) -> SearchKiemkeItem {
        let message = MessageKiemKe.getObjFromDictionary(map: map["message"])
        let data = SearchKiemKeDetail.parseObjfromArray(array: map["data"].arrayValue)
        let data_XML = map["data_XML"].stringValue
        return SearchKiemkeItem(message: message, data: data, data_XML: data_XML)
    }

}

class SearchKiemKeDetail {
    var statusColor: UIColor = .black
    var docentry : String?
    var doc_Status : String?
    var doc_Type : String?
    var create_Date : String?
    var shop_Code : String?
    var shop_Name : String?
    var doc_Type_Name: String?
    var user_Full_Text: String?
    var user_KK: String?
    var user_GT: String?
    var user_HuyKK: String?
    var user_HT: String?
    
    init(docentry: String? = nil, doc_Status: String? = nil, doc_Type: String? = nil, create_Date: String? = nil, shop_Code: String? = nil, shop_Name: String? = nil, doc_Type_Name: String? = nil,user_Full_Text: String? = nil,user_KK:String = "",user_GT: String = "",user_HuyKK: String = "",user_HT:String = "") {
        self.docentry = docentry
        self.doc_Status = doc_Status
        self.doc_Type = doc_Type
        self.create_Date = create_Date
        self.shop_Code = shop_Code
        self.shop_Name = shop_Name
        self.doc_Type_Name = doc_Type_Name
        self.user_Full_Text = user_Full_Text
        self.user_KK = user_KK
        self.user_GT = user_GT
        self.user_HuyKK = user_HuyKK
        self.user_HT = user_HT
    }

    class func getObjFromDictionary(map:JSON) -> SearchKiemKeDetail {
        let docentry = map["docentry"].stringValue
        let doc_Status = map["doc_Status"].stringValue
        let doc_Type = map["doc_Type"].stringValue
        let create_Date = map["create_Date"].stringValue
        let shop_Code = map["shop_Code"].stringValue
        let shop_Name = map["shop_Name"].stringValue
        let doc_Type_Name = map["doc_Type_Name"].stringValue
        let user_Full_Text = map["user_Full_Text"].stringValue
        let user_KK = map["user_KK"].stringValue
        let user_GT = map["user_GT"].stringValue
        let user_HuyKK = map["user_HuyKK"].stringValue
        let user_HT = map["user_HT"].stringValue
        return SearchKiemKeDetail(docentry: docentry, doc_Status: doc_Status, doc_Type: doc_Type, create_Date: create_Date, shop_Code: shop_Code, shop_Name: shop_Name,doc_Type_Name: doc_Type_Name,user_Full_Text:user_Full_Text,user_KK:user_KK,user_GT:user_GT,user_HuyKK:user_HuyKK,user_HT:user_HT)
    }
    
    class func parseObjfromArray(array:[JSON])->[SearchKiemKeDetail]{
        var list:[SearchKiemKeDetail] = []
        for item in array {
            list.append(self.getObjFromDictionary(map: item))
        }
        return list
    }
    
    var statusName: String {
        switch doc_Status {
        case "O":
            self.statusColor = .black
            return "Mở"
        case "W":
            self.statusColor = Constants.COLORS.bold_green
            return "Giải trình"
        case "F":
            self.statusColor = .blue
            return "Hoàn Tất"
        case "C":
            self.statusColor = .red
            return "Hủy"
        default:
            return ""
        }
    }
    
}
