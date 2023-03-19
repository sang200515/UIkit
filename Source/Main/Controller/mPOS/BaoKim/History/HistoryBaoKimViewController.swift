//
//  HistoryBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 29/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryBaoKimViewController: UIViewController {

    @IBOutlet weak var tbvHistory: UITableView!
    
    private var histories: [BaoKimHistory] = []
    private var filtedHistories: [BaoKimHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadData()
    }
    
    private func setupUI() {
        addBackButton()
        
        // search bar
        let searchField = UITextField(frame: CGRect(x: 30, y: 20, width: UIScreen.main.bounds.size.width, height: 35))
        searchField.delegate = self
        searchField.placeholder = "Nhập số đơn hàng/SĐT/Mã đặt vé"
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
    
    private func loadData() {
        Provider.shared.baokimAPIService.getHistories(success: { [weak self] data in
            guard let self = self else { return }
            self.histories = data
            self.filtedHistories = data
            self.tbvHistory.reloadData()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}

extension HistoryBaoKimViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtedHistories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(VietjetHistoryTableViewCell.self)
        cell.selectionStyle = .none
        cell.setupCell(filtedHistories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HistoryDetailBaoKimViewController()
        vc.bookingCode = filtedHistories[indexPath.row].bookingID
        vc.mposCode = "\(filtedHistories[indexPath.row].sompos)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HistoryBaoKimViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text&.isEmpty {
            filtedHistories = histories
            tbvHistory.reloadData()
            return true
        }

        var listDataSuggest: [BaoKimHistory] = []
        let locale = Locale(identifier: "vi_VN")
        for item in histories {
            let mpos = "\(item.sompos)".folding(options: .diacriticInsensitive, locale: locale)
            if mpos.contains(textField.text&.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                listDataSuggest.append(item)
                break
            }
            
            let phone = item.customerPhone.folding(options: .diacriticInsensitive, locale: locale)
            if phone.contains(textField.text&.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                listDataSuggest.append(item)
                break
            }
            
            let booking = item.bookingID.folding(options: .diacriticInsensitive, locale: locale)
            if booking.contains(textField.text&.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                listDataSuggest.append(item)
                break
            }
        }

        filtedHistories = listDataSuggest
        tbvHistory.reloadData()
        return true
    }
}
