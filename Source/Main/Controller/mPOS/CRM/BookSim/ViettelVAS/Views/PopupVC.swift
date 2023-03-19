//
//  PopupVC.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 31/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class PopupVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    var onOKAction: (() -> Void)?
    var onCloseAction: (() -> Void)?

    
    var dataPopup = (title:"Thông báo",content:"",titleButton:"OK",isShowClose: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.alpha = 0.5
        titleLabel.text = dataPopup.title
        contentLabel.text = dataPopup.content
        okButton.setTitle(dataPopup.titleButton, for: .normal)
        closeButton.isHidden = !dataPopup.isShowClose
        contentLabel.AutoScaleHeightForLabel()
    }
    
//    func bindPopup(title: String = "Thông báo", content: String, titleButton: String = "OK") {
////        contentLabel.text = content
//        okButton.setTitle(titleButton, for: .normal)
//        titleLabel.text = title
//    }
    
    @IBAction func okAction() {
        self.dismiss(animated: true, completion: nil)
        if let ok = onOKAction {
            ok()
        }
    }
    @IBAction func closeAction() {
        self.dismiss(animated: true, completion: nil)
        if let ok = onCloseAction {
            ok()
        }
    }
}
