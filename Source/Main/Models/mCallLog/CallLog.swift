//
//  CallLog.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 31/08/2018.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class CallLog: Jsonable {
    required init(json: JSON) {
        AssignToUserCode = json["AssignToUserCode"].string ?? "";
        CommentLast = json["CommentLast"].string ?? "";
        CreateDateTime = json["CreateDateTime"].string ?? "";
        CreateUpdateTimeCM = json["CreateUpdateTimeCM"].string ?? "";
        EmployeeName = json["EmployeeName"].string ?? "";
        Function = json["Function"].string ?? "";
        IsAlertPending = json["IsAlertPending"].string ?? "";
        RequestDesc = json["RequestDesc"].string ?? "";
        RequestID = json["RequestID"].int ?? 0;
        RequestStatus = json["RequestStatus"].string ?? "";
        RequestTitle = json["RequestTitle"].string ?? "";
        RequestTypeDesc = json["RequestTypeDesc"].string ?? "";
        RequestTypeID = json["RequestTypeID"].int ?? 0;
        StepNo = json["StepNo"].int ?? 0;
        SubjectName = json["SubjectName"].string ?? "";
        TimeUnsettled = json["TimeUnsettled"].string ?? "";
        UserSendCode = json["UserSendCode"].string ?? "";
        LinkFileAttached = json["LinkFileAttached"].int ?? 0;
    }
    
    var AssignToUserCode: String?;
    var CommentLast: String?;
    var CreateDateTime: String?;
    var CreateUpdateTimeCM: String?;
    var EmployeeName: String?;
    var Function: String?;
    var IsAlertPending: String?;
    var RequestDesc: String?;
    var RequestID: Int?;
    var RequestStatus: String?;
    var RequestTitle: String?;
    var RequestTypeDesc: String?;
    var RequestTypeID: Int?;
    var StepNo: Int?;
    var SubjectName: String?;
    var TimeUnsettled: String?;
    var UserSendCode: String?;
    var LinkFileAttached: Int?;
}
