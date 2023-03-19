//
//  BaoHiem_addOrderBodyResult.swift
//  mPOS
//
//  Created by sumi on 8/3/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_addOrderBodyResult: NSObject {
    
    var Code: String
    var Message: String
    var NgayKetThucHLVC: String
    var Value: String
    var Voucher: String
    
    init(Code: String, Message: String, NgayKetThucHLVC: String, Value: String, Voucher: String){
        self.Code = Code
        self.Message = Message
        self.NgayKetThucHLVC = NgayKetThucHLVC
        self.Value = Value
        self.Voucher = Voucher
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiem_addOrderBodyResult]{
        var list:[BaoHiem_addOrderBodyResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_addOrderBodyResult{
        var Code = data["Code"].string
        var Message = data["Message"].string
        var NgayKetThucHLVC = data["NgayKetThucHLVC"].string
        var Value = data["Value"].string
        var Voucher = data["Voucher"].string
        
        Voucher = Voucher == nil ? "": Voucher
        Value = Value == nil ? "" : Value
        NgayKetThucHLVC = NgayKetThucHLVC == nil ? "" : NgayKetThucHLVC
        Message = Message == nil ? "": Message
        Code = Code == nil ? "": Code
        return BaoHiem_addOrderBodyResult(Code: Code!, Message: Message!, NgayKetThucHLVC: NgayKetThucHLVC!, Value: Value!, Voucher: Voucher!)
    }
}
