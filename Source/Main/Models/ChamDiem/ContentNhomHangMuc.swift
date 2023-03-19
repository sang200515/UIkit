//
//  ContentNhomHangMuc.swift
//  fptshop
//
//  Created by Apple on 5/31/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//


import UIKit
import SwiftyJSON

class ContentNhomHangMuc: NSObject {
    
    let STT: Int
    let GroupID: Int
    let GroupName: String
    let ListContent: [ContentHangMuc]
    let ListObject: [DoiTuongChamDiem]
    let Count: Int
    
    init(STT: Int, GroupID: Int, GroupName: String, ListContent: [ContentHangMuc], ListObject: [DoiTuongChamDiem], Count: Int) {
        
        self.STT = STT
        self.GroupID = GroupID
        self.GroupName = GroupName
        self.ListContent = ListContent
        self.ListObject = ListObject
        self.Count = Count
    }
    
    class func parseObjfromArray(array:[JSON])->[ContentNhomHangMuc]{
        var list:[ContentNhomHangMuc] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ContentNhomHangMuc{
        var STT = data["STT"].int
        var GroupID = data["GroupID"].int
        var GroupName = data["GroupName"].string
        var ListContent = data["ListContent"].array
        var ListObject = data["ListObject"].array
        var Count = data["Count"].int
        
        STT = STT == nil ? 0 : STT
        GroupID = GroupID == nil ? 0 : GroupID
        GroupName = GroupName == nil ? "" : GroupName
        ListContent = ListContent == nil ? [] : ListContent
        ListObject = ListObject == nil ? [] : ListObject
        Count = Count == nil ? 0 : Count
        
        let listContentHangMuc = ContentHangMuc.parseObjfromArray(array: ListContent ?? [])
        let listDoiTuong = DoiTuongChamDiem.parseObjfromArray(array: ListObject ?? [])
        
        return ContentNhomHangMuc(STT: STT!, GroupID: GroupID!, GroupName: GroupName!, ListContent: listContentHangMuc, ListObject: listDoiTuong, Count: Count!)
    }
}
