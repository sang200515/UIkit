//
//  DetectIDCard.swift
//  fptshop
//
//  Created by tan on 8/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class DetectIDCard: NSObject {
    var IdCard:String
    var FullName:String
    var FirstName:String
    var LastName:String
    var MiddleName:String
    var Native:String
    var BirthDay:String
    var Gender:String
    var Address:String
    
    
    init(IdCard:String
    , FullName:String
    , FirstName:String
    , LastName:String
    , MiddleName:String
    , Native:String
    , BirthDay:String
    , Gender:String
    , Address:String){
        self.IdCard = IdCard
        self.FullName = FullName
        self.FirstName = FirstName
        self.LastName = LastName
        self.MiddleName = MiddleName
        self.Native = Native
        self.BirthDay = BirthDay
        self.Gender = Gender
        self.Address = Address
    }
    
    class func parseObjfromArray(array:[JSON])->[DetectIDCard]{
        var list:[DetectIDCard] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> DetectIDCard{
        
        var IdCard = data["IdCard"].string
        var FullName = data["FullName"].string
        var FirstName = data["FirstName"].string
        var LastName = data["LastName"].string
        var MiddleName = data["MiddleName"].string
        var Native = data["Native"].string
        var BirthDay = data["BirthDay"].string
        var Gender = data["Gender"].string
        var Address = data["Address"].string
        
        
        
        IdCard = IdCard == nil ? "" : IdCard
        FullName = FullName == nil ? "" : FullName
             FirstName = FirstName == nil ? "" : FirstName
             LastName = LastName == nil ? "" : LastName
             MiddleName = MiddleName == nil ? "" : MiddleName
         Native = Native == nil ? "" : Native
         BirthDay = BirthDay == nil ? "" : BirthDay
         Gender = Gender == nil ? "" : Gender
         Address = Address == nil ? "" : Address
        return DetectIDCard(IdCard:IdCard!
            , FullName:FullName!
            , FirstName:FirstName!
            , LastName:LastName!
            , MiddleName:MiddleName!
            , Native:Native!
            , BirthDay:BirthDay!
            , Gender:Gender!
            , Address:Address!
        )
    }
    
}


class UpdateMdeliItem: NSObject {
    
    var Success: String
    var Error: String
    var Data: String
    
    init(Success: String, Error: String, Data: String) {
        self.Success = Success
        self.Error = Error
        self.Data = Data
    }
    
    class func getObjFromDictionary(data:JSON) -> UpdateMdeliItem{
        
        let Success = data["Success"].stringValue
        let Error = data["Error"].stringValue
        let Data = data["Error"].stringValue
        return UpdateMdeliItem(Success: Success, Error: Error, Data: Data)
    }
}

class CheckBTSUploadItem: NSObject {
    
    var Success: Bool
    var Message: String
    var BtsData: BTSDataItem
    
    init(Success: Bool, Message: String, BtsData: BTSDataItem) {
       self.Success = Success
       self.Message = Message
       self.BtsData = BtsData
   }
    
    class func getObjFromDictionary(data:JSON) -> CheckBTSUploadItem{
        
        let Success = data[""].boolValue
        let Message = data[""].stringValue
        let BtsData = BTSDataItem.getObjFromDictionary(data: data["Data"])
        
        return CheckBTSUploadItem(Success: Success, Message: Message, BtsData: BtsData)
    }
}

class BTSDataItem: NSObject {
    
    var result: Int
    var isUpload: Bool
    var messages: String
    var ID_BTS: Int
    
    init(result: Int, isUpload: Bool, messages: String, ID_BTS: Int) {
        self.result = result
        self.isUpload = isUpload
        self.messages = messages
        self.ID_BTS = ID_BTS
    }
    
    class func getObjFromDictionary(data:JSON) -> BTSDataItem {
        
        let result = data["result"].intValue
        let isUpload = data["isUpload"].boolValue
        let messages = data["messages"].stringValue
        let ID_BTS = data["ID_BTS"].intValue
        return BTSDataItem(result: result, isUpload: isUpload, messages: messages, ID_BTS: ID_BTS)
    }
}




