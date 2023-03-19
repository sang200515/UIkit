//
//  mDel_ReportNotificationResult.swift
//  NewmDelivery
//
//  Created by sumi on 6/15/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class mDel_ReportNotificationResult: NSObject {
    
    var ID: String
    var Title: String
    var Messages: String
    var AppStatus:String
    
    
    init(mDel_ReportNotificationResult: JSON)
    {
        ID = mDel_ReportNotificationResult["ID"].stringValue ;
        Title = mDel_ReportNotificationResult["Title"].stringValue;
        Messages = mDel_ReportNotificationResult["Messages"].stringValue;
        AppStatus = mDel_ReportNotificationResult["AppStatus"].stringValue;
    }
    
}

