//
//  UpdateHinhAnhMiraePresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

//MARK:- Input View to Presenter
class UpdateHinhAnhMiraePresenter : UpdateHinhAnhMiraeViewToPresenterProtocol {
    
    var model:[UpdateHinhAnhMiraeEntity.EditableField] = [UpdateHinhAnhMiraeEntity.EditableField]()

    var modelLichSu:LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel?
    
    weak var view: UpdateHinhAnhMiraePresenterToViewProtocol?
    
    var interactor: UpdateHinhAnhMiraePresenterToInteractorProtocol?
    
    var router: UpdateHinhAnhMiraePresenterToRouterProtocol?
    
    func viewDidLoad() {
        self.view?.showLoading(message: "Đang tải dữ liệu")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.loadAnhConThieu(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", appDocEntry: "\(self.modelLichSu?.appDocEntry ?? 0)")
    }
    
    func updateHinhConThieu() {
        self.view?.showLoading(message: "Đang tải dữ liệu")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.updateHinhConThieu(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", appDocEntry: "\(self.modelLichSu?.appDocEntry ?? 0)")
    }
    
    func uploadHinhHoSo(base64: String, fileId: Int, image: UIImage) {
        self.view?.showLoading(message: "Đang tải lên")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.uploadHinhHoSo(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", base64: base64, fileId: fileId, appDocEntry: self.modelLichSu?.appDocEntry ?? 0, applicationId: self.modelLichSu?.applicationID ?? "", image: image)
    }
    
    func resubmitToMirae(){
        self.view?.showLoading(message: "Đang tải")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.resubmitToMirae(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", appDocEntry: "\(self.modelLichSu?.appDocEntry ?? 0)")
    }
    
}

//MARK: -Out Presenter To View
extension UpdateHinhAnhMiraePresenter : UpdateHinhAnhMiraeInteractorToPresenterProtocol {
    func resubmitToMiraeSuccess(message: String) {
        self.view?.didResubmitToMiraeSuccess(message: message)
    }
    
    
    func uploadHinhSuccess(message: String, tag: Int, image: UIImage) {
        self.view?.didUploadHinhSuccess(message: message, tag: tag, image: image)
    }
    
    func loadAnhConThieuSuccess(model: [UpdateHinhAnhMiraeEntity.EditableField]) {
        self.model = model
        self.view?.didLoadAnhConThieuSuccess()
    }
    
    func updateHinhConThieuSuccess(message: String) {
        self.view?.didUpdateHinhConThieuSuccess(message: message)
    }
    
    func updateHinhConThieuFailed(message: String, model: [UpdateHinhAnhMiraeEntity.EditableField]) {
        self.view?.didUpdateHinhConThieuFailed(message: message)
        self.model = model
        self.view?.didLoadAnhConThieuSuccess()
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
