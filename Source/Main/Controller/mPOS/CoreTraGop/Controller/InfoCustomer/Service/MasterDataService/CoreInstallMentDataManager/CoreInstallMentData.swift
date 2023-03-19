import Foundation
//
//  CoreInstallMentData.swift
//  QuickCode
//
//  Created by Sang Trương on 16/07/2022.
//
import UIKit

class CoreInstallMentData {
	static let shared = CoreInstallMentData()
    var searchID:String = ""


	//MARK: image CMNND
	var frontImageIDCard: UIImage? = nil
	var backImageIDCard: UIImage? = nil
	//MARK: customer info detech cmnd
	var customerInforFromDetechCMND: DetechCMNDModel?
	var customerName: String = ""
	//MARK: thuong tru
	var diaChiThuongTru: String = ""
	var houseNumberThuongTru: String = ""
	var streetThuongTru: String = ""
	var cityThuongTru: String = ""
	var districtThuongTru: String = ""
	var wardThuongTru: String = ""

	//MARK: tam tru
	var diaChiTamTru: String = ""
	var houseNumberTamTru: String = ""
	var streetTamTru: String = ""
	var cityTamTru: String = ""
	var districtTamTru: String = ""
	var wardTamTru: String = ""

	//MARK: Flow tao
    var isCreatedCompany:Bool = false
    var isCreatedCompanyAddress:Bool = false
    var isCreateNguoiLienHe:Bool = false
    var isCreateRelateProfile:Bool = false

	var userCode: String = ""
	var idCard: String = ""
	var firstName: String = ""
    var idCardType: Int = 0

	var middleName: String = ""
	var lastName: String = ""
	var email: String = ""
	var gender: Int = 0
	var birthDate: String = ""
	var phone: String = ""
	var idCardIssuedBy: String = ""
    var idCardIssuedByCode: String = ""
	var idCardIssuedDate: String = ""
	var idCardIssuedExpiration: String = ""
    var relatedDocumentType: String = ""
	var relatedDocument: [CreateRelatedDocument]?
	var company: [CreateCompany]?
	var refPersons: [CreateRefPersons]?
	var addresses: [CreateAddresses]?
	var uploadFiles: [UploadFiles]?
	var id: String = ""
    var listIndexSHKAdded:[Int] = []

	//MARK: - Người liên hệ

	var listNguoiLienHe = [[String: Any]]()
	var itemNguoiLienHe: [String: Any] = [:]
	var infoCustomerCompanyDetail: [String: Any] = [:] //bo?
    var listDiaChi : [[String: Any]] = []
    var itemDiaChiThuongTru: [String: Any] = [:]
    var itemDiaChiTamTru: [String: Any] = [:]
    var itemDiaChiCty: [String: Any] = [:]
	var itemDiaChiCtyDetail: [String: Any] = [:]
	var itemGiayTo: [String: Any] = [:]
	var filePath = [[String: Any]]()
    var pathCMNDfront: [String: Any] = [:]
    var pathCMNDBack: [String: Any] = [:]
    var pathChanDung: [String: Any] = [:]
    var paththueBao: [String: Any] = [:]
    var listLienHeImage:[[String: Any]] = []
    var listChungTuImage:[[String: Any]] = []
    var listSHKImage:[[String: Any]] = []
    var pathGPLXfront: [String: Any] = [:]
    var pathhGPLXBack: [String: Any] = [:]
    func resetParamCreate(){
        isCreatedCompany = false
        isCreatedCompanyAddress = false
        isCreateNguoiLienHe = false
        isCreateRelateProfile = false
        listNguoiLienHe = [[:]]
        itemNguoiLienHe = [:]
        infoCustomerCompanyDetail = [:]
        listDiaChi = [[:]]
        itemDiaChiThuongTru = [:]
        itemDiaChiTamTru = [:]
        itemDiaChiCty = [:]
        itemDiaChiCtyDetail = [:]
        itemGiayTo = [:]
        filePath = [[:]]
        pathCMNDfront = [:]
        pathCMNDBack = [:]
        pathChanDung = [:]
        paththueBao = [:]
        listLienHeImage = [[:]]
        listChungTuImage = [[:]]
        listSHKImage = [[:]]
        pathGPLXfront = [:]
        pathhGPLXBack = [:]
        middleName = ""
        lastName = ""
        email = ""
        gender = 0
        birthDate = ""
        phone = ""
        idCardIssuedBy = ""
        idCardIssuedDate = ""
        idCardIssuedExpiration = ""


    }
//MARK: Mapping
    var infoCustomerMapping:MasterDataInstallMent?

