//
//  ResultUploadImagePosm.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ResultUploadImagePosm: NSObject {
    var Message:String
    var Result:Int
    var Url:String
    init(Message:String
      , Result:Int
      , Url:String){
        self.Message = Message
        self.Result = Result
        self.Url = Url
    }
    
    class func parseObjfromArray(array:[JSON])->[ResultUploadImagePosm]{
        var list:[ResultUploadImagePosm] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ResultUploadImagePosm{
         
         var Message = data["Message"].string
        var Result = data["Result"].int
        var Url = data["Url"].string
         
         Message = Message == nil ? "" : Message
        Result = Result == nil ? 0 : Result
        Url = Url == nil ? "" : Url
         return ResultUploadImagePosm(Message:Message!
         , Result:Result!
         , Url:Url!
         )
     }
}
class ParameDetailImage:Encodable{
    var DetailId:String?
    var Url:String?
    var LyDoKhongUpHinh: String?
    init(DetailId:String,Url:String,LyDoKhongUpHinh: String){
        self.DetailId = DetailId
        self.Url = Url
        self.LyDoKhongUpHinh = LyDoKhongUpHinh
    }
}
class TypeId_229_XuLyResult:NSObject{
    var Result:Int
    var Message:String
    
    init(Result:Int
    , Message:String){
        self.Result = Result
        self.Message = Message
    }
    
    
    class func parseObjfromArray(array:[JSON])->[TypeId_229_XuLyResult]{
        var list:[TypeId_229_XuLyResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> TypeId_229_XuLyResult{
         
         var Result = data["Result"].int
        var Message = data["Message"].string
 
         
         Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
   
         return TypeId_229_XuLyResult(Result:Result!
         , Message:Message!
         )
     }
}
