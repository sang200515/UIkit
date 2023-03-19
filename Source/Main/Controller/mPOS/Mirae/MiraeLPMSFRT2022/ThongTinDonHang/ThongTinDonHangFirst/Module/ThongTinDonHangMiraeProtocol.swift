//
//  ThongTinDonHangMiraeProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol ThongTinDonHangMiraeViewToPresenterProtocol: AnyObject {
    var view: ThongTinDonHangMiraePresenterToViewProtocol? { get set }
    var interactor: ThongTinDonHangMiraePresenterToInteractorProtocol? { get set }
    var router: ThongTinDonHangMiraePresenterToRouterProtocol? { get set }
    func viewDidLoad()
}

protocol ThongTinDonHangMiraePresenterToInteractorProtocol: AnyObject {
    var presenter:ThongTinDonHangMiraeInteractorToPresenterProtocol? { get set }
    func loadNgayThanhToan(userCode:String,shopCode:String,partnerId:String)
    func loadThongTinKhachHang(userCode: String, shopCode: String, partnerId: String, appDocEntry: String)
    func loadGoiTraGop(userCode:String,shopCode:String,partnerId:String,RDR1:String)
    func loadThongTinDonHang(userCode: String, shopCode: String, partnerId: String, appDocEntry: String)
}

protocol ThongTinDonHangMiraeInteractorToPresenterProtocol:AnyObject {
    func loadThongTinDonHangSuccess(model:ThongTinDonHangMiraeEntity.DataChiTietDonHangModel)
    func loadThongTinDonHangFailed(message:String)
    func loadThongTinKhachHangSuccess(model:ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel)
    func loadGoiTraGopSuccess(model:[ThongTinDonHangMiraeEntity.DataGoiVayMiraeModel])
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol ThongTinDonHangMiraePresenterToViewProtocol:AnyObject {
    func didLoadThongTinDonHangFailed(message:String)
    func didLoadVoucherSuccess()
    func didLoadThongTinDonHangSuccess(model:ThongTinDonHangMiraeEntity.DataChiTietDonHangModel)
    func didLoadGoiTraGopSuccess(model:[ThongTinDonHangMiraeEntity.DataGoiVayMiraeModel])
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol ThongTinDonHangMiraePresenterToRouterProtocol:AnyObject {
    var view: ThongTinDonHangMiraeViewController! { get set }
    func configureVIPERThongTinDonHangMirae() -> ThongTinDonHangMiraeViewController
}

