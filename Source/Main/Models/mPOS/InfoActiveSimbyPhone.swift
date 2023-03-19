//
//  InfoActiveSimbyPhone.swift
//  mPOS
//
//  Created by tan on 6/2/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class InfoActiveSimbyPhone: NSObject {
    var Address:String
    var FullName:String
    var FirstName:String
    var LastName:String
    var Birthday:String
    var DateCreateCMND:String
    var CMND:String
    var PalaceCreateCMND:String
    var ProvinceCode:String
    var Gender:Int
    var DistrictCode:String
    var Updateby:String
    var Updatedate:String
    var MaShop:String
    var URL_FileCMNDMatTruoc:String
    var URL_FileCMNDMatSau:String
    var URL_FileKH_TaiShop:String
    var PrecinctCode:String
    var Provider:String
    var SeriSIM:String
    var SoHopDong:Int
    
    var idNoiCapCMND:String
    var otp:String
    var sdt:String
    
    init(Address:String,FullName:String,FirstName:String,LastName:String,Birthday:String,DateCreateCMND:String,CMND:String,PalaceCreateCMND:String,ProvinceCode:String,Gender:Int,DistrictCode:String,
         Updateby:String,Updatedate:String,MaShop:String,URL_FileCMNDMatTruoc:String,URL_FileCMNDMatSau:String,URL_FileKH_TaiShop:String,PrecinctCode:String,Provider:String,
         SeriSIM:String,SoHopDong:Int,idNoiCapCMND:String,otp:String,sdt:String){
        
        self.Address = Address
        self.FullName = FullName
        self.FirstName = FirstName
        self.LastName = LastName
        self.Birthday = Birthday
        self.DateCreateCMND = DateCreateCMND
        self.CMND = CMND
        self.PalaceCreateCMND = PalaceCreateCMND
        self.ProvinceCode = ProvinceCode
        self.Gender  = Gender
        self.DistrictCode = DistrictCode
        self.Updateby = Updateby
        self.Updatedate = Updatedate
        self.MaShop = MaShop
        self.URL_FileCMNDMatTruoc = URL_FileCMNDMatTruoc
        self.URL_FileCMNDMatSau = URL_FileCMNDMatSau
        self.URL_FileKH_TaiShop = URL_FileKH_TaiShop
        self.PrecinctCode = PrecinctCode
        self.Provider = Provider
        self.SeriSIM = SeriSIM
        self.SoHopDong = SoHopDong
        // param
        self.idNoiCapCMND = idNoiCapCMND
        self.otp = otp
        self.sdt = sdt
        
        
    }
    
    class func parseObjfromArray(array:[JSON])->[InfoActiveSimbyPhone]{
        var list:[InfoActiveSimbyPhone] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InfoActiveSimbyPhone{
        var address = data["Address"].string
        var fullname = data["FullName"].string
        address = address == nil ? "" : address
        fullname = fullname == nil ? "" : fullname
        
        var firstname = data["FirstName"].string
        var lastname = data["LastName"].string
        firstname = firstname == nil ? "" : firstname
        lastname = lastname == nil ? "" : lastname
        var birthday = data["Birthday"].string
        var datecreatecmnd = data["DateCreateCMND"].string
        var cmnd = data["CMND"].string
        var palacecreatecmnd = data["PalaceCreateCMND"].string
        cmnd = cmnd == nil ? "" : cmnd
        palacecreatecmnd = palacecreatecmnd == nil ? "" : palacecreatecmnd
        var provincecode = data["ProvinceCode"].string
        var gender = data["Gender"].int
        
        provincecode = provincecode == nil ? "" : provincecode
        gender = gender == nil ? 0 : gender
        var districtcode = data["DistrictCode"].string
        var updateby = data["Updateby"].string
        districtcode = districtcode == nil ? "" : districtcode
        updateby = updateby == nil ? "" : updateby
        var updatedate = data["Updatedate"].string
        var mashop = data["MaShop"].string
        updatedate = updatedate == nil ? "" : updatedate
        mashop = mashop == nil ? "" : mashop
        var url_filecmndmattruoc = data["URL_FileCMNDMatTruoc"].string
        var url_filecmndmatsau = data["URL_FileCMNDMatSau"].string
        url_filecmndmattruoc = url_filecmndmattruoc == nil ? "" : url_filecmndmattruoc
        url_filecmndmatsau = url_filecmndmatsau == nil ? "" : url_filecmndmatsau
        var url_filekh_taishop = data["URL_FileKH_TaiShop"].string
        var PrecinctCode = data["PrecinctCode"].string
        url_filekh_taishop = url_filekh_taishop == nil ? "" : url_filekh_taishop
        PrecinctCode = PrecinctCode == nil ? "" : PrecinctCode
        var Provider = data["Provider"].string
        var SeriSIM = data["SeriSIM"].string
        Provider = Provider == nil ? "" : Provider
        SeriSIM = SeriSIM == nil ? "" : SeriSIM
        var SoHopDong = data["SoHopDong"].int
        SoHopDong = SoHopDong == nil ? 0 : SoHopDong
        let idNoiCapCMND = ""
        let otp = ""
        let sdt = ""
        datecreatecmnd = formatDate(date: datecreatecmnd!)
        birthday =  formatDate(date: birthday!)
        
        return InfoActiveSimbyPhone(Address: address!, FullName: fullname!,FirstName:firstname!,LastName:lastname!,Birthday:birthday!, DateCreateCMND: datecreatecmnd!, CMND: cmnd!, PalaceCreateCMND: palacecreatecmnd!, ProvinceCode: provincecode!, Gender: gender!, DistrictCode: districtcode!, Updateby: updateby!, Updatedate: updatedate!, MaShop: mashop!, URL_FileCMNDMatTruoc: url_filecmndmattruoc!, URL_FileCMNDMatSau: url_filecmndmatsau!, URL_FileKH_TaiShop: url_filekh_taishop!,PrecinctCode:PrecinctCode!,Provider:Provider!,SeriSIM: SeriSIM!,
                                    SoHopDong:SoHopDong!,idNoiCapCMND:idNoiCapCMND,otp:otp,sdt:sdt)
    }
    class func formatDate(date:String) -> String{
        let deFormatter = DateFormatter()
        deFormatter.timeZone = TimeZone(abbreviation: "UTC")
        deFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let startTime = deFormatter.date(from: date) ?? Date()
        deFormatter.dateFormat = "dd/MM/yyyy"
        return deFormatter.string(from: startTime)
    }
}
