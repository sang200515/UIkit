//
//  Documents_InfoMirae.swift
//  fptshop
//
//  Created by tan on 8/30/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Result": 1,
//"Message": "Kiểm tra số hợp đồng thành công",
//"ContractNumber": "105919",
//"ShopCode": "30808"

import Foundation
import SwiftyJSON
class Documents_InfoMirae: NSObject {
    var Result:Int
    var Message:String
    var ContractNumber:String
    var ShopCode:String
    
    init(Result:Int
    , Message:String
    , ContractNumber:String
    , ShopCode:String){
        self.Result = Result
        self.Message = Message
        self.ContractNumber = ContractNumber
        self.ShopCode = ShopCode
    }
    
    class func parseObjfromArray(array:[JSON])->[Documents_InfoMirae]{
        var list:[Documents_InfoMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Documents_InfoMirae{
        var Result = data["Result"].int
        var Message = data["Message"].string
        var ContractNumber = data["ContractNumber"].string
        var ShopCode = data["ShopCode"].string
  
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
        ContractNumber = ContractNumber == nil ? "" : ContractNumber
        ShopCode = ShopCode == nil ? "" : ShopCode

        return Documents_InfoMirae(
            Result:Result!,
            Message:Message!,
            ContractNumber:ContractNumber!,
            ShopCode:ShopCode!
        )
    }
}
