//
//  AddBookSimVinaphoneModel.swift
//  QuickCode
//
//  Created by Sang Trương on 30/12/2022.
//

import Foundation
import ObjectMapper
class AddBookSimVinaphoneModel : Mappable {
	var success : Bool = false
	var mess :  String = ""
	required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["Success"]
		mess <- map["Mess"]
	}

}

class ActiveSimVinaModel : Mappable {
	var success : Bool = false
	var data : [ActiveSimVinaDataModel] = []

	required init?(map: Map) {

	}

	 func mapping(map: Map) {

		success <- map["Success"]
		data <- map["Data"]
	}

}

class ActiveSimVinaDataModel : Mappable {
	var id_vina : String = ""
	var provider : String = ""
	var so_mpos : Int = 0
	var activedate : String = ""
	var fullName : String = ""
	var phonenumber : String = ""
	var serial : String = ""
	var cMND : String = ""
	var confirm_date : String = ""
	var userName : String = ""
	var status : String = ""
	var packageName : String = ""
	var packageType : String = ""
	var package_price : Double = 0
	var sub_number_price : Double = 0
	var totalPrice : Double = 0

	required init?(map: Map) {

	}

	 func mapping(map: Map) {

		id_vina <- map["Id_vina"]
		provider <- map["Provider"]
		so_mpos <- map["So_mpos"]
		activedate <- map["Activedate"]
		fullName <- map["FullName"]
		phonenumber <- map["Phonenumber"]
		serial <- map["Serial"]
		cMND <- map["CMND"]
		confirm_date <- map["Confirm_date"]
		userName <- map["UserName"]
		status <- map["Status"]
		packageName <- map["PackageName"]
		packageType <- map["PackageType"]
		package_price <- map["package_price"]
		sub_number_price <- map["sub_number_price"]
		totalPrice <- map["TotalPrice"]
	}

}
