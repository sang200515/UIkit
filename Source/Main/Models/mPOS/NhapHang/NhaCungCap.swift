//
//  NCC.swift
//  mPOS
//
//  Created by tan on 8/15/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class NhaCungCap: NSObject {
    var Vendorcode:String
    var VendorNam:String
    
    
    init(Vendorcode:String, VendorNam:String){
        self.Vendorcode = Vendorcode
        self.VendorNam = VendorNam
        
    }
    
    

    
    class func parseObjfromArray(array:[JSON])->[NhaCungCap]{
        var list:[NhaCungCap] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    

    
    
    class func getObjFromDictionary(data:JSON) -> NhaCungCap{
        var Vendorcode = data["Vendorcode"].string
        var VendorNam = data["VendorNam"].string
  
        
        
        Vendorcode = Vendorcode == nil ? "" : Vendorcode
        VendorNam = VendorNam == nil ? "" : VendorNam
 
        return NhaCungCap(Vendorcode:Vendorcode!,VendorNam:VendorNam!
        )
    }
}
