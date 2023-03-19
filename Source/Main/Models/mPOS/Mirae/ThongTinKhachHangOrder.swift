//
//  ThongTinKhachHangOrder.swift
//  fptshop
//
//  Created by tan on 6/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ThongTinKhachHangOrder: NSObject {
    var FullName:String
    var Gender:String
    var IDCard:String
    var PhoneNumber:String
    var P_Address:String
    var processId_Mirae:String
    var activityId_Mirae:String
    var IDMPOS:Int
    
    init(FullName:String
    , Gender:String
    , IDCard:String
    , PhoneNumber:String
    , P_Address:String
    , processId_Mirae:String
    , activityId_Mirae:String
    , IDMPOS:Int){
        self.FullName = FullName
        self.Gender = Gender
        self.IDCard = IDCard
        self.PhoneNumber = PhoneNumber
        self.P_Address = P_Address
        self.processId_Mirae = processId_Mirae
        self.activityId_Mirae = activityId_Mirae
        self.IDMPOS = IDMPOS
    }
    
    class func parseObjfromArray(array:[JSON])->[ThongTinKhachHangOrder]{
        var list:[ThongTinKhachHangOrder] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ThongTinKhachHangOrder{
        
        var FullName = data["FullName"].string
        var Gender = data["Gender"].string
        var IDCard = data["IDCard"].string
        var PhoneNumber = data["PhoneNumber"].string
        var P_Address = data["P_Address"].string
        var processId_Mirae = data["processId_Mirae"].string
        var activityId_Mirae = data["activityId_Mirae"].string
        var IDMPOS = data["IDMPOS"].int
        
        FullName = FullName == nil ? "" : FullName
        Gender = Gender == nil ? "" : Gender
        IDCard = IDCard == nil ? "" : IDCard
        PhoneNumber = PhoneNumber == nil ? "" : PhoneNumber
        P_Address = P_Address == nil ? "" : P_Address
        processId_Mirae = processId_Mirae == nil ? "" : processId_Mirae
        activityId_Mirae = activityId_Mirae == nil ? "" : activityId_Mirae
        IDMPOS = IDMPOS == nil ? 0 : IDMPOS
        
        
        
        return ThongTinKhachHangOrder(FullName:FullName!
            , Gender:Gender!
            , IDCard:IDCard!
            , PhoneNumber:PhoneNumber!
            , P_Address:P_Address!
            , processId_Mirae:processId_Mirae!
            , activityId_Mirae:activityId_Mirae!
            , IDMPOS:IDMPOS!)
    }
    
}
