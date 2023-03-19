//
//  GetCRMPaymentHistoryThuHo.swift
//  mPOS
//
//  Created by sumi on 12/28/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetCRMPaymentHistoryTheNapResult: NSObject {
    var Bill_Code:String
    var MPOS: Int
    var TinhTrang_ThuTien: String
    var LoaiGiaoDich: String
    var SDT_KH: String
    var TongTienDaThu: Int
    var Tong_TienMat: Int
    var Tong_The: Int
    var Tong_VC: Int
    var GiaTri_VC: String
    var NhaMang: String
    var MenhGia: Int
    var LoaiDichVu: String
    var NCC: String
    var Is_Cash:Int
    var customerCode:String
    var customerName:String
    var ExpiredCard:String
    var NumberCode:String
    var SerialCard:String
    var CreatedDateTime:String
    var TongTienKhongPhi:Int
    var TongTienPhi:Int
    var U_Voucher:String
    var KyThanhToan:String
    var PhiCaThe:Int
    var mVoucher = [GetCRMPaymentHistoryVoucherResult]()
    var MaGD:String
    var NgayHetHan:String
    var NVGD: String
    var Type_LoaiDichVu:Int
    var SLThe:Int
    var NameCard: String
    var Is_HDCty:Int
    
    init(Bill_Code:String, MPOS: Int, TinhTrang_ThuTien: String, LoaiGiaoDich: String, SDT_KH: String, TongTienDaThu: Int, Tong_TienMat: Int, Tong_The: Int, Tong_VC: Int, GiaTri_VC: String, NhaMang: String, MenhGia: Int, LoaiDichVu: String, NCC: String, Is_Cash:Int, customerCode:String, customerName:String, ExpiredCard:String, NumberCode:String, SerialCard:String, CreatedDateTime:String, TongTienKhongPhi:Int, TongTienPhi:Int, U_Voucher:String,  KyThanhToan:String, PhiCaThe:Int, mVoucher:[GetCRMPaymentHistoryVoucherResult],MaGD:String, NgayHetHan:String, NVGD: String, Type_LoaiDichVu:Int, SLThe:Int, NameCard: String, Is_HDCty:Int){
        self.Bill_Code = Bill_Code
        self.MPOS = MPOS
        self.TinhTrang_ThuTien = TinhTrang_ThuTien
        self.LoaiGiaoDich = LoaiGiaoDich
        self.SDT_KH = SDT_KH
        self.TongTienDaThu = TongTienDaThu
        self.Tong_TienMat = Tong_TienMat
        self.Tong_The = Tong_The
        self.Tong_VC = Tong_VC
        self.GiaTri_VC = GiaTri_VC
        self.NhaMang = NhaMang
        self.MenhGia = MenhGia
        self.LoaiDichVu = LoaiDichVu
        self.NCC = NCC
        self.Is_Cash = Is_Cash
        self.customerCode = customerCode
        self.customerName = customerName
        self.ExpiredCard = ExpiredCard
        self.NumberCode = NumberCode
        self.SerialCard = SerialCard
        self.CreatedDateTime = CreatedDateTime
        self.TongTienKhongPhi = TongTienKhongPhi
        self.TongTienPhi = TongTienPhi
        self.U_Voucher = U_Voucher
        self.KyThanhToan = KyThanhToan
        self.PhiCaThe = PhiCaThe
        self.mVoucher = mVoucher
        self.MaGD = MaGD
        self.NgayHetHan = NgayHetHan
        self.NVGD = NVGD
        self.Type_LoaiDichVu = Type_LoaiDichVu
        self.SLThe = SLThe
        self.NameCard = NameCard
        self.Is_HDCty = Is_HDCty
    }
    class func parseObjfromArray(array:[JSON])->[GetCRMPaymentHistoryTheNapResult]{
        var list:[GetCRMPaymentHistoryTheNapResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item ))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> GetCRMPaymentHistoryTheNapResult{
        var MPOS = data["MPOS"].int
        var TinhTrang_ThuTien = data["TinhTrang_ThuTien"].string
        var LoaiGiaoDich = data["LoaiGiaoDich"].string
        
        MPOS = MPOS == nil ? 0 : MPOS
        TinhTrang_ThuTien = TinhTrang_ThuTien == nil ? "" : TinhTrang_ThuTien
        LoaiGiaoDich = LoaiGiaoDich == nil ? "" : LoaiGiaoDich
        
        var SDT_KH = data["SDT_KH"].string
        var  TongTienDaThu = data["TongTienDaThu"].int
        var Tong_TienMat = data["Tong_TienMat"].int
        
        SDT_KH = SDT_KH == nil ? "" : SDT_KH
        TongTienDaThu = TongTienDaThu == nil ? 0 : TongTienDaThu
        Tong_TienMat = Tong_TienMat == nil ? 0 : Tong_TienMat
        
        var Tong_The = data["Tong_The"].int
        var  Tong_VC = data["Tong_VC"].int
        
        Tong_The = Tong_The == nil ? 0 : Tong_The
        Tong_VC = Tong_VC == nil ? 0 : Tong_VC
        
        var  GiaTri_VC = data["GiaTri_VC"].string
        var NhaMang = data["NhaMang"].string
        
        GiaTri_VC = GiaTri_VC == nil ? "" : GiaTri_VC
        NhaMang = NhaMang == nil ? "" : NhaMang
        
        var MenhGia = data["MenhGia"].int
        var LoaiDichVu = data["LoaiDichVu"].string
        var NCC = data["NCC"].string
        
        MenhGia = MenhGia == nil ? 0 : MenhGia
        LoaiDichVu = LoaiDichVu == nil ? "" : LoaiDichVu
        NCC = NCC == nil ? "" : NCC
        
        var Is_Cash = data["Is_Cash"].int
        var customerCode = data["customerCode"].string
        var customerName = data["customerName"].string
        
        Is_Cash = Is_Cash == nil ? 0 : Is_Cash
        customerCode = customerCode == nil ? "" : customerCode
        customerName = customerName == nil ? "" : customerName
        
        var Bill_Code = data["Bill_Code"].string
        var ExpiredCard = data["ExpiredCard"].string
        var NumberCode = data["NumberCode"].string
        
        Bill_Code = Bill_Code == nil ? "" : Bill_Code
        ExpiredCard = ExpiredCard == nil ? "" : ExpiredCard
        NumberCode = NumberCode == nil ? "" : NumberCode
        
        var SerialCard = data["SerialCard"].string
        var CreatedDateTime = data["CreatedDateTime"].string
        var TongTienKhongPhi = data["TongTienKhongPhi"].int
        
        SerialCard = SerialCard == nil ? "" : SerialCard
        CreatedDateTime = CreatedDateTime == nil ? "" : CreatedDateTime
        TongTienKhongPhi = TongTienKhongPhi == nil ? 0 : TongTienKhongPhi
        
        var TongTienPhi = data["TongTienPhi"].int
        var U_Voucher = data["U_Voucher"].string
        
        TongTienPhi = TongTienPhi == nil ? 0 : TongTienPhi
        U_Voucher = U_Voucher == nil ? "" : U_Voucher
        
        var KyThanhToan = data["KyThanhToan"].string
        var PhiCaThe = data["PhiCaThe"].int
        var taskDataVoucher = data["Vouchers"].array
        
        KyThanhToan = KyThanhToan == nil ? "" : KyThanhToan
        PhiCaThe = PhiCaThe == nil ? 0 : PhiCaThe
        taskDataVoucher = taskDataVoucher == nil ? [] : taskDataVoucher
        
        var MaGD = data["MaGD"].string
        MaGD = MaGD == nil ? "" : MaGD
        
        var NgayHetHan = data["NgayHetHan"].string
        NgayHetHan = NgayHetHan == nil ? "" : NgayHetHan
        
        var NVGD = data["NVGD"].string
        NVGD = NVGD == nil ? "" : NVGD
        var Type_LoaiDichVu = data["Type_LoaiDichVu"].int
        Type_LoaiDichVu = Type_LoaiDichVu == nil ? 0 : Type_LoaiDichVu
        var SLThe = data["SLThe"].int
        SLThe = SLThe == nil ? 0 : SLThe
        var NameCard = data["NameCard"].string
        NameCard = NameCard == nil ? "" : NameCard
        var Is_HDCty = data["Is_HDCty"].int
        Is_HDCty = Is_HDCty == nil ? 0 : Is_HDCty
        
        let mVoucher = GetCRMPaymentHistoryVoucherResult.parseObjfromArray(array: taskDataVoucher!)
        
        return GetCRMPaymentHistoryTheNapResult(Bill_Code:Bill_Code!, MPOS: MPOS!, TinhTrang_ThuTien: TinhTrang_ThuTien!, LoaiGiaoDich: LoaiGiaoDich!, SDT_KH: SDT_KH!, TongTienDaThu: TongTienDaThu!, Tong_TienMat: Tong_TienMat!, Tong_The: Tong_The!, Tong_VC: Tong_VC!, GiaTri_VC: GiaTri_VC!, NhaMang: NhaMang!, MenhGia: MenhGia!, LoaiDichVu: LoaiDichVu!, NCC: NCC!, Is_Cash:Is_Cash!, customerCode:customerCode!, customerName:customerName!, ExpiredCard:ExpiredCard!, NumberCode:NumberCode!, SerialCard:SerialCard!, CreatedDateTime:CreatedDateTime!, TongTienKhongPhi:TongTienKhongPhi!, TongTienPhi:TongTienPhi!, U_Voucher:U_Voucher!, KyThanhToan:KyThanhToan!, PhiCaThe:PhiCaThe!, mVoucher:mVoucher,MaGD:MaGD!, NgayHetHan: NgayHetHan!, NVGD: NVGD!, Type_LoaiDichVu:Type_LoaiDichVu!, SLThe:SLThe!, NameCard:NameCard!, Is_HDCty:Is_HDCty!)
    }
}

