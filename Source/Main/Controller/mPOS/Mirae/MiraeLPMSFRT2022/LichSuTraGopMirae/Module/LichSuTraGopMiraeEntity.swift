//
//  LichSuTraGopMiraeEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

class LichSuTraGopMiraeEntity {
    
    class LichSuTraGopMiraeModel: Codable {
        let success: Bool?
        let message: String?
        let data: [DataLichSuTraGopMiraeModel]?
        
        enum CodingKeys: String, CodingKey {
            case success,message,data
        }
        
        init(success: Bool?, message: String?, data: [DataLichSuTraGopMiraeModel]?) {
            self.success = success
            self.message = message
            self.data = data
        }
    }
    
    // MARK: - Datum
    class DataLichSuTraGopMiraeModel: Codable {
        let appDocEntry: Int?
        let applicationID: String?
        let soMPOS: Int?
        let idCard, cancelReason, status, statusCode: String?
        let statusColor, createDate, fullName,phone: String?

            enum CodingKeys: String, CodingKey {
                case appDocEntry
                case applicationID = "applicationId"
                case soMPOS, idCard, cancelReason, status, statusCode, statusColor, createDate, fullName,phone
            }

            init(appDocEntry: Int?, applicationID: String?, soMPOS: Int?, idCard: String?, cancelReason: String?, status: String?, statusCode: String?, statusColor: String?, createDate: String?, fullName: String?,phone: String?) {
                self.appDocEntry = appDocEntry
                self.applicationID = applicationID
                self.soMPOS = soMPOS
                self.idCard = idCard
                self.cancelReason = cancelReason
                self.status = status
                self.statusCode = statusCode
                self.statusColor = statusColor
                self.createDate = createDate
                self.fullName = fullName
                self.phone = phone
            }
    }
    
    struct SearchType {
        let id:Int
        let value:String
    }
}
