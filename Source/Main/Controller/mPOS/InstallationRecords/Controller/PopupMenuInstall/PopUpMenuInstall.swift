//
//  PopUpMenuInstall.swift
//  fptshop
//
//  Created by Sang Truong on 11/4/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class PopUpMenuInstall: UIViewController {

    @IBOutlet var blurView: UIView!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var confirmButtton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var heightView: NSLayoutConstraint!
    var onOKAction: (() -> Void)?
    
    
    var dataPopup = (title:"Xác Nhận",content:"Nhập mã OTP đã được gửi về máy của KH",titleButton:"Xác Nhận",isShowClose: true,isShowOKButon:false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.alpha = 0.5
        tittleLabel.text = dataPopup.title
        contentLabel.text = dataPopup.content
        okButton.setTitle(dataPopup.titleButton, for: .normal)
        closeButton.isHidden = !dataPopup.isShowClose
        okButton.isHidden = !dataPopup.isShowOKButon
        if okButton.isHidden {
            heightView.constant = 120
            contentLabel.numberOfLines = 2
            
        }
    }
    
    @IBAction func okAction() {
        self.dismiss(animated: true, completion: nil)
        if let ok = onOKAction {
            ok()
        }
    }
    @IBAction func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }

}
