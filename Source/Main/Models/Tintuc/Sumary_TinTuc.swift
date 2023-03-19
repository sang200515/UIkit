//
//  Sumary_TinTuc.swift
//  fptshop
//
//  Created by DiemMy Le on 5/4/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class Sumary_TinTuc: NSObject {

    var id:String
    var title:String
    var created: String
    var field_description: String
    var body_processed: String
    var imgChuDe: String
    var imgBanner: String
    
    init(id:String, title:String, created:String, field_description: String, body_processed: String, imgChuDe: String, imgBanner: String) {
        self.id = id
        self.title = title
        self.created = created
        self.field_description = field_description
        self.body_processed = body_processed
        self.imgChuDe = imgChuDe
        self.imgBanner = imgBanner
    }
    
    class func parseObjfromArray(array:[JSON])->[Sumary_TinTuc]{
        var list:[Sumary_TinTuc] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Sumary_TinTuc{
        
        var id = data["id"].string
        var imgChuDe = data["url"].string
        let attributes = data["attributes"]

        var title = attributes["title"].string
        var created = attributes["created"].string
        var field_description = attributes["field_description"].string
        //body
        let body = attributes["body"]
        var body_processed = body["processed"].string
        
        // include
        var imgBanner = ""
        let include = data["include"].arrayValue
        if include.count > 1 {
            imgBanner = include.last!["attributes"]["uri"]["url"].string ?? ""
        }

        id = id == nil ? "" : id
        imgChuDe = imgChuDe == nil ? "" : imgChuDe
        title = title == nil ? "" : title
        created = created == nil ? "" : created
        field_description = field_description == nil ? "" : field_description
        body_processed = body_processed == nil ? "" : body_processed

        return Sumary_TinTuc(id: id!, title: title!, created: created!, field_description: field_description!, body_processed: body_processed!, imgChuDe: imgChuDe!, imgBanner: imgBanner)
    }
}
