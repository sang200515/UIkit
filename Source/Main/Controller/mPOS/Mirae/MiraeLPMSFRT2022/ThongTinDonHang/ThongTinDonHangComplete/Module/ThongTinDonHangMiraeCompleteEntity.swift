//
//  ThongTinDonHangCompleteEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

struct ThongTinDonHangMiraeCompleteEntity:Decodable {
    class LuuDonHangAndCustomerModel: Codable {
        let success: Bool?
        let message: String?
        let mposSoNum: Int?

        init(success: Bool?, message: String?, mposSoNum: Int?) {
            self.success = success
            self.message = message
            self.mposSoNum = mposSoNum
        }
    }
}
