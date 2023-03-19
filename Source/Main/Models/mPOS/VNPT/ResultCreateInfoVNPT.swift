//
//  ResultCreateInfoVNPT.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/29/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
////
//"p_status": 0,
//"p_messages": "Mã otp không hợp lệ, bạn vui lòng kiểm tra lại mã hoặc yêu cầu gửi mã mới nhé.",
//"Docentry": "0"
import Foundation
import SwiftyJSON
class ResultCreateInfoVNPT: NSObject{
    var p_status:Int
    var p_messages:String
    var Docentry:String
    
    init(  p_status:Int
        , p_messages:String
        , Docentry:String){
        self.p_status = p_status
        self.p_messages = p_messages
        self.Docentry = Docentry
    }
    
    class func parseObjfromArray(array:[JSON])->[ResultCreateInfoVNPT]{
          var list:[ResultCreateInfoVNPT] = []
          for item in array {
              list.append(self.getObjFromDictionary(data: item))
          }
          return list
      }
      
      class func getObjFromDictionary(data:JSON) -> ResultCreateInfoVNPT{
          var p_status = data["p_status"].int
          var p_messages = data["p_messages"].string
          var Docentry = data["Docentry"].string
      
          
      
          
          p_status = p_status == nil ? 0 : p_status
          p_messages = p_messages == nil ? "" : p_messages
          Docentry = Docentry == nil ? "" : Docentry
       
          return ResultCreateInfoVNPT(
         p_status:p_status!
              , p_messages:p_messages!
              , Docentry:Docentry!
   
          )
      }
}
