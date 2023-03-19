//
//  CmndTypePopUp.swift
//  fptshop
//
//  Created by Ngoc Bao on 10/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CmndTypePopUp: UIViewController {

    @IBOutlet weak var radio9so: RadioCustom!
    @IBOutlet weak var radio12So: RadioCustom!
    @IBOutlet weak var radioCCCD: RadioCustom!
    
    @IBOutlet weak var blurView: UIView!
    
    
    var onNext: (()->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.alpha = 0.5
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ondissmiss))
        blurView.isUserInteractionEnabled = true
        blurView.addGestureRecognizer(gesture)
        radio9so.delegate = self
        radioCCCD.delegate = self
        radio12So.delegate = self
    }
    
    @objc func ondissmiss() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onContinue(_ sender: Any) {
        if !radio9so.isSelect && !radioCCCD.isSelect && !radio12So.isSelect {
            self.showAlert("Vui lòng chọn một loại chứng từ!")
        } else {
            self.dismiss(animated: true) {
                if let onNext = self.onNext {
                    onNext()
                }
            }
        }
    }
}

extension CmndTypePopUp: RadioCustomDelegate {
    func onClickRadio(radioView: UIView,tag: Int) {
        switch radioView.tag {
        case 0:
            radio9so.setSelect(isSelect: true)
            radio12So.setSelect(isSelect: false)
            radioCCCD.setSelect(isSelect: false)
            ShinhanData.cmndType = 0
        case 1:
            radio9so.setSelect(isSelect: false)
            radio12So.setSelect(isSelect: true)
            radioCCCD.setSelect(isSelect: false)
            ShinhanData.cmndType = 3
        case 2:
            radio9so.setSelect(isSelect: false)
            radio12So.setSelect(isSelect: false)
            radioCCCD.setSelect(isSelect: true)
            ShinhanData.cmndType = 1
        default:
            break
        }
    }
}
