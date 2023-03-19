//
//  GHTNChiTietChoGiaoProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol GHTNChiTietChoGiaoViewToPresenterProtocol: AnyObject {
    var view: GHTNChiTietChoGiaoPresenterToViewProtocol? { get set }
    var interactor: GHTNChiTietChoGiaoPresenterToInteractorProtocol? { get set }
    var router: GHTNChiTietChoGiaoPresenterToRouterProtocol? { get set }
    func viewDidLoad()
    func khachNhanHang()
    func datGrabGiaoHang()
    func uploadImageGHTN(image:String,type:String,latitude:String,longitude:String)
    func khachKhongNhanHang(reason:String)
    func huyDonHang(reason:String)
    func chonNVGiaoHang(userCode:String,empName:String)
    func bookGrabGHTN(plaining:GrabPlainingItem)
}

protocol GHTNChiTietChoGiaoPresenterToInteractorProtocol: AnyObject {
    var presenter:GHTNChiTietChoGiaoInteractorToPresenterProtocol? { get set }
    func getSODetails(docNum:String)
    func upLoadImageGHTN(soSO:String,
                         fileName:String,
                         base64String:String,
                         userID:String,
                         kH_Latitude:String,
                         kH_Longitude:String,
                         type:String)
    func khachNhanHangHandle(docNum:String,
                             userCode:String,
                             finishLatitude:String,
                             finishLongitude:String)
    func khachKhongNhanHang(docNum: String,
                            userCode: String,
                            reason: String)
    func huyDonHangGHTN(docNum: String,
                        userCode:String,
                        reason:String)
    func getListNhanVienGiaoHang(shopCode: String, jobtitle:String)
    func chonNhanVienGiaoHang(docNum: String, userCode:String,empName:String)
    func getPlainningGrab(docEntry:String,id:String)
    func bookGrabGHTN(plaining:GrabPlainingItem,model:GetSOByUserResult,partenName:String)
    func checkImageUpload(idcard: String, voucher: String, phone: String, soPOS: Int)
    func getInstallmentHistory(shopCode:String,docEntry:String,userCode:String,imageString:String)
    func xacMinhDanhTinhKhachHangMiera(shopCode:String,userCode:String,imageString:String,modeldetailHistory:InstallmentOrderData)
}

protocol GHTNChiTietChoGiaoInteractorToPresenterProtocol:AnyObject {
    func xacMinhDanhTinhKhachHangMieraSuccess(image:String)
    func bookGrabGHTNSuccess(model:BookingItem)
    func checkImageUploadSuccess(isUpload:Bool,idBackToSchool:Int)
    func getPlainningGrabSuccess(model:GrabPlainingItem)
    func chonNhanVienGiaoHangSuccess(model:ConfirmThuKhoResult,user:String)
    func getSODetailsSuccess(model: [GHTNChiTietChoGiaoEntity.ChiTietDonHangModel])
    func getListNhanVienGiaoHangSuccess(model:[GetEmPloyeesResult])
    func uploadImageGHTNSuccess(message:String, code:Int)
    func huyDonHangGHTNSuccess(message:String)
    func xacNhanGiaoHangSuccess(model:GHTNChiTietChoGiaoEntity.XacNhanGiaoHangModel)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol GHTNChiTietChoGiaoPresenterToViewProtocol:AnyObject {
    func didXacMinhDanhTinhKhachHangMieraSuccess(image:String)
    func didCheckImageUploadSuccess(idBackToSchool:Int)
    func didChonNhanVienGiaoHangSuccess(message:String)
    func didBookGrabGHTNSuccess(message:String)
    func didgetPlainningGrabSuccess(model:GrabPlainingItem)
    func didxacNhanGiaoHangSuccess(message:String)
    func didHuyDonHangGHTNSuccess()
    func didGoiNhanhKhachHang(numberPhone:String)
    func didgetSODetailsSuccess(tongTien:Double,phaiThu:Double)
    func didUploadChupTaiNhaSuccess(image:UIImage)
    func didUploadChupChanDungSuccess(image:UIImage)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func showToast(message:String)
    func hideLoading()
}

protocol GHTNChiTietChoGiaoPresenterToRouterProtocol:AnyObject {
    var view: GHTNChiTietChoGiaoViewController! { get set }
    func configureVIPERGHTNChiTietChoGiao() -> GHTNChiTietChoGiaoViewController
}

