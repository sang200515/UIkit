//
//  PopupCancelOrder.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 02/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Toaster

class PopupCancelOrder: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var stackViewRadio: UIStackView!
    @IBOutlet weak var reason1Icon: UIImageView!
    @IBOutlet weak var reason2Icon: UIImageView!
    @IBOutlet weak var reasonStack: UIStackView!
    @IBOutlet weak var bottomButtom: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var otherReasonTxt: UITextView!
    
    var oncancel: ((String,String) -> Void)?
    var ondisMiss: (() -> Void)?
    var selectIndex = -1 // 0: Huy don 1: Huy don co su dong y
    var currentStep = 1 //1 chon hinh thuc 2: xac nhan
    var placeHolder = "Vui lòng nhập lý do hủy"
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.alpha = 0.5
        otherReasonTxt.delegate = self
        otherReasonTxt.text = placeHolder
        otherReasonTxt.textColor = .lightGray
    }
    
    @IBAction func radioAction(_ sender: UIButton) {
        selectIndex = sender.tag
        setImage(img: reason1Icon, isSelect: sender.tag == 0)
        setImage(img: reason2Icon, isSelect: sender.tag == 1)
    }
    
    @IBAction func onCancelAction() { // dong popup
        self.dismiss(animated: true, completion: nil)
        if let dismiss = ondisMiss {
            dismiss()
        }
    }
    
    @IBAction func onDismissAction() { // huy don
        if currentStep == 1 { // chon hinh thuc
            if selectIndex < 0 {
                Toast.init(text: "Bạn chưa chọn hình thức!").show()
                return
            }
            currentStep += 1
            bottomButtom.setTitle("XÁC NHẬN", for: .normal)
            titleLbl.text = "LÝ DO HUỶ"
            descriptionLbl.isHidden = false
            descriptionLbl.text = selectIndex == 0 ? "Hủy đơn hàng" : "Hủy đơn hàng và hợp đồng\n(hủy hợp đồng phải có sự đồng ý của KH)"
            stackViewRadio.isHidden = true
            reasonStack.isHidden = false
        } else { // xac nhan huy
            self.dismiss(animated: true, completion: nil)
            if let cancel = oncancel {
                let text = otherReasonTxt.text ?? ""
                cancel(text == placeHolder ? "" : text,selectIndex == 0 ? "INACT" : "CANC")
            }
        }
    }
    
    func setImage(img: UIImageView, isSelect: Bool) {
        img.image = isSelect ? UIImage(named: "mdi_check_circle_gr_2") : UIImage(named: "mdi_check_circle_gr")
    }

}
extension PopupCancelOrder: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHolder {
            otherReasonTxt.text = ""
            otherReasonTxt.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            otherReasonTxt.text = placeHolder
            otherReasonTxt.textColor = .lightGray
        }
    }
    
    
}
