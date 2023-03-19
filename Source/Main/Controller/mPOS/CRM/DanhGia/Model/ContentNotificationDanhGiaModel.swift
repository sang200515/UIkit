//
//  ContentNotificationDanhGiaModel.swift
//  QuickCode
//
//  Created by Sang Trương on 07/11/2022.
//


import Foundation
import ObjectMapper

class ContentNotificationDanhGiaModel : Mappable {
	var title : String?
	var ngay : String?
	var nguoiDanhGia : String?
	var shopPhongBanNguoiDanhGia : String?
	var email : String?
	var hoVaTenNhanVien : String?
	var shopPhongBanNhanVien : String?
	var hangMucGiaTri : String?
	var capDoDichVu : String?
	var lyDo : String?

	required init?(map: Map) {

	}

	 func mapping(map: Map) {

		title <- map["Title"]
		ngay <- map["Ngay"]
		nguoiDanhGia <- map["NguoiDanhGia"]
		shopPhongBanNguoiDanhGia <- map["ShopPhongBanNguoiDanhGia"]
		email <- map["Email"]
		hoVaTenNhanVien <- map["HoVaTenNhanVien"]
		shopPhongBanNhanVien <- map["ShopPhongBanNhanVien"]
		hangMucGiaTri <- map["HangMucGiaTri"]
		capDoDichVu <- map["CapDoDichVu"]
		lyDo <- map["LyDo"]
	}

}
