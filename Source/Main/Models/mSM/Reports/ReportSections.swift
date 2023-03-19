//
//  ReportSections.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 08/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class ReportSections: Jsonable{
    required init?(json: JSON) {
        self.Permission = json["Permission"].string ?? "";
        self.PositionCode = json["PositionCode"].string ?? "";
        self.PositionName = json["PositionName"].string ?? "";
        
        let permissionArray = Permission!.components(separatedBy: ",");
        var permissionsInt = [Int]();
        debugPrint("AAAA_\(Permission!)_")
        if(Permission! != "" &&  permissionArray.count > 0){
            permissionArray.forEach{ permission in
                if(Int(permission) != nil){
                    permissionsInt.append(Int(permission)!);
                }
            }
            
            permissionsInt.sort{ $0 < $1 };
            
            debugPrint(permissionArray)
            for item in permissionsInt {
                debugPrint(item);
                if(PermissionHashCode(rawValue: item) != nil){
                    let it = PermissionHashCode(rawValue: item)!
                    self.Permissions.append(it)
                }
            }
        }
        //        Permissions = permissionArray.map{ PermissionHashCode(rawValue: $0 as? Int ?? 0)! };
    }
    
    fileprivate var Permission: String?;
    var Permissions: [PermissionHashCode] = []
    var PositionCode: String?;
    var PositionName: String?;
}
