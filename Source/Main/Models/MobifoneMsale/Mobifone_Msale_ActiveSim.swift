//
//  Mobifone_Msale_ActiveSim.swift
//  fptshop
//
//  Created by DiemMy Le on 11/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//            "id": 1,
//            "so_mpos": 0,
//            "confirm_date": null,
//            "sub_name": "Nguyễn Tân Gia ",
//            "phonenumber": "0708640723",
//            "id_no": "072084004524",
//            "activedate": "23/11/2020 11:15:54",
//            "userid": "4472",
//            "status": "Chưa phát sinh đơn hàng",
//            "package_name_sale": "Gọi Thả Ga 90 1 T",
//            "package_sale": "00722919",
//            "package_name_mbf": "Gọi Thả Ga 90 1 T",
//            "package_mbf": "00722919",
//            "package_fpt": "00722919",
//            "package_name_fpt": "Gọi Thả Ga 90 1 T",
//            "package_price": 210000.000000,
//            "sub_number_price": 0.000000,
//            "sub_number_name": "",
//            "flag_package": 0

import UIKit
import SwiftyJSON

class Mobifone_Msale_ActiveSim: NSObject {

    var id:Int
    var so_mpos:Int
    var confirm_date:String
    var sub_name:String
    var phonenumber:String
    var id_no:String
    var activedate:String
    var userid:String
    var status:String
    
    var package_name_sale:String
    var package_sale:String
    var package_name_provider:String
    var package_provider:String
    var package_fpt:String
    var package_name_fpt:String
    var package_price: Double
    var sub_number_price: Double
    var sub_number_name: String
    var flag_package: Int
    var serial: String
    var Provider: String
    
    init(id:Int, so_mpos:Int, confirm_date:String, sub_name:String, phonenumber:String, id_no:String, activedate:String, userid:String, status:String, package_name_sale:String, package_sale:String, package_name_provider:String, package_provider:String, package_fpt:String, package_name_fpt:String, package_price: Double, sub_number_price: Double, sub_number_name: String, flag_package: Int, serial: String,Provider: String) {
        
        self.id = id
        self.so_mpos = so_mpos
        self.confirm_date = confirm_date
        self.sub_name = sub_name
        self.phonenumber = phonenumber
        self.id_no = id_no
        self.activedate = activedate
        self.userid = userid
        self.status = status
        self.package_name_sale = package_name_sale
        self.package_sale = package_sale
        self.package_name_provider = package_name_provider
        self.package_provider = package_provider
        self.package_fpt = package_fpt
        self.package_name_fpt = package_name_fpt
        self.package_price = package_price
        self.sub_number_price = sub_number_price
        self.sub_number_name = sub_number_name
        self.flag_package = flag_package
        self.serial = serial
        self.Provider = Provider
    }
    
    class func parseObjfromArray(array:[JSON])->[Mobifone_Msale_ActiveSim]{
        var list:[Mobifone_Msale_ActiveSim] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Mobifone_Msale_ActiveSim {
        let id = data["id"].intValue
        let so_mpos = data["so_mpos"].intValue
        let confirm_date = data["confirm_date"].stringValue
        let sub_name = data["sub_name"].stringValue
        let phonenumber = data["phonenumber"].stringValue
        let id_no = data["id_no"].stringValue
        
        let activedate = data["activedate"].stringValue
        let userid = data["userid"].stringValue
        let status = data["status"].stringValue
        let package_name_sale = data["package_name_sale"].stringValue
        
        let package_sale = data["package_sale"].stringValue
        let package_name_provider = data["package_name_provider"].stringValue
        let package_provider = data["package_provider"].stringValue
        let package_fpt = data["package_fpt"].stringValue
        let package_name_fpt = data["package_name_fpt"].stringValue
        
        let package_price = data["package_price"].doubleValue
        let sub_number_price = data["sub_number_price"].doubleValue
        let sub_number_name = data["sub_number_name"].stringValue
        let flag_package = data["flag_package"].intValue
        let serial = data["serial"].stringValue
        let Provider = data["Provider"].stringValue
        

        return Mobifone_Msale_ActiveSim(id: id, so_mpos: so_mpos, confirm_date: confirm_date, sub_name: sub_name, phonenumber: phonenumber, id_no: id_no, activedate: activedate, userid: userid, status: status, package_name_sale: package_name_sale, package_sale: package_sale, package_name_provider: package_name_provider, package_provider: package_provider, package_fpt: package_fpt, package_name_fpt: package_name_fpt, package_price: package_price, sub_number_price: sub_number_price, sub_number_name: sub_number_name, flag_package: flag_package, serial:serial,Provider: Provider)
        
    }
}
