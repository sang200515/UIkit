//
//  ResponseItemUploadImageFile.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

struct ResponseItemUploadImageFile: Codable {
    let pStatus: Int?
    let pMessages: String?
    struct PData: Codable {
        let message: String?
        let fileInfoFileName: String?
        let fileInfoMessage: String?
        let fileInfoResultCode: Int?
        let fileInfoFileID: String?
        let resultCode: Int?
        private enum CodingKeys: String, CodingKey {
            case message
            case fileInfoFileName = "fileInfo_fileName"
            case fileInfoMessage = "fileInfo_Message"
            case fileInfoResultCode = "fileInfo_ResultCode"
            case fileInfoFileID = "fileInfo_fileID"
            case resultCode
        }
    }
    let pData: PData?
    private enum CodingKeys: String, CodingKey {
        case pStatus = "p_status"
        case pMessages = "p_messages"
        case pData = "p_data"
    }
}
