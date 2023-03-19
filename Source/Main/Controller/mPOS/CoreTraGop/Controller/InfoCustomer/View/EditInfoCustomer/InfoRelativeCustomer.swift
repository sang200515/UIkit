//
//  InfoRelativeCustomer.swift
//  QuickCode
//
//  Created by Sang Trương on 13/07/2022.
//

import UIKit


class InfoRelativeCustomer: UIViewController {
        //MARK: - Variable

        //MARK: - Properties

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfEmail: UITextField!

        //    @IBOutlet weak var btnSearch: UIButton!


        // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.01877964661, green: 0.6705997586, blue: 0.4313761592, alpha: 1)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "thông tin người liên hệ"
    }

        // MARK: - setupUI
    private func setupUI() {
        title = "Thông tin khách hàng"

        tfName.withImage(direction: .left, image: UIImage(named: "ic_user")!)
        tfPhone.withImage(direction: .left, image: UIImage(named: "ic_phone")!)
        tfDate.withImage(direction: .left, image: UIImage(named: "ic_calendar")!)
        tfEmail.withImage(direction: .left, image: UIImage(named: "ic_mail")!)



    }

        // MARK: - API




        // MARK: - Helpers

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return email.isEmpty ? true : emailPred.evaluate(with: email)
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
        guard let name = tfDate.text, !name.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Email hợp lệ1", titleButton: "OK")
            return false
        }


        return true
    }

        // MARK: - Selectors


    @IBAction func searchButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }




    }
}

extension InfoRelativeCustomer: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfPhone {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)

            return range.location < 10 && allowedCharacters.isSuperset(of: characterSet)
        }

        return true
    }
}
