//
//  PopUpHuongDanCheckKhuyenMaiViewController.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 10/06/2022.
//

import UIKit

class PopUpHuongDanCheckKhuyenMaiViewController : BaseVC<PopUpHuongDanCheckKhuyenMaiView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.mainView.closeButton.addTarget(self, action: #selector(self.dismissController), for: .touchUpInside)
    }
    
    @objc
    private func dismissController(){
        self.dismiss(animated: true)
    }
}
