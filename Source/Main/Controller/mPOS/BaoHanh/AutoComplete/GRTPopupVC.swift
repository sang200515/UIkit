//
//  GRTPopupVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 23/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class GRTPopupVC: BaseController {

    @IBOutlet weak var okImg: UIImageView!
    @IBOutlet weak var noOkImg: UIImageView!
    @IBOutlet weak var errDesTxt: UITextView!
    @IBOutlet weak var errDesView: UIView!
    var radioValue = -1 // 0 -> OK | 1 -> not OK
    
    var onSaves: ((Bool,String)-> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setImage(img: UIImageView, isSelect: Bool) {
        img.image = isSelect ? UIImage(named: "mdi_check_circle_gr_2") : UIImage(named: "mdi_check_circle_gr")
    }
    @IBAction func onClickRadio(btn: UIButton) {
        errDesView.isHidden = btn.tag == 0
        radioValue = btn.tag
        setImage(img: okImg, isSelect: btn.tag == 0)
        setImage(img: noOkImg, isSelect: btn.tag == 1)
    }

    
    @IBAction func onClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSave() {
        let errDes = errDesTxt.text
        if radioValue == -1 {
            self.showPopup(with: "Bạn chưa chọn kết quả test", completion: nil)
            return
        }
        if radioValue == 1 && errDes == ""{
            self.showPopup(with: "Bạn phải nhập mô tả lỗi", completion: nil)
            return
        }
        self.dismiss(animated: true) {
            if let save = self.onSaves {
                save(self.radioValue == 0,errDes ?? "")
            }
        }
    }

}
