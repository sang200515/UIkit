//
//  CapNhatChungTuMiraePresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Alamofire
import UIKit

//MARK:- Input View to Presenter
class CapNhatChungTuMiraePresenter: CapNhatChungTuMiraeViewToPresenterProtocol {

	var isUpMoreSoHK: Bool = false
	var model: LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel?

	var modelLyDoHuy: [CapNhatChungTuMiraeEntity.DataLyDoHuyModel] = []
	var modelMoiQuanHe: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel] = []
	var modelLoaiHopDong: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel] = []
	var modelLoaiChungTu: [CapNhatChungTuMiraeEntity.DataLoaiChungTuModel] = []
	var modelNgayThanhToan: [CapNhatChungTuMiraeEntity.DataLoaiChungTuModel] = []
	var modelChucVu: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel] = []
	var modelMaNoiBo: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel] = []
	var codeLoaiChungTu: String = ""
	var modelWorkInfo: [ThongTinKhachHangMireaEntity.ParamCustomer] = []
	//data core
	private var detailDataMapping: MasterDataInstallMent?
	private var listUploadImage: [UploadFilesMapping] = []
	private var listSHKImage: [UploadFilesMapping] = []
	weak var view: CapNhatChungTuMiraePresenterToViewProtocol?

	var interactor: CapNhatChungTuMiraePresenterToInteractorProtocol?
	var countUpload: Int = 0
	var countUploadImageSHK: Int = 5
	var router: CapNhatChungTuMiraePresenterToRouterProtocol?

	func viewDidLoad() {
		self.modelWorkInfo = [
			ThongTinKhachHangMireaEntity.ParamCustomer(key: "companyName", value: ""),
			ThongTinKhachHangMireaEntity.ParamCustomer(key: "position", value: ""),
			ThongTinKhachHangMireaEntity.ParamCustomer(key: "laborContractType", value: ""),
			ThongTinKhachHangMireaEntity.ParamCustomer(key: "yearWorkNum", value: 0),
			ThongTinKhachHangMireaEntity.ParamCustomer(key: "monthWorkNum", value: 0),
			ThongTinKhachHangMireaEntity.ParamCustomer(key: "firstPaymentDate", value: ""),
			ThongTinKhachHangMireaEntity.ParamCustomer(key: "internalCode", value: ""),
		]
		guard let userCode = UserDefaults.standard.getUsernameEmployee() else { return }
		self.interactor?.loadLyDoHuy(
			userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)")
		getMasterDataInstallMent()
	}

	private func getMasterDataInstallMent() {

		Provider.shared.coreInstallmentService.getMasterDataInstallMent(
            idCard:  CoreInstallMentData.shared.editIdCard,
			success: { [weak self] result in
				guard let self = self else { return }
				guard let respone = result else { return }
				self.detailDataMapping = result
				self.view?.didLoadInfoCore(model: respone)
				self.listUploadImage = respone.uploadFiles ?? []
				self.listSHKImage = self.listUploadImage.filter({
					$0.insHouseUploadFile?.miraeCode == "6"
				})
                self.listUploadImage.removeAll {
					$0.insHouseUploadFile?.miraeCode == "6"
				}
                self.listSHKImage.forEach { item in
                    self.countUploadImageSHK += 1
                    item.insHouseUploadFile?.miraeCode = "\(self.countUploadImageSHK)"
                }
                self.listUploadImage.append(contentsOf: self.listSHKImage)
				self.listUploadImage.removeAll(where: { $0.insHouseUploadFile?.miraeCode == nil })
				if self.listUploadImage.count > 0 {
					self.downLoadIMage(
						url: self.listUploadImage[self.countUpload].urlImage ?? "",
						fileID: Int(
							PARTNERID == "FPT" ? self.listUploadImage[self.countUpload].insHouseUploadFile?
                                .miraeCode ?? "" : self.listUploadImage[self.countUpload].insHouseUploadFile?
                                .compCode ?? "") ?? 0)
				}
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.outPutFailed(error: error.description)
			})
	}

	private func uploadImageCore() {
		if listUploadImage.count == self.countUpload { return }
		self.downLoadIMage(
			url: listUploadImage[countUpload].urlImage ?? "",
			fileID: Int(listUploadImage[countUpload].insHouseUploadFile?.miraeCode ?? "") ?? 0)
	}

	private func downLoadIMage(url: String, fileID: Int) {
		AF.request(url, method: .get).response { [weak self] response in
			guard let self = self else { return }
			switch response.result {
			case .success(let responseData):
				let imageView = UIImage(data: responseData!, scale: 1)
				//                    self.myImageView.image = UIImage(data: responseData!, scale:1)
				if let imageData: NSData = imageView?.jpegData(compressionQuality: 0.1) as NSData? {
					let base64Str = imageData.base64EncodedString(options: .lineLength64Characters)
					self.uploadHinhHoSo(
						base64: base64Str, fileId: fileID, image: imageView ?? UIImage())

				}
			case .failure(let error):
				print("error--->", error)
			}
		}

	}

	func uploadHinhHoSo(base64: String, fileId: Int, image: UIImage) {
		self.view?.showLoading(message: "")
		guard let userCode = UserDefaults.standard.getUsernameEmployee() else { return }
		self.interactor?.uploadHinhHoSo(
			userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)",
			base64: base64, fileId: fileId, appDocEntry: self.model?.appDocEntry ?? 0,
			applicationId: "_FPT", image: image)
	}

	func updateThongTinCongViec() {
		guard let userCode = UserDefaults.standard.getUsernameEmployee() else { return }
		self.interactor?.uploadCapNhatChungTu(
			applicationId: self.model?.applicationID ?? "", userCode: userCode,
			shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)",
			appDocEntry: "\(self.model?.appDocEntry ?? 0)", workInfo: self.createParamWorkInfo(),
			documentType: self.codeLoaiChungTu)
	}

	private func createParamWorkInfo() -> [String: Any] {
		var model: [String: Any] = [String: Any]()
		self.modelWorkInfo.forEach { item in
			model[item.key] = item.value
		}
		return model
	}

}

