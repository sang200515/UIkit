//
//  POAll.swift
//  mPOS
//
//  Created by tan on 8/17/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class POAll: NSObject {
    
    var PONum:Int
    var DocDate:String
    var ItemCode:String
    var ItemName:String
    var SLDat:Int
    var ManSerNum:String
    
    
    init(PONum:Int,DocDate:String,ItemCode:String,ItemName:String,SLDat:Int,ManSerNum:String){
        self.PONum = PONum
        self.DocDate = DocDate
        self.ItemCode = ItemCode
        self.ItemName = ItemName
        self.SLDat = SLDat
        self.ManSerNum = ManSerNum
    }
    
    

    
    class func parseObjfromArray(array:[JSON])->[POAll]{
        var list:[POAll] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
 
    
    
    
    class func getObjFromDictionary(data:JSON) -> POAll{

        var PONum = data["PONum"].int
        var DocDate = data["DocDate"].string
        var ItemCode = data["ItemCode"].string
        var ItemName = data["ItemName"].string
        var SLDat = data["SLDat"].int
        var ManSerNum = data["ManSerNum"].string
        
        
        
        PONum = PONum == nil ? 0 : PONum
        DocDate = DocDate == nil ? "1970-01-01T00:00:00" : DocDate
        ItemCode = ItemCode == nil ? "" : ItemCode
        ItemName = ItemName == nil ? "" : ItemName
        SLDat = SLDat == nil ? 0 : SLDat
        ManSerNum = ManSerNum == nil ? "" : ManSerNum
        
        DocDate = formatDate(date: DocDate!)
        return POAll(PONum: PONum!, DocDate: DocDate!,ItemCode:ItemCode!,ItemName:ItemName!,SLDat:SLDat!,ManSerNum:ManSerNum!)
    }
    
    class func formatDate(date:String) -> String{
        let deFormatter = DateFormatter()
        deFormatter.timeZone = TimeZone(abbreviation: "UTC")
        deFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let startTime = deFormatter.date(from: date)
        deFormatter.dateFormat = "dd/MM/yyyy"
        return deFormatter.string(from: startTime!)
    }
    
}
