//
//  GRTPopupView.swift
//  fptshop
//
//  Created by Ngoc Bao on 23/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Toaster

class GRTPopupView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var okImg: UIImageView!
    @IBOutlet weak var noOkImg: UIImageView!
    @IBOutlet weak var errDesTxt: UITextView!
    @IBOutlet weak var errDesView: UIView!
    var radioValue = -1 // 0 -> OK | 1 -> not OK
    var onSaves: ((Bool,String)-> Void)?
    //MARK:
        override init(frame: CGRect) {
            super.init(frame: frame)

            loadViewFromNib()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)

            loadViewFromNib()
        }

        //MARK:
    func loadViewFromNib() {
        Bundle.main.loadNibNamed("GRTPopupView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }

    func setImage(img: UIImageView, isSelect: Bool) {
        img.image = isSelect ? UIImage(named: "mdi_check_circle_gr_2") : UIImage(named: "mdi_check_circle_gr")
    }
    
    @IBAction func onClickRadio(btn: UIButton) {
        self.endEditing(true)
        errDesView.isHidden = btn.tag == 0
        radioValue = btn.tag
        setImage(img: okImg, isSelect: btn.tag == 0)
        setImage(img: noOkImg, isSelect: btn.tag == 1)
    }

    
    @IBAction func onClose() {
        self.removeFromSuperview()
    }
    
    @IBAction func onSave() {
        self.endEditing(true)
        let errDes = errDesTxt.text
        if radioValue == -1 {
            Toast(text: "Bạn chưa chọn kết quả test").show()
            return
        }
        if radioValue == 1 && errDes == ""{
            Toast(text:"Bạn phải nhập mô tả lỗi").show()
            return
        }
        self.removeFromSuperview()
        if let save = self.onSaves {
            save(self.radioValue == 0,errDes ?? "")
        }
        
    }
}
extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
