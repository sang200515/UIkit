//
//  CheckBookingViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 04/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CheckBookingViewController: UIViewController {

    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var btnCheck: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        VietjetDataManager.shared.resetAddon()
        VietjetDataManager.shared.resetChangeFlight()
    }
    
    private func setupUI() {
        if VietjetDataManager.shared.isAddon {
            title = "Dịch vụ"
        } else if VietjetDataManager.shared.isChangeFlight {
            title = "Thay đổi thông tin"
        }
        
        addBackButton()
        
        btnCheck.roundCorners(.allCorners, radius: 5)
    }

    @IBAction func checkButtonPressed(_ sender: Any) {
        guard let code = tfCode.text else { return }
        Provider.shared.vietjetAPIService.getReservation(locator: code, success: { [weak self] data in
            guard let self = self, let result = data else { return }
            VietjetDataManager.shared.historyBooking = result
            if VietjetDataManager.shared.isAddon {
                let vc = AddMoreServicesViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if VietjetDataManager.shared.isChangeFlight {
                let vc = VietjetChangeFlightViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}

extension CheckBookingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
        return false
    }
}
