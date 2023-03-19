//
//  EditInfoBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 23/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class EditInfoBaoKimViewController: UIViewController {

    var didChangeCustomerInfo: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Thay đổi thông tin"
        addBackButton()
    }
    
    @IBAction func changeCustomerInfoButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        didChangeCustomerInfo?()
    }
    
    @IBAction func changeTripInfoButtonPressed(_ sender: Any) {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc is SearchTripBaoKimViewController {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
}
