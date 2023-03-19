//
//  HistoryZaloPayViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 28/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0
class HistoryZaloPayViewController: UIViewController {
    
    var tableView = UITableView()
    var safeArea: UILayoutGuide!
    var dataList: [OrderZaloPay] = []
    var fromDateView: CustomViewDate!
    var toDateView: CustomViewDate!
    var valueFromDate: String = ""
    var valueToDate: String = ""
    var spinner = UIActivityIndicatorView(style: .gray)
    
    var productSOM: ProductSOM?
    var providerSOM: ProviderSOM?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.title = "Lịch sử giao dịch"
        safeArea = view.layoutMarginsGuide
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(self.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.clipsToBounds = true
        self.view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        let viewLeft = UIView()
        let lbFrom = UILabel()
        viewLeft.addSubview(lbFrom)
        lbFrom.text = "Từ ngày:"
        lbFrom.translatesAutoresizingMaskIntoConstraints = false
        lbFrom.leftAnchor.constraint(equalTo: viewLeft.leftAnchor,constant: Common.Size(s: 10)).isActive = true
        lbFrom.topAnchor.constraint(equalTo: viewLeft.topAnchor,constant: Common.Size(s: 10)).isActive = true
        lbFrom.rightAnchor.constraint(equalTo: viewLeft.rightAnchor,constant: Common.Size(s: 10)).isActive = true
        
        
        fromDateView = CustomViewDate()
        viewLeft.addSubview(fromDateView)
        fromDateView.translatesAutoresizingMaskIntoConstraints = false
        fromDateView.leftAnchor.constraint(equalTo: viewLeft.leftAnchor,constant: Common.Size(s: 10)).isActive = true
        fromDateView.topAnchor.constraint(equalTo: lbFrom.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        fromDateView.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        fromDateView.rightAnchor.constraint(equalTo: viewLeft.rightAnchor,constant: Common.Size(s: -10)).isActive = true
        fromDateView.bottomAnchor.constraint(equalTo: viewLeft.bottomAnchor).isActive = true
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(self.tapFromDate))
        fromDateView.addGestureRecognizer(tapFromDate)
        fromDateView.isUserInteractionEnabled = true
        
        
        let viewRight = UIView()
        let lbTo = UILabel()
        viewRight.addSubview(lbTo)
        lbTo.text = "Đến ngày:"
        lbTo.translatesAutoresizingMaskIntoConstraints = false
        lbTo.leftAnchor.constraint(equalTo: viewRight.leftAnchor, constant: 10).isActive = true
        lbTo.topAnchor.constraint(equalTo: viewRight.topAnchor,constant: 10).isActive = true
        lbTo.rightAnchor.constraint(equalTo: viewRight.rightAnchor,constant: 10).isActive = true
        
        toDateView = CustomViewDate()
        viewRight.addSubview(toDateView)
        toDateView.translatesAutoresizingMaskIntoConstraints = false
        toDateView.leftAnchor.constraint(equalTo: viewRight.leftAnchor,constant: Common.Size(s: 10)).isActive = true
        toDateView.topAnchor.constraint(equalTo: lbTo.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        toDateView.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        toDateView.rightAnchor.constraint(equalTo: viewRight.rightAnchor,constant: Common.Size(s: -10)).isActive = true
        toDateView.bottomAnchor.constraint(equalTo: viewRight.bottomAnchor).isActive = true
        
        let tapToDate = UITapGestureRecognizer(target: self, action: #selector(self.tapToDate))
        toDateView.addGestureRecognizer(tapToDate)
        toDateView.isUserInteractionEnabled = true
        
        let stackView = UIStackView(arrangedSubviews: [viewLeft,viewRight])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        headerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        
        
        let btnSearch = UIButton()
        btnSearch.setTitle("TÌM KIẾM", for: .normal)
        btnSearch.backgroundColor = UIColor(netHex:0x00955E)
        btnSearch.setTitleColor(.white, for: .normal)
        btnSearch.layer.cornerRadius = 10
        headerView.addSubview(btnSearch)
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        btnSearch.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        btnSearch.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        btnSearch.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        btnSearch.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        btnSearch.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        btnSearch.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        tableView.register(ItemZaloPayCell.self, forCellReuseIdentifier: "ItemZaloPayCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        var dayComponent    = DateComponents()
        dayComponent.day    = -7
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
        valueToDate = formatDate3(date: Date())
        valueFromDate = formatDate3(date: nextDate!)
        self.fromDateView.date.text = "\(valueFromDate)"
        self.toDateView.date.text = "\(valueToDate)"
        
        loadHistory(fromDate: valueFromDate,toDate: valueToDate)
        
        
    }
    @objc func searchAction(sender: UIButton!) {
        
        
        
        loadHistory(fromDate: valueFromDate,toDate: valueToDate)
    }
    func loadHistory(fromDate: String, toDate: String) {
        ZaloPayServiceImpl.searchOrders(param: RequestHistoryZalopay(warehouseCode: "\(Cache.user!.ShopCode)", fromDate: fromDate, toDate: toDate, isQueryMaKH: false, parentCategoryIds: ["6421ee90-8d9b-4fb0-a17c-1645b7682ba5"], term: "")) { results in
            self.dataList = results
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    @objc func tapFromDate(){
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            
            self.fromDateView.date.text = "\(strDate)"
            self.valueFromDate = strDate
            
//            self.loadHistory(fromDate:  self.valueFromDate ,toDate:  self.valueToDate)
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.maximumDate = Date()
        datePicker?.show()
    }
    @objc func tapToDate(){
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.toDateView.date.text = "\(strDate)"
            self.valueToDate = strDate
//            self.loadHistory(fromDate:  self.valueFromDate ,toDate:  self.valueToDate)
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.maximumDate = Date()
        datePicker?.show()
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func formatDate3(date:Date) -> String{
        let deFormatter = DateFormatter()
        deFormatter.dateFormat = "dd/MM/yyyy"
        return deFormatter.string(from: date)
    }
}
extension HistoryZaloPayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemZaloPayCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemZaloPayCell")
        cell.selectionStyle = .none
        let item: OrderZaloPay  = dataList[indexPath.row]
        cell.setUpCell(item: item)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item: OrderZaloPay = dataList[indexPath.row]
        let newViewController = DetailZaloPayViewController()
        newViewController.orderId = item.orderId
        newViewController.productSOM = self.productSOM
        newViewController.providerSOM = self.providerSOM
        newViewController.isHistory = true
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
class ItemZaloPayCell: UITableViewCell {

    var viewCell = UIView()
    
    var lbTextNo = UILabel()
    var lbNo = UILabel()
    
    var lbTextPhoneNumber = UILabel()
    var lbPhoneNumber = UILabel()
    
    var lbTextStatus = UILabel()
    var lbStatus = UILabel()
    
    var lbTextTypeService = UILabel()
    var lbTypeService = UILabel()
    
    var lbTextUser = UILabel()
    var lbUser = UILabel()
    
    var lbTextTime = UILabel()
    var lbTime = UILabel()


    func setUpCell(item: OrderZaloPay){
        
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .clear
        self.contentView.addSubview(viewCell)
        viewCell.translatesAutoresizingMaskIntoConstraints = false
        
        viewCell.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Common.Size(s: 5)).isActive = true
        viewCell.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        viewCell.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: Common.Size(s: -5)).isActive = true
        viewCell.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: Common.Size(s: -5)).isActive = true
//        viewCell.heightAnchor.constraint(equalToConstant: Common.Size(s: 230)).isActive = true
        viewCell.backgroundColor = .white
        viewCell.layer.cornerRadius = 5
        
        lbTextNo.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextNo)
        lbTextNo.leftAnchor.constraint(equalTo: viewCell.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextNo.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextNo.widthAnchor.constraint(equalTo: viewCell.widthAnchor, multiplier: 1/4).isActive = true

        lbTextNo.textAlignment = .left
        lbTextNo.textColor = UIColor.black
        lbTextNo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextNo.text = "Số phiếu:"
        
        lbNo.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbNo)
        lbNo.leftAnchor.constraint(equalTo: lbTextNo.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbNo.topAnchor.constraint(equalTo: lbTextNo.topAnchor).isActive = true
        lbNo.rightAnchor.constraint(equalTo: viewCell.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        lbNo.textAlignment = .right
        lbNo.textColor = UIColor.black
        lbNo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbNo.text = "\(item.billNo)"
        
        lbTextPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextPhoneNumber)
        lbTextPhoneNumber.leftAnchor.constraint(equalTo: lbTextNo.leftAnchor).isActive = true
        lbTextPhoneNumber.topAnchor.constraint(equalTo: lbTextNo.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextPhoneNumber.widthAnchor.constraint(equalTo: viewCell.widthAnchor, multiplier: 1/3.5).isActive = true

        lbTextPhoneNumber.textAlignment = .left
        lbTextPhoneNumber.textColor = UIColor.black
        lbTextPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextPhoneNumber.text = "SĐT khách hàng:"
        
        lbPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbPhoneNumber)
        lbPhoneNumber.leftAnchor.constraint(equalTo: lbTextPhoneNumber.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbPhoneNumber.topAnchor.constraint(equalTo: lbTextPhoneNumber.topAnchor).isActive = true
        lbPhoneNumber.rightAnchor.constraint(equalTo: lbNo.rightAnchor).isActive = true
        lbPhoneNumber.textAlignment = .right
        lbPhoneNumber.textColor = UIColor(netHex:0x00955E)
        lbPhoneNumber.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbPhoneNumber.text = "\(item.customerPhoneNumber)"
        
        lbTextStatus.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextStatus)
        lbTextStatus.leftAnchor.constraint(equalTo: lbTextPhoneNumber.leftAnchor).isActive = true
        lbTextStatus.topAnchor.constraint(equalTo: lbTextPhoneNumber.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextStatus.widthAnchor.constraint(equalTo: viewCell.widthAnchor, multiplier: 1/3).isActive = true

        lbTextStatus.textAlignment = .left
        lbTextStatus.textColor = UIColor.black
        lbTextStatus.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextStatus.text = "Trạng thái:"
        
        lbStatus.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbStatus)
        lbStatus.leftAnchor.constraint(equalTo: lbTextStatus.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbStatus.topAnchor.constraint(equalTo: lbTextStatus.topAnchor).isActive = true
        lbStatus.rightAnchor.constraint(equalTo: lbNo.rightAnchor).isActive = true
        lbStatus.textAlignment = .right
        lbStatus.textColor = item.orderStatus.color
        lbStatus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbStatus.text = "\(item.orderStatus.name)"
        
        
        lbTextTypeService.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextTypeService)
        lbTextTypeService.leftAnchor.constraint(equalTo: lbTextStatus.leftAnchor).isActive = true
        lbTextTypeService.topAnchor.constraint(equalTo: lbTextStatus.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextTypeService.widthAnchor.constraint(equalTo: viewCell.widthAnchor, multiplier: 1/3).isActive = true

        lbTextTypeService.textAlignment = .left
        lbTextTypeService.textColor = UIColor.black
        lbTextTypeService.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextTypeService.text = "Loại dịch vụ:"
        
        lbTypeService.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTypeService)
        lbTypeService.leftAnchor.constraint(equalTo: lbTextTypeService.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTypeService.topAnchor.constraint(equalTo: lbTextTypeService.topAnchor).isActive = true
        lbTypeService.rightAnchor.constraint(equalTo: lbNo.rightAnchor).isActive = true
        lbTypeService.textAlignment = .right
        lbTypeService.textColor = UIColor.black
        lbTypeService.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTypeService.text = "\(item.productName)"
        
        lbTextUser.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextUser)
        lbTextUser.leftAnchor.constraint(equalTo: lbTextTypeService.leftAnchor).isActive = true
        lbTextUser.topAnchor.constraint(equalTo: lbTextTypeService.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextUser.widthAnchor.constraint(equalTo: viewCell.widthAnchor, multiplier: 1/3).isActive = true

        lbTextUser.textAlignment = .left
        lbTextUser.textColor = UIColor.black
        lbTextUser.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextUser.text = "Tên nhân viên:"
        
        lbUser.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbUser)
        lbUser.leftAnchor.constraint(equalTo: lbTextUser.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbUser.topAnchor.constraint(equalTo: lbTextUser.topAnchor).isActive = true
        lbUser.rightAnchor.constraint(equalTo: lbNo.rightAnchor).isActive = true
        lbUser.textAlignment = .right
        lbUser.textColor = UIColor.black
        lbUser.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbUser.text = "\(item.employeeName)"
        
        lbTextTime.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextTime)
        lbTextTime.leftAnchor.constraint(equalTo: lbTextUser.leftAnchor).isActive = true
        lbTextTime.topAnchor.constraint(equalTo: lbTextUser.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTextTime.widthAnchor.constraint(equalTo: viewCell.widthAnchor, multiplier: 1/3).isActive = true

        lbTextTime.textAlignment = .left
        lbTextTime.textColor = UIColor.black
        lbTextTime.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextTime.text = "Thời gian:"
        
        lbTime.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTime)
        lbTime.leftAnchor.constraint(equalTo: lbTextTime.rightAnchor,constant: Common.Size(s: 5)).isActive = true
        lbTime.topAnchor.constraint(equalTo: lbTextTime.topAnchor).isActive = true
        lbTime.rightAnchor.constraint(equalTo: lbNo.rightAnchor).isActive = true
        lbTime.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        lbTime.textAlignment = .right
        lbTime.textColor = UIColor.black
        lbTime.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTime.text = convertDate(dateString: item.creationTime)
        
    }
    func convertDate(dateString: String) -> String {
        let dateFormatterGetWithMs = DateFormatter()
        let dateFormatterGetNoMs = DateFormatter()
        dateFormatterGetWithMs.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatterGetNoMs.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        dateFormatterGetWithMs.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatterGetNoMs.timeZone = TimeZone(abbreviation: "UTC")
        
        dateFormatterPrint.timeZone = .current

        var date: Date? = dateFormatterGetWithMs.date(from: dateString)
        if (date == nil){
            date = dateFormatterGetNoMs.date(from: dateString)
        }
        if(date != nil){
            return  dateFormatterPrint.string(from: date!)
        }
        return ""
    }
}
