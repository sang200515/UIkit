//
//  KiemTraThongTinKhuyenMaiMiraeProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol KiemTraThongTinKhuyenMaiMiraeViewToPresenterProtocol: class {
    var view: KiemTraThongTinKhuyenMaiMiraePresenterToViewProtocol? { get set }
    var interactor: KiemTraThongTinKhuyenMaiMiraePresenterToInteractorProtocol? { get set }
    var router: KiemTraThongTinKhuyenMaiMiraePresenterToRouterProtocol? { get set }
    func fetchData(username:String,password:String)
}

protocol KiemTraThongTinKhuyenMaiMiraePresenterToInteractorProtocol: class {
    var presenter:KiemTraThongTinKhuyenMaiMiraeInteractorToPresenterProtocol? { get set }
    func fetchNotice(username:String,password:String)
}

protocol KiemTraThongTinKhuyenMaiMiraeInteractorToPresenterProtocol:class {
    func outPutSuccess(data:String)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol KiemTraThongTinKhuyenMaiMiraePresenterToViewProtocol:class {
    func outPutSuccess(data:String)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol KiemTraThongTinKhuyenMaiMiraePresenterToRouterProtocol:class {
    var view: KiemTraThongTinKhuyenMaiMiraeViewController! { get set }
    func configureVIPERKiemTraThongTinKhuyenMaiMirae() -> KiemTraThongTinKhuyenMaiMiraeViewController
}

