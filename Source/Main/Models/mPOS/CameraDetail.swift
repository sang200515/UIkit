//
//  CameraDetail.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 5/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CameraDetail: NSObject {
    var MaShop:String
    var TenShop:String
    var LinkCamera:String
    var STTCamera:Int
    var TenCamera:String
    var p_Type:Int

    init(MaShop:String, TenShop:String, LinkCamera:String, STTCamera:Int, TenCamera:String, p_Type:Int){
        self.MaShop = MaShop
        self.TenShop = TenShop
        self.LinkCamera = LinkCamera
        self.STTCamera = STTCamera
        self.TenCamera = TenCamera
        self.p_Type = p_Type
        
    }
    
    class func parseObjfromArray(array:[JSON])->[CameraDetail]{
        var list:[CameraDetail] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CameraDetail{
        
        var MaShop = data["MaShop"].string
        var TenShop = data["TenShop"].string
        var LinkCamera = data["LinkCamera"].string
        var STTCamera = data["STTCamera"].int
        var TenCamera = data["TenCamera"].string
        var p_Type = data["p_Type"].int
   
        MaShop = MaShop == nil ? "" : MaShop
        TenShop = TenShop == nil ? "" : TenShop
        LinkCamera = LinkCamera == nil ? "" : LinkCamera
        STTCamera = STTCamera == nil ? 0 : STTCamera
        TenCamera = TenCamera == nil ? "" : TenCamera
        p_Type = p_Type == nil ? 0 : p_Type
        
        
        return CameraDetail(MaShop:MaShop!, TenShop:TenShop!, LinkCamera:LinkCamera!, STTCamera:STTCamera!, TenCamera:TenCamera!, p_Type:p_Type!)
    }
}

