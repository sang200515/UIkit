//
//  DetailScoreError.swift
//  fptshop
//
//  Created by Apple on 6/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"STT": 1,
//"DetailID": 1,
//"GroupID": 1,
//"GroupName": "Bãi xe",
//"ContentID": 1,
//"ContentName": "Bãi giữ xe có rác",
//"Content": "Test Create phiếu chấm điểm",
//"CreateDate": "13:35 29/05/2019",
//"Status": "Đã up hình",
//"UrlImgFailed": "/ssss",
//"UrlImgComplete": "/"

//"Point": "Sai"


import UIKit
import SwiftyJSON

class DetailScoreError: NSObject {

//    static var domainUrlImgComplete = "http://118.69.201.45:1233"

    var STT: Int
    var DetailID: Int
    var GroupID: Int
    var GroupName: String
    var ContentID: Int
    var ContentName: String
    var Content: String
    var CreateDate: String
    var Status: String
    var UrlImgFailed: String
    var UrlImgComplete: String
    var Point: String
    
    init(STT: Int, DetailID: Int, GroupID: Int, GroupName: String, ContentID: Int, ContentName: String, Content: String, CreateDate: String, Status: String, UrlImgFailed: String, UrlImgComplete: String, Point: String) {
        
        self.STT = STT
        self.DetailID = DetailID
        self.GroupID = GroupID
        self.GroupName = GroupName
        self.ContentID = ContentID
        self.ContentName = ContentName
        self.Content = Content
        self.CreateDate = CreateDate
        self.Status = Status
        self.UrlImgFailed = UrlImgFailed
        self.UrlImgComplete = UrlImgComplete
        self.Point = Point
    }
    
    class func parseObjfromArray(array:[JSON])->[DetailScoreError]{
        var list:[DetailScoreError] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> DetailScoreError{
        var STT = data["STT"].int
        var DetailID = data["DetailID"].int
        var GroupID = data["GroupID"].int
        var GroupName = data["GroupName"].string
        var ContentID = data["ContentID"].int
        var ContentName = data["ContentName"].string
        var Content = data["Content"].string
        var CreateDate = data["CreateDate"].string
        var Status = data["Status"].string
        var UrlImgFailed = data["UrlImgFailed"].string
        var UrlImgComplete = data["UrlImgComplete"].string
        var Point = data["Point"].string
        
        STT = STT == nil ? 0 : STT
        DetailID = DetailID == nil ? 0 : DetailID
        GroupID = GroupID == nil ? 0 : GroupID
        GroupName = GroupName == nil ? "" : GroupName
        ContentID = ContentID == nil ? 0 : ContentID
        ContentName = ContentName == nil ? "" : ContentName
        Content = Content == nil ? "" : Content
        CreateDate = CreateDate == nil ? "" : CreateDate
        Content = Content == nil ? "" : Content
        Status = Status == nil ? "" : Status
        UrlImgFailed = UrlImgFailed == nil ? "" : UrlImgFailed
        UrlImgComplete = UrlImgComplete == nil ? "" : UrlImgComplete
        Point = Point == nil ? "" : Point
        
        
        return DetailScoreError(STT: STT!, DetailID: DetailID!, GroupID: GroupID!, GroupName: GroupName!, ContentID: ContentID!, ContentName: ContentName!, Content: Content!, CreateDate: CreateDate!, Status: Status!, UrlImgFailed: UrlImgFailed!, UrlImgComplete: UrlImgComplete!, Point: Point!)
    }
}
