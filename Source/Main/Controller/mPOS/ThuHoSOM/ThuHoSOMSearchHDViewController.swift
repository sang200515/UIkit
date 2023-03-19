//
//  ThuHoSOMSearchHDViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 16/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

class ThuHoSOMSearchHDViewController: UIViewController {
    
    @IBOutlet weak var tfSearchType: UITextField!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tbSearch: UITableView!
    
    private var agreements: [ThuHoSOMAgreement] = []
    private var selectedTypeIndex: Int = 0
    private var types = ["Số điện thoại", "CMND"]
    private var typeDropDown = DropDown()
    var didSelectHD: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDropDowns()
        setupTableView()
    }
    
    private func setupUI() {
        title = "Tìm Kiếm Số Hợp Đồng"
        addBackButton()
        
        btnSearch.roundCorners(.allCorners, radius: 5)
        
        tfSearchType.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
        tfSearchType.text = types[selectedTypeIndex]
    }
    
    private func configureDropDowns() {
        DropDown.startListeningToKeyboard()
        
        typeDropDown.direction = .bottom
        typeDropDown.bottomOffset = CGPoint(x: 0, y: tfSearchType.bounds.height)
        typeDropDown.anchorView = tfSearchType
        
        typeDropDown.selectionAction = { [weak self] index, item in
            guard let self = self else { return }
            self.view.endEditing(true)
            self.selectedTypeIndex = index
            self.tfSearchType.text = item
        }
    }
    
    private func setupTableView() {
        tbSearch.registerTableCell(ThuHoSOMAgreementHeaderTableViewCell.self)
        tbSearch.registerTableCell(ThuHoSOMAgreementTableViewCell.self)
    }
    
    @IBAction func searchHDButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        Provider.shared.thuhoSOMAPIService.getAgreements(providerId: ThuHoSOMDataManager.shared.selectedProduct.defaultProviderId, contract: tfSearch.text&, type: selectedTypeIndex + 1, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.agreements = data.agreements
            self.tbSearch.reloadData()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}

extension ThuHoSOMSearchHDViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfSearchType {
            typeDropDown.dataSource = types
            typeDropDown.show()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfSearchType {
           return false
        }
        
        return true
    }
}

extension ThuHoSOMSearchHDViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return agreements.count == 0 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agreements.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueTableCell(ThuHoSOMAgreementHeaderTableViewCell.self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(ThuHoSOMAgreementTableViewCell.self)
        cell.setupCell(order: indexPath.row + 1, agreement: agreements[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectHD?(agreements[indexPath.row].contract)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
