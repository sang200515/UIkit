//
//  PrintBillThuHo.swift
//  mPOS
//
//  Created by sumi on 5/24/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//
///just edit
import UIKit

class BillParamGalaxyPay: NSObject {
    var BillCode:String
    var TransactionCode: String
    var ThoiGianThu: String
    var ServiceName: String
    var ProVideName: String
    var PayerMobiphone: String
    var GoiDichVu: String
    var ThoiHanGoi: String
    var GiaGoi: String
    var Paymentfee: String
    var TotalAmouth: String
    var HanSuDung: String
    var Employname:String
    var Createby: String
    var ShopAddress: String
    var MaVoucher: String
    //
    init(BillCode:String, TransactionCode: String, ThoiGianThu: String
      , ServiceName: String
      , ProVideName: String
      , PayerMobiphone: String
      , GoiDichVu: String
      , ThoiHanGoi: String
      , GiaGoi: String
      , Paymentfee: String
      , TotalAmouth: String
      , HanSuDung: String
      , Employname:String
      , Createby: String
      , ShopAddress: String
      , MaVoucher: String) {
        self.BillCode = BillCode
        self.TransactionCode = TransactionCode
        self.ThoiGianThu = ThoiGianThu
        self.ServiceName = ServiceName
        self.ProVideName = ProVideName
        self.PayerMobiphone = PayerMobiphone
        self.GoiDichVu = GoiDichVu
        self.ThoiHanGoi = ThoiHanGoi
        self.GiaGoi = GiaGoi
        self.Paymentfee = Paymentfee
        self.TotalAmouth = TotalAmouth
        self.HanSuDung = HanSuDung
        self.Employname = Employname
        self.Createby = Createby
        self.ShopAddress = ShopAddress
        self.MaVoucher = MaVoucher
        
    }
}
extension BillParamGalaxyPay {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "BillCode": self.BillCode,
            "TransactionCode": self.TransactionCode,
            "ThoiGianThu":self.ThoiGianThu,
            "ServiceName":self.ServiceName,
            "ProVideName":self.ProVideName,
            "PayerMobiphone":self.PayerMobiphone,
            "GoiDichVu":self.GoiDichVu,
            "ThoiHanGoi":self.ThoiHanGoi,
            "GiaGoi":self.GiaGoi,
            "Paymentfee":self.Paymentfee,
            "TotalAmouth":self.TotalAmouth,
            "HanSuDung":self.HanSuDung,
            "Employname":self.Employname,
            "Createby":self.Createby,
            "ShopAddress":self.ShopAddress,
            "MaVoucher":self.MaVoucher
        ]
    }
}



