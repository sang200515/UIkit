//
//  GHTNChiTietChoGiaoPresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

//MARK:- Input View to Presenter
class GHTNChiTietChoGiaoPresenter : GHTNChiTietChoGiaoViewToPresenterProtocol {

    var modelListChiTietDonHang: [GHTNChiTietChoGiaoEntity.ChiTietDonHangModel] = []
    var modelListNVGH:[GetEmPloyeesResult] = []
    var model:GHTNChiTietChoGiaoEntity.GHTNModel?
    var mObjectData:GetSOByUserResult?
    var typeUpload:Int = 0
    var imageUpload:UIImage?
    var jobtitle:String = Cache.user!.JobTitle
    var userPicker:String = ""
    let hide:CGFloat = 0
    let showButton:CGFloat = 40
    let showImage:CGFloat = 200
    let showLabel:CGFloat = 18
    
    weak var view: GHTNChiTietChoGiaoPresenterToViewProtocol?
    var interactor: GHTNChiTietChoGiaoPresenterToInteractorProtocol?
    var router: GHTNChiTietChoGiaoPresenterToRouterProtocol?
    
    func viewDidLoad(){
        guard let model = model else {
            return
        }
        self.view?.showLoading(message: "Đang lấy thông tin")
        self.interactor?.getSODetails(docNum: "\(model.id ?? 0)")
        self.interactor?.getListNhanVienGiaoHang(shopCode: "\(Cache.user!.ShopCode)",
                                                 jobtitle: "\(Cache.user!.JobTitle)")
    }
    
    func chonNVGiaoHang(userCode:String,empName:String){
        guard let model = model else {
            return
        }
        self.view?.showLoading(message: "")
        self.interactor?.chonNhanVienGiaoHang(docNum: "\(model.id ?? 0)", userCode: userCode, empName: empName)
    }
    
    func datGrabGiaoHang() {
        guard let model = model else {
            return
        }
        self.view?.showLoading(message: "")
        self.interactor?.getPlainningGrab(docEntry: "\(model.docEntry ?? 0)", id: "\(model.id ?? 0)")
    }
    
    func goiNhanhKhachHang(){
        self.view?.didGoiNhanhKhachHang(numberPhone: self.model?.uPhone ?? "")
    }
    
    func uploadImageGHTN(image:String,type:String,latitude:String,longitude:String) {
        guard let model = model else {
            return
        }
        self.view?.showLoading(message: "Đang tải hình lên")
        self.interactor?.upLoadImageGHTN(soSO: "\(model.docEntry ?? 0)",
                                         fileName: "\(Common.randomString(length: 30))\(Helper.getUserName() ?? "")_iOS.jpg",
                                         base64String: image, userID: Helper.getUserName() ?? "",
                                         kH_Latitude: latitude,
                                         kH_Longitude: longitude,
                                         type: type)
    }
    
    func checkImageUpLoadBackToSchool(){
        guard let model = model else {
            return
        }
        self.interactor?.checkImageUpload(idcard: model.cmnd ?? "",
                                          voucher: model.contentWork ?? "",
                                          phone: model.uPhone ?? "",
                                          soPOS: model.docEntry ?? 0)
    }
    
    func khachNhanHang() {
        guard let model = model else {
            return
        }
        self.view?.showLoading(message: "Đang xác nhận")        
        self.interactor?.khachNhanHangHandle(docNum: "\(model.id ?? 0)",
                                             userCode: Helper.getUserName() ?? "",
                                             finishLatitude: "\(model.finishLatitude ?? 0)",
                                             finishLongitude: "\(model.finishLongitude ?? 0)")
    }
    
    func khachKhongNhanHang(reason:String){
        guard let model = model else {
            return
        }
        self.view?.showLoading(message: "Đang xác nhận")
        self.interactor?.khachKhongNhanHang(docNum: "\(model.id ?? 0)",
                                            userCode: Helper.getUserName() ?? "",
                                            reason: reason)
    }
    
    func huyDonHang(reason:String){
        guard let model = model else {
            return
        }
        self.view?.showLoading(message: "Đang hủy đơn hàng")
        self.interactor?.huyDonHangGHTN(docNum: "\(model.id ?? 0)",
                                        userCode: Helper.getUserName() ?? "",
                                        reason: reason)
    }
    
    func bookGrabGHTN(plaining:GrabPlainingItem) {
        guard let model = self.mObjectData else {
            return
        }
        self.view?.showLoading(message: "")
        self.interactor?.bookGrabGHTN(plaining: plaining, model: model,partenName:self.model?.partnerCode ?? "")
    }
    
    func xacMinhDanhTinhKhachHang(imageString:String){
        self.view?.showLoading(message: "")
        self.interactor?.getInstallmentHistory(shopCode: "\(Cache.user!.ShopCode)",
                                               docEntry: "\(self.model?.docEntry ?? 0)",
                                               userCode: Helper.getUserName() ?? "", imageString: imageString)
    }
   
