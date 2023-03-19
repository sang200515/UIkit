//
//  TimKiemDonHangHangMireaInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class TimKiemDonHangHangMireaInteractor:TimKiemDonHangHangMireaPresenterToInteractorProtocol {
    
    weak var presenter: TimKiemDonHangHangMireaInteractorToPresenterProtocol?

    func timKiemDonHang(userCode: String, shopCode: String, partnerId: String, soPOS: String) {
        ApiRequestMirae.request(.timDonCoc(userCode: userCode, shopCode: shopCode, partnerId: partnerId, soPOS: soPOS), TimKiemDonHangHangMireaEntity.TimKiemDonHangModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.outPutSuccess(data: data.data ?? [])
                }else {
                    self.presenter?.outPutFailed(error: (data.message ?? ""))
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Tìm đơn cọc không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }

}
