//
//  ScoreError.swift
//  fptshop
//
//  Created by Apple on 6/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"HeaderID": 1,
//"ShopCode": "273",
//"ShopName": "",
//"Point": "Đúng: 1;Sai: 0;Chưa chấm: 1",
//"Status": "Ðã hoàn thành",
//"StatusCode": 3,
//"CreateBy": "25376 - Nguyễn Minh Thương",
//"CreateDate": "13:35 29/05/2019",
//"DetailScores": [

import UIKit
import SwiftyJSON

class ScoreError: NSObject {
    
    let HeaderID: Int
    let ShopCode: String
    let ShopName: String
    let Point: String
    let Status: String
    let StatusCode: Int
    let CreateBy: String
    let CreateDate: String
    let DetailScores: [DetailScoreError]
    
    init(HeaderID: Int, ShopCode: String, ShopName: String, Point: String, Status: String, StatusCode: Int, CreateBy: String, CreateDate: String, DetailScores: [DetailScoreError]) {
        
        self.HeaderID = HeaderID
        self.ShopCode = ShopCode
        self.ShopName = ShopName
        self.Point = Point
        self.Status = Status
        self.StatusCode = StatusCode
        self.CreateBy = CreateBy
        self.CreateDate = CreateDate
        self.DetailScores = DetailScores
    }
    
    class func parseObjfromArray(array:[JSON])->[ScoreError]{
        var list:[ScoreError] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ScoreError{
        var HeaderID = data["HeaderID"].int
        var ShopCode = data["ShopCode"].string
        var ShopName = data["ShopName"].string
        var Point = data["Point"].string
        var Status = data["Status"].string
        var StatusCode = data["StatusCode"].int
        var CreateBy = data["CreateBy"].string
        var CreateDate = data["CreateDate"].string
        var DetailScores = data["DetailScores"].array
        
        HeaderID = HeaderID == nil ? 0 : HeaderID
        ShopCode = ShopCode == nil ? "" : ShopCode
        ShopName = ShopName == nil ? "" : ShopName
        Point = Point == nil ? "" : Point
        Status = Status == nil ? "" : Status
        StatusCode = StatusCode == nil ? 0 : StatusCode
        CreateBy = CreateBy == nil ? "" : CreateBy
        CreateDate = CreateDate == nil ? "" : CreateDate
        DetailScores = DetailScores == nil ? [] : DetailScores
        
        
        let listDetailScores = DetailScoreError.parseObjfromArray(array: DetailScores ?? [])
        
        return ScoreError(HeaderID: HeaderID!, ShopCode: ShopCode!, ShopName: ShopName!, Point: Point!, Status: Status!, StatusCode: StatusCode!, CreateBy: CreateBy!, CreateDate: CreateDate!, DetailScores: listDetailScores)
    }
}
