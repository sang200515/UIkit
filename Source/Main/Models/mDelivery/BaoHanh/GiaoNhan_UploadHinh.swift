//
//  GiaoNhan_UploadHinh.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GiaoNhan_UploadHinh: NSObject {
    
    var LinkHinhAnhXacNhan:String
    var LinkHinhAnhChuKy:String
    var Result: String
    var Msg: String
    var LinkHinhAnhChuKyGiaoNhan:String
    
    
    
    init(GiaoNhan_UploadHinh: JSON)
    {
        LinkHinhAnhXacNhan = GiaoNhan_UploadHinh["LinkHinhAnhXacNhan"].stringValue ;
        LinkHinhAnhChuKy = GiaoNhan_UploadHinh["LinkHinhAnhChuKy"].stringValue ;
        Result = GiaoNhan_UploadHinh["Result"].stringValue ;
        Msg = GiaoNhan_UploadHinh["Msg"].stringValue;
        LinkHinhAnhChuKyGiaoNhan = GiaoNhan_UploadHinh["LinkHinhAnhChuKyGiaoNhan"].stringValue;
    }
    
    
}
