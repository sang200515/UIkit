//
//  ThongTinDonHangMiraeCompleteProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol ThongTinDonHangMiraeCompleteViewToPresenterProtocol: class {
    var view: ThongTinDonHangMiraeCompletePresenterToViewProtocol? { get set }
    var interactor: ThongTinDonHangMiraeCompletePresenterToInteractorProtocol? { get set }
    var router: ThongTinDonHangMiraeCompletePresenterToRouterProtocol? { get set }
    func viewDidLoad()
    func sumitApplication()
}

protocol ThongTinDonHangMiraeCompletePresenterToInteractorProtocol: AnyObject {
    var presenter:ThongTinDonHangMiraeCompleteInteractorToPresenterProtocol? { get set }
    func loadThongTinDonHang(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    func sumitApplicationMirae(discount: Float,
                               loaiTraGop: String,
                               voucher: String,
                               diviceType: String,
                               payments: String,
                               doctype: String,
                               soTienTraTruoc: Float,
                               tenCTyTraGop: String,
                               token: String,
                               shopCode: String,
                               ngaySinh: String,
                               cardName: String,
                               soHDtragop: String,
                               address: String,
                               mail: String,
                               phone: String,
                               pre_docentry: String,
                               xmlspGiamGiaTay: String,
                               xmlVoucherDH: String,
                               U_EplCod: String,
                               xml_url_pk: String,
                               cardcode: String,
                               laiSuat: Float,
                               is_sale_MDMH: String,
                               CMND: String,
                               is_DH_DuAn: String,
                               PROMOS: String,
                               U_des: String,
                               is_sale_software: String,
                               is_samsung: String,
                               RDR1: String,
                               xmlstringpay: String,
                               kyhan: Int,
                               is_KHRotTG: Int,
                               gioitinh: Int,
                               CRMCode: String,
                               appDocEntry: Int,
                               schemecode: String)
}

protocol ThongTinDonHangMiraeCompleteInteractorToPresenterProtocol:class {
    func loadThongTinDonHangSuccess(model:ThongTinDonHangMiraeEntity.DataChiTietDonHangModel)
    func loadThongTinDonHangFailed(message:String)
    func luuDonHangSuccess(message:String)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol ThongTinDonHangMiraeCompletePresenterToViewProtocol:class {
    func didBidingDataCache(model:KhachHangMiraeModel)
    func didLoadThongTinDonHangFailed(message:String)
    func didLuuDonHangSuccess(message:String)
    func didLoadThongTinDonHangSuccess(model:ThongTinDonHangMiraeEntity.DataChiTietDonHangModel)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol ThongTinDonHangMiraeCompletePresenterToRouterProtocol:class {
    var view: ThongTinDonHangMiraeCompleteViewController! { get set }
    func configureVIPERThongTinDonHangComplete() -> ThongTinDonHangMiraeCompleteViewController
}

