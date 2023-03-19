//
//  KiemTraThongTinKhuyenMaiMiraeInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class KiemTraThongTinKhuyenMaiMiraeInteractor:KiemTraThongTinKhuyenMaiMiraePresenterToInteractorProtocol {
    
    weak var presenter: KiemTraThongTinKhuyenMaiMiraeInteractorToPresenterProtocol?
    
    func fetchNotice(username: String, password: String) {
        self.presenter?.showLoading(message: "Show Loading")
    }

}
