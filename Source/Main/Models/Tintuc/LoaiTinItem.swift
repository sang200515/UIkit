//
//  LoaiTinItem.swift
//  fptshop
//
//  Created by DiemMy Le on 5/4/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoaiTinItem: NSObject {
    var idLoaiTin:String
    var nameLoaiTin:String
    var listSummary: [Sumary_TinTuc]
    
    init(idLoaiTin:String, nameLoaiTin:String, listSummary: [Sumary_TinTuc]) {
        self.idLoaiTin = idLoaiTin
        self.nameLoaiTin = nameLoaiTin
        self.listSummary = listSummary
    }
    
    class func parseObjfromArray(array:[JSON])->[LoaiTinItem]{
        var list:[LoaiTinItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> LoaiTinItem {
        var idLoaiTin = data["id"].string
        
        let attributes = data["attributes"]
        var nameLoaiTin = attributes["name"].string
        let listSummary = data["details"].array ?? []

        idLoaiTin = idLoaiTin == nil ? "" : idLoaiTin
        nameLoaiTin = nameLoaiTin == nil ? "" : nameLoaiTin
        let arrSummary = Sumary_TinTuc.parseObjfromArray(array: listSummary)

        return LoaiTinItem(idLoaiTin: idLoaiTin!, nameLoaiTin: nameLoaiTin!, listSummary: arrSummary)
    }
}
