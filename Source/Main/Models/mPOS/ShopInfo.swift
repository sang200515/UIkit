//
//  ShopInfo.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON;

class ShopInfo: NSObject {
    var Address: String
    var ID: Int
    var IPMax: String
    var IPMin: String
    var IPPublic: String
    var IPRange: String
    var Region: String
    var ShopCode: String
    var ShopName: String
    
    init(Address: String, ID: Int, IPMax: String, IPMin: String, IPPublic: String, IPRange: String, Region: String, ShopCode: String, ShopName: String) {
        self.Address = Address
        self.ID = ID
        self.IPMax = IPMax
        self.IPMin = IPMin
        self.IPPublic = IPPublic
        self.IPRange = IPRange
        self.Region = Region
        self.ShopCode = ShopCode
        self.ShopName = ShopName
    }
    
    class func parseObjfromArray(array:[JSON])->[ShopInfo]{
        var list:[ShopInfo] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
        
    class func getObjFromDictionary(data:JSON) -> ShopInfo{
        var Address = data["Address"].string
        var ID = data["ID"].int
        var IPMax = data["IPMax"].string
        var IPMin = data["IPMin"].string
        var IPPublic = data["IPPublic"].string
        var IPRange = data["IPRange"].string
        var Region = data["Region"].string
        var ShopCode = data["ShopCode"].string
        var ShopName = data["ShopName"].string
        
        Address = Address == nil ? "" : Address
        ID = ID == nil ? 0 : ID
        IPMax = IPMax == nil ? "" : IPMax
        IPMin = IPMin == nil ? "" : IPMin
        IPPublic = IPPublic == nil ? "" : IPPublic
        IPRange = IPRange == nil ? "" : IPRange
        Region = Region == nil ? "" : Region
        ShopCode = ShopCode == nil ? "" : ShopCode
        ShopName = ShopName == nil ? "" : ShopName
        
        return ShopInfo(Address: Address!, ID: ID!, IPMax: IPMax!, IPMin: IPMin!, IPPublic: IPPublic!, IPRange: IPRange!, Region: Region!, ShopCode: ShopCode!, ShopName: ShopName!)
    }
}
