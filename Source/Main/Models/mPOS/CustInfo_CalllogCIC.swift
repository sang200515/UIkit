//
//  CustInfo_CalllogCIC.swift
//  fptshop
//
//  Created by tan on 3/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CustInfo_CalllogCIC: NSObject {
    var Result:Int
    var Message:String
    var CalllogCIC:Int
    var IsTGTT:Int
    var IsTGKnox:Int
    var IsTT:Int
    
    init(Result:Int, Message:String, CalllogCIC:Int, IsTGTT:Int,IsTGKnox:Int,IsTT:Int){
        self.Result = Result
        self.Message = Message
        self.CalllogCIC = CalllogCIC
        self.IsTGTT = IsTGTT
        self.IsTGKnox = IsTGKnox
        self.IsTT = IsTT
    }
    
    class func parseObjfromArray(array:[JSON])->[CustInfo_CalllogCIC]{
        var list:[CustInfo_CalllogCIC] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> CustInfo_CalllogCIC{
        var Result = data["Result"].int
        var Message = data["Message"].string
        var CalllogCIC = data["CalllogCIC"].int
        var IsTGTT = data["IsTGTT"].int
        var IsTGKnox = data["IsTGKnox"].int
        var IsTT = data["IsTT"].int
        
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
        CalllogCIC = CalllogCIC == nil ? 0 : CalllogCIC
        IsTGTT = IsTGTT == nil ? 0 : IsTGTT
        IsTGKnox = IsTGKnox == nil ? 0 : IsTGKnox
        IsTT = IsTT == nil ? 0 : IsTT
        
        return CustInfo_CalllogCIC(Result:Result!, Message:Message!, CalllogCIC: CalllogCIC!, IsTGTT:IsTGTT!, IsTGKnox:IsTGKnox!,IsTT:IsTT!)
    }
}
