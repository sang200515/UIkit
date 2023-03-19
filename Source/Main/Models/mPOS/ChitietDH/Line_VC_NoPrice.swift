//
//  Line_VC_NoPrice.swift
//  fptshop
//
//  Created by DiemMy Le on 7/23/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"docentry": 3068077,
//"sdt": "0985021924",
//"mashop": "30808",
//"VC_num": "09B8726YA585",
//"VC_Name": "",
//"Expired": ""

import UIKit
import SwiftyJSON

class Line_VC_NoPrice: NSObject {
    let docentry:Int
    let sdt:String
    let mashop:String
    let VC_num: String
    let VC_Name: String
    let Expired: String
    
    init(docentry:Int, sdt:String, mashop:String, VC_num: String, VC_Name: String, Expired: String) {
        self.docentry = docentry
        self.sdt = sdt
        self.mashop = mashop
        self.VC_num = VC_num
        self.VC_Name = VC_Name
        self.Expired = Expired
    }
    
    class func parseObjfromArray(array:[JSON])->[Line_VC_NoPrice]{
        var list:[Line_VC_NoPrice] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
        
    class func getObjFromDictionary(data:JSON) -> Line_VC_NoPrice{
        var docentry = data["docentry"].int
        var sdt = data["sdt"].string
        var mashop = data["mashop"].string
        var VC_num = data["VC_num"].string
        var VC_Name = data["VC_Name"].string
        var Expired = data["Expired"].string
        
        docentry = docentry == nil ? 0 : docentry
        sdt = sdt == nil ? "" : sdt
        mashop = mashop == nil ? "" : mashop
        VC_num = VC_num == nil ? "" : VC_num
        VC_Name = VC_Name == nil ? "" : VC_Name
        Expired = Expired == nil ? "" : Expired
        
        return Line_VC_NoPrice(docentry: docentry!, sdt: sdt!, mashop: mashop!, VC_num: VC_num!, VC_Name: VC_Name!, Expired: Expired!)
    }
}
