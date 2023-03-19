//
//  LichSuTraGopMiraePresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

//MARK:- Input View to Presenter
class LichSuTraGopMiraePresenter : LichSuTraGopMiraeViewToPresenterProtocol {

    weak var view: LichSuTraGopMiraePresenterToViewProtocol?
    var model:[LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel] = []
    var modelFull:[LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel] = []
    var modelSearchType:[LichSuTraGopMiraeEntity.SearchType] = []
    var interactor: LichSuTraGopMiraePresenterToInteractorProtocol?
    var typeLoad:Int = 0
    var typeSearch:Int = 0
    var router: LichSuTraGopMiraePresenterToRouterProtocol?
    
    func viewDidLoad(type:String) {
        self.view?.showLoading(message: "Đang tải dữ liệu")
        self.setDataSearchType()
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.loadDanhSachLichSu(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", loadType: type)
    }
    
    private func setDataSearchType(){
        self.modelSearchType = [
            LichSuTraGopMiraeEntity.SearchType(id: 0, value: "Mã hồ sơ"),
            LichSuTraGopMiraeEntity.SearchType(id: 1, value: "CMND/CCCD"),
            LichSuTraGopMiraeEntity.SearchType(id: 2, value: "SDT khách hàng"),
            LichSuTraGopMiraeEntity.SearchType(id: 3, value: "SO MPOS")
        ]
    }
    
    func searchDonHang(text:String){
        self.filterContentForSearchText(text)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        var filteredItems:[LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel] = []
        if searchText == "" {
            self.model = self.modelFull
        }else {
            let options = String.CompareOptions.caseInsensitive
            switch self.typeSearch {
            case 0:
                filteredItems = self.model
                    .filter{String($0.applicationID ?? "0").range(of: searchText, options: options) != nil}
                    .sorted{ (String($0.applicationID ?? "0").hasPrefix(searchText) ? 0 : 1) < (String($1.applicationID ?? "0").hasPrefix(searchText) ? 0 : 1) }
            case 1:
                filteredItems = self.model
                    .filter{$0.idCard?.range(of: searchText, options: options) != nil}
                    .sorted{ (($0.idCard ?? "").hasPrefix(searchText) ? 0 : 1) < (($1.idCard ?? "").hasPrefix(searchText) ? 0 : 1) }
            case 2:
                filteredItems = self.model
                    .filter{$0.phone?.range(of: searchText, options: options) != nil}
                    .sorted{ (($0.phone ?? "").hasPrefix(searchText) ? 0 : 1) < (($1.phone ?? "").hasPrefix(searchText) ? 0 : 1) }
                break
            case 3:
                filteredItems = self.model
                    .filter{String($0.soMPOS ?? 0).range(of: searchText, options: options) != nil}
                    .sorted{ (String($0.soMPOS ?? 0).hasPrefix(searchText) ? 0 : 1) < (String($1.soMPOS ?? 0).hasPrefix(searchText) ? 0 : 1) }
            default:

                break
            }
            self.model = filteredItems
        }
        self.view?.didSearchSuccess()
    }
}

//MARK: -Out Presenter To View
extension LichSuTraGopMiraePresenter : LichSuTraGopMiraeInteractorToPresenterProtocol {
    
    func loadDanhSachLichSuSuccess(model: [LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel]) {
        self.model = model
        self.modelFull = model
        self.view?.didLoadDanhSachLichSuSuccess(model: model)
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
