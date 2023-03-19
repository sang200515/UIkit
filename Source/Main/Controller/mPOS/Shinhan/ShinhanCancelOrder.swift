//
//  ShinhanCancelOrder.swift
//  fptshop
//
//  Created by Ngoc Bao on 03/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShinhanCancelOrder: UIViewController {

    @IBOutlet weak var reasonTv: UITextView!
    
    var onConfirm: ((String)->Void)?

    @IBAction func closePopup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        guard let text = reasonTv.text, !text.isEmpty else {
            self.showAlert("Lý do không được để trống")
            return
        }
        self.dismiss(animated: true) {
            if let confirm = self.onConfirm {
                confirm(text)
            }
        }
    }
}
