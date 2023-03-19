//
//  ContentHangMuc.swift
//  fptshop
//
//  Created by Apple on 5/31/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"STT": 1,
//"ContentID": 1,
//"ContentName": "Bãi giữ xe có rác"

//"STT": 4,
//"ContentID": 26,
//"GroupID": 1,
//"ObjectID": 1,
//"ContentName": "Vệ sinh bảng hiệu",
//"Content": "Bảng hiệu FPT shop  không được vệ sinh sạch sẽ",
//"UrlImage": "/"

import UIKit
import SwiftyJSON

class ContentHangMuc: NSObject {
    
    let STT: Int
    let ContentID: Int
    let GroupID: Int
    let ObjectID: String
    let ContentName: String
    let Content: String
    let UrlImage: String
    
    
    init(STT: Int, ContentID: Int, GroupID: Int, ObjectID: String, ContentName: String, Content: String, UrlImage: String) {
        self.STT = STT
        self.ContentID = ContentID
        self.GroupID = GroupID
        self.ObjectID = ObjectID
        self.ContentName = ContentName
        self.Content = Content
        self.UrlImage = UrlImage
    }
    
    class func parseObjfromArray(array:[JSON])->[ContentHangMuc]{
        var list:[ContentHangMuc] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ContentHangMuc{
        var STT = data["STT"].int
        var ContentID = data["ContentID"].int
        var GroupID = data["GroupID"].int
        var ObjectID = data["ObjectID"].string
        var ContentName = data["ContentName"].string
        var Content = data["Content"].string
        var UrlImage = data["UrlImage"].string
        
        
        STT = STT == nil ? 0 : STT
        ContentID = ContentID == nil ? 0 : ContentID
        GroupID = GroupID == nil ? 0 : GroupID
        ObjectID = ObjectID == nil ? "" : ObjectID
        ContentName = ContentName == nil ? "" : ContentName
        Content = Content == nil ? "" : Content
        UrlImage = UrlImage == nil ? "" : UrlImage
        
        
        return ContentHangMuc(STT: STT!, ContentID: ContentID!, GroupID: GroupID!, ObjectID: ObjectID!, ContentName: ContentName!, Content: Content!, UrlImage: UrlImage!)
    }
}
