//
//  CustomerToshiba.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CustomerToshiba: NSObject {
    
    var code: Int
    var name: String
    var isPrivate: String
    var phoneOrTaxCode: String
    var address: String
    var city: String
    var email: String
    var KH_TraGop: String
    var HangThe: String
    var Diem: Int
    var FMoney: Int
    var IDcardPoint: String
    var NgaySinh: String
    var gioitinh: Int
    var ocrd_FF: String
    var p_flag:Int
    var p_messagess:String
    
    init(code: Int,name: String,isPrivate: String,phoneOrTaxCode: String,address: String,city: String,email: String,KH_TraGop: String,HangThe: String,Diem: Int,FMoney: Int,IDcardPoint: String, NgaySinh: String, gioitinh: Int, ocrd_FF: String,p_flag:Int,p_messagess:String){
        self.code = code
        self.name = name
        self.isPrivate = isPrivate
        self.phoneOrTaxCode = phoneOrTaxCode
        self.address = address
        self.city = city
        self.email = email
        self.KH_TraGop = KH_TraGop
        self.HangThe = HangThe
        self.Diem = Diem
        self.FMoney = FMoney
        self.IDcardPoint = IDcardPoint
        self.NgaySinh = NgaySinh
        self.gioitinh = gioitinh
        self.ocrd_FF = ocrd_FF
        self.p_flag = p_flag
        self.p_messagess = p_messagess
    }
    class func parseObjfromArray(array:[JSON])->[CustomerToshiba]{
        var list:[CustomerToshiba] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CustomerToshiba{
        
        var code = data["code"].int
        var name = data["name"].string
        var isPrivate = data["isPrivate"].string
        var phoneOrTaxCode = data["phoneOrTaxCode"].string
        var address = data["address"].string
        var city = data["city"].string
        var email = data["email"].string
        var kh_TraGop = data["KH_TraGop"].string
        var hangThe = data["HangThe"].string
        var diem = data["Diem"].int
        var fMoney = data["FMoney"].int
        var idCardPoint = data["IDcardPoint"].string
        
        var ngaySinh = data["NgaySinh"].string
        var gioitinh = data["gioitinh"].int
        var ocrd_FF = data["ocrd_FF"].string
        var p_flag = data["p_flag"].int
        var p_messagess = data["p_messagess"].string
        
        code = code == nil ? 0 : code
        name = name == nil ? "" : name
        isPrivate = isPrivate == nil ? "" : isPrivate
        phoneOrTaxCode = phoneOrTaxCode == nil ? "" : phoneOrTaxCode
        address = address == nil ? "" : address
        city = city == nil ? "" : city
        email = email == nil ? "" : email
        kh_TraGop = kh_TraGop == nil ? "" : kh_TraGop
        hangThe = hangThe == nil ? "" : hangThe
        diem = diem == nil ? 0 : diem
        fMoney = fMoney == nil ? 0 : fMoney
        idCardPoint = idCardPoint == nil ? "" : idCardPoint
        
        ngaySinh = ngaySinh == nil ? "" : ngaySinh
        gioitinh = gioitinh == nil ? -1 : gioitinh
        ocrd_FF = ocrd_FF == nil ? "" : ocrd_FF
        p_flag = p_flag == nil ? 0 : p_flag
        p_messagess = p_messagess == nil ? "" : p_messagess
        
        var dateNgaySinh = ""
        if (ngaySinh != ""){
            dateNgaySinh = self.converDate(dateString: ngaySinh!)
        }
        
        return CustomerToshiba(code: code!,name: name!,isPrivate: isPrivate!,phoneOrTaxCode: phoneOrTaxCode!,address: address!,city: city!,email: email!,KH_TraGop: kh_TraGop!,HangThe: hangThe!,Diem: diem!,FMoney: fMoney!,IDcardPoint: idCardPoint!, NgaySinh: dateNgaySinh, gioitinh: gioitinh!, ocrd_FF: ocrd_FF!,p_flag:p_flag!,p_messagess:p_messagess!)
    }
    static let dateFormatter = DateFormatter()
    class func converDate(dateString:String)->String{
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        print("AAAA " + dateString)
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        return dateString
    }
    
}

