//
//  GHTNChiTietChoGiaoInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class GHTNChiTietChoGiaoInteractor:GHTNChiTietChoGiaoPresenterToInteractorProtocol {
    
    weak var presenter: GHTNChiTietChoGiaoInteractorToPresenterProtocol?
    
    func getSODetails(docNum: String) {
        self.presenter?.showLoading(message: "Đang lấy thông tin đơn hàng")
        GHTNApiRequest.request(.getListChiTietDonHang(docNum: docNum), [GHTNChiTietChoGiaoEntity.ChiTietDonHangModel].self) { response in
            switch response {
            case .success(let data):
                if !data.isEmpty {
                    self.presenter?.getSODetailsSuccess(model: data)
                }else {
                    self.presenter?.outPutFailed(error: "Danh sách hàng trống")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Không thể hoàn thành tác vụ.\nLỗi: \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func upLoadImageGHTN(soSO: String,
                         fileName: String,
                         base64String: String,
                         userID: String,
                         kH_Latitude: String,
                         kH_Longitude: String,
                         type: String) {
        GHTNApiRequest.request(.upLoadImageGHTN(soSO: soSO, fileName: fileName, base64String: base64String, userID: userID, kH_Latitude: kH_Latitude, kH_Longitude: kH_Longitude, type: type), GHTNChiTietChoGiaoEntity.UpLoadImageGHTNModel.self) { response in
            switch response {
            case .success(let model):
                self.presenter?.uploadImageGHTNSuccess(message: model.msg ?? "", code:model.result ?? 0)
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Không thể hoàn thành tác vụ upload hình.\nLỗi: \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func khachNhanHangHandle(docNum:String,
                             userCode:String,
                             finishLatitude:String,
                             finishLongitude:String) {
        GHTNApiRequest.request(.khachNhanHang(docNum: docNum, userCode: userCode, finishLatitude: finishLatitude, finishLongitude: finishLongitude), GHTNChiTietChoGiaoEntity.XacNhanGiaoHangModel.self) { response in
            switch response {
            case .success(let model):
                if model.result == 1 {
                    self.presenter?.xacNhanGiaoHangSuccess(model: model)
                }else {
                    self.presenter?.outPutFailed(error: "Không thể hoàn thành tác vụ Xác nhận giao hàng.\n\(model.description ?? "")")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Không thể hoàn thành tác vụ Xác nhận giao hàng.\nLỗi: \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func khachKhongNhanHang(docNum: String, userCode: String, reason: String){
        GHTNApiRequest.request(.khachTraHang(docNum: docNum,
                                             userCode: userCode,
                                             reason: reason
                                            ), GHTNChiTietChoGiaoEntity.XacNhanGiaoHangModel.self) { response in
            switch response {
            case .success(let model):
                if model.result == 1 {
                    self.presenter?.xacNhanGiaoHangSuccess(model: model)
                }else {
                    self.presenter?.outPutFailed(error: "Không thể hoàn thành tác vụ Khách không nhận hàng.\n\(model.description ?? "")")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Không thể hoàn thành tác vụ Khách không nhận hàng.\n\(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func huyDonHangGHTN(docNum: String, userCode:String, reason:String){
        MDeliveryAPIService.GetDataSetSORejected(docNum: docNum, userCode:userCode, reason:reason){ [weak self] (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            if success {
                if(result != nil ){
                    self?.presenter?.huyDonHangGHTNSuccess(message: result.Descriptionn )
                }
            }else{
                self?.presenter?.outPutFailed(error: "Không thể hoàn thành tác vụ hủy đơn hàng.\n\(error?.localizedDescription ?? "")")
            }
            self?.presenter?.hideLoading()
        }
    }
    
    func getListNhanVienGiaoHang(shopCode: String, jobtitle:String) {
        MDeliveryAPIService.GetUserDelivery(shopCode: shopCode, jobtitle:jobtitle){ (error: Error?, success: Bool, result: [GetEmPloyeesResult]!) in
            if success {
                if(result != nil && result.count > 0) {
                    self.presenter?.getListNhanVienGiaoHangSuccess(model: result)
                }
            }else{
                
            }
            self.presenter?.hideLoading()
        }
    }
    
    func chonNhanVienGiaoHang(docNum: String, userCode:String,empName:String){
        MDeliveryAPIService.GetSetSOBooked(docNum: docNum, userCode:userCode,empName:empName){ (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            if success {
                if(result != nil) {
                    self.presenter?.chonNhanVienGiaoHangSuccess(model: result,user: "\(userCode)")
                }
            } else {
                self.presenter?.outPutFailed(error: error?.localizedDescription ?? "")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func getPlainningGrab(docEntry:String,id:String) {
        GrabBookingApiManager.shared.getPlainningGrab(docEntry: docEntry, id: id) { [weak self] response, err in
            guard let self = self else {return}
            if err != "" {
                self.presenter?.outPutFailed(error: err)
            } else {
                if response?.result == 0 {
                    self.presenter?.outPutFailed(error: "\(response?.msg ?? "")")
                } else {
                    guard let response = response else { return }
                    self.presenter?.getPlainningGrabSuccess(model: response)
                }
            }
            self.presenter?.hideLoading()
            
        }
    }
    
    func bookGrabGHTN(plaining: GrabPlainingItem, model: GetSOByUserResult, partenName:String) {
        GrabBookingApiManager.shared.bookingGrab(item: model, planning: plaining, partnerName: partenName) { [weak self] res, err in
            guard let self = self else {return}
            if err != "" {
                self.presenter?.outPutFailed(error: err)
            } else {
                guard let model = res else { return }
                self.presenter?.bookGrabGHTNSuccess(model: model)
            }
            self.presenter?.hideLoading()
        }
    }
    
    func checkImageUpload(idcard: String, voucher: String, phone: String, soPOS: Int){
        MPOSAPIManager.checkImageUploaded(idcard: idcard, voudcher: voucher, phone: phone, sopos: soPOS) { [weak self] (respone, error) in
            guard let self = self else {return}
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if error != "" {
                    self.presenter?.outPutFailed(error: error)
                } else {
                    guard let res = respone else {
                        self.presenter?.outPutFailed(error: "can not parse data")
                        return
                    }
                    if res.BtsData.result == 0 {
                        self.presenter?.outPutFailed(error:  res.BtsData.messages)
                    } else if res.BtsData.result == 1 {
                        self.presenter?.checkImageUploadSuccess(isUpload: res.BtsData.isUpload, idBackToSchool: res.BtsData.ID_BTS)
                    }
                }
            }
            
        }
    }
    
    func getInstallmentHistory(shopCode:String,docEntry:String,userCode:String,imageString:String){
        let parammeters:[String:Any] = [
            "shopCode":shopCode,
            "filterKey":"4",
            "filterValue":docEntry,
            "isDetail":true
        ]
        InstallmentApiManager.shared.getInstallmentHistory(params: parammeters) {[weak self] (_, detailHistory, error) in
            guard let self = self else { return }
            if detailHistory?.data.count != 0 {
                if let modeldetailHistory = detailHistory?.data.first {
                    self.xacMinhDanhTinhKhachHangMiera(shopCode: Cache.user?.ShopCode ?? "", userCode: Helper.getUserName() ?? "", imageString: imageString, modeldetailHistory: modeldetailHistory)
                }
            }else {
                self.presenter?.outPutFailed(error: "Không có thông tin đơn hàng")
            }
            self.presenter?.hideLoading()
        }
    }
    
    func xacMinhDanhTinhKhachHangMiera(shopCode:String,userCode:String,imageString:String,modeldetailHistory:InstallmentOrderData){
        let parammeters:[String:Any] = [
            "employeeCode":userCode,
            "shopCode":shopCode,
            "nationalId":modeldetailHistory.customer.cMND,
            "realSelfie":imageString,
            "applicationId":modeldetailHistory.otherInfos.applicationId,
            "docEntry":modeldetailHistory.otherInfos.docEntry
        ]
        self.presenter?.showLoading(message: "Đang xác minh ảnh khách hàng...")
        InstallmentApiManager.shared.checkInfordelivery(params: parammeters) { [weak self] (response, error) in
            guard let self = self else { return }
            if error != "" {
                self.presenter?.outPutFailed(error: "Xác minh hình ảnh không thành công.\(error)")
            } else {
                if (response?.isSuccess ?? false) {
                    self.presenter?.xacMinhDanhTinhKhachHangMieraSuccess(image: imageString)
                }
                if let res = response {
                    self.presenter?.outPutFailed(error: "Xác minh hình ảnh không thành công.\(res.message)")
                }
            }
            self.presenter?.hideLoading()
        }
    }
    
}
