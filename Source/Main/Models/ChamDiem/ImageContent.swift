//
//  ImageContent.swift
//  fptshop
//
//  Created by Apple on 6/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"STT": 1,
//"ContentID": 1,
//"ContentName": "Bãi giữ xe có rác",
//"UrlImageSample": "/AAAAA",
//"GroupId": 1,
//"ObjectId": 1

import UIKit
import SwiftyJSON

class ImageContent: NSObject {
    
    let STT: Int
    let ContentID: Int
    let ContentName: String
    let UrlImageSample: String
    let GroupId: Int
    let ObjectId: Int
    
    var dienGiaiLoi = ""
    var urlImgThucTe = ""
    var radioType = ""
    
    init(STT: Int, ContentID: Int, ContentName: String, UrlImageSample: String, GroupId: Int, ObjectId: Int) {
        self.STT = STT
        self.ContentID = ContentID
        self.ContentName = ContentName
        self.UrlImageSample = UrlImageSample
        self.GroupId = GroupId
        self.ObjectId = ObjectId
    }
    
    class func parseObjfromArray(array:[JSON])->[ImageContent]{
        var list:[ImageContent] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ImageContent{
        var STT = data["STT"].int
        var ContentID = data["ContentID"].int
        var ContentName = data["ContentName"].string
        var UrlImageSample = data["UrlImageSample"].string
        var GroupId = data["GroupId"].int
        var ObjectId = data["ObjectId"].int
        
        
        STT = STT == nil ? 0 : STT
        ContentID = ContentID == nil ? 0 : ContentID
        ContentName = ContentName == nil ? "" : ContentName
        UrlImageSample = UrlImageSample == nil ? "" : UrlImageSample
        GroupId = GroupId == nil ? 0 : GroupId
        ObjectId = ObjectId == nil ? 0 : ObjectId
        
        
        return ImageContent(STT: STT!, ContentID: ContentID!, ContentName: ContentName!, UrlImageSample: UrlImageSample!, GroupId: GroupId!, ObjectId: ObjectId!)
    }
}
