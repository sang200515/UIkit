//
//  DetailsCallLogNopQuyItem.swift
//  fptshop
//
//  Created by Apple on 7/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"DocEntry": 11,
//"RequestId": 5683903,
//"CreateDate": "17:15 15/07/2019",
//"Date": "15/07/2019",
//"Status": "Đã gửi",
//"StatusCode": "P         ",
//"Money": "30799000.000000",
//"EmployeeName": "15261 - Nguyễn Phúc Hữu",
//"ShopName": "30808 - HCM 305 Tô Hiến Thành",
//"Note": "bđbb",
//"UpdateDate": "10:50 16/07/2019",
//"ImageSelfie": "http://imagescore.fptshop.com.vn:1233/PaymentOfFunds/16072019/Payment_160719105005.jpg",
//"ImageReceipt": "http://imagescore.fptshop.com.vn:1233/PaymentOfFunds/16072019/Payment_160719105008.jpg"

import UIKit
import SwiftyJSON

class DetailsCallLogNopQuyItem: NSObject {

    let DocEntry: Int
    let RequestId: Int
    let CreateDate: String
    let Date: String
    let Status: String
    let StatusCode: String
    let Money: String
    let EmployeeName: String
    let ShopName: String
    let Note: String
    let UpdateDate: String
    let ImageSelfie: String
    let ImageReceipt: String
    
    init(DocEntry: Int, RequestId: Int, CreateDate: String, Date: String, Status: String, StatusCode: String, Money: String, EmployeeName: String, ShopName: String, Note: String, UpdateDate: String, ImageSelfie: String, ImageReceipt: String) {
        
        self.DocEntry = DocEntry
        self.RequestId = RequestId
        self.CreateDate = CreateDate
        self.Date = Date
        self.Status = Status
        self.StatusCode = StatusCode
        self.Money = Money
        self.EmployeeName = EmployeeName
        self.ShopName = ShopName
        self.Note = Note
        self.UpdateDate = UpdateDate
        self.ImageSelfie = ImageSelfie
        self.ImageReceipt = ImageReceipt
    }
    
    class func parseObjfromArray(array:[JSON])->[DetailsCallLogNopQuyItem]{
        var list:[DetailsCallLogNopQuyItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> DetailsCallLogNopQuyItem{
        
        var DocEntry = data["DocEntry"].int
        var RequestId = data["RequestId"].int
        var CreateDate = data["CreateDate"].string
        var Date = data["Date"].string
        var Status = data["Status"].string
        var StatusCode = data["StatusCode"].string
        var Money = data["Money"].string
        var EmployeeName = data["EmployeeName"].string
        var ShopName = data["ShopName"].string
        var Note = data["Note"].string
        var UpdateDate = data["UpdateDate"].string
        var ImageSelfie = data["ImageSelfie"].string
        var ImageReceipt = data["ImageReceipt"].string
        
        DocEntry = DocEntry == nil ? 0 : DocEntry
        RequestId = RequestId == nil ? 0 : RequestId
        CreateDate = CreateDate == nil ? "" : CreateDate
        Date = Date == nil ? "" : Date
        Status = Status == nil ? "" : Status
        StatusCode = StatusCode == nil ? "" : StatusCode
        Money = Money == nil ? "" : Money
        EmployeeName = EmployeeName == nil ? "" : EmployeeName
        ShopName = ShopName == nil ? "" : ShopName
        Note = Note == nil ? "" : Note
        UpdateDate = UpdateDate == nil ? "" : UpdateDate
        ImageSelfie = ImageSelfie == nil ? "" : ImageSelfie
        ImageReceipt = ImageReceipt == nil ? "" : ImageReceipt
        
        return DetailsCallLogNopQuyItem(DocEntry: DocEntry!, RequestId: RequestId!, CreateDate: CreateDate!, Date: Date!, Status: Status!, StatusCode: StatusCode!, Money: Money!, EmployeeName: EmployeeName!, ShopName: ShopName!, Note: Note!, UpdateDate: UpdateDate!, ImageSelfie: ImageSelfie!, ImageReceipt: ImageReceipt!)
    }
}
