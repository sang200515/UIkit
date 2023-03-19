//
//  CapNhatChungTuMiraeInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class CapNhatChungTuMiraeInteractor:CapNhatChungTuMiraePresenterToInteractorProtocol {
    
    weak var presenter: CapNhatChungTuMiraeInteractorToPresenterProtocol?
    
    func uploadHinhHoSo(userCode: String, shopCode: String, partnerId: String, base64: String, fileId: Int, appDocEntry: Int, applicationId: String,image:UIImage) {
        
        ApiRequestMirae.request(.upLoadHinhHoSo(userCode: userCode,
                                                shopCode: shopCode,
                                                partnerId: partnerId,
                                                base64: base64,
                                                fileId: fileId > 6 ? 6 : fileId,
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
    func loadLyDoHuy(userCode: String, shopCode: String, partnerId: String){
        ApiRequestMirae.request(.loadLyDoHuy(userCode: userCode, shopCode: shopCode, partnerId: partnerId), CapNhatChungTuMiraeEntity.LyDoHuyModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.loadLyDoHuySuccess(model: data.data ?? [])
                }else {
                    self.presenter?.outPutFailed(error: "Lấy lý do hủy không thành công")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy lý do hủy không thành công. \(error.message)")
            }
            self.loadMoiQuanHe(userCode: userCode, shopCode: shopCode, partnerId: partnerId)
        }
    }
    func loadMoiQuanHe(userCode: String, shopCode: String, partnerId: String){
        ApiRequestMirae.request(.loadMoiQuanHeGiaDinh(userCode: userCode, shopCode: shopCode, partnerId: partnerId), CapNhatChungTuMiraeEntity.MoiQuanHeModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.loadMoiQuanHeSuccess(model: data.data ?? [])
                }else {
                    self.presenter?.outPutFailed(error: "Lấy mối quan hệ không thành công")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy mối quan hệ không thành công. \(error.message)")
            }
            self.loadLoaiHopDong(userCode: userCode, shopCode: shopCode, partnerId: partnerId)
        }
    }
    func loadLoaiHopDong(userCode: String, shopCode: String, partnerId: String){
        ApiRequestMirae.request(.loadLoaiHopDong(userCode: userCode, shopCode: shopCode, partnerId: partnerId), CapNhatChungTuMiraeEntity.MoiQuanHeModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.loadLoaiHopDongSuccess(model: data.data ?? [])
                }else {
                    self.presenter?.outPutFailed(error: "Lấy thông tin loại hợp đồng không thành công")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy thông tin loại hợp đồng không thành công. \(error.message)")
            }
            self.loadLoaiChungTu(userCode: userCode, shopCode: shopCode, partnerId: partnerId)
        }
    }
    func loadLoaiChungTu(userCode: String, shopCode: String, partnerId: String){
        ApiRequestMirae.request(.loadLoaiChungTu(userCode: userCode, shopCode: shopCode, partnerId: partnerId), CapNhatChungTuMiraeEntity.LoaiChungTuModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.loadLoaiChungTuSuccess(model: data.data ?? [])
                }else {
                    self.presenter?.outPutFailed(error: "Lấy thông tin chứng từ không thành công")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy thông tin chứng từ không thành công. \(error.message)")
            }
            self.loadChucVuLamViec(userCode: userCode, shopCode: shopCode, partnerId: partnerId)
        }
    }
    func loadChucVuLamViec(userCode: String, shopCode: String, partnerId: String){
        ApiRequestMirae.request(.loadChucVuLamViec(userCode: userCode, shopCode: shopCode, partnerId: partnerId), CapNhatChungTuMiraeEntity.MoiQuanHeModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.loadLoaiChucVuSuccess(model: data.data ?? [])
                }else {
                    self.presenter?.outPutFailed(error: "Lấy thông tin chức vụ không thành công")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy thông tin chức vụ không thành công. \(error.message)")
            }
            self.loadMaNoiBo(userCode: userCode, shopCode: shopCode, partnerId: partnerId)
        }
    }
    func loadMaNoiBo(userCode: String, shopCode: String, partnerId: String){
        ApiRequestMirae.request(.loadMaNoiBo(userCode: userCode, shopCode: shopCode, partnerId: partnerId), CapNhatChungTuMiraeEntity.MoiQuanHeModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.loadMaNoiBoSuccess(model: data.data ?? [])
                }else {
                    self.presenter?.outPutFailed(error: "Lấy thông tin mã nội bộ không thành công")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy thông tin mã nội bộ không thành công. \(error.message)")
            }
            self.loadNgayThanhToan(userCode: userCode, shopCode: shopCode, partnerId: partnerId)
        }
    }
    func loadNgayThanhToan(userCode: String, shopCode: String, partnerId: String){
        ApiRequestMirae.request(.loadNgayThanhToan(userCode: userCode, shopCode: shopCode, partnerId: partnerId), CapNhatChungTuMiraeEntity.LoaiChungTuModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.loadNgayThanhToanSuccess(model: data.data ?? [])
                }else {
                    self.presenter?.outPutFailed(error: "Lấy thông tin ngày thanh toán không thành công")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy thông tin  ngày thanh toán không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    func uploadCapNhatChungTu(applicationId:String,userCode:String,shopCode:String,partnerId:String,appDocEntry:String,workInfo:Dictionary<String, Any>,documentType:String){
        ApiRequestMirae.request(.submitAppCapNhatChungTu(applicationId: applicationId, userCode: userCode, shopCode: shopCode, partnerId: partnerId, appDocEntry: appDocEntry, workInfo: workInfo,documentType:documentType), CapNhatChungTuMiraeEntity.UpdateThongTinCongViecModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.uploadCapNhatChungTuSuccess(message: data.message ?? "")
                }else {
                    self.presenter?.outPutFailed(error: "Upload chứng từ không thành công.\(data.message ?? "")")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Upload chứng từ không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
}
