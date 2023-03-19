//
//  GHTNChiTietChoGiaoRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class GHTNChiTietChoGiaoRouter : GHTNChiTietChoGiaoPresenterToRouterProtocol {

    var view: GHTNChiTietChoGiaoViewController!

    func configureVIPERGHTNChiTietChoGiao() -> GHTNChiTietChoGiaoViewController {
        self.view = GHTNChiTietChoGiaoViewController()
        let presenter: GHTNChiTietChoGiaoPresenter = GHTNChiTietChoGiaoPresenter()
        let interactor: GHTNChiTietChoGiaoInteractor = GHTNChiTietChoGiaoInteractor()
        let router:GHTNChiTietChoGiaoPresenterToRouterProtocol = GHTNChiTietChoGiaoRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
