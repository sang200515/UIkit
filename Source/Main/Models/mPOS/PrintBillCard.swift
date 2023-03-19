//
//  PrintBillSoftware.swift
//  mPOS
//
//  Created by MinhDH on 4/18/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class PrintBillCard: NSObject {
    var Address:String
    var CardType: String
    var FaceValue:String
    var NumberCode:String
    var Serial: String
    var ExpirationDate:String
    var ExportTime:String
    var SaleOrderCode:String
    var UserCode:String
    var MaVoucher:String
    var HanSuDung:String
    
    
    init(Address:String, CardType: String, FaceValue:String, NumberCode:String, Serial: String, ExpirationDate:String, ExportTime:String, SaleOrderCode:String, UserCode:String,MaVoucher:String,HanSuDung:String) {
        self.Address = Address
        self.CardType = CardType
        self.FaceValue = FaceValue
        self.NumberCode = NumberCode
        self.Serial = Serial
        self.ExpirationDate = ExpirationDate
        self.ExportTime = ExportTime
        self.SaleOrderCode = SaleOrderCode
        self.UserCode = UserCode
        self.MaVoucher = MaVoucher
        self.HanSuDung = HanSuDung
    }
}
extension PrintBillCard {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "Address": self.Address,
            "CardType": self.CardType,
            "FaceValue": self.FaceValue,
            "NumberCode": self.NumberCode,
            "Serial": self.Serial,
            "ExpirationDate": self.ExpirationDate,
            "ExportTime": self.ExportTime,
            "SaleOrderCode": self.SaleOrderCode,
            "UserCode": self.UserCode,
            "MaVoucher": self.MaVoucher,
            "HanSuDung": self.HanSuDung,
        ]
    }
}

