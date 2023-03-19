//
//  ThongTinKhachHangMireaRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ThongTinKhachHangMireaRouter : ThongTinKhachHangMireaPresenterToRouterProtocol {

    var view: ThongTinKhachHangMireaViewController!

    func configureVIPERThongTinKhachHangMirea() -> ThongTinKhachHangMireaViewController {
        self.view = ThongTinKhachHangMireaViewController()
        let presenter: ThongTinKhachHangMireaPresenter = ThongTinKhachHangMireaPresenter()
        let interactor: ThongTinKhachHangMireaInteractor = ThongTinKhachHangMireaInteractor()
        let router:ThongTinKhachHangMireaPresenterToRouterProtocol = ThongTinKhachHangMireaRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
