//
//  UpdateHinhAnhMiraeInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class UpdateHinhAnhMiraeInteractor:UpdateHinhAnhMiraePresenterToInteractorProtocol {
    
    func resubmitToMirae(userCode: String, shopCode: String, partnerId: String, appDocEntry: String) {
        ApiRequestMirae.request(.resubmitToMirae(userCode: userCode, shopCode: shopCode, partnerId: partnerId, appDocEntry: appDocEntry), UpdateGoiVayMiraeEntity.ResubmitModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.resubmitToMiraeSuccess(message: "Gửi hồ sơ thành công.\(data.message ?? "")")
                }else {
                    self.presenter?.outPutFailed(error: "Gửi hồ sơ không thành công. \(data.message ?? "")")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Gửi hồ sơ không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    
    weak var presenter: UpdateHinhAnhMiraeInteractorToPresenterProtocol?
    
    func loadAnhConThieu(userCode: String, shopCode: String, partnerId: String, appDocEntry: String) {
        ApiRequestMirae.request(.loadAnhConThieu(userCode: userCode, shopCode: shopCode, partnerId: partnerId, appDocEntry: appDocEntry), UpdateHinhAnhMiraeEntity.UpdateHinhAnhModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.loadAnhConThieuSuccess(model: data.editableField ?? [])
                }else {
                    self.presenter?.outPutFailed(error: "Lấy thông tin không thành công. \(data.message ?? "")")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy thông tin không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func updateHinhConThieu(userCode: String, shopCode: String, partnerId: String, appDocEntry: String) {
        ApiRequestMirae.request(.updateAnhConThieu(userCode: userCode, shopCode: shopCode, partnerId: partnerId, appDocEntry: appDocEntry), UpdateHinhAnhMiraeEntity.UpdateHinhAnhModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.updateHinhConThieuSuccess(message: "Cập nhật ảnh thành công.\(data.message ?? "")")
                }else {
                    self.presenter?.updateHinhConThieuFailed(message: data.message ?? "", model: data.editableField ?? [])
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Cập nhật ảnh không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }

    func uploadHinhHoSo(userCode: String, shopCode: String, partnerId: String, base64: String, fileId: Int, appDocEntry: Int, applicationId: String, image: UIImage) {
        ApiRequestMirae.request(.upLoadHinhHoSo(userCode: userCode,
                                                shopCode: shopCode,
                                                partnerId: partnerId,
                                                base64: base64,
                                                fileId: fileId,
                                                appDocEntry: appDocEntry,
                                                applicationId: applicationId),
                                CapNhatChungTuMiraeEntity.UploadHinhModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.uploadHinhSuccess(message: data.message, tag: fileId, image: image)
                }else {
                    self.presenter?.outPutFailed(error: data.message == "" ? "Upload hình không thành công" : data.message)
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Upload hình không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
}
