//
//  PopupInputOTP.swift
//  fptshop
//
//  Created by Sang Truong on 11/18/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit


class PopupInputOTP: UIViewController {

    @IBOutlet var blurView: UIView!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var inputTxt: UITextField!
    @IBOutlet weak var resendOTP: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var inputOTPTextField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var heightView: NSLayoutConstraint!
    @IBOutlet weak var errorMsgLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    var onOKAction: (() -> Void)?
    var onResendOTP: (() -> Void)?

    
    var dataPopup = (title:"Xác Nhận",content:"Nhập mã OTP đã được gửi về máy của KH",titleButton:"Xác Nhận",errMsg:"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.alpha = 0.5
        tittleLabel.text = dataPopup.title
        contentLabel.text = dataPopup.content
        okButton.setTitle(dataPopup.titleButton, for: .normal)

        view.alpha = 0.5
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

//    @IBAction func resendOTP(_ sender: Any) {
//        if let ok = onResendOTP {
//            ok()
//        }
//    }
}
