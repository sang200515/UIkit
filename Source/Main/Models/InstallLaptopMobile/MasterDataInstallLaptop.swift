//
//  MasterDataInstallLaptopMobile.swift
//  fptshop
//
//  Created by Ngo Dang tan on 15/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
// MARK: - MasterDataInstallLaptop
struct MasterDataInstallLaptop: Codable {
    let success: Bool
    var data: [DataInstallLaptop]

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case data = "Data"
    }
}

// MARK: - Datum
struct DataInstallLaptop: Codable {
    let groupCode, groupName: String
    var items: [ItemDataInstallLaptop]

    enum CodingKeys: String, CodingKey {
        case groupCode = "GroupCode"
        case groupName = "GroupName"
        case items = "Items"
    }
}

// MARK: - Item
struct ItemDataInstallLaptop: Codable {
    let id: Int
    let name: String
    var isSelected: Bool = false
 

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
     
    }
}
// MARK: - ResultInstallationReceipt
struct ResultInstallationReceipt: Codable {
    let success: Bool
    let data: DataInstallationReceipt

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case data = "Data"
    }
}

// MARK: - DataClass
struct DataInstallationReceipt: Codable {
    let pStatus: Int
    let pMessagess: String
    let receiptId: Int?

    enum CodingKeys: String, CodingKey {
        case pStatus = "p_status"
        case pMessagess = "p_messagess"
        case receiptId = "ReceiptId"

    }
}


// MARK: - InstallationReceipt
struct InstallationReceipt: Codable {
    let success: Bool
    let data: [InstallationReceiptData]

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case data = "Data"
    }
}

// MARK: - Datum
struct InstallationReceiptData: Codable {
    let id: Int
    let itemName, phoneNumber, deviceColor, updatedBy: String
    let custFullname, createDate, deviceType, imei: String
    let receiptStatus: String
    let deletButton:Bool
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case itemName = "ItemName"
        case phoneNumber = "PhoneNumber"
        case deviceColor = "DeviceColor"
        case updatedBy = "UpdatedBy"
        case custFullname = "CustFullname"
        case createDate = "CreateDate"
        case deviceType = "DeviceType"
        case imei = "Imei"
        case receiptStatus = "ReceiptStatus"
        case deletButton = "DeleteBtn"

    }
}

// MARK: - DetailInstallationReceipt
struct DetailDeleteInstallationReceipt: Codable {
    let Message: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case Message = "Messagee"
        case success = "Success"
    }
}
// MARK: - DetailInstallationReceipt
struct DetailInstallationReceipt: Codable {
    let data: DetailInstallationReceiptData
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case success = "Success"
    }
}
// MARK: - DataClass
struct DetailInstallationReceiptData: Codable {
    let id: Int
    let receiptURL: String
    let note, imei, currentStatus, phoneNumber: String
    let createDate, deviceColor: String
    let masterData: [MasterDatum]
    let itemName, employeeName, custFullname,problem: String
    let bitLockerStatus:Bool
    let resendOTP:Bool

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case receiptURL = "ReceiptUrl"
        case note = "Note"
        case imei = "Imei"
        case currentStatus = "CurrentStatus"
        case phoneNumber = "PhoneNumber"
        case createDate = "CreateDate"
        case deviceColor = "DeviceColor"
        case masterData = "MasterData"
        case itemName = "ItemName"
        case employeeName = "EmployeeName"
        case custFullname = "CustFullname"
        case bitLockerStatus = "BitLockerStatus"
        case problem = "Problem"
        case resendOTP = "ReSendOtpBtn"

        
    }
}

// MARK: - MasterDatum
struct MasterDatum: Codable {
    let name, groupCode, groupName: String
    let idMasterData: Int
    let deviceType: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case groupCode = "GroupCode"
        case groupName = "GroupName"
        case idMasterData = "Id_MasterData"
        case deviceType = "DeviceType"
    }
}

// MARK: - Send OTP
struct SendOTPForCustomer: Codable {
    let Message: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case Message = "Message"
        case success = "Success"
    }
}

// MARK: - Confirm OTP
struct ConfirmOTPReceipt: Codable {
    let Message: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case Message = "Message"
        case success = "Success"
    }
}

// MARK: - return Device
struct ReturnDevice: Codable {
    let Message: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case Message = "Message"
        case success = "Success"
    }
}
