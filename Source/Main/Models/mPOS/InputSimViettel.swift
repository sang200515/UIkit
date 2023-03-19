//
//  InputSimViettel.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class InputSimViettel: NSObject {
    
    var p_Duong: String
    var p_Phuong: String
    var p_Quan: String
    var p_Tinh: String
    var p_QuocTich: String
    var ChuKy: String
    var p_SoPhieuYeuCau: String
    var p_TenKH: String
    var p_NgaySinh_KH: String
    
    var p_GioiTinh_KH: String
    var p_SoCMND_KH: String
    var p_NoiCap_CMND_KH: String
    var p_NgayCap_CMND_KH: String
    var p_DiaChi_CMND_KH: String
    var p_GoiCuocDK_Line1: String
    var p_SoThueBao_Line1: String
    var p_SoSerialSim_Imei_Line1: String
    var p_Visa: String
    
    var strBase64CMNDTruoc:String
    var strBase64CMNDSau:String
    var strBase64Avatar:String
    
    var Nationality:String
    
    var simActive:SimActive
    var ProvinceCode:String
    var DistrictCode:String
    var PrecinctCode:String
    var contractNo:String
    var LoaiGiayTo:String
    var Passport:String
    var DayGrantPassport:String
    var NoiCapPassport:String
    var gtInt:String
    
    init(p_Duong: String, p_Phuong: String, p_Quan: String, p_Tinh: String, p_QuocTich: String, ChuKy: String, p_SoPhieuYeuCau: String, p_TenKH: String, p_NgaySinh_KH: String,p_GioiTinh_KH: String, p_SoCMND_KH: String, p_NoiCap_CMND_KH: String, p_NgayCap_CMND_KH: String, p_DiaChi_CMND_KH: String, p_GoiCuocDK_Line1: String, p_SoThueBao_Line1: String, p_SoSerialSim_Imei_Line1: String, p_Visa: String,strBase64CMNDTruoc:String, strBase64CMNDSau:String, strBase64Avatar:String,simActive:SimActive,Nationality:String,ProvinceCode:String,DistrictCode:String,PrecinctCode:String,contractNo:String,LoaiGiayTo:String,Passport:String,DayGrantPassport:String,NoiCapPassport:String,gtInt:String){
        self.p_Duong = p_Duong
        self.p_Phuong = p_Phuong
        self.p_Quan = p_Quan
        self.p_Tinh = p_Tinh
        self.p_QuocTich = p_QuocTich
        self.ChuKy = ChuKy
        self.p_SoPhieuYeuCau = p_SoPhieuYeuCau
        self.p_TenKH = p_TenKH
        self.p_NgaySinh_KH = p_NgaySinh_KH
        
        self.p_GioiTinh_KH = p_GioiTinh_KH
        self.p_SoCMND_KH = p_SoCMND_KH
        self.p_NoiCap_CMND_KH = p_NoiCap_CMND_KH
        self.p_NgayCap_CMND_KH = p_NgayCap_CMND_KH
        self.p_DiaChi_CMND_KH = p_DiaChi_CMND_KH
        self.p_GoiCuocDK_Line1 = p_GoiCuocDK_Line1
        self.p_SoThueBao_Line1 = p_SoThueBao_Line1
        self.p_SoSerialSim_Imei_Line1 = p_SoSerialSim_Imei_Line1
        self.p_Visa = p_Visa
        self.strBase64CMNDTruoc = strBase64CMNDTruoc
        self.strBase64CMNDSau = strBase64CMNDSau
        self.strBase64Avatar = strBase64Avatar
        self.simActive = simActive
        self.Nationality = Nationality
        self.ProvinceCode = ProvinceCode
        self.DistrictCode  = DistrictCode
        self.PrecinctCode = PrecinctCode
        self.contractNo = contractNo
        self.LoaiGiayTo = LoaiGiayTo
        self.Passport = Passport
        self.DayGrantPassport = DayGrantPassport
        self.NoiCapPassport = NoiCapPassport
        self.gtInt = gtInt
    }
    
}
