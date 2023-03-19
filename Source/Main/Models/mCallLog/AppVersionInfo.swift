//
//  AppVersionInfo.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 03/10/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class AppVersionInfo: Jsonable{
    required init(json: JSON) {
        Id = json["ID"].int ?? 0;
        CurrentRemoteVersion = json["Version"].string ?? "";
        Description = json["Description"].string ?? "";
        ReleasedDate = json["ReleaseDate"].string ?? "";
        UpdateURL = json["GooglePlayURL"].string ?? "";
        DeviceType = json["DeviceType"].string ?? "";
        IsUpdated = json["IsUpdate"].int ?? 0;
        Message = json["NoiDung"].string ?? "";
    }
    
    var Id: Int?;
    var CurrentRemoteVersion: String?;
    var Description: String?;
    var ReleasedDate: String?;
    var UpdateURL: String?;
    var DeviceType: String?;
    var IsUpdated: Int?;
    var Message:String?;
}
