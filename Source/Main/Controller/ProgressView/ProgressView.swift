//
//  ProgressView.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 30/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import MBProgressHUD

class ProgressView {
    static let shared = ProgressView()

    func show(_ title: String = "Đang lấy dữ liệu, bạn đợi xíu nhé") {
        let topVC = UIApplication.shared.topMostViewController()
        let hud = MBProgressHUD.showAdded(to: topVC.view, animated: true)
        hud.label.text = title
        topVC.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func hide() {
        let topVC = UIApplication.shared.topMostViewController()
        MBProgressHUD.hide(for: topVC.view, animated: true)
        topVC.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
