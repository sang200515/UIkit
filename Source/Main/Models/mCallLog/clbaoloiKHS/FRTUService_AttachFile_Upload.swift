//
//  FRTUService_AttachFile_Upload.swift
//  fptshop
//
//  Created by DiemMy Le on 8/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//{
//  "p_status": 0,
//  "p_messages": "string",
//  "p_data": {
//    "message": "string",
//    "fileInfo_fileName": "string",
//    "fileInfo_Message": "string",
//    "fileInfo_ResultCode": 0,
//    "fileInfo_fileID": "string",
//    "resultCode": 0
//  }
//}
//- p_status: 0:Thành công ; Khác 0:Lỗi
//- p_messages: Nội dung Thông báo
//- fileInfo_fileID: ID file, app lưu lại giá trị này sau khi upload, để truyền sang API tạo ticket

import UIKit
import SwiftyJSON

class FRTUService_AttachFile_Upload: NSObject {

    let p_status:Int
    let p_messages:String
    
    let message_data:String
    let fileInfo_fileName:String
    let fileInfo_Message:String
    let fileInfo_ResultCode:Int
    let fileInfo_fileID:String
    let resultCode_data:Int
    
    init(p_status:Int, p_messages:String, message_data:String, fileInfo_fileName:String, fileInfo_Message:String, fileInfo_ResultCode:Int, fileInfo_fileID:String, resultCode_data:Int) {
        
        self.p_status = p_status
        self.p_messages = p_messages
        self.message_data = message_data
        self.fileInfo_fileName = fileInfo_fileName
        self.fileInfo_Message = fileInfo_Message
        self.fileInfo_ResultCode = fileInfo_ResultCode
        self.fileInfo_fileID = fileInfo_fileID
        self.resultCode_data = resultCode_data
    }
    
    class func getObjFromDictionary(data:JSON) -> FRTUService_AttachFile_Upload {
        
        var p_status = data["p_status"].int
        var p_messages = data["p_messages"].string
        
        let p_data = data["p_data"]
        var message_data = p_data["message"].string
        var fileInfo_fileName = p_data["fileInfo_fileName"].string
        var fileInfo_Message = p_data["fileInfo_Message"].string
        var fileInfo_ResultCode = p_data["fileInfo_ResultCode"].int
        var fileInfo_fileID = p_data["fileInfo_fileID"].string
        var resultCode_data = p_data["resultCode"].int
        
        p_status = p_status == nil ? 0 : p_status
        p_messages = p_messages == nil ? "" : p_messages
        message_data = message_data == nil ? "" : message_data
        fileInfo_fileName = fileInfo_fileName == nil ? "" : fileInfo_fileName
        fileInfo_Message = fileInfo_Message == nil ? "" : fileInfo_Message
        fileInfo_ResultCode = fileInfo_ResultCode == nil ? 0 : fileInfo_ResultCode
        fileInfo_fileID = fileInfo_fileID == nil ? "" : fileInfo_fileID
        resultCode_data = resultCode_data == nil ? 0 : resultCode_data
        
        return FRTUService_AttachFile_Upload(p_status: p_status!, p_messages: p_messages!, message_data: message_data!, fileInfo_fileName: fileInfo_fileName!, fileInfo_Message: fileInfo_Message!, fileInfo_ResultCode: fileInfo_ResultCode!, fileInfo_fileID: fileInfo_fileID!, resultCode_data: resultCode_data!)
    }
}
