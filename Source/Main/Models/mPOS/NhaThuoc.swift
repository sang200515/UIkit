//
//  NhaThuoc.swift
//  mPOS
//
//  Created by tan on 9/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class NhaThuoc: NSObject {
    var Mashop:String
    var TenShop:String
    var DiaChiShop:String
    
    init(Mashop:String,TenShop:String,DiaChiShop:String){
        self.Mashop = Mashop
        self.TenShop = TenShop
        self.DiaChiShop = DiaChiShop
    }
    
    class func parseObjfromArray(array:[JSON])->[NhaThuoc]{
        var list:[NhaThuoc] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> NhaThuoc{
        var Mashop = data["Mashop"].string
        var TenShop = data["TenShop"].string
        var DiaChiShop = data["DiaChiShop"].string
        
        Mashop = Mashop == nil ? "" : Mashop
        TenShop = TenShop == nil ? "" : TenShop
        DiaChiShop = DiaChiShop == nil ? "" : DiaChiShop
        return NhaThuoc(Mashop: Mashop!, TenShop: TenShop!,DiaChiShop:DiaChiShop!)
    }
    
}
