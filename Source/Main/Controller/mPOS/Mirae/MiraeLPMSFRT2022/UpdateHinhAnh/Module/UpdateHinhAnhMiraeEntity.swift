//
//  UpdateHinhAnhMiraeEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation
import UIKit

struct UpdateHinhAnhMiraeEntity:Decodable {
    
    class UpdateHinhAnhModel: Codable {
        let success: Bool?
        let message: String?
        let editableField: [EditableField]?

        init(success: Bool?, message: String?, editableField: [EditableField]?) {
            self.success = success
            self.message = message
            self.editableField = editableField
        }
    }

    // MARK: - EditableField
    class EditableField: Codable {
        let fieldID: Int?
        let fieldName: String?
        var image:UIImage?

        enum CodingKeys: String, CodingKey {
            case fieldID = "fieldId"
            case fieldName
        }

        init(fieldID: Int?, fieldName: String?) {
            self.fieldID = fieldID
            self.fieldName = fieldName
        }
    }

}
