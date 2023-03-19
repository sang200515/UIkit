//
//  SODetail.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SODetail: NSObject {
    var linePromos: [LinePromos]?
    var lineProduct: [LineProduct]?
    var lineORCT: [LineORCT]?
    
    init(linePromos:[LinePromos]?,lineProduct:[LineProduct]?,lineORCT: [LineORCT]?) {
        self.linePromos = linePromos
        self.lineProduct = lineProduct
        self.lineORCT = lineORCT
    }
    
    class func getObjFromDictionary(data:JSON) -> SODetail{
        
        var linePromos:[LinePromos]?
        var lineProduct:[LineProduct]?
        var lineORCT:[LineORCT]?
        
        if let linePromosDic = data["LinePromos"].array {
            linePromos  = LinePromos.parseObjfromArray(array: linePromosDic)
        }
        if let lineProductDic = data["Lines"].array{
            lineProduct = LineProduct.parseObjfromArray(array: lineProductDic)
        }
        if let lineORCTDic = data["LineORCT"].array{
            lineORCT = LineORCT.parseObjfromArray(array: lineORCTDic)
        }
        return SODetail(linePromos: linePromos, lineProduct: lineProduct,lineORCT:lineORCT)
    }
}
