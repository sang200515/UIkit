//
//  Promotion.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/5/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class Promotion: NSObject {
    var productInStock: [ProductInStock]?
    var productPromotions: [ProductPromotions]?
    var unconfirmationReasons: [UnconfirmationReasons]?
    init(productInStock:[ProductInStock]?,productPromotions:[ProductPromotions]?,unconfirmationReasons:[UnconfirmationReasons]?) {
        self.productInStock = productInStock
        self.productPromotions = productPromotions
        self.unconfirmationReasons = unconfirmationReasons
    }
    
    class func getObjFromDictionary(data:JSON) -> Promotion{
        
        var productInStock:[ProductInStock]? = nil
        var productPromotions:[ProductPromotions]?  = nil
        let productInStockDic = data["UnitInStock"].array
        var unconfirmationReasons:[UnconfirmationReasons]?  = nil
        if(productInStockDic != nil){
            productInStock  = ProductInStock.parseObjfromArray(array: productInStockDic!)
        }
          let productPromotionsDic = data["Promotions"].array
        if(productPromotionsDic != nil){
            productPromotions = ProductPromotions.parseObjfromArray(array: productPromotionsDic!)
        }
        let unconfirmationReasonsDic = data["UnconfirmationReasons"].array
        
        if(unconfirmationReasonsDic != nil){
            unconfirmationReasons = UnconfirmationReasons.parseObjfromArray(array: unconfirmationReasonsDic!)
        }
        return Promotion(productInStock: productInStock, productPromotions: productPromotions,unconfirmationReasons: unconfirmationReasons)
    }
}
