//
//  ReportDeliveryHeaderOrderListResult.swift
//  NewmDelivery
//
//  Created by sumi on 4/26/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReportDeliveryHeaderOrderListResult2: NSObject {
    
    var SoDHPOS : String
    var SoDHEcom : String
    var TinhDungHen : String
    var TinhTrangSDmDelivery : String
    var INC : String
    
    init(SoDHPOS: String, SoDHEcom: String, TinhDungHen: String, TinhTrangSDmDelivery: String, INC: String) {
        self.SoDHPOS = SoDHPOS
        self.SoDHEcom  = SoDHEcom
        self.TinhDungHen  = TinhDungHen
        self.TinhTrangSDmDelivery  = TinhTrangSDmDelivery
        self.INC = INC
    }
    class func getObjFromDictionary(data:JSON) -> ReportDeliveryHeaderOrderListResult2{
        
        var  SoDHPOS = data["SoDHPOS"].string
        var SoDHEcom = data["SoDHEcom"].string
        var TinhDungHen = data["TinhDungHen"].string
        var TinhTrangSDmDelivery = data["TinhTrangSDmDelivery"].string
        var INC = data["INC"].string
        
        SoDHPOS = SoDHPOS == nil ? "" : SoDHPOS
        SoDHEcom = SoDHEcom == nil ? "" : SoDHEcom
        TinhDungHen = TinhDungHen == nil ? "" : TinhDungHen
        TinhTrangSDmDelivery = TinhTrangSDmDelivery == nil ? "" : TinhTrangSDmDelivery
        INC = INC == nil ? "" : INC
        
        return ReportDeliveryHeaderOrderListResult2(SoDHPOS: SoDHPOS!, SoDHEcom: SoDHEcom!, TinhDungHen: TinhDungHen!, TinhTrangSDmDelivery: TinhTrangSDmDelivery!, INC: INC!)
    }
    class func parseObjfromArray(array:[JSON])->[ReportDeliveryHeaderOrderListResult2]{
        var list:[ReportDeliveryHeaderOrderListResult2] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}

