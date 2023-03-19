//
//  ResultInsertTribi.swift
//  fptshop
//
//  Created by Ngo Dang tan on 1/7/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"Result": 0,
//"Message": "Đã tồn tại mã booking ID 1763538",
//"DocEntry": 0,
//"bookingId": 0
import Foundation
import SwiftyJSON
class ResultInsertTribi: NSObject {
    var Result:Int
    var Message:String
    var DocEntry:Int
    var bookingId:Int
    
    init( Result:Int
        , Message:String
        , DocEntry:Int
        , bookingId:Int){
        self.Result = Result
        self.Message = Message
        self.DocEntry = DocEntry
        self.bookingId = bookingId
    }
    
    class func parseObjfromArray(array:[JSON])->[ResultInsertTribi]{
        var list:[ResultInsertTribi] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ResultInsertTribi{
        
        var Result = data["Result"].int
        var Message = data["Message"].string
        var DocEntry = data["DocEntry"].int
        var bookingId = data["bookingId"].int
        
        
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
        DocEntry = DocEntry == nil ? 0 : DocEntry
        bookingId = bookingId == nil ? 0 : bookingId
        
        return ResultInsertTribi(Result:Result!
            , Message:Message!
            ,DocEntry:DocEntry!
            ,bookingId:bookingId!
            
        )
    }
    
    
}
