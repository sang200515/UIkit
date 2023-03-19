//
//  CMSNHistoryViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 08/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CMSNHistoryViewController: UIViewController {
    
    @IBOutlet weak var tbvHistory: UITableView!
    
    private var histories: [CMSNHistoryData] = []
    private var filtedHistories: [CMSNHistoryData] = []

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
        searchField.placeholder = "Nhập số CMND/Căn cước/SĐT"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5
        searchField.keyboardType = .numberPad

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
        tbvHistory.registerTableCell(CMSNHistoryTableViewCell.self)
        tbvHistory.estimatedRowHeight = 100
        tbvHistory.rowHeight = UITableView.automaticDimension
    }
    
    private func loadData() {
        Provider.shared.cmsnAPIService.getCMSNHistories(success: { [weak self] data in
            guard let self = self, let result = data else { return }
            self.histories = result.data
            self.filtedHistories = result.data
            self.tbvHistory.reloadData()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}

extension CMSNHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtedHistories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(CMSNHistoryTableViewCell.self)
        cell.selectionStyle = .none
        cell.setupCell(filtedHistories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CMSNHistoryDetailViewController()
        vc.detail = filtedHistories[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Xoá") { (action, sourceView, completionHandler) in
            self.showAlertTwoButton(title: "Thông báo", with: self.filtedHistories[indexPath.row].cancelPopupContent, titleButtonOne: "Xác nhận", titleButtonTwo: "Huỷ", handleButtonOne: {
                Provider.shared.cmsnAPIService.cancelCMSNVoucher(id: self.filtedHistories[indexPath.row].id, success: { [weak self] data in
                    guard let self = self, let result = data else { return }
                    if result.success {
                        self.histories.removeAll(where: { $0.id == self.filtedHistories[indexPath.row].id })
                        self.filtedHistories.remove(at: indexPath.row)
                    }
                    self.showAlertOneButton(title: "Thông báo", with: result.message, titleButton: "OK", handleOk: {
                        DispatchQueue.main.async {
                            completionHandler(result.success)
                        }
                    })
                }, failure: { [weak self] error in
                    guard let self = self else { return }
                    self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                })
            }, handleButtonTwo: {
                DispatchQueue.main.async {
                    completionHandler(false)
                }
            })
        }
        
        delete.backgroundColor = .red
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = true
        return swipeActionConfig
    }
}

extension CMSNHistoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text&.isEmpty {
            filtedHistories = histories
            tbvHistory.reloadData()
            return true
        }

        var listDataSuggest: [CMSNHistoryData] = []
        let locale = Locale(identifier: "vi_VN")
        for item in histories {
            let mpos = "\(item.idCard)".folding(options: .diacriticInsensitive, locale: locale)
            if mpos.contains(textField.text&.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                listDataSuggest.append(item)
                break
            }
            
            let phone = item.phoneNumber.folding(options: .diacriticInsensitive, locale: locale)
            if phone.contains(textField.text&.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                listDataSuggest.append(item)
                break
            }
        }

        filtedHistories = listDataSuggest
        tbvHistory.reloadData()
        return true
    }
}
