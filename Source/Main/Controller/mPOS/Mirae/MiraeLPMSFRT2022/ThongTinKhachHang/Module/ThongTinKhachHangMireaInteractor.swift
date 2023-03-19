//
//  ThongTinKhachHangMireaInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ThongTinKhachHangMireaInteractor:ThongTinKhachHangMireaPresenterToInteractorProtocol {
    
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
    
 
    func updateThongTinCongViec(userCode: String, shopCode: String, partnerId: String, appDocEntry: String, customerInfo: Dictionary<String, Any>, permanentAddress: Dictionary<String, Any>, residenceAddress: Dictionary<String, Any>, refPerson1: Dictionary<String, Any>, refPerson2: Dictionary<String, Any>, workInfo: Dictionary<String, Any>) {
        ApiRequestMirae.request(.updateThongTinCongViec(userCode: userCode, shopCode: shopCode, partnerId: partnerId, appDocEntry: appDocEntry, customerInfo: customerInfo, permanentAddress: permanentAddress, residenceAddress: residenceAddress, refPerson1: refPerson1, refPerson2: refPerson2, workInfo: workInfo), ThongTinKhachHangMireaEntity.UpdateThongTinCongViecModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.updateThongTinCongViecSuccess(model: data)
                }else {
                    self.presenter?.outPutFailed(error: "Update thông tin công việc không thành công. \(data.message ?? "")")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Update thông tin công việc không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    
  
    weak var presenter: ThongTinKhachHangMireaInteractorToPresenterProtocol?
    
    func loadTinhThanhPho(userCode: String, shopCode: String, partnerId: String,tag:Int) {
        ApiRequestMirae.request(ApiRouterMirae.loadTinh(userCode: userCode, shopCode: shopCode, partnerId: partnerId), ThongTinKhachHangMireaEntity.TinhModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    if let model = data.data {
                        self.presenter?.loadTinhThanhPhoSuccess(model: model,tag: tag)
                    }
                }else {
                    self.presenter?.outPutFailed(error: "Lấy danh sách tỉnh/thành phố không thành công.")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy danh sách tỉnh/thành phố không thành công.\(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func loadQuanHuyen(userCode: String, shopCode: String, partnerId: String, codeTinh: String,tag:Int) {
        ApiRequestMirae.request(.loadQuanHuyen(userCode: userCode, shopCode: shopCode, partnerId: partnerId, codeTinh: codeTinh), ThongTinKhachHangMireaEntity.TinhModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    if let model = data.data {
                        self.presenter?.loadQuanHuyenSuccess(model: model, tag: tag)
                    }
                }else {
                    self.presenter?.outPutFailed(error: "Lấy danh sách quận/huyện không thành công.")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy danh sách quận/huyện không thành công.\(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func loadXaPhuong(userCode: String, shopCode: String, partnerId: String, codeQuanHuyen: String,tag:Int) {
        ApiRequestMirae.request(ApiRouterMirae.loadXaPhuong(userCode: userCode, shopCode: shopCode, partnerId: partnerId, codeQuanHuyen: codeQuanHuyen), ThongTinKhachHangMireaEntity.TinhModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    if let model = data.data {
                        self.presenter?.loadPhuongXaSuccess(model: model, tag: tag)
                    }
                }else {
                    self.presenter?.outPutFailed(error: "Lấy danh sách phường/xã không thành công.")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy danh sách phường/xã không thành công.\(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func luuHoSoMirae(userCode: String,
                      shopCode: String,
                      partnerId: String,
                      customerInfo: Dictionary<String, Any>,
                      permanentAddress: Dictionary<String, Any>,
                      residenceAddress: Dictionary<String, Any>,
                      refPerson1: Dictionary<String, Any>,
                      refPerson2: Dictionary<String, Any>) {
        ApiRequestMirae.request(.luuHoSoMirae(userCode: userCode, shopCode: shopCode, partnerId: partnerId, customerInfo: customerInfo, permanentAddress: permanentAddress, residenceAddress: residenceAddress, refPerson1: refPerson1, refPerson2: refPerson2), ThongTinKhachHangMireaEntity.LuuHoSoModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.luuHoSoSuccess(message: data.message ?? "",docEntry: data.appDocEntry ?? 0)
                }else {
                    self.presenter?.outPutFailed(error: data.message ?? "Lưu thông tin không thành công")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lưu hồ sơ không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func loadThongTinKhachHang(userCode:String,shopCode:String,partnerId:String,appDocEntry:String){
        ApiRequestMirae.request(.loadThongTinKH(userCode: userCode, shopCode: shopCode, partnerId: partnerId, appDocEntry: appDocEntry), ORCCMNDMiraeEntity.ORCCMNDMiraeModel.self) { response in
            switch response {
            case .success(let modelData):
                if modelData.success == true {
                    if let model = modelData.data {
                        self.presenter?.loadThongTinKhachHangSuccess(model: model)
                    }
                }else {
                    self.presenter?.outPutFailed(error: modelData.message ?? "")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: error.message)
            }
            self.presenter?.hideLoading()
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
    
}
