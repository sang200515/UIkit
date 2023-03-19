//
//  VietjetPaymentHistoryViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 28/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetPaymentHistoryViewController: UIViewController {

    @IBOutlet weak var tbvHistory: UITableView!
    
    private var histories: [VietjetPaymentHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadData("")
    }
    
    private func setupUI() {
        addBackButton()
        
        // search bar
        let searchField = UITextField(frame: CGRect(x: 30, y: 20, width: UIScreen.main.bounds.size.width, height: 35))
        searchField.delegate = self
        searchField.placeholder = "Tìm kiếm theo SĐT/Mã đặt vé"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5

        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper
        self.navigationItem.titleView = searchField
    }
    
    private func setupTableView() {
        tbvHistory.registerTableCell(VietjetHistoryTableViewCell.self)
        tbvHistory.estimatedRowHeight = 100
        tbvHistory.rowHeight = UITableView.automaticDimension
    }
    
    private func loadData(_ key: String) {
        Provider.shared.vietjetAPIService.getOrderHistory(key: key, success: { [weak self] data in
            guard let self = self else { return }
            self.histories = data
            self.tbvHistory.reloadData()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}

extension VietjetPaymentHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(VietjetHistoryTableViewCell.self)
        cell.selectionStyle = .none
        cell.setupCell(histories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VietjetFlightInfoViewController()
        vc.history = histories[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension VietjetPaymentHistoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loadData(textField.text&)
        return true
    }
}
