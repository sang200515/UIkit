//
//  LineVoucher.swift
//  fptshop
//
//  Created by DiemMy Le on 7/23/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"U_NumVouhcer": "07X7I4RMD643",
//"U_NameVouhcer": "Tặng PMH tất cả ngành hàng trị giá 400.000 đồng khi mua Apple",
//"U_MoVoCh": 400000.000000

import UIKit
import SwiftyJSON

class LineVoucher: NSObject {
    let U_MoVoCh:Double
    let U_NumVouhcer:String
    let U_NameVouhcer:String
    
    init(U_MoVoCh:Double, U_NumVouhcer:String, U_NameVouhcer:String) {
        self.U_MoVoCh = U_MoVoCh
        self.U_NumVouhcer = U_NumVouhcer
        self.U_NameVouhcer = U_NameVouhcer
    }
    
    class func parseObjfromArray(array:[JSON])->[LineVoucher]{
        var list:[LineVoucher] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
        
    class func getObjFromDictionary(data:JSON) -> LineVoucher{
        var U_MoVoCh = data["U_MoVoCh"].double
        var U_NumVouhcer = data["U_NumVouhcer"].string
        var U_NameVouhcer = data["U_NameVouhcer"].string
        
        U_MoVoCh = U_MoVoCh == nil ? 0 : U_MoVoCh
        U_NumVouhcer = U_NumVouhcer == nil ? "" : U_NumVouhcer
        U_NameVouhcer = U_NameVouhcer == nil ? "" : U_NameVouhcer
        
        return LineVoucher(U_MoVoCh: U_MoVoCh!, U_NumVouhcer: U_NumVouhcer!, U_NameVouhcer: U_NameVouhcer!)
    }
}
