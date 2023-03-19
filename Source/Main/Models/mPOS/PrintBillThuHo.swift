//
//  PrintBillThuHo.swift
//  mPOS
//
//  Created by sumi on 5/24/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//
///just edit
import UIKit

class PrintBillThuHo: NSObject {
    var BillCode:String
    var TransactionCode: String
    var ServiceName:String
    var ProVideName:String
    var NhaCungCap: String
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
    var ShopAddress:String
    var ThoiGianXuat:String
    var MaVoucher:String
    var HanSuDung:String
    var PhiCaThe:String
    //
    init(BillCode:String, TransactionCode: String, ServiceName:String, ProVideName:String, NhaCungCap: String, Customernamne:String, Customerpayoo:String, PayerMobiphone:String, Address:String, BillID:String, Month:String, TotalAmouth:String, Paymentfee:String, Employname:String, Createby:String, ShopAddress:String,ThoiGianXuat:String,MaVoucher:String,HanSuDung:String,PhiCaThe:String) {
        self.BillCode = BillCode
        self.TransactionCode = TransactionCode
        self.ServiceName = ServiceName
        self.ProVideName = ProVideName
        self.NhaCungCap = NhaCungCap
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
        self.ShopAddress = ShopAddress
        self.ThoiGianXuat = ThoiGianXuat
        self.MaVoucher = MaVoucher
        self.HanSuDung = HanSuDung
        self.PhiCaThe = PhiCaThe
        
    }
}
extension PrintBillThuHo {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "BillCode": self.BillCode,
            "TransactionCode": self.TransactionCode,
            "ServiceName": self.ServiceName,
            "ProVideName": self.ProVideName,
            "NhaCungCap": self.NhaCungCap,
            "Customernamne": self.Customernamne,
            "Customerpayoo": self.Customerpayoo,
            "PayerMobiphone": self.PayerMobiphone,
            "Address": self.Address,
            
            "BillID": self.BillID,
            "Month": self.Month,
            "TotalAmouth": self.TotalAmouth,
            "Paymentfee": self.Paymentfee,
            "Employname": self.Employname,
            "Createby": self.Createby,
            "ShopAddress": self.ShopAddress,
            "ThoiGianXuat":self.ThoiGianXuat,
            "MaVoucher":self.MaVoucher,
            "HanSuDung":self.HanSuDung,
            "PhiCaThe": self.PhiCaThe,
            "GoiDichVu": "",
            "GiaGoi": "0"
        ]
    }
}



