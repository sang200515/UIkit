    //
    //  CoreInstallMentModel.swift
    //  QuickCode
    //
    //  Created by Sang Trương on 16/07/2022.
    //

import Foundation
import ObjectMapper

    //----Tỉnh thành
class ListTinhThanhCore: Mappable {
    var code: String?
    var name: String?
    var id: Int?

    required init?(map: Map) {}

    func mapping(map: Map) {
        code <- map["code"]
        name <- map["name"]
        id <- map["id"]
    }

}
    //----Quận huyện
class ListQuanHuyenCore: Mappable {
    var code: String?
    var name: String?
    var id: Int?

    required init?(map: Map) {}

    func mapping(map: Map) {
        code <- map["code"]
        name <- map["name"]
        id <- map["id"]
    }
}
    //----Phường xã
class ListPhuongXaCore: Mappable {
    var code: String?
    var name: String?
    var id: Int?

    required init?(map: Map) {}

    func mapping(map: Map) {

        code <- map["code"]
        name <- map["name"]
        id <- map["id"]
    }

}
    //----Mối quan hệ
class ListMoiQuanHe: Mappable {
    var code: String?
    var name: String?
    var id: Int?

    required init?(map: Map) {}
    func mapping(map: Map) {

        code <- map["code"]
        name <- map["name"]
        id <- map["id"]
    }
}
    //----DS nha tra gop

class ListInstallment : Mappable {
    var isReject : Bool?
    var rejectMessage : String?
    var insHouses : [InsHouses]?

   required init?(map: Map) {

    }

     func mapping(map: Map) {

         isReject <- map["isReject"]
         rejectMessage <- map["rejectMessage"]
        insHouses <- map["insHouses"]
    }

}
class InsHouses : Mappable {
    var code : String?
    var alertMessage : String?
    var message : String?
    var messageColor : String?
    var isEnable : Bool?
    var name : String?
    var icon : String?

    required init?(map: Map) {

    }

     func mapping(map: Map) {

        code <- map["code"]
        alertMessage <- map["alertMessage"]
        message <- map["message"]
        messageColor <- map["messageColor"]
        isEnable <- map["isEnable"]
        name <- map["name"]
        icon <- map["icon"]
    }

}
