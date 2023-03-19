//
//  KiemTraThongTinKhuyenMaiMiraeRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class KiemTraThongTinKhuyenMaiMiraeRouter : KiemTraThongTinKhuyenMaiMiraePresenterToRouterProtocol {

    var view: KiemTraThongTinKhuyenMaiMiraeViewController!

    func configureVIPERKiemTraThongTinKhuyenMaiMirae() -> KiemTraThongTinKhuyenMaiMiraeViewController {
        self.view = KiemTraThongTinKhuyenMaiMiraeViewController()
        let presenter: KiemTraThongTinKhuyenMaiMiraePresenter = KiemTraThongTinKhuyenMaiMiraePresenter()
        let interactor: KiemTraThongTinKhuyenMaiMiraeInteractor = KiemTraThongTinKhuyenMaiMiraeInteractor()
        let router:KiemTraThongTinKhuyenMaiMiraePresenterToRouterProtocol = KiemTraThongTinKhuyenMaiMiraeRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
