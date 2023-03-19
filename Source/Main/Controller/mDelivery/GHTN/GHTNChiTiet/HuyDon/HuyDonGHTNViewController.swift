//
//  HuyDonGHTNViewController.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 15/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol HuyDonGHTNViewControllerDelegate:AnyObject {
    func xacNhanHuyDonHang(reason:String)
}

class HuyDonGHTNViewController: BaseVC<HuyDonGHTNView> {
    
    weak var delegate:HuyDonGHTNViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.reasonTextView.delegate = self
        self.mainView.backgroundColor = .black.withAlphaComponent(0.5)
        self.mainView.xacNhanHuyButton.addTarget(self, action: #selector(self.xacNhanHuyDon), for: .touchUpInside)
        self.mainView.closeButton.addTarget(self, action: #selector(self.closeTapped), for: .touchUpInside)
    }
    @objc private func xacNhanHuyDon(){
        if self.mainView.reasonTextView.text.isEmpty ||
            self.mainView.reasonTextView.text == "Nhập lý do hủy đơn hàng" {
            AlertManager.shared.alertWithViewController(title: "Thông báo", message: "Vui lòng nhập lý do hủy đơn hàng", titleButton: "OK", viewController: self) {
                
            }
            return
        }
        self.dismiss(animated: true) {
            self.delegate?.xacNhanHuyDonHang(reason: self.mainView.reasonTextView.text ?? "")
        }
    }
    @objc private func closeTapped(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension HuyDonGHTNViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Nhập lý do hủy đơn hàng" {
            textView.text = ""
        }
    }
}
