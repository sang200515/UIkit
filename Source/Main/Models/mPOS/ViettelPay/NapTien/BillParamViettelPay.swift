//
//  BillParamThuHo.swift
//  mPOS
//
//  Created by tan on 10/3/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class BillParamViettelPay: NSObject{
    var BillCode:String
    var TransactionCode:String
    var ServiceName:String
    var ProVideName:String
    var Customernamne:String
    var Customerpayoo:String
    var PayerMobiphone:String
    var Address:String
    var BillID:String
    var Month:String
    var TotalAmouth:String
    var Paymentfee:String
    var Employname:String
    var Createby:String
    var MaVoucher:String
    var HanSuDung:String
    var ShopAddress:String
    var ThoiGianXuat:String
    var PhiCaThe:String
    var dichVu: String
    var NhaCungCap: String = ""
    var GoiDichVu: String = ""
    var GiaGoi: String = ""
    var desService: String = ""
    
    init(  BillCode:String
       , TransactionCode:String
       , ServiceName:String
       , ProVideName:String
       , Customernamne:String
       , Customerpayoo:String
       , PayerMobiphone:String
       , Address:String
       , BillID:String
       , Month:String
       , TotalAmouth:String
       , Paymentfee:String
       , Employname:String
       , Createby:String
       , MaVoucher:String
       , HanSuDung:String
       , ShopAddress:String
       , ThoiGianXuat:String
       , PhiCaThe:String
       , dichVu: String
       , NhaCungCap: String = ""
       , GoiDichVu: String = ""
       , GiaGoi: String = "0"){
        
        self.BillCode = BillCode
        self.TransactionCode = TransactionCode
        self.ServiceName = ServiceName
        self.ProVideName = ProVideName
        self.Customernamne = Customernamne
        self.Customerpayoo = Customerpayoo
        self.PayerMobiphone = PayerMobiphone
        self.Address = Address
        self.BillID = BillID
        
        self.Month = Month
        self.TotalAmouth = TotalAmouth
        self.Paymentfee = Paymentfee
        self.Employname = Employname
        self.Createby = Createby
        self.MaVoucher = MaVoucher
        self.HanSuDung = HanSuDung
        self.ShopAddress = ShopAddress
        self.ThoiGianXuat = ThoiGianXuat
        self.PhiCaThe = PhiCaThe
        self.dichVu = dichVu
        self.GoiDichVu = GoiDichVu
        self.NhaCungCap = NhaCungCap
        self.GiaGoi = GiaGoi
    }
}
extension BillParamViettelPay {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "BillCode" : self.BillCode,
            "TransactionCode" : self.TransactionCode,
            "ServiceName" : desService != "" ? desService : "Nạp tiền tài khoản Viettel Pay",
            "ProVideName" : self.ProVideName,
            "Customernamne": self.Customernamne,
            "PayerMobiphone": self.PayerMobiphone,
            "Address": self.Address,
            "BillID" : self.BillID,
            "Month" : self.Month,
            "TotalAmouth" : self.TotalAmouth,
            "Paymentfee" : self.Paymentfee,
            "Employname" : self.Employname,
            "Createby" : self.Createby,
            "MaVoucher" : self.MaVoucher,
            "HanSuDung" : self.HanSuDung,
            "ShopAddress" : self.ShopAddress,
            "ThoiGianXuat":self.ThoiGianXuat,
            "PhiCaThe":self.PhiCaThe,
            "Customerpayoo": self.Customerpayoo,
            "NhaCungCap": self.NhaCungCap,
            "GoiDichVu": self.GoiDichVu,
            "GiaGoi": self.GiaGoi,
        ]
    }
}
