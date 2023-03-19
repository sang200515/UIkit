//
//  ThongTinKhachHangMireaProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol ThongTinKhachHangMireaViewToPresenterProtocol: class {
    var view: ThongTinKhachHangMireaPresenterToViewProtocol? { get set }
    var interactor: ThongTinKhachHangMireaPresenterToInteractorProtocol? { get set }
    var router: ThongTinKhachHangMireaPresenterToRouterProtocol? { get set }
    func viewDidLoad()
    func resubmitToMirae()
    func loadListTinhThanhPho(tag:Int)
    func loadQuanHuyen(tag:Int)
    func loadPhuongXa(tag:Int)
    func luuHoSo(customerInfo: Dictionary<String, Any>,
                 permanentAddress: Dictionary<String, Any>,
                 residenceAddress: Dictionary<String, Any>,
                 refPerson1: Dictionary<String, Any>,
                 refPerson2: Dictionary<String, Any>)
    func updateThongTinCongViec(customerInfo: Dictionary<String, Any>,
                                permanentAddress: Dictionary<String, Any>,
                                residenceAddress: Dictionary<String, Any>,
                                refPerson1: Dictionary<String, Any>,
                                refPerson2: Dictionary<String, Any>)
    func loadMoiQuanHe(tag:Int)
    func filterContentForSearchText(_ searchText: String,tag:Int)
}

protocol ThongTinKhachHangMireaPresenterToInteractorProtocol: class {
    var presenter:ThongTinKhachHangMireaInteractorToPresenterProtocol? { get set }
    func loadMoiQuanHe(userCode: String, shopCode: String, partnerId: String)
    func loadTinhThanhPho(userCode:String,shopCode:String,partnerId:String,tag:Int)
    func resubmitToMirae(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    func loadQuanHuyen(userCode:String,shopCode:String,partnerId:String,codeTinh:String,tag:Int)
    func loadXaPhuong(userCode:String,shopCode:String,partnerId:String,codeQuanHuyen:String,tag:Int)
    func luuHoSoMirae(userCode:String,
                      shopCode:String,
                      partnerId:String,
                      customerInfo:Dictionary<String,Any>,
                      permanentAddress:Dictionary<String,Any>,
                      residenceAddress:Dictionary<String,Any>,
                      refPerson1:Dictionary<String,Any>,
                      refPerson2:Dictionary<String,Any>)
    func loadThongTinKhachHang(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    func updateThongTinCongViec(userCode:String,
                                shopCode:String,
                                partnerId:String,
                                appDocEntry:String,
                                customerInfo:Dictionary<String,Any>,
                                permanentAddress:Dictionary<String,Any>,
                                residenceAddress:Dictionary<String,Any>,
                                refPerson1:Dictionary<String,Any>,
                                refPerson2:Dictionary<String,Any>,
                                workInfo:Dictionary<String, Any>)
}

protocol ThongTinKhachHangMireaInteractorToPresenterProtocol:class {
    func loadTinhThanhPhoSuccess(model:[ThongTinKhachHangMireaEntity.DataTinhModel],tag:Int)
    func resubmitToMiraeSuccess(message:String)
    func loadThongTinKhachHangSuccess(model: ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel)
    func loadQuanHuyenSuccess(model:[ThongTinKhachHangMireaEntity.DataTinhModel],tag:Int)
    func loadPhuongXaSuccess(model:[ThongTinKhachHangMireaEntity.DataTinhModel],tag:Int)
    func loadMoiQuanHeSuccess(model:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel])
    func loadLoaiHopDongSuccess(model:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel])
    func loadLoaiChungTuSuccess(model:[CapNhatChungTuMiraeEntity.DataLoaiChungTuModel])
    func loadLoaiChucVuSuccess(model:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel])
    func loadMaNoiBoSuccess(model:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel])
    func loadNgayThanhToanSuccess(model:[CapNhatChungTuMiraeEntity.DataLoaiChungTuModel])
    func updateThongTinCongViecSuccess(model:ThongTinKhachHangMireaEntity.UpdateThongTinCongViecModel)
    func luuHoSoSuccess(message:String,docEntry:Int)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol ThongTinKhachHangMireaPresenterToViewProtocol:class {
    func didSearchTinhThanhPhoSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel],tag:Int)
    func didLoadTinhThanhPhoSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel],tag:Int)
    func didUpdateThongTinCongViecSuccess(model:ThongTinKhachHangMireaEntity.UpdateThongTinCongViecModel)
    func didLoadQuanHuyenSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel],tag:Int)
    func didLoadPhuongXaSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel],tag:Int)
    func didLoadThongTinKhachHangSuccess(model: ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel)
    func didResubmitToMiraeSuccess(message:String)
    func bindingNgaySinh(date:String)
    func bindingNgayCap(date:String)
    func didLuuHoSoSuccess(message:String,docEntry:Int)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol ThongTinKhachHangMireaPresenterToRouterProtocol:class {
    var view: ThongTinKhachHangMireaViewController! { get set }
    func configureVIPERThongTinKhachHangMirea() -> ThongTinKhachHangMireaViewController
}

