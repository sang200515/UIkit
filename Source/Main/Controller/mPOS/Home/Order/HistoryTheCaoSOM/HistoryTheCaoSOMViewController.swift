//
//  HistoryTheCaoSOMViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 04/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryTheCaoSOMViewController: UIViewController {

    @IBOutlet weak var tfFromDate: UITextField!
    @IBOutlet weak var tfToDate: UITextField!
    @IBOutlet weak var tbvHistory: UITableView!
    private var searchField: UITextField!
    
    private var fromDatePicker = UIDatePicker()
    private var fromDateToolbar = UIToolbar()
    private var toDatePicker = UIDatePicker()
    private var toDateToolbar = UIToolbar()
    private var term: String = ""
    var isTopup: Bool = false
    private var historyList: [ThuHoSOMHistory] = [] {
        didSet {
            if historyList.count <= 0 {
                TableViewHelper.EmptyMessage(message: "Không có đơn hàng.\n:/", viewController: tbvHistory)
            } else {
                TableViewHelper.removeEmptyMessage(viewController: tbvHistory)
            }
            tbvHistory.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
    }
    
    private func setupUI() {
        let width = UIScreen.main.bounds.size.width
        addBackButton(#selector(actionBack))
        
        let calendarImageViewWrapper1 = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let calendarImageView1 = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let calendar1 = UIImage(named: "calendarIC")
        calendarImageView1.image = calendar1
        calendarImageViewWrapper1.addSubview(calendarImageView1)
        
        tfFromDate.layer.cornerRadius = 5
        tfFromDate.rightViewMode = .always
        tfFromDate.rightView = calendarImageViewWrapper1
        
        let calendarImageViewWrapper2 = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let calendarImageView2 = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let calendar2 = UIImage(named: "calendarIC")
        calendarImageView2.image = calendar2
        calendarImageViewWrapper2.addSubview(calendarImageView2)
        
        tfToDate.layer.cornerRadius = 5
        tfToDate.rightViewMode = .always
        tfToDate.rightView = calendarImageViewWrapper2
        
        // search bar
        searchField = UITextField(frame: CGRect(x: 30, y: 20, width: width, height: 35))
        searchField.delegate = self
        searchField.placeholder = "Tìm kiếm theo số phiếu thu"
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
        
        fromDateToolbar.barStyle = UIBarStyle.default
        fromDateToolbar.isTranslucent = true
        fromDateToolbar.sizeToFit()

        let fromDateDoneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(handleFromDate))

        fromDateToolbar.setItems([fromDateDoneButton], animated: false)
        fromDateToolbar.isUserInteractionEnabled = true
        
        toDateToolbar.barStyle = UIBarStyle.default
        toDateToolbar.isTranslucent = true
        toDateToolbar.sizeToFit()

        let toDateDoneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(handleToDate))

        toDateToolbar.setItems([toDateDoneButton], animated: false)
        toDateToolbar.isUserInteractionEnabled = true
        
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        fromDatePicker.datePickerMode = .date
        fromDatePicker.date = previousMonth ?? Date()
        fromDatePicker.maximumDate = Date()
        toDatePicker.datePickerMode = .date
        toDatePicker.date = Date()
        toDatePicker.minimumDate = previousMonth
        
        if #available(iOS 13.4, *) {
            fromDatePicker.preferredDatePickerStyle = .wheels
            toDatePicker.preferredDatePickerStyle = .wheels
        }
        
        tfFromDate.inputView = fromDatePicker
        tfFromDate.inputAccessoryView = fromDateToolbar
        tfFromDate.text = fromDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
        tfToDate.inputView = toDatePicker
        tfToDate.inputAccessoryView = toDateToolbar
        tfToDate.text = toDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
    }
    
    @objc private func actionBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tbvHistory.registerTableCell(HistoryThuHoSOMCell.self)
        
        tbvHistory.estimatedRowHeight = 100
        tbvHistory.rowHeight = UITableView.automaticDimension
    }
    
    private func loadData() {
        let fromDate = fromDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
        let toDate = toDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
        Provider.shared.thecaoSOMAPIService.getOrderHistory(term: term, fromDate: fromDate, toDate: toDate, isTopup: isTopup, success: { [weak self] result in
            guard let self = self else { return }
            self.historyList = result
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @objc private func handleFromDate() {
        self.view.endEditing(false)
        tfFromDate.text = fromDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
        fromDatePicker.maximumDate = toDatePicker.date
        toDatePicker.minimumDate = fromDatePicker.date
        
        loadData()
    }
    
    @objc private func handleToDate() {
        self.view.endEditing(false)
        tfToDate.text = toDatePicker.date.toString(dateFormat: "dd/MM/yyyy")
        fromDatePicker.maximumDate = toDatePicker.date
        toDatePicker.minimumDate = fromDatePicker.date
        
        loadData()
    }
}

extension HistoryTheCaoSOMViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        term = textField.text&
        loadData()
        return true
    }
}

extension HistoryTheCaoSOMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(HistoryThuHoSOMCell.self)
        cell.selectionStyle = .none
        cell.setupCell(history: historyList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = historyList[indexPath.row]
        Provider.shared.thecaoSOMAPIService.getOrderDetail(orderId: history.orderID, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            TheCaoSOMDataManager.shared.orderDetail = data
            
            let vc = TheNapSOMOrderSummaryViewController()
            vc.isHistory = true
            vc.type = self.isTopup ? .BanTien : .TheNap
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}
