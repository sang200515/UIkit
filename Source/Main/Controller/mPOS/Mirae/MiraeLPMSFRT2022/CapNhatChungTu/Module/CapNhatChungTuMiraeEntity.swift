//
//  CapNhatChungTuMiraeEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

class CapNhatChungTuMiraeEntity {
    
    class UploadHinhModel: Codable {
        let success: Bool
        let message: String

        init(success: Bool, message: String) {
            self.success = success
            self.message = message
        }
    }
    
    class LyDoHuyModel: Codable {
        let success: Bool?
        let data: [DataLyDoHuyModel]?

        init(success: Bool?, data: [DataLyDoHuyModel]?) {
            self.success = success
            self.data = data
        }
    }

    // MARK: - DataLyDoHuyModel
    class DataLyDoHuyModel: Codable {
        let text: String?

        init(text: String?) {
            self.text = text
        }
    }
    
    class MoiQuanHeModel: Codable {
        let success: Bool?
        let data: [DataMoiQuanHeModel]?

        init(success: Bool?, data: [DataMoiQuanHeModel]?) {
            self.success = success
            self.data = data
        }
    }

    // MARK: - Datum
    class DataMoiQuanHeModel: Codable {
        let value: String?

        init(value: String?) {
            self.value = value
        }
    }
    
    class LoaiChungTuModel: Codable {
        let success: Bool?
        let data: [DataLoaiChungTuModel]?

        init(success: Bool?, data: [DataLoaiChungTuModel]?) {
            self.success = success
            self.data = data
        }
    }

    // MARK: - Datum
    class DataLoaiChungTuModel: Codable {
        let code, name: String?

        init(code: String?, name: String?) {
            self.code = code
            self.name = name
        }
    }
    
    class UpdateThongTinCongViecModel: Codable {
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