    func GetTime(mObject:GHTNChiTietChoGiaoEntity.GHTNModel)->String {
        if (mObject.orderStatus != 5 && mObject.orderStatus != 6 && mObject.orderStatus != 4 && mObject.orderStatus != 8){
            let dateFormatter = DateFormatter()
            if(mObject.uDateDe?.count ?? 0 > 0){
                var mStr = mObject.deliveryDateTime ?? ""
                if(mStr.count > 19){
                    let index = mStr.index(mStr.startIndex, offsetBy: 19)
                    mStr = String(mStr[..<index])
                }
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter.timeZone = TimeZone(identifier: "UTC")
                let date = dateFormatter.date(from: "\(mStr)")
                var now = Date()
                var nowComponents = DateComponents()
                let calendar = Calendar.current
                nowComponents.year = Calendar.current.component(.year, from: now)
                nowComponents.month = Calendar.current.component(.month, from: now)
                nowComponents.day = Calendar.current.component(.day, from: now)
                nowComponents.hour = Calendar.current.component(.hour, from: now)
                nowComponents.minute = Calendar.current.component(.minute, from: now)
                nowComponents.second = Calendar.current.component(.second, from: now)
                nowComponents.timeZone = TimeZone(abbreviation: "GMT")!
                now = calendar.date(from: nowComponents)!
                let myString = dateFormatter.string(from: now)
                let date2 = dateFormatter.date(from: "\(myString)")
                if date2 != nil && date != nil {
                    var interval = date2!.timeIntervalSince(date!)
                    if (interval < 0){
                        interval = abs(interval)
                        return "còn lại: \(interval.timeIntervalAsString(seconds: interval))"
                    }else{
                        return "trễ: \(interval.timeIntervalAsString(seconds: interval))"
                    }
                }else{
                    return ""
                }
            }else{
                return ""
            }
        }else{
            return ""
        }
        
    }
   
}

//MARK: -Out Presenter To View
extension GHTNChiTietChoGiaoPresenter : GHTNChiTietChoGiaoInteractorToPresenterProtocol {
    
    func xacMinhDanhTinhKhachHangMieraSuccess(image:String){
        self.view?.didXacMinhDanhTinhKhachHangMieraSuccess(image: image)
    }
    
    func checkImageUploadSuccess(isUpload: Bool,idBackToSchool:Int) {
        if isUpload {
            self.khachNhanHang()
        } else {
            self.view?.didCheckImageUploadSuccess(idBackToSchool: idBackToSchool)
        }
    }
  
    func chonNhanVienGiaoHangSuccess(model: ConfirmThuKhoResult, user: String) {
        if model.Result == "1" {
            self.model?.userName = user
            self.model?.empName = self.userPicker
            self.view?.didChonNhanVienGiaoHangSuccess(message: user)
            self.view?.showToast(message: "Phân công nhân viên thành công")
        }else {
            self.view?.showToast(message: "Phân công nhân viên không thành công.\n\(model.Descriptionn)")
        }
    }
    
    func bookGrabGHTNSuccess(model: BookingItem) {
        if model.result == 1 {
            self.view?.didBookGrabGHTNSuccess(message:model.msg)
        }else {
            self.view?.outPutFailed(error: model.msg)
        }
    }
    
    func getPlainningGrabSuccess(model: GrabPlainingItem) {
        self.view?.didgetPlainningGrabSuccess(model: model)
    }
    
    func getListNhanVienGiaoHangSuccess(model:[GetEmPloyeesResult]) {
        self.modelListNVGH = model
    }
    
    func huyDonHangGHTNSuccess(message: String) {
        self.view?.showToast(message: message)
        self.view?.didHuyDonHangGHTNSuccess()
    }

    func xacNhanGiaoHangSuccess(model: GHTNChiTietChoGiaoEntity.XacNhanGiaoHangModel) {
        self.view?.didxacNhanGiaoHangSuccess(message: model.description ?? "")
    }

    func uploadImageGHTNSuccess(message:String, code:Int) {
        self.view?.showToast(message: message)
        guard let image = self.imageUpload else { return }
        if code != 0 {
            switch self.typeUpload {
            case 11:
                self.view?.didUploadChupChanDungSuccess(image: image)
            case 2:
                self.view?.didUploadChupTaiNhaSuccess(image: image)
            default:
                break
            }
        }
    }

    func getSODetailsSuccess(model: [GHTNChiTietChoGiaoEntity.ChiTietDonHangModel]) {
        self.modelListChiTietDonHang = model
        var tongTien:Double = 0
        var phaiThu:Double = 0
        let soTienTraTruoc:Double = self.model?.soTienTraTruoc ?? 0
        model.forEach { item in
            tongTien += item.uTMoney ?? 0
        }
        if self.model?.type != 11 {
            phaiThu = tongTien - soTienTraTruoc
        }
        self.view?.didgetSODetailsSuccess(tongTien:tongTien,phaiThu: phaiThu)
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
