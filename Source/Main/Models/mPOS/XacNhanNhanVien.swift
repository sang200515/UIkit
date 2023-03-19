//
//  XacNhanNhanVien.swift
//  mPOS
//
//  Created by tan on 9/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class XacNhanNhanVien: NSObject{
    var success:Bool
    var message:String
    var Result:String
    var docentry:String
    var sophieucrm:String
    var IDBill:String
    
    init(success:Bool,message:String,Result:String,docentry:String,sophieucrm:String,IDBill:String){
        self.success = success
        self.message = message
        self.Result = Result
        self.docentry = docentry
        self.sophieucrm = sophieucrm
        self.IDBill = IDBill
    }
    
    
    
    
}
