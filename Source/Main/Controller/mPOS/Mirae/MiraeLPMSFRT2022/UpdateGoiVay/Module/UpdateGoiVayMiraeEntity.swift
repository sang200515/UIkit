//
//  UpdateGoiVayMiraeEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

struct UpdateGoiVayMiraeEntity:Decodable {
    class ResubmitModel: Codable {
        let success: Bool?
        let message: String?
        let continueUpdateBtn: Bool?

        init(success: Bool?, message: String?, continueUpdateBtn: Bool?) {
            self.success = success
            self.message = message
            self.continueUpdateBtn = continueUpdateBtn
        }
    }

}
