//
//  NhomHangMuc.swift
//  fptshop
//
//  Created by Apple on 5/31/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"STT": 1,
//"GroupID": 1,
//"GroupName": "Bãi xe",
//"ListObjectScore": "1,3"

import UIKit
import SwiftyJSON

class NhomHangMuc: NSObject {
    
    let STT: Int
    let GroupID: Int
    let GroupName: String
    let ListObjectScore: String
    
    
    init(STT: Int, GroupID: Int, GroupName: String, ListObjectScore: String) {
        self.STT = STT
        self.GroupID = GroupID
        self.GroupName = GroupName
        self.ListObjectScore = ListObjectScore
    }
    
    class func parseObjfromArray(array:[JSON])->[NhomHangMuc]{
        var list:[NhomHangMuc] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> NhomHangMuc{
        var STT = data["STT"].int
        var GroupID = data["GroupID"].int
        var GroupName = data["GroupName"].string
        var ListObjectScore = data["ListObjectScore"].string
        
        
        STT = STT == nil ? 0 : STT
        GroupID = GroupID == nil ? 0 : GroupID
        GroupName = GroupName == nil ? "" : GroupName
        ListObjectScore = ListObjectScore == nil ? "" : ListObjectScore
        
        
        return NhomHangMuc(STT: STT!, GroupID: GroupID!, GroupName: GroupName!, ListObjectScore: ListObjectScore!)
    }
}
