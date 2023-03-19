//
//  ToshibaPoint.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ToshibaPoint: NSObject {
    
    var MemberName: String
    var Phone: String
    var CurrentRank: String
    var FPoint: Int
    var FCoin: Int
    
    
    init(MemberName: String,Phone: String,CurrentRank: String,FPoint: Int,FCoin: Int){
        self.MemberName = MemberName
        self.Phone = Phone
        self.CurrentRank = CurrentRank
        self.FPoint = FPoint
        self.FCoin = FCoin
    }
    class func parseObjfromArray(array:[JSON])->[ToshibaPoint]{
        var list:[ToshibaPoint] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ToshibaPoint{
        
        var memberName = data["MemberName"].string
        var phone = data["Phone"].string
        var currentRank = data["CurrentRank"].string
        var fPoint =  "\(String(describing: data["FPoint"]))"
        var fCoin =  "\(String(describing: data["FCoin"]))"
        //        var fPoint = data["FPoint"] as? Int
        //        var fCoin = data["FCoin"] as? Int
        
        memberName = memberName == nil ? "" : memberName
        phone = phone == nil ? "" : phone
        currentRank = currentRank == nil ? "" : currentRank
        if(fPoint == ""){
            fPoint = "0"
        }
        if(fCoin == ""){
            fCoin = "0"
        }
        
        //        fPoint = fPoint == nil ? 0 : fPoint
        //        fCoin = fCoin == nil ? 0 : fCoin
        
        
        return ToshibaPoint(MemberName: memberName!,Phone: phone!,CurrentRank: currentRank!,FPoint: Int(fPoint)!,FCoin: Int(fCoin)!)
    }
    
}