//MARK: -Out Presenter To View
extension CapNhatChungTuMiraePresenter: CapNhatChungTuMiraeInteractorToPresenterProtocol {

	func uploadCapNhatChungTuSuccess(message: String) {
		self.view?.didUploadCapNhatChungTuSuccess(message: message)
	}

	func uploadHinhSuccess(message: String, tag: Int, image: UIImage) {
		self.view?.didUploadHinhSuccess(message: message, tag: tag, image: image)
        
        if self.countUpload < listUploadImage.count {
            countUpload += 1
            uploadImageCore()
        }
	}

	func loadNgayThanhToanSuccess(model: [CapNhatChungTuMiraeEntity.DataLoaiChungTuModel]) {
		self.modelNgayThanhToan = model
	}

	func loadLyDoHuySuccess(model: [CapNhatChungTuMiraeEntity.DataLyDoHuyModel]) {
		self.modelLyDoHuy = model
	}

	func loadMoiQuanHeSuccess(model: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel]) {
		self.modelMoiQuanHe = model
	}

	func loadLoaiHopDongSuccess(model: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel]) {
		self.modelLoaiHopDong = model
	}

	func loadLoaiChungTuSuccess(model: [CapNhatChungTuMiraeEntity.DataLoaiChungTuModel]) {
		self.modelLoaiChungTu = model
	}

	func loadLoaiChucVuSuccess(model: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel]) {
		self.modelChucVu = model
	}

	func loadMaNoiBoSuccess(model: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel]) {
		self.modelMaNoiBo = model
	}

	func outPutSuccess(message: String) {
		self.view?.outPutFailed(error: message)
	}

	func outPutFailed(error: String) {
		self.view?.outPutFailed(error: error)
	}

	func showLoading(message: String) {
		self.view?.showLoading(message: message)
	}

	func hideLoading() {
		self.view?.hideLoading()
	}

}
