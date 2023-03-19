//
//  CreateTicketResponseItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation


struct CreateTicketResponseItem : Codable {

        let pData : CreateTicketResponseItemPDatum?
        let pMessages : String?
        let pStatus : Int?

        enum CodingKeys: String, CodingKey {
                case pData = "p_data"
                case pMessages = "p_messages"
                case pStatus = "p_status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                pData = try CreateTicketResponseItemPDatum(from: decoder)
                pMessages = try values.decodeIfPresent(String.self, forKey: .pMessages)
                pStatus = try values.decodeIfPresent(Int.self, forKey: .pStatus)
        }

}

struct CreateTicketResponseItemPDatum : Codable {

        let dataId : Int?
        let message : String?
        let resultCode : Int?

        enum CodingKeys: String, CodingKey {
                case dataId = "data_id"
                case message = "message"
                case resultCode = "resultCode"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                dataId = try values.decodeIfPresent(Int.self, forKey: .dataId)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                resultCode = try values.decodeIfPresent(Int.self, forKey: .resultCode)
        }

}
