//
//  StudentBTSInfo.swift
//  fptshop
//
//  Created by Apple on 7/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Result": 1,
//"Msg": "Thành công",
//"ID_BackToSchool": 1,
//"SoBaoDanh": "02060642",
//"HoTen": "Nguyễn Văn A",
//"CMND": "0123456789",
//"SDT": "0987654321",
//"NgaySinh": "1",
//"DiemTungMon": [],
//"DiemTrungBinh": 5.36,
//"PhanTramGiamGia": 8,
//"Voucher": "",
//"TinhTrangVoucher": "",
//"Url_CMND_MT": "",
//"Url_CMND_MS": "",
//"Url_GiayBaoThi": ""

import UIKit
import SwiftyJSON

class StudentBTSInfo: NSObject {
    
    let Result: Int
    let Msg: String
    let ID_BackToSchool: Int
    let SoBaoDanh: String
    let HoTen: String
    let CMND: String
    let SDT: String
    let NgaySinh: String
    let DiemTungMon: [MonHocBTS]
    let DiemTrungBinh: String
    let PhanTramGiamGia: String
    let Voucher: String
    let TinhTrangVoucher: String
    let Url_CMND_MT: String
    let Url_CMND_MS: String
    let Url_GiayBaoThi: String
    let Allow_UploadImg: Int
    
    init(Result: Int, Msg: String, ID_BackToSchool: Int, SoBaoDanh: String, HoTen: String, CMND: String, SDT: String, NgaySinh: String, DiemTungMon: [MonHocBTS], DiemTrungBinh: String, PhanTramGiamGia: String, Voucher: String, TinhTrangVoucher: String, Url_CMND_MT: String, Url_CMND_MS: String, Url_GiayBaoThi: String, Allow_UploadImg: Int) {
        
        self.Result = Result
        self.Msg = Msg
        self.ID_BackToSchool = ID_BackToSchool
        self.SoBaoDanh = SoBaoDanh
        self.HoTen = HoTen
        self.CMND = CMND
        self.SDT = SDT
        self.NgaySinh = NgaySinh
        self.DiemTungMon = DiemTungMon
        self.DiemTrungBinh = DiemTrungBinh
        self.PhanTramGiamGia = PhanTramGiamGia
        self.Voucher = Voucher
        self.TinhTrangVoucher = TinhTrangVoucher
        self.Url_CMND_MT = Url_CMND_MT
        self.Url_CMND_MS = Url_CMND_MS
        self.Url_GiayBaoThi = Url_GiayBaoThi
        self.Allow_UploadImg = Allow_UploadImg
    }
    
    class func parseObjfromArray(array:[JSON])->[StudentBTSInfo]{
        var list:[StudentBTSInfo] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> StudentBTSInfo{
        var Result = data["Result"].int
        var Msg = data["Msg"].string
        var ID_BackToSchool = data["ID_BackToSchool"].int
        var SoBaoDanh = data["SoBaoDanh"].string
        var HoTen = data["HoTen"].string
        var CMND = data["CMND"].string
        var SDT = data["SDT"].string
        var NgaySinh = data["NgaySinh"].string
        
        var DiemTungMon = data["DiemTungMon"].array
        var DiemTrungBinh = data["DiemTrungBinh"].string
        var PhanTramGiamGia = data["PhanTramGiamGia"].string
        
        var Voucher = data["Voucher"].string
        var TinhTrangVoucher = data["TinhTrangVoucher"].string
        var Url_CMND_MT = data["Url_CMND_MT"].string
        var Url_CMND_MS = data["Url_CMND_MS"].string
        var Url_GiayBaoThi = data["Url_GiayBaoThi"].string
        var Allow_UploadImg = data["Allow_UploadImg"].int
        
        Result = Result == nil ? 0 : Result
        Msg = Msg == nil ? "" : Msg
        ID_BackToSchool = ID_BackToSchool == nil ? 0 : ID_BackToSchool
        SoBaoDanh = SoBaoDanh == nil ? "" : SoBaoDanh
        HoTen = HoTen == nil ? "" : HoTen
        CMND = CMND == nil ? "" : CMND
        SDT = SDT == nil ? "" : SDT
        NgaySinh = NgaySinh == nil ? "" : NgaySinh
        DiemTungMon = DiemTungMon == nil ? [] : DiemTungMon
        DiemTrungBinh = DiemTrungBinh == nil ? "" : DiemTrungBinh
        PhanTramGiamGia = PhanTramGiamGia == nil ? "" : PhanTramGiamGia
        
        Voucher = Voucher == nil ? "" : Voucher
        TinhTrangVoucher = TinhTrangVoucher == nil ? "" : TinhTrangVoucher
        Url_CMND_MT = Url_CMND_MT == nil ? "" : Url_CMND_MT
        Url_CMND_MS = Url_CMND_MS == nil ? "" : Url_CMND_MS
        Url_GiayBaoThi = Url_GiayBaoThi == nil ? "" : Url_GiayBaoThi
        Allow_UploadImg = Allow_UploadImg == nil ? 0 : Allow_UploadImg
        
        let DiemTungMonData = MonHocBTS.parseObjfromArray(array: DiemTungMon ?? [])
        
        return StudentBTSInfo(Result: Result!, Msg: Msg!, ID_BackToSchool: ID_BackToSchool!, SoBaoDanh: SoBaoDanh!, HoTen: HoTen!, CMND: CMND!, SDT: SDT!, NgaySinh: NgaySinh!, DiemTungMon: DiemTungMonData, DiemTrungBinh: DiemTrungBinh!, PhanTramGiamGia: PhanTramGiamGia!, Voucher: Voucher!, TinhTrangVoucher: TinhTrangVoucher!, Url_CMND_MT: Url_CMND_MT!, Url_CMND_MS: Url_CMND_MS!, Url_GiayBaoThi: Url_GiayBaoThi!, Allow_UploadImg:Allow_UploadImg!)
    }
    
}
