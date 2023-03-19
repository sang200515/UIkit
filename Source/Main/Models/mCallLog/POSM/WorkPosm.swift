//
//  WorkPosm.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class WorkPosm: NSObject {
    var Assigner:String
    var AssignerName:String
    var CreateDateTime:String
    var RequestId:String
    var RequestTitle:String
    var RequestTypeId:String
    var Sender:String
    var SenderName:String
    var Status:String
    var StatusApprove:String
    init(  Assigner:String
           , AssignerName:String
           , CreateDateTime:String
           , RequestId:String
           , RequestTitle:String
           , RequestTypeId:String
           , Sender:String
           , SenderName:String
           , Status:String
           , StatusApprove:String){
        self.Assigner = Assigner
        self.AssignerName = AssignerName
        self.CreateDateTime = CreateDateTime
        self.RequestId = RequestId
        self.RequestTitle = RequestTitle
        self.RequestTypeId = RequestTypeId
        self.Sender = Sender
        self.SenderName = SenderName
        self.Status = Status
        self.StatusApprove = StatusApprove
    }
    class func parseObjfromArray(array:[JSON])->[WorkPosm]{
        var list:[WorkPosm] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> WorkPosm{
        
        var Assigner = data["Assigner"].string
        var AssignerName = data["AssignerName"].string
        var CreateDateTime = data["CreateDateTime"].string
        var RequestId = data["RequestId"].string
        var RequestTitle = data["RequestTitle"].string
        var RequestTypeId = data["RequestTypeId"].string
        var Sender = data["Sender"].string
        var SenderName = data["SenderName"].string
        var Status = data["Status"].string
        var StatusApprove = data["StatusApprove"].string
        
        Assigner = Assigner == nil ? "" : Assigner
        AssignerName = AssignerName == nil ? "" : AssignerName
        CreateDateTime = CreateDateTime == nil ? "" :CreateDateTime
        RequestId = RequestId == nil ? "" : RequestId
        RequestTitle = RequestTitle == nil ? "" : RequestTitle
        RequestTypeId = RequestTypeId == nil ? "" : RequestTypeId
        Sender = Sender == nil ? "" : Sender
        SenderName = SenderName == nil ? "" : SenderName
        Status = Status == nil ? "" : Status
        StatusApprove = StatusApprove == nil ? "" : StatusApprove
        return WorkPosm(Assigner:Assigner!
                        , AssignerName:AssignerName!
                        , CreateDateTime:CreateDateTime!
                        , RequestId:RequestId!
                        , RequestTitle:RequestTitle!
                        , RequestTypeId:RequestTypeId!
                        , Sender:Sender!
                        , SenderName:SenderName!
                        , Status:Status!
                        , StatusApprove:StatusApprove!
        )
    }
}
