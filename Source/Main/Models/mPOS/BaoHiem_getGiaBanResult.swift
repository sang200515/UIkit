//
//  BaoHiem_getGiaBanResult.swift
//  mPOS
//
//  Created by sumi on 7/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaoHiem_getGiaBanResult: NSObject {
    
    var GiaBHXeMay: Int
    var GiaBHNgoiSau: Int
    var GiaTong: Int
    var GiaFRT:Int
    
    init(GiaBHXeMay:Int,GiaBHNgoiSau:Int,GiaTong: Int,GiaFRT:Int){
        
        self.GiaBHXeMay = GiaBHXeMay
        self.GiaBHNgoiSau = GiaBHNgoiSau
        self.GiaTong = GiaTong
        self.GiaFRT = GiaFRT
    }
    
    class func parseObjfromArray(array:[JSON])->[BaoHiem_getGiaBanResult]{
        var list:[BaoHiem_getGiaBanResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BaoHiem_getGiaBanResult{
        var GiaBHXeMay = data["GiaBHXeMay"].int
        var GiaBHNgoiSau = data["GiaBHNgoiSau"].int
        var GiaTong = data["GiaTong"].int
        var GiaFRT = data["GiaFRT"].int
        
        GiaBHXeMay = GiaBHXeMay == nil ? 0: GiaBHXeMay
        GiaBHNgoiSau = GiaBHNgoiSau == nil ? 0 : GiaBHNgoiSau
        GiaTong = GiaTong == nil ? 0 : GiaTong
        GiaFRT = GiaFRT == nil ? 0 : GiaFRT
        return BaoHiem_getGiaBanResult(GiaBHXeMay: GiaBHXeMay!, GiaBHNgoiSau: GiaBHNgoiSau!,GiaTong:GiaTong!,GiaFRT:GiaFRT!)
    }
}
