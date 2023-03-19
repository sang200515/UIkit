//
//  ButtonCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 03/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
class ButtonCell: UITableViewCell {

    @IBOutlet weak var buttonCell: UIButton!
    @IBOutlet weak var upButtonStack: UIStackView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var getOTPButton: UIButton!
    @IBOutlet weak var infoCusbutton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var onAction: (()->Void)?
    var rightAction: (()->Void)?
    var onCancelAction: (()->Void)?
    var onInfoAction: (()->Void)?
    var controller:UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func bindCellKM() {
        buttonCell.setTitle("KIỂM TRA KHUYẾN MÃI", for: .normal)
        infoCusbutton.isHidden = true
        cancelButton.isHidden = true
        buttonCell.backgroundColor = UIColor(red: 21, green: 184, blue: 71)
    }
    
    func bindCellSave() {
        if ShinhanData.detailorDerHistory != nil {
            buttonCell.setTitle("CẬP NHẬT ĐƠN HÀNG", for: .normal)
        } else {
            buttonCell.setTitle("LƯU ĐƠN HÀNG", for: .normal)
        }
        infoCusbutton.isHidden = true
        cancelButton.isHidden = true
        buttonCell.backgroundColor = UIColor(red: 21, green: 184, blue: 71)
    }
    
    func bincellDetail(item:ShinhanButton?,mainController:UIViewController) {
        controller = mainController
        getOTPButton.isHidden = false
        if !(item?.updateLoanInfoBtn ?? false) && !(item?.updateImageBtn ?? false) {
            upButtonStack.isHidden = true
        } else {
            upButtonStack.isHidden = false
        }
        buttonCell.setTitle("CẬP NHẬT KHOẢN VAY", for: .normal)
        buttonCell.backgroundColor = UIColor(hexString: "#072D95")
        rightButton.setTitle("CẬP NHẬT HÌNH ẢNH", for: .normal)
        rightButton.backgroundColor = UIColor(hexString: "#F36F20")
        buttonCell.isHidden = (item?.updateLoanInfoBtn ?? false) ? false : true
        rightButton.isHidden = (item?.updateImageBtn ?? false) ? false : true
        infoCusbutton.isHidden = (item?.viewCustomerInfoBtn ?? false) ? false : true
        cancelButton.isHidden = (item?.cancelBtn ?? false) ? false : true
        
    }
    
    @IBAction func getOTP(_ sender: Any) {
        let vc = OTPShinhanVC()
        vc.mposNum = ShinhanData.mposNum
        vc.isFromHistory = true
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onclickButton() {
        if let click = onAction {
            click()
        }
    }
    
    @IBAction func onRightAction() {
        if let click = rightAction {
            click()
        }
    }
    
    @IBAction func infoAction() {
        if let click = onInfoAction {
            click()
        }
    }
    
    @IBAction func cancelAction() {
        if let click = onCancelAction {
            click()
        }
    }

    
}
