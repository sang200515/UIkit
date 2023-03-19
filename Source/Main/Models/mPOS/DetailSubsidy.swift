//
//  DetailSubsidy.swift
//  mPOS
//
//  Created by MinhDH on 4/24/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class DetailSubsidy: NSObject {
    
    var CPData: String
    var CPFacebook: String
    var CPNgoaiMang: String
    var CPNoiMang: String
    var CPSMS: String
    var TongCong: String
    var UuDaiData: String
    var UuDaiFacebook: String
    var UuDaiNgoaiMang: String
    var UuDaiNoiMang:String
    var UuDaiSMS:String
    
    var DataLink:String
    var DataNote:String
    var GiaDinh:String
    var NgoaiMagNote:String
    var NgoaiMangLink:String
    var NoiMangLink:String
    var NoiMangNote:String
    var SMSLink:String
    var SMSNote:String
    var SoTienTietKiem:String
    
    
    
    init(CPData: String, CPFacebook: String, CPNgoaiMang: String, CPNoiMang: String, CPSMS: String, TongCong: String, UuDaiData: String, UuDaiFacebook: String, UuDaiNgoaiMang: String, UuDaiNoiMang:String, UuDaiSMS:String,DataLink:String, DataNote:String, GiaDinh:String, NgoaiMagNote:String, NgoaiMangLink:String, NoiMangLink:String, NoiMangNote:String, SMSLink:String, SMSNote:String,SoTienTietKiem:String){
        self.CPData = CPData
        self.CPFacebook = CPFacebook
        self.CPNgoaiMang = CPNgoaiMang
        self.CPNoiMang = CPNoiMang
        self.CPSMS = CPSMS
        self.TongCong = TongCong
        self.UuDaiData = UuDaiData
        self.UuDaiFacebook = UuDaiFacebook
        self.UuDaiNgoaiMang = UuDaiNgoaiMang
        self.UuDaiNoiMang = UuDaiNoiMang
        self.UuDaiSMS = UuDaiSMS
        
        self.DataLink = DataLink
        self.DataNote = DataNote
        self.GiaDinh = GiaDinh
        self.NgoaiMagNote = NgoaiMagNote
        self.NgoaiMangLink = NgoaiMangLink
        self.NoiMangLink = NoiMangLink
        self.NoiMangNote = NoiMangNote
        self.SMSLink = SMSLink
        self.SMSNote = SMSNote
        self.SoTienTietKiem = SoTienTietKiem
    }
    class func parseObjfromArray(array:[JSON])->[DetailSubsidy]{
        var list:[DetailSubsidy] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> DetailSubsidy{
        
        var cpData = data["CPData"].string
        var cpFacebook = data["CPFacebook"].string
        var cpNgoaiMang = data["CPNgoaiMang"].string
        var cpNoiMang = data["CPNoiMang"].string
        
        
        var cpSMS = data["CPSMS"].string
        var tongCong = data["TongCong"].string
        var uuDaiData = data["UuDaiData"].string
        var uuDaiFacebook = data["UuDaiFacebook"].string
        var uuDaiNgoaiMang = data["UuDaiNgoaiMang"].string
        var uuDaiNoiMang = data["UuDaiNoiMang"].string
        var uuDaiSMS = data["UuDaiSMS"].string
        
        var dataLink = data["DataLink"].string
        var dataNote = data["DataNote"].string
        var giaDinh = data["GiaDinh"].string
        var ngoaiMagNote = data["NgoaiMagNote"].string
        var ngoaiMangLink = data["NgoaiMangLink"].string
        var noiMangLink = data["NoiMangLink"].string
        var noiMangNote = data["NoiMangNote"].string
        var smsLink = data["SMSLink"].string
        var smsNote = data["SMSNote"].string
        var soTienTietKiem = data["SoTienTietKiem"].string
        
        cpData = cpData == nil ? "" : cpData
        cpFacebook = cpFacebook == nil ? "" : cpFacebook
        cpNgoaiMang = cpNgoaiMang == nil ? "" : cpNgoaiMang
        cpNoiMang = cpNoiMang == nil ? "" : cpNoiMang
        
        cpSMS = cpSMS == nil ? "" : cpSMS
        tongCong = tongCong == nil ? "" : tongCong
        uuDaiData = uuDaiData == nil ? "" : uuDaiData
        uuDaiFacebook = uuDaiFacebook == nil ? "" : uuDaiFacebook
        uuDaiNgoaiMang = uuDaiNgoaiMang == nil ? "" : uuDaiNgoaiMang
        uuDaiNoiMang = uuDaiNoiMang == nil ? "" : uuDaiNoiMang
        uuDaiSMS = uuDaiSMS == nil ? "" : uuDaiSMS
        
        dataLink = dataLink == nil ? "" : dataLink
        dataNote = dataNote == nil ? "" : dataNote
        giaDinh = giaDinh == nil ? "" : giaDinh
        ngoaiMagNote = ngoaiMagNote == nil ? "" : ngoaiMagNote
        ngoaiMangLink = ngoaiMangLink == nil ? "" : ngoaiMangLink
        noiMangLink = noiMangLink == nil ? "" : noiMangLink
        noiMangNote = noiMangNote == nil ? "" : noiMangNote
        smsLink = smsLink == nil ? "" : smsLink
        smsNote = smsNote == nil ? "" : smsNote
        soTienTietKiem = soTienTietKiem == nil ? "" : soTienTietKiem
        
        return DetailSubsidy(CPData: cpData!, CPFacebook: cpFacebook!, CPNgoaiMang: cpNgoaiMang!, CPNoiMang: cpNoiMang!, CPSMS: cpSMS!, TongCong: tongCong!, UuDaiData: uuDaiData!, UuDaiFacebook: uuDaiFacebook!, UuDaiNgoaiMang: uuDaiNgoaiMang!, UuDaiNoiMang:uuDaiNoiMang!, UuDaiSMS:uuDaiSMS!,DataLink:dataLink!, DataNote:dataNote!, GiaDinh:giaDinh!, NgoaiMagNote:ngoaiMagNote!, NgoaiMangLink:ngoaiMangLink!, NoiMangLink:noiMangLink!, NoiMangNote:noiMangNote!, SMSLink:smsLink!, SMSNote:smsNote!,SoTienTietKiem:soTienTietKiem!)
    }
}
