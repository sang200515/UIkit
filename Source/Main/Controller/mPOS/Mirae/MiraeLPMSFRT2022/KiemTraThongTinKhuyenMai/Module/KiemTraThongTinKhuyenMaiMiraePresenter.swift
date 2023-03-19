//
//  KiemTraThongTinKhuyenMaiMiraePresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit
import MapKit

//MARK:- Input View to Presenter
class KiemTraThongTinKhuyenMaiMiraePresenter : KiemTraThongTinKhuyenMaiMiraeViewToPresenterProtocol {

    var model:[TestModel] = [TestModel(hedearTitle: "Giảm giá 1", subTitle: [
        TestSubModel(title: "Giảm giá 3,500,000", subTitle: "SL:1 - (Khi mua DTDD Samsung note 8)"),
        TestSubModel(title: "Giảm giá 1,500,000", subTitle: "SL:1 - (Khi mua DTDD Samsung note 8)")
    ]),
    TestModel(hedearTitle: "Giảm giá 1", subTitle: [
        TestSubModel(title: "Giảm giá 3,500,000", subTitle: "SL:1 - (Khi mua DTDD Samsung note 8)"),
        TestSubModel(title: "Giảm giá 1,500,000", subTitle: "SL:1 - (Khi mua DTDD Samsung note 8)")
    ])]
    
    weak var view: KiemTraThongTinKhuyenMaiMiraePresenterToViewProtocol?
    
    var interactor: KiemTraThongTinKhuyenMaiMiraePresenterToInteractorProtocol?
    
    var router: KiemTraThongTinKhuyenMaiMiraePresenterToRouterProtocol?
    
    func fetchData(username: String, password: String) {
        
    }
}

//MARK: -Out Presenter To View
extension KiemTraThongTinKhuyenMaiMiraePresenter : KiemTraThongTinKhuyenMaiMiraeInteractorToPresenterProtocol {
    
    func outPutSuccess(data: String) {
        self.view?.outPutSuccess(data: data)
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


class TestModel {
    var hedearTitle:String
    var subTitle:[TestSubModel]
    var isSelected:Bool = false
    var isExpanded:Bool = true
    init(hedearTitle:String,subTitle:[TestSubModel]) {
        self.hedearTitle = hedearTitle
        self.subTitle = subTitle
    }
}

class TestSubModel {
    var title:String
    var subTitle:String
    init(title:String,subTitle:String) {
        self.title = title
        self.subTitle = subTitle
    }
}
