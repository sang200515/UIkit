//
//  LapTopBirthdayHistory.swift
//  fptshop
//
//  Created by DiemMy Le on 11/13/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"id": 1,
//"phonenumber": "0396440829",
//"idcard": "25376",
//"fullname": "Nguyễn Minh Thương",
//"birthday": "1996-12-26T00:00:00",
//"address": "Cát Thắng, Phù Cát, Bình Định",
//"issueday": "2011-11-11T00:00:00",
//"url_mattruoc": "link1",
//"url_matsau": "link 2",
//"typecard": 1,
//"voucher": "",
//"status": "Chưa cấp phát voucher",
//"createby": "15261-Nguyễn Phúc Hữu",
//"createtime": "12/11/2020 14:41"

import UIKit
import SwiftyJSON

class LapTopBirthdayHistory: NSObject {

    let id:Int
    let phonenumber:String
    let idcard:String
    let fullname: String
    let birthday: String
    let address: String
    let issueday: String
    let url_mattruoc: String
    let url_matsau: String
    var typecard: Int
    let voucher: String
    let status: String
    let createby: String
    let createtime: String
    
    init(id:Int, phonenumber:String, idcard:String, fullname: String, birthday: String, address: String, issueday: String, url_mattruoc: String, url_matsau: String, typecard: Int, voucher: String, status: String, createby: String, createtime: String) {
        self.id = id
        self.phonenumber = phonenumber
        self.idcard = idcard
        self.fullname = fullname
        self.birthday = birthday
        self.address = address
        self.issueday = issueday
        self.url_mattruoc = url_mattruoc
        self.url_matsau = url_matsau
        self.typecard = typecard
        self.voucher = voucher
        self.status = status
        self.createby = createby
        self.createtime = createtime
    }
    
    class func parseObjfromArray(array:[JSON])->[LapTopBirthdayHistory]{
        var list:[LapTopBirthdayHistory] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
        
    class func getObjFromDictionary(data:JSON) -> LapTopBirthdayHistory{
        let id = data["id"].intValue
        let phonenumber = data["phonenumber"].stringValue
        let idcard = data["idcard"].stringValue
        let fullname = data["fullname"].stringValue
        let birthday = data["birthday"].stringValue
        let address = data["address"].stringValue
        let issueday = data["issueday"].stringValue
        let url_mattruoc = data["url_mattruoc"].stringValue
        let url_matsau = data["url_matsau"].stringValue
        let typecard = data["typecard"].intValue
        let voucher = data["voucher"].stringValue
        let status = data["status"].stringValue
        let createby = data["createby"].stringValue
        let createtime = data["createtime"].stringValue
        
        return LapTopBirthdayHistory(id: id, phonenumber: phonenumber, idcard: idcard, fullname: fullname, birthday: birthday, address: address, issueday: issueday, url_mattruoc: url_mattruoc, url_matsau: url_matsau, typecard: typecard, voucher: voucher, status: status, createby: createby, createtime: createtime)
    }
}
