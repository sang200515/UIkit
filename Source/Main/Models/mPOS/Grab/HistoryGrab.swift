//
//  HistoryGrab.swift
//  fptshop
//
//  Created by tan on 5/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class HistoryGrab: NSObject {
    var Createby:String
    var TrangThai:String
    var customerPhone:String
    var HinhThuc:String
    var systemTrace:String
    var NgayHoanTat:String
    var customerName:String
    var Docentry:Int
    var TinhTrangThuTien:String
    var Hinhthucthanhtoan:String
    var MaGD_NCC:String
    var NV:String
    var addingInput:String
    var moneyAmount:Int
    var customerId:String
    var U_Voucher:String
 
    
    
    init(   Createby:String
    , TrangThai:String
    , customerPhone:String
    , HinhThuc:String
    , systemTrace:String
    , NgayHoanTat:String
    , customerName:String
    , Docentry:Int
    , TinhTrangThuTien:String
    , Hinhthucthanhtoan:String
    , MaGD_NCC:String
    , NV:String
        , addingInput:String
        ,moneyAmount:Int
        ,customerId:String
        ,U_Voucher:String){
        self.Createby = Createby
        self.TrangThai = TrangThai
        self.customerPhone = customerPhone
        self.HinhThuc = HinhThuc
        self.systemTrace = systemTrace
        self.NgayHoanTat = NgayHoanTat
        self.customerName = customerName
        self.Docentry = Docentry
        self.TinhTrangThuTien = TinhTrangThuTien
        self.Hinhthucthanhtoan = Hinhthucthanhtoan
        self.MaGD_NCC = MaGD_NCC
        self.NV = NV
        self.addingInput = addingInput
        self.moneyAmount = moneyAmount
        self.customerId = customerId
        self.U_Voucher = U_Voucher
    
    }
    
    class func parseObjfromArray(array:[JSON])->[HistoryGrab]{
        var list:[HistoryGrab] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> HistoryGrab{
        
        var Createby = data["Createby"].string
        var TrangThai = data["TrangThai"].string
        var customerPhone = data["customerPhone"].string
        var HinhThuc = data["HinhThuc"].string
        var systemTrace = data["systemTrace"].string
        var NgayHoanTat = data["NgayHoanTat"].string
        var customerName = data["customerName"].string
        var Docentry = data["Docentry"].int
        var TinhTrangThuTien = data["TinhTrangThuTien"].string
        var Hinhthucthanhtoan = data["Hinhthucthanhtoan"].string
        var MaGD_NCC = data["MaGD_NCC"].string
        var NV = data["NV"].string
        var addingInput = data["addingInput"].string
        var moneyAmount = data["moneyAmount"].int
        var customerId = data["customerId"].string
        var U_Voucher = data["U_Voucher"].string
      
        
        Createby = Createby == nil ? "" : Createby
        TrangThai = TrangThai == nil ? "" : TrangThai
        customerPhone = customerPhone == nil ? "" : customerPhone
        HinhThuc = HinhThuc == nil ? "" : HinhThuc
        systemTrace = systemTrace == nil ? "" : systemTrace
        NgayHoanTat = NgayHoanTat == nil ? "" : NgayHoanTat
        
         customerName = customerName == nil ? "" : customerName
         Docentry = Docentry == nil ? 0 : Docentry
         TinhTrangThuTien = TinhTrangThuTien == nil ? "" : TinhTrangThuTien
        Hinhthucthanhtoan = Hinhthucthanhtoan == nil ? "" : Hinhthucthanhtoan
        MaGD_NCC = MaGD_NCC == nil ? "" : MaGD_NCC
         NV = NV == nil ? "" : NV
        addingInput = addingInput == nil ? "" : addingInput
        moneyAmount = moneyAmount == nil ? 0 : moneyAmount
        customerId = customerId == nil ? "" : customerId
        U_Voucher = U_Voucher == nil ? "" : U_Voucher
        
        return HistoryGrab(Createby: Createby!,TrangThai:TrangThai!,customerPhone:customerPhone!,HinhThuc:HinhThuc!,systemTrace:systemTrace!,NgayHoanTat:NgayHoanTat!,customerName:customerName!,Docentry:Docentry!,TinhTrangThuTien:TinhTrangThuTien!,Hinhthucthanhtoan:Hinhthucthanhtoan!,MaGD_NCC:MaGD_NCC!,NV:NV!,addingInput:addingInput!,moneyAmount:moneyAmount!,customerId:customerId!,U_Voucher:U_Voucher!
        )
    }
}
