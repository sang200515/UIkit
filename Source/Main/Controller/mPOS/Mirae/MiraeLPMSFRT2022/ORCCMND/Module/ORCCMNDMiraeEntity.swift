//
//  ORCCMNDMiraeEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

class ORCCMNDMiraeEntity {
    
    class ORCCMNDMiraeModel: Codable {
        let error:Int?
        let success: Bool?
        let message: String?
        let data: ORCCMNDMiraeDataModel?
        
        enum CodingKeys: String, CodingKey {
            case success,message
            case data
            case error
        }
        
        init(success: Bool?, message: String?, data: ORCCMNDMiraeDataModel?,error:Int?) {
            self.success = success
            self.message = message
            self.data = data
            self.error = error
        }
        
    }
    
    // MARK: - DataClass
    class ORCCMNDMiraeDataModel: Codable {
        let customerInfo: CustomerInfo?
            let permanentAddress, residenceAddress: Address?
            let refPerson1, refPerson2: RefPerson?
            let workInfo: WorkInfo?
            let editableField: [EditableField]?

            init(customerInfo: CustomerInfo?, permanentAddress: Address?, residenceAddress: Address?, refPerson1: RefPerson?, refPerson2: RefPerson?, workInfo: WorkInfo?, editableField: [EditableField]?) {
                self.customerInfo = customerInfo
                self.permanentAddress = permanentAddress
                self.residenceAddress = residenceAddress
                self.refPerson1 = refPerson1
                self.refPerson2 = refPerson2
                self.workInfo = workInfo
                self.editableField = editableField
            }
    }
    
    class Address: Codable {
        let street, cityCode, cityName, wardCode: String?
        let wardName: String?
        let districtCode, districtName: String?
        let samePerResAddress: Bool?

        init(street: String?, cityCode: String?, cityName: String?, wardCode: String?, wardName: String?, districtCode: String?, districtName: String?, samePerResAddress: Bool?) {
            self.street = street
            self.cityCode = cityCode
            self.cityName = cityName
            self.wardCode = wardCode
            self.wardName = wardName
            self.districtCode = districtCode
            self.districtName = districtName
            self.samePerResAddress = samePerResAddress
        }
    }
    
    class WorkInfo: Codable {
        let companyName, position, laborContractType: String?
        let yearWorkNum, monthWorkNum: Int?
        let firstPaymentDate, internalCode: String?

        init(companyName: String?, position: String?, laborContractType: String?, yearWorkNum: Int?, monthWorkNum: Int?, firstPaymentDate: String?, internalCode: String?) {
            self.companyName = companyName
            self.position = position
            self.laborContractType = laborContractType
            self.yearWorkNum = yearWorkNum
            self.monthWorkNum = monthWorkNum
            self.firstPaymentDate = firstPaymentDate
            self.internalCode = internalCode
        }
    }
    
    // MARK: - CustomerInfo
    class CustomerInfo: Codable {
        var nationalID, idIssuedDate, idIssuedBy, sex: String?
        var lName, mName, fName, dob: String?
        var mobile: String?
        var empSalary: String?
        
        enum CodingKeys: String, CodingKey {
            case nationalID = "nationalId"
            case idIssuedDate, idIssuedBy, sex, lName, mName, fName, dob, mobile, empSalary
        }
        
        init(nationalID: String?, idIssuedDate: String?, idIssuedBy: String?, sex: String?, lName: String?, mName: String?, fName: String?, dob: String?, mobile: String?, empSalary: String?) {
            self.nationalID = nationalID
            self.idIssuedDate = idIssuedDate
            self.idIssuedBy = idIssuedBy
            self.sex = sex
            self.lName = lName
            self.mName = mName
            self.fName = fName
            self.dob = dob
            self.mobile = mobile
            self.empSalary = empSalary
        }
    }
    
    // MARK: - Permanent
    struct Permanent: Codable {
        var street, cityCode, cityName, wardCode: String?
        var wardName, districtCode, districtName: String?
        var samePerResAddress: Bool?
        
        init(street: String?, cityCode: String?, cityName: String?, wardCode: String?, wardName: String?, districtCode: String?, districtName: String?, samePerResAddress: Bool?) {
            self.street = street
            self.cityCode = cityCode
            self.cityName = cityName
            self.wardCode = wardCode
            self.wardName = wardName
            self.districtCode = districtCode
            self.districtName = districtName
            self.samePerResAddress = samePerResAddress
        }
    }
    
    // MARK: - RefPerson
    class RefPerson: Codable {
        let fullName, relationship, phone: String?
        
        init(fullName: String?, relationship: String?, phone: String?) {
            self.fullName = fullName
            self.relationship = relationship
            self.phone = phone
        }
    }
    
    class EditableField: Codable {
        let fieldID: Int?
        let fieldName: String?

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
