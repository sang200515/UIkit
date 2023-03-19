//
//  ProductBySku.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class BaoHanh:NSObject {
    var masp:[String]
    var sku:[String]
    init(masp:[String],sku:[String]){
        self.masp = masp
        self.sku = sku
    }
}
class ProductBySku: NSObject,NSCopying {
    var product: Product
    var variant: [Variant]
    var atrribute: [Atrribute]
    var crossSale: [Product]
    var upSale: [Product]
    var segment: [Product]
    var compare: Compare
    var accessories: [Product]
    
    init(product: Product, variant: [Variant], atrribute: [Atrribute], crossSale: [Product], upSale: [Product], segment: [Product], compare: Compare,accessories: [Product]) {
        self.product = product
        self.variant = variant
        self.atrribute = atrribute
        self.crossSale = crossSale
        self.upSale = upSale
        self.segment = segment
        self.compare = compare
        self.accessories = accessories
    }
    
    
    class func getObjFromDictionary(data:JSON) -> ProductBySku{
        //product
        let productDic = data["header"]
        let product  = Product.getObjFromDictionary(data: productDic)
        //variant
        let variantArr = data["variants"].array
        let variant = Variant.parseObjfromArray(array: variantArr!)
        //atrribute
        let atrributesArr = data["header"]["settings"].array
        
        let atrributes = Attributes.parseObjfromArray(array: atrributesArr!)
        var dictionary: [String:NSMutableArray] = [:]
        var listAtrribute = [Atrribute]()
        for item in atrributes {
            if let val:NSMutableArray = dictionary["\(item.groupName)"] {
                val.add(item)
                dictionary.updateValue(val, forKey: "\(item.groupName)")
            } else {
                let arr: NSMutableArray = NSMutableArray()
                arr.add(item)
                dictionary.updateValue(arr, forKey: "\(item.groupName)")
            }
        }
        for item in dictionary{
            let atrribute = Atrribute(group: item.key, attributes: item.value as! [Attributes])
            listAtrribute.append(atrribute)
        }
        
        let crossSale = [Product]()
        let upSale = [Product]()
        let segment = [Product]()
        let compare = Compare(keySellingPoint: [], basicInformation: [])
        let accessories = [Product]()
        
        return ProductBySku(product: product, variant: variant, atrribute: listAtrribute, crossSale: crossSale, upSale: upSale, segment: segment, compare: compare,accessories:accessories)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = ProductBySku(product: product, variant: variant, atrribute: atrribute, crossSale: crossSale, upSale: upSale, segment: segment, compare: compare,accessories:accessories)
        return copy
    }
    
    class func parseObjfromArray(array:[JSON])->[ProductBySku]{
        var list:[ProductBySku] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
}
