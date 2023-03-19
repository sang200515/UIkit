//
//  LCNB_GetDSPhieu.swift
//  NewmDelivery
//
//  Created by sumi on 8/30/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class LCNB_GetDSPhieu: NSObject {
    var U_numref : String
    var ShopXuat: String
    var ShopNhan : String
    var NgayGiao: String
    var NgayNhan : String
    var UserXuat: String
    var UserNhan : String
    var mIsCheck : Bool
    var mBarCode : String
    
    
    init(LCNB_GetDSPhieu: JSON)
    {
        U_numref = LCNB_GetDSPhieu["U_numref"].stringValue;
        ShopXuat = LCNB_GetDSPhieu["ShopXuat"].stringValue;
        ShopNhan = LCNB_GetDSPhieu["ShopNhan"].stringValue;
        NgayGiao = LCNB_GetDSPhieu["NgayGiao"].stringValue;
        NgayNhan = LCNB_GetDSPhieu["NgayNhan"].stringValue;
        UserXuat = LCNB_GetDSPhieu["UserXuat"].stringValue;
        UserNhan = LCNB_GetDSPhieu["UserNhan"].stringValue;
        mIsCheck = false
        mBarCode = ""
    }
    
    
    init(U_numref:String,ShopXuat:String,ShopNhan:String,NgayGiao:String,NgayNhan:String,UserXuat:String,UserNhan:String ,mIsCheck:Bool,mBarCode:String)
    {
        
        
        self.U_numref = U_numref
        self.ShopXuat = ShopXuat
        self.ShopNhan = ShopNhan
        self.NgayGiao = NgayGiao
        self.NgayNhan = NgayNhan
        self.UserXuat = UserXuat
        self.UserNhan = UserNhan
        self.mIsCheck = mIsCheck
        self.mBarCode = mBarCode
    }
    
}
