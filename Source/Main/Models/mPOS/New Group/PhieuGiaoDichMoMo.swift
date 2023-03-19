//
//  PhieuGiaoDichMoMo.swift
//  mPOS
//
//  Created by tan on 12/11/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

//momo
import Foundation
import SwiftyJSON
class PhieuGiaoDichMoMo: NSObject {
    var p_status: Int
    var p_messagess:String
    var SOMPOS:String
    var SoPhieu:String
    var PhoneNumber:String
    var Email:String
    var CardName:String
    var NgayGiaoDich:String
    var DocTotal:Int
    var Status:String
    var TrangThai:String
    var NhanVien:String
    var MaNhanVien:String
    var Note:String
    var LoaiGiaoDich:String
    var DocType:String
    var Fee:Float
    var U_voucher:String
    var NgayHetHan:String
    
    init(p_status: Int
        , p_messagess:String
        , SOMPOS:String
        , SoPhieu:String
        , PhoneNumber:String
        , Email:String
        , CardName:String
        , NgayGiaoDich:String
        , DocTotal:Int
        , Status:String
        , TrangThai:String
        , NhanVien:String
        , MaNhanVien:String
        , Note:String
        , LoaiGiaoDich:String
        , DocType:String
        , Fee:Float
        , U_voucher:String
        , NgayHetHan:String){
        
        
        self.p_status = p_status
        self.p_messagess = p_messagess
        self.SOMPOS = SOMPOS
        self.SoPhieu = SoPhieu
        self.PhoneNumber = PhoneNumber
        self.Email = Email
        self.CardName = CardName
        self.NgayGiaoDich = NgayGiaoDich
        self.DocTotal = DocTotal
        self.Status = Status
        self.TrangThai = TrangThai
        self.NhanVien = NhanVien
        self.MaNhanVien = MaNhanVien
        self.Note = Note
        self.LoaiGiaoDich = LoaiGiaoDich
        self.DocType = DocType
        self.Fee = Fee
        self.U_voucher = U_voucher
        self.NgayHetHan = NgayHetHan
        
        
        
    }
    
    
    
    
    class func parseObjfromArray(array:[JSON])->[PhieuGiaoDichMoMo]{
        var list:[PhieuGiaoDichMoMo] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> PhieuGiaoDichMoMo{
        var p_status = data["p_status"].int
        var p_messagess = data["p_messagess"].string
        var SOMPOS = data["SOMPOS"].string
        var SoPhieu = data["SoPhieu"].string
        var PhoneNumber = data["PhoneNumber"].string
        var Email = data["Email"].string
        var CardName = data["CardName"].string
        var NgayGiaoDich = data["NgayGiaoDich"].string
        var DocTotal = data["DocTotal"].int
        var Status = data["Status"].string
        var TrangThai = data["TrangThai"].string
        var NhanVien = data["NhanVien"].string
        var MaNhanVien = data["MaNhanVien"].string
        var Note = data["Note"].string
        var LoaiGiaoDich = data["LoaiGiaoDich"].string
        var DocType = data["DocType"].string
        var Fee = data["Fee"].float
        var U_voucher = data["U_voucher"].string
        var NgayHetHan = data["NgayHetHan"].string
        
        
        p_status = p_status == nil ? 0 : p_status
        p_messagess = p_messagess == nil ? "" : p_messagess
        SOMPOS = SOMPOS == nil ? "" : SOMPOS
        SoPhieu = SoPhieu == nil ? "" : SoPhieu
        PhoneNumber = PhoneNumber == nil ? "" : PhoneNumber
        Email = Email == nil ? "" : Email
        CardName = CardName == nil ? "" : CardName
        NgayGiaoDich = NgayGiaoDich == nil ? "" : NgayGiaoDich
        DocTotal = DocTotal == nil ? 0 : DocTotal
        Status = Status == nil ? "" : Status
        TrangThai = TrangThai == nil ? "" : TrangThai
        NhanVien = NhanVien == nil ? "" : NhanVien
        MaNhanVien = MaNhanVien == nil ? "" : MaNhanVien
        Note = Note == nil ? "" : Note
        LoaiGiaoDich = LoaiGiaoDich == nil ? "" : LoaiGiaoDich
        DocType = DocType == nil ? "" : DocType
        Fee = Fee == nil ? 0 : Fee
        U_voucher = U_voucher == nil ? "" : U_voucher
        NgayHetHan = NgayHetHan == nil ? "" : NgayHetHan
        return PhieuGiaoDichMoMo(p_status: p_status!
            , p_messagess:p_messagess!
            , SOMPOS:SOMPOS!
            , SoPhieu:SoPhieu!
            ,PhoneNumber: PhoneNumber!
            , Email:Email!
            , CardName:CardName!
            , NgayGiaoDich:NgayGiaoDich!
            , DocTotal:DocTotal!
            , Status:Status!
            , TrangThai:TrangThai!
            , NhanVien:NhanVien!
            , MaNhanVien:MaNhanVien!
            , Note:Note!
            , LoaiGiaoDich:LoaiGiaoDich!
            , DocType:DocType!
            , Fee:Fee!
            ,U_voucher:U_voucher!
            ,NgayHetHan:NgayHetHan!)
    }
    
    
}
