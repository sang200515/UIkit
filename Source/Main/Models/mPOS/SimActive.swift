//
//  SimActive.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SimActive: NSObject {
    var ID: Int
    var Provider: String
    var Status: String
    var Phonenumber: String
    var SeriSIM: String
    
    var FullName: String
    var Birthday: String
    var Gender: Int
    var Address: String
    var CMND: String
    
    var DateCreateCMND: String
    var PalaceCreateCMND: String
    var ProvinceCode: String
    var DistrictCode: String
    var PrecinctCode: String
    
    var URL_FileCMNDMatTruoc: String
    var URL_FileCMNDMatSau: String
    var URL_FilePhieuDKTT: String
    var URL_FileKH_TaiShop: String
    var Note: String
    
    var GoiCuoc: String
    var ProductName: String
    var ProductCode: String
    var TypeKichHoat: Int
    var POSSODocNum: String
    
    var Passport: String
    var DayGrantPassport: String
    var Nationality: String
    
    var LoaiGiayTo: Int
    var SoVisa: String
    var NoiCapPassport:String
    
    var TenShop: String
    var DiaChiShop: String
    var TenNhanVien:String
    var SSD:String
    
    init(ID: Int,Provider: String,Status: String,Phonenumber: String,SeriSIM: String,FullName: String,Birthday: String,Gender: Int,Address: String,CMND: String,DateCreateCMND: String,PalaceCreateCMND: String,ProvinceCode: String,DistrictCode: String,PrecinctCode: String,URL_FileCMNDMatTruoc: String,URL_FileCMNDMatSau: String,URL_FilePhieuDKTT: String,URL_FileKH_TaiShop: String,Note: String,GoiCuoc: String,ProductName: String,ProductCode: String, TypeKichHoat: Int,POSSODocNum: String,Passport: String, DayGrantPassport: String,Nationality: String,LoaiGiayTo: Int,SoVisa: String,NoiCapPassport:String,TenShop: String,DiaChiShop: String,TenNhanVien:String,SSD:String) {
        self.ID = ID
        self.Provider = Provider
        self.Status = Status
        self.Phonenumber = Phonenumber
        self.SeriSIM = SeriSIM
        
        self.FullName = FullName
        self.Birthday = Birthday
        self.Gender = Gender
        self.Address = Address
        self.CMND = CMND
        
        self.DateCreateCMND = DateCreateCMND
        self.PalaceCreateCMND = PalaceCreateCMND
        self.ProvinceCode = ProvinceCode
        self.DistrictCode = DistrictCode
        self.PrecinctCode = PrecinctCode
        
        self.URL_FileCMNDMatTruoc = URL_FileCMNDMatTruoc
        self.URL_FileCMNDMatSau = URL_FileCMNDMatSau
        self.URL_FilePhieuDKTT = URL_FilePhieuDKTT
        self.URL_FileKH_TaiShop = URL_FileKH_TaiShop
        self.Note = Note
        self.GoiCuoc = GoiCuoc
        self.ProductName = ProductName
        self.ProductCode = ProductCode
        self.TypeKichHoat = TypeKichHoat
        self.POSSODocNum = POSSODocNum
        
        self.Passport = Passport
        self.DayGrantPassport = DayGrantPassport
        self.Nationality = Nationality
        self.LoaiGiayTo = LoaiGiayTo
        self.SoVisa =  SoVisa
        self.NoiCapPassport =  NoiCapPassport
        
        self.TenShop = TenShop
        self.DiaChiShop = DiaChiShop
        self.TenNhanVien = TenNhanVien
        self.SSD = SSD
    }
    class func parseObjfromArray(array:[JSON])->[SimActive]{
        var list:[SimActive] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SimActive{
        
        var id = data["ID"].int
        var provider = data["Provider"].string
        var status = data["Status"].string
        var phonenumber = data["Phonenumber"].string
        var seriSIM = data["SeriSIM"].string
        
        var fullName = data["FullName"].string
        var birthday = data["Birthday"].string
        var gender = data["Gender"].int
        var address = data["Address"].string
        var cmnd = data["CMND"].string
        
        var dateCreateCMND = data["DateCreateCMND"].string
        var palaceCreateCMND = data["PalaceCreateCMND"].string
        var provinceCode = data["ProvinceCode"].string
        var districtCode = data["DistrictCode"].string
        var precinctCode = data["PrecinctCode"].string
        
        var url_FileCMNDMatTruoc = data["URL_FileCMNDMatTruoc"].string
        var url_FileCMNDMatSau = data["URL_FileCMNDMatSau"].string
        var url_FilePhieuDKTT = data["URL_FilePhieuDKTT"].string
        var url_FileKH_TaiShop = data["URL_FileKH_TaiShop"].string
        var note = data["Note"].string
        var goiCuoc = data["GoiCuoc"].string
        var productName = data["ProductName"].string
        var productCode = data["ProductCode"].string
        var typeKichHoat = data["TypeKichHoat"].int
        var posSODocNum = data["POSSODocNum"].string
        
        var passport = data["Passport"].string
        var dayGrantPassport = data["DayGrantPassport"].string
        var nationality = data["Nationality"].string
        var loaiGiayTo = data["LoaiGiayTo"].int
        var soVisa = data["SoVisa"].string
        var noiCapPassport = data["NoiCapPassport"].string
        
        var tenShop = data["TenShop"].string
        var diaChiShop = data["DiaChiShop"].string
        var tenNhanVien = data["TenNhanVien"].string
        var SSD = data["SSD"].string
        
        id = id == nil ? 0 : id
        provider = provider == nil ? "" : provider
        status = status == nil ? "" : status
        phonenumber = phonenumber == nil ? "" : phonenumber
        seriSIM = seriSIM == nil ? "" : seriSIM
        
        fullName = fullName == nil ? "" : fullName
        birthday = birthday == nil ? "" : birthday
        gender = gender == nil ? 0 : gender
        address = address == nil ? "" : address
        cmnd = cmnd == nil ? "" : cmnd
        
        dateCreateCMND = dateCreateCMND == nil ? "" : dateCreateCMND
        palaceCreateCMND = palaceCreateCMND == nil ? "" : palaceCreateCMND?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        provinceCode = provinceCode == nil ? "" : provinceCode
        districtCode = districtCode == nil ? "" : districtCode
        precinctCode = precinctCode == nil ? "" : precinctCode
        
        url_FileCMNDMatTruoc = url_FileCMNDMatTruoc == nil ? "" : url_FileCMNDMatTruoc
        url_FileCMNDMatSau = url_FileCMNDMatSau == nil ? "" : url_FileCMNDMatSau
        url_FilePhieuDKTT = url_FilePhieuDKTT == nil ? "" : url_FilePhieuDKTT
        url_FileKH_TaiShop = url_FileKH_TaiShop == nil ? "" : url_FileKH_TaiShop
        note = note == nil ? "" : note
        
        goiCuoc = goiCuoc == nil ? "" : goiCuoc
        productName = productName == nil ? "" : productName
        productCode = productCode == nil ? "" : productCode
        typeKichHoat = typeKichHoat == nil ? 0 : typeKichHoat
        posSODocNum = posSODocNum == nil ? "" : posSODocNum
        
        passport = passport == nil ? "" : passport
        passport = passport == "undefined" ? "" : passport
        dayGrantPassport = dayGrantPassport == nil ? "" : dayGrantPassport
        SSD = SSD == nil ? "" : SSD
        
        nationality = nationality == nil ? "" : nationality
        if(nationality == ""){
            if(provider == "Mobifone"){
                nationality = "VNM"
            }else if (provider == "Vinaphone"){
                nationality = "232"
            }else if (provider == "Viettel"){
                nationality = "232"
            }else if (provider == "Vietnammobile"){
                nationality = "232"
            }
        }
        loaiGiayTo = loaiGiayTo == nil ? 0 : loaiGiayTo
        soVisa = soVisa == nil ? "" : soVisa
        noiCapPassport = noiCapPassport == nil ? "" : noiCapPassport
        
        tenShop = tenShop == nil ? "" : tenShop
        diaChiShop = diaChiShop == nil ? "" : diaChiShop
        tenNhanVien = tenNhanVien == nil ? "" : tenNhanVien
        
        var dateBirthday = ""
        var dateCreateCMNDConvert = ""
        var dayGrantPassportConvert = ""
        if (birthday != ""){
            dateBirthday = self.converDate(dateString: birthday!)
        }
        if (dateCreateCMND != ""){
            dateCreateCMNDConvert = self.converDate(dateString: dateCreateCMND!)
        }
        if (dayGrantPassport != ""){
            dayGrantPassportConvert = self.converDate(dateString: dayGrantPassport!)
        }
        
        return SimActive(ID: id!,Provider: provider!,Status: status!,Phonenumber: phonenumber!,SeriSIM: seriSIM!,FullName: fullName!,Birthday: dateBirthday,Gender: gender!,Address: address!,CMND: cmnd!,DateCreateCMND: dateCreateCMNDConvert,PalaceCreateCMND: palaceCreateCMND!,ProvinceCode: provinceCode!,DistrictCode: districtCode!,PrecinctCode: precinctCode!,URL_FileCMNDMatTruoc: url_FileCMNDMatTruoc!,URL_FileCMNDMatSau: url_FileCMNDMatSau!,URL_FilePhieuDKTT: url_FilePhieuDKTT!,URL_FileKH_TaiShop: url_FileKH_TaiShop!,Note: note!,GoiCuoc: goiCuoc!,ProductName: productName!,ProductCode:productCode!, TypeKichHoat: typeKichHoat!,POSSODocNum: posSODocNum!,Passport: passport!, DayGrantPassport: dayGrantPassportConvert,Nationality: nationality!,LoaiGiayTo:loaiGiayTo!,SoVisa:soVisa!, NoiCapPassport: noiCapPassport!,TenShop: tenShop!,DiaChiShop: diaChiShop!,TenNhanVien:tenNhanVien!,SSD:SSD!)
    }
    static let dateFormatter = DateFormatter()
    class func converDate(dateString:String)->String{
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        return dateString
    }
}

