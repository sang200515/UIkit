//
//  HistoryFFriend.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class HistoryFFriend: NSObject {
    
    var IDDK: Int
    var ThanhTien: Float
    var SoTienTraTruoc: Float
    var SoTienConNo: Float
    var TrangThai: String
    var TenShop: String
    var NhomMua: String
    var NoGoc: Float
    var SoTienDaThanhToan: Float
    var Status: String
    var LoaiDHSS: String
    var Flag: String
    var SOmPOS: String
    var KyHan: Int
    var HinhThucThuTien: String
    var SoTienThanhToanHangThang: Float
    var Is_Credit: Bool
    var CallogID: Int
    var ID_Final:String
    var SoSO_POS:String
    var HinhThucGH :Int
    var Flag_Ecom :Int
    var Flag_Image_ChungTuDoiTra:Int
    var Flag_album:Int
    
    init(IDDK: Int,ThanhTien: Float,SoTienTraTruoc: Float,SoTienConNo: Float,TrangThai: String,TenShop: String,NhomMua: String,NoGoc: Float,SoTienDaThanhToan: Float,Status: String,LoaiDHSS: String,Flag: String,SOmPOS: String,KyHan: Int,HinhThucThuTien: String,SoTienThanhToanHangThang: Float,Is_Credit: Bool,CallogID: Int,ID_Final:String,SoSO_POS:String,HinhThucGH:Int,Flag_Ecom :Int,Flag_Image_ChungTuDoiTra:Int,Flag_album:Int){
        self.IDDK = IDDK
        self.ThanhTien = ThanhTien
        self.SoTienTraTruoc = SoTienTraTruoc
        self.SoTienConNo = SoTienConNo
        self.TrangThai = TrangThai
        self.TenShop = TenShop
        self.NhomMua = NhomMua
        self.NoGoc = NoGoc
        self.SoTienDaThanhToan = SoTienDaThanhToan
        self.Status = Status
        self.LoaiDHSS = LoaiDHSS
        self.Flag = Flag
        self.SOmPOS = SOmPOS
        self.KyHan = KyHan
        self.HinhThucThuTien = HinhThucThuTien
        self.SoTienThanhToanHangThang = SoTienThanhToanHangThang
        self.Is_Credit = Is_Credit
        self.CallogID = CallogID
        self.ID_Final = ID_Final
        self.SoSO_POS = SoSO_POS
        self.HinhThucGH = HinhThucGH
        self.Flag_Ecom = Flag_Ecom
        self.Flag_Image_ChungTuDoiTra = Flag_Image_ChungTuDoiTra
        self.Flag_album = Flag_album
    }
    class func parseObjfromArray(array:[JSON])->[HistoryFFriend]{
        var list:[HistoryFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> HistoryFFriend{
        
        var idDK = data["IDDK"] .int
        var thanhTien = data["ThanhTien"].float
        var soTienTraTruoc = data["SoTienTraTruoc"].float
        var soTienConNo = data["SoTienConNo"].float
        var trangThai = data["TrangThai"].string
        
        var tenShop = data["TenShop"].string
        var nhomMua = data["NhomMua"].string
        var noGoc = data["SoTienTraNoGocTruoc"].float
        var soTienDaThanhToan = data["SoTienDaThanhToan"].float
        var status = data["Status"].string
        var loaiDHSS = data["LoaiDHSS"].string
        
        var flag = data["Flag"].string
        var somPOS = data["SOmPOS"].string
        var kyHan = data["KyHan"] .int
        var hinhThucThuTien = data["HinhThucThuTien"].string
        var soTienThanhToanHangThang = data["SoTienThanhToanHangThang"].float
        var is_Credit = data["Is_Credit"].bool
        var callogID = data["CallogID"] .int
        var id_Final = data["ID_Final"].string
        var soSO_POS = data["SoSO_POS"].string
        var hinhThucGH = data["HinhThucGH"] .int
        
        var flag_Ecom = data["Flag_Ecom"] .int
        var flag_Image_ChungTuDoiTra = data["Flag_Image_ChungTuDoiTra"] .int
        var Flag_album = data["Flag_album"].int
        
        
        idDK = idDK == nil ? 0 : idDK
        thanhTien = thanhTien == nil ? 0 : thanhTien
        soTienTraTruoc = soTienTraTruoc == nil ? 0 : soTienTraTruoc
        soTienConNo = soTienConNo == nil ? 0 : soTienConNo
        trangThai = trangThai == nil ? "" : trangThai
        
        tenShop = tenShop == nil ? "" : tenShop
        nhomMua = nhomMua == nil ? "" : nhomMua
        noGoc = noGoc == nil ? 0 : noGoc
        soTienDaThanhToan = soTienDaThanhToan == nil ? 0 : soTienDaThanhToan
        status = status == nil ? "" : status
        loaiDHSS = loaiDHSS == nil ? "" : loaiDHSS
        
        flag = flag == nil ? "" : flag
        somPOS = somPOS == nil ? "" : somPOS
        kyHan = kyHan == nil ? 0 : kyHan
        hinhThucThuTien = hinhThucThuTien == nil ? "M" : hinhThucThuTien
        soTienThanhToanHangThang = soTienThanhToanHangThang == nil ? 0 : soTienThanhToanHangThang
        is_Credit = is_Credit == nil ? false : is_Credit
        callogID = callogID == nil ? 0 : callogID
        id_Final = id_Final == nil ? "" : id_Final
        soSO_POS = soSO_POS == nil ? "" : soSO_POS
        hinhThucGH = hinhThucGH == nil ? 0 : hinhThucGH
        flag_Ecom = flag_Ecom == nil ? 0 : flag_Ecom
        Flag_album = Flag_album == nil ? 0 : Flag_album
        
        flag_Image_ChungTuDoiTra = flag_Image_ChungTuDoiTra == nil ? 0 : flag_Image_ChungTuDoiTra
        return HistoryFFriend(IDDK: idDK!,ThanhTien: thanhTien!,SoTienTraTruoc: soTienTraTruoc!,SoTienConNo: soTienConNo!,TrangThai: trangThai!,TenShop: tenShop!,NhomMua: nhomMua!,NoGoc: noGoc!,SoTienDaThanhToan: soTienDaThanhToan!,Status: status!,LoaiDHSS: loaiDHSS!,Flag: flag!,SOmPOS: somPOS!,KyHan: kyHan!,HinhThucThuTien: hinhThucThuTien!,SoTienThanhToanHangThang: soTienThanhToanHangThang!,Is_Credit:is_Credit!,CallogID: callogID!,ID_Final:id_Final!,SoSO_POS:soSO_POS!,HinhThucGH:hinhThucGH!,Flag_Ecom:flag_Ecom!,Flag_Image_ChungTuDoiTra:flag_Image_ChungTuDoiTra!,Flag_album:Flag_album!)
    }
}