        //MARK: Flow edit
    var editInCome: Int = 0
    var editID: Int = 0
    var editUserCode: String = ""
    var editIdCard: String = ""
    var editFirstName: String = ""
    var editMiddleName: String = ""
    var editLastName: String = ""
    var editEmail: String = ""
    var editGender: Int = 0
    var editIdCardType: Int = 0
    var editBirthDate: String = ""
    var editPhone: String = ""
    var editIdCardIssuedBy: String = ""
    var editIdCardIssuedByCode: String = ""
    var editIdCardIssuedDate: String = ""
    var editIdCardIssuedExpiration: String = ""
    var editId: String = ""
    var editDiachiCty: String = ""
    var editfullAddressCompany: String = ""
    var editrelatedDocumentType: String?
    var editItemDiaChiTT: [String: Any] = [:]
    var editItemDiaChiTamTru: [String: Any] = [:]
    var editItemNguoiLienHe1: [String: Any] = [:]
    var editItemListNguoiLienHe: [[String: Any]] = [[:]]
    var editItemNguoiLienHe2: [String: Any] = [:]
    var editCompanyDetail: [String: Any] = [:]
    var editItemDiaChi: [String: Any] = [:]
    var ediItemDocument: [String: Any] = [:]
    var editPathIDCardFront: [String: Any] = [:]
    var editPathIDCardBack: [String: Any] = [:]
    var editPathChanDung: [String: Any] = [:]
    var editPathIDThueBao: [String: Any] = [:]
    var editPathIDDLFront: [String: Any] = [:]
    var editPathIDDLBack: [String: Any] = [:]
    var editListSHKImage: [[String: Any]] = [[:]]
    var editFrontIDCardImg:UIImage?
    var editBackIDCardImg:UIImage?
    var editFrontGPLX:UIImage?
    var editBackIDGPLX:UIImage?
    var listSHKImageCache:[UIImage] = []


    func resetParamEdit(){
        editInCome = 0
        editDiachiCty = ""
        editID = 0
        editUserCode = ""
        editIdCard =  ""
        editFirstName =  ""
        editMiddleName =  ""
        editLastName =  ""
        editEmail = ""
        editGender = 0
        editIdCardType = 0
        editBirthDate = ""
        editPhone = ""
        editIdCardIssuedBy = ""
        editIdCardIssuedByCode = ""
        editIdCardIssuedDate = ""
        editIdCardIssuedExpiration = ""
        editId = ""
        editrelatedDocumentType = ""
        editItemDiaChiTT = [:]
        editItemDiaChiTamTru = [:]
        editItemNguoiLienHe1 = [:]
        editItemListNguoiLienHe =  [[:]]
        editItemNguoiLienHe2 = [:]
        editCompanyDetail = [:]
        editItemDiaChi = [:]
        ediItemDocument = [:]
        editPathIDCardFront = [:]
        editPathIDCardBack = [:]
        editPathChanDung = [:]
        editPathIDThueBao = [:]
        editPathIDDLFront = [:]
        editPathIDDLBack = [:]
        editListSHKImage =  [[:]]
        editFrontIDCardImg = UIImage()
        editBackIDCardImg = UIImage()
        editFrontGPLX = UIImage()
        editBackIDGPLX = UIImage()
        listSHKImageCache = []










    }

	private func validateParamsCreateProfile() -> Bool {
		guard userCode != "" else { return false }
		guard idCard != "" else { return false }
		guard middleName != "" else { return false }
		guard lastName != "" else { return false }
		guard email != "" else { return false }
		guard gender != 2 else { return false }
		guard birthDate != "" else { return false }
		guard phone != "" else { return false }
		guard idCardIssuedBy != "" else { return false }
		guard idCardIssuedDate != "" else { return false }
		guard idCardIssuedExpiration != "" else { return false }
		guard let relatedDocument = relatedDocument, !relatedDocument.isEmpty else { return false }
		guard let company = company, !company.isEmpty else { return false }
		guard let refPersons = refPersons, !refPersons.isEmpty else { return false }
		guard let addresses = addresses, !addresses.isEmpty else { return false }
		guard let uploadFiles = uploadFiles, !uploadFiles.isEmpty else { return false }
		guard id != "" else { return false }
		return true
	}
}
