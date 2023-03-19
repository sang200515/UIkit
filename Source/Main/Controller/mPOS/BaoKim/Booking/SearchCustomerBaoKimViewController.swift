//
//  SearchCustomerBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 17/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SearchCustomerBaoKimViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    var isEdit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Tìm chuyến xe"
        addBackButton()
        
        btnSearch.roundCorners(.allCorners, radius: 5)
        btnSearch.setTitle(isEdit ? "Lưu Lại" : "Tiếp Tục", for: .normal)
        tfName.withImage(direction: .left, image: UIImage(named: "ic_user")!)
        tfPhone.withImage(direction: .left, image: UIImage(named: "ic_phone")!)
        tfEmail.withImage(direction: .left, image: UIImage(named: "ic_email")!)
        
        if isEdit {
            tfName.text = BaoKimDataManager.shared.name
            tfPhone.text = BaoKimDataManager.shared.phone
            tfEmail.text = BaoKimDataManager.shared.email
        }
    }
    
    private func validateInputs() -> Bool {
        guard let name = tfName.text, !name.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập tên khách hàng", titleButton: "OK")
            return false
        }
        
        guard let phone = tfPhone.text, !phone.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT khách hàng", titleButton: "OK")
            return false
        }
        
        if phone.count != 10 {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin SĐT 10 chữ số", titleButton: "OK")
            return false
        }
        
        if !isValidEmail(tfEmail.text&) {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Email hợp lệ", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return email.isEmpty ? true : emailPred.evaluate(with: email)
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }
        
        BaoKimDataManager.shared.name = tfName.text&.trim()
        BaoKimDataManager.shared.phone = tfPhone.text&.trim()
        BaoKimDataManager.shared.email = tfEmail.text&.trim()
        
        if isEdit {
            self.navigationController?.popViewController(animated: true)
        } else {
            let vc = SearchTripBaoKimViewController()
            navigationController?.push(viewController: vc)
        }
    }
}

extension SearchCustomerBaoKimViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfPhone {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
            return range.location < 10 && allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
}
