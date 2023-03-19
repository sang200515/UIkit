//
//  SearchHistoryEveluateModel.swift
//  QuickCode
//
//  Created by Sang Trương on 01/11/2022.
//

import Foundation
import ObjectMapper

class SearchHistoryEveluateModel : Mappable {
    var iD : Int?
    var loaiDanhGia : String?
    var danhGiaUser : String?
    var phongBan : String?
    var chucDanh : String?
    var ngayDanhGia : String?
    var userSangKien : String?

   required init?(map: Map) {

    }

     func mapping(map: Map) {

        iD <- map["ID"]
        loaiDanhGia <- map["LoaiDanhGia"]
        danhGiaUser <- map["DanhGiaUser"]
        phongBan <- map["PhongBan"]
        chucDanh <- map["ChucDanh"]
        ngayDanhGia <- map["NgayDanhGia"]
        userSangKien <- map["UserSangKien"]
    }

}
