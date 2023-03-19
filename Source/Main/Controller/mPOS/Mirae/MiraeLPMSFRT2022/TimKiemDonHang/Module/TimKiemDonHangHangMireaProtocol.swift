//
//  TimKiemDonHangHangMireaProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol TimKiemDonHangHangMireaViewToPresenterProtocol: class {
    var view: TimKiemDonHangHangMireaPresenterToViewProtocol? { get set }
    var interactor: TimKiemDonHangHangMireaPresenterToInteractorProtocol? { get set }
    var router: TimKiemDonHangHangMireaPresenterToRouterProtocol? { get set }
    func timKiemDonHang(soPOS:String)
}

protocol TimKiemDonHangHangMireaPresenterToInteractorProtocol: class {
    var presenter:TimKiemDonHangHangMireaInteractorToPresenterProtocol? { get set }
    func timKiemDonHang(userCode:String,
                        shopCode:String,
                        partnerId:String,
                        soPOS:String)
}

protocol TimKiemDonHangHangMireaInteractorToPresenterProtocol:class {
    func outPutSuccess(data:[TimKiemDonHangHangMireaEntity.DataTimKiemDonHangModel])
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol TimKiemDonHangHangMireaPresenterToViewProtocol:class {
    func didOutPutSuccess()
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol TimKiemDonHangHangMireaPresenterToRouterProtocol:class {
    var view: TimKiemDonHangHangMireaViewController! { get set }
    func configureVIPERTimKiemDonHangHangMirea() -> TimKiemDonHangHangMireaViewController
}

