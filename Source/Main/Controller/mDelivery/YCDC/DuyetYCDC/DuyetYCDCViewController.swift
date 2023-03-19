//
//  DuyetYCDCViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 21/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ActionSheetPicker_3_0
class DuyetYCDCViewController: UIViewController {
    
    var tableView: UITableView!
    var list: [BodyYCDC] = []
    var filteredYCDC: [BodyYCDC] = []
    var parentNavigationController: UINavigationController?
    var keySearch:String = ""
    var safeArea: UILayoutGuide!
    var fromDateView: CustomViewDate!
    var toDateView: CustomViewDate!
    var valueToDate: String = ""
    var valueFromDate: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.title = "Duyệt YCĐC"
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
        
        
        let searchField = UITextField()
        searchField.placeholder = "Bạn cần tìm?"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5
        searchField.layer.borderWidth = 0.5
        searchField.layer.borderColor = UIColor.lightGray.cgColor

        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper
        searchField.addTarget(self, action: #selector(search(textField:)), for: .editingChanged)
//        self.navigationItem.titleView = searchField
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.clipsToBounds = true
        self.view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        headerView.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        
        fromDateView = CustomViewDate()
        fromDateView.date.text = "22/01/2021"
        headerView.addSubview(fromDateView)
        fromDateView.translatesAutoresizingMaskIntoConstraints = false
        fromDateView.leftAnchor.constraint(equalTo: headerView.leftAnchor,constant: Common.Size(s: 10)).isActive = true
        fromDateView.topAnchor.constraint(equalTo: headerView.topAnchor,constant: Common.Size(s: 10)).isActive = true
        fromDateView.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        fromDateView.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1/3.5).isActive = true
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(self.tapFromDate))
        fromDateView.addGestureRecognizer(tapFromDate)
        fromDateView.isUserInteractionEnabled = true
        
        let icTo = UIImageView()
        icTo.image = #imageLiteral(resourceName: "ic-right")
        icTo.contentMode = .scaleAspectFit
        headerView.addSubview(icTo)
        icTo.translatesAutoresizingMaskIntoConstraints = false
        icTo.leftAnchor.constraint(equalTo: fromDateView.rightAnchor,constant: Common.Size(s: 10)).isActive = true
        icTo.topAnchor.constraint(equalTo: fromDateView.topAnchor).isActive = true
        icTo.heightAnchor.constraint(equalTo: fromDateView.heightAnchor).isActive = true
        icTo.widthAnchor.constraint(equalTo: fromDateView.heightAnchor,multiplier: 2/3).isActive = true
        
        
        toDateView = CustomViewDate()
     
        headerView.addSubview(toDateView)
        toDateView.translatesAutoresizingMaskIntoConstraints = false
        toDateView.leftAnchor.constraint(equalTo: icTo.rightAnchor,constant: Common.Size(s: 10)).isActive = true
        toDateView.topAnchor.constraint(equalTo: fromDateView.topAnchor).isActive = true
        toDateView.heightAnchor.constraint(equalTo: fromDateView.heightAnchor).isActive = true
        toDateView.widthAnchor.constraint(equalTo: fromDateView.widthAnchor).isActive = true
        
        let tapToDate = UITapGestureRecognizer(target: self, action: #selector(self.tapToDate))
        toDateView.addGestureRecognizer(tapToDate)
        toDateView.isUserInteractionEnabled = true
        
        headerView.addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
        searchField.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        searchField.topAnchor.constraint(equalTo: fromDateView.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        searchField.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        
        searchField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Common.Size(s: -10)).isActive = true

        
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.register(DuyetYCDCCell.self, forCellReuseIdentifier: "DuyetYCDCCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = UIColor(netHex: 0xEEEEEE)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.tableFooterView = UIView()
        
        var dayComponent    = DateComponents()
        dayComponent.day    = -7
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
        valueToDate = formatDate2(date: Date())
        toDateView.date.text = formatDate3(date: Date())
        valueFromDate = formatDate2(date: nextDate!)
        fromDateView.date.text = formatDate3(date: nextDate!)
        APIManager.searchYCDC(fromDate: valueFromDate, toDate: valueToDate) { (results) in
            self.list = results.filter {
                $0.shpRec == "\(Cache.user!.ShopCode)"
            }
            self.tableView.reloadData()
        }
        
    }
    @objc func tapFromDate(){
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            
            self.fromDateView.date.text = "\(strDate)"
            self.valueFromDate = self.formatDate2(date: value as! Date)
            APIManager.searchYCDC(fromDate: self.valueFromDate, toDate: self.valueToDate) { (results) in
                self.list = results.filter {
                    $0.shpRec == "\(Cache.user!.ShopCode)"
                }
                self.tableView.reloadData()
            }
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
            self.valueToDate = self.formatDate2(date: value as! Date)
            APIManager.searchYCDC(fromDate: self.valueFromDate, toDate: self.valueToDate) { (results) in
                self.list = results.filter {
                    $0.shpRec == "\(Cache.user!.ShopCode)"
                }
                self.tableView.reloadData()
            }
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.maximumDate = Date()
        datePicker?.show()
    }
    
    
    @objc private func search(textField: UITextField) {
        if let key = textField.text {
            self.keySearch = key
            filteredYCDC = list.filter { (ycdc: BodyYCDC) -> Bool in
                return ycdc.docEntry.lowercased().contains(self.keySearch.lowercased()) || ycdc.u_ShpRec.lowercased().contains(self.keySearch.lowercased()) || ycdc.u_ShpCod.lowercased().contains(self.keySearch.lowercased())
            }
            tableView.reloadData()
        }
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
//    override func viewWillAppear(_ animated: Bool) {
//        if(tableView != nil){
//
//            var dayComponent    = DateComponents()
//            dayComponent.day    = -7
//            let theCalendar     = Calendar.current
//            let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
//
//        }
//    }
}
class CustomViewDate : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        build()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        build()
    }
    
    var date: UILabel = UILabel()
    func build() {
        print("AAAA")
//        let view = UIView()
        self.backgroundColor = .white
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        let ic = UIImageView()
        ic.contentMode = .scaleAspectFit
        ic.image = #imageLiteral(resourceName: "ic-down")
        self.addSubview(ic)
        ic.translatesAutoresizingMaskIntoConstraints = false
        ic.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        ic.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ic.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        ic.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2/3).isActive = true

//        let text = UILabel()
//        text.text = date
        date.textAlignment = .center
        date.font = .systemFont(ofSize: 16)
        self.addSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false
        date.rightAnchor.constraint(equalTo: ic.leftAnchor).isActive = true
        date.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        date.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        date.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
//        self.addSubview(view)
    }
}
extension DuyetYCDCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.keySearch != "" {
            return filteredYCDC.count
        }
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DuyetYCDCCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "DuyetYCDCCell")
        let ycdc: BodyYCDC
        if self.keySearch != "" {
            ycdc = filteredYCDC[indexPath.row]
        } else {
            ycdc = list[indexPath.row]
        }
        cell.setUpCell(item: ycdc)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 215)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item: BodyYCDC
        if self.keySearch != "" {
            item = filteredYCDC[indexPath.row]
        } else {
            item = list[indexPath.row]
        }
        let newViewController = ChiTietDuyetYCDCViewController()
        newViewController.headerItem = item
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    func formatDate2(date:Date) -> String{
        let deFormatter = DateFormatter()
        deFormatter.dateFormat = "yyyy-MM-dd"
        return deFormatter.string(from: date)
    }
    func formatDate3(date:Date) -> String{
        let deFormatter = DateFormatter()
        deFormatter.dateFormat = "dd/MM/yyyy"
        return deFormatter.string(from: date)
    }

}

class DuyetYCDCCell: UITableViewCell {
    
    var lblSOYCDC = UILabel()
    var lblDate = UILabel()
    var viewCell = UIView()
    var line = UIView()
    var lbTextShop = UILabel()
    var lbShop = UILabel()
    var lbTextShopIn = UILabel()
    var lbShopIn = UILabel()
    var lbTextSender = UILabel()
    var lbSender = UILabel()
    var lbTextApprovedBy = UILabel()
    var lbApprovedBy = UILabel()
    var lbTextStatus = UILabel()
    var lbStatus = UILabel()
    var lbTextWhEx = UILabel()
    var lbWhEx = UILabel()
    
    var lbTextWhRe = UILabel()
    var lbWhRe = UILabel()
    var lbTextNote = UILabel()
    var lbNote = UILabel()
    
    func setUpCell(item: BodyYCDC){
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .clear
        viewCell.frame =  CGRect(x: Common.Size(s: 5), y: Common.Size(s: 2.5), width: UIScreen.main.bounds.width - Common.Size(s: 10), height: Common.Size(s: 210))
        viewCell.backgroundColor = .white
        viewCell.layer.cornerRadius = 5
        self.addSubview(viewCell)
    
        lblSOYCDC.frame =  CGRect(x: Common.Size(s: 10), y: Common.Size(s: 5), width: viewCell.frame.size.width/2 - Common.Size(s: 10), height: Common.Size(s: 20))
        lblSOYCDC.text = "Số YCDC: \(item.docEntry)"
        lblSOYCDC.textColor = UIColor(netHex:0x00955E)
        lblSOYCDC.font = UIFont.boldSystemFont(ofSize: 15)
        lblSOYCDC.numberOfLines = 1
        viewCell.addSubview(lblSOYCDC)

        lblDate.frame =  CGRect(x: lblSOYCDC.frame.origin.x + lblSOYCDC.frame.size.width, y: lblSOYCDC.frame.origin.y , width: lblSOYCDC.frame.size.width, height: lblSOYCDC.frame.size.height)
        lblDate.text = "\(item.createDate)"
        lblDate.textColor = UIColor.black
        lblDate.textAlignment = .right
        lblDate.font = UIFont.systemFont(ofSize: 13)
        viewCell.addSubview(lblDate)
        
        line.frame = CGRect(x: 0, y: lblSOYCDC.frame.origin.y + lblSOYCDC.frame.size.height +  Common.Size(s: 5) , width: viewCell.frame.size.width, height: 0.5)
        line.backgroundColor = UIColor(netHex: 0xEEEEEE)
        viewCell.addSubview(line)
        
        lbTextShop.frame = CGRect(x: Common.Size(s:10), y: line.frame.origin.y + line.frame.size.height + Common.Size(s:5), width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextShop.textAlignment = .left
        lbTextShop.textColor = UIColor.black
        lbTextShop.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextShop.text = "Shop xuất:"
        lbTextShop.sizeToFit()
        viewCell.addSubview(lbTextShop)
        lbTextShop.frame.origin.y = line.frame.origin.y + line.frame.size.height + Common.Size(s:5) + Common.Size(s:20)/2 - lbTextShop.frame.height/2
        
        lbShop.frame = CGRect(x: lbTextShop.frame.origin.x + lbTextShop.frame.size.width + Common.Size(s:5), y: line.frame.origin.y + line.frame.size.height + Common.Size(s:5), width: viewCell.frame.size.width - (lbTextShop.frame.origin.x + lbTextShop.frame.size.width + Common.Size(s:15)), height: Common.Size(s:20))
        lbShop.textAlignment = .right
        lbShop.textColor = UIColor.black
        lbShop.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbShop.text = "\(item.u_ShpRec)"
        viewCell.addSubview(lbShop)
        
        lbTextWhEx.frame = CGRect(x: Common.Size(s:10), y: lbShop.frame.origin.y + lbShop.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextWhEx.textAlignment = .left
        lbTextWhEx.textColor = UIColor.black
        lbTextWhEx.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextWhEx.text = "Kho xuất:"
        lbTextWhEx.sizeToFit()
        viewCell.addSubview(lbTextWhEx)
        lbTextWhEx.frame.origin.y = lbShop.frame.origin.y + lbShop.frame.size.height + Common.Size(s:20)/2 - lbTextWhEx.frame.height/2
        
        lbWhEx.frame = CGRect(x: lbShop.frame.origin.x, y: lbShop.frame.origin.y + lbShop.frame.size.height, width:lbShop.frame.size.width, height: Common.Size(s:20))
        lbWhEx.textAlignment = .right
        lbWhEx.textColor = UIColor.black
        lbWhEx.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbWhEx.text = "\(item.u_WhsEx)"
        viewCell.addSubview(lbWhEx)
        
        lbTextShopIn.frame = CGRect(x: Common.Size(s:10), y: lbWhEx.frame.origin.y + lbWhEx.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextShopIn.textAlignment = .left
        lbTextShopIn.textColor = UIColor.black
        lbTextShopIn.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextShopIn.text = "Shop nhận:"
        lbTextShopIn.sizeToFit()
        viewCell.addSubview(lbTextShopIn)
        lbTextShopIn.frame.origin.y = lbWhEx.frame.origin.y + lbWhEx.frame.size.height + Common.Size(s:20)/2 - lbTextShopIn.frame.height/2
        
        
        lbShopIn.frame = CGRect(x: lbShop.frame.origin.x, y: lbWhEx.frame.origin.y + lbWhEx.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:20))
        lbShopIn.textAlignment = .right
        lbShopIn.textColor = UIColor.black
        lbShopIn.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbShopIn.text = "\(item.u_ShpCod)"
        viewCell.addSubview(lbShopIn)
        
        lbTextWhRe.frame = CGRect(x: Common.Size(s:10), y: lbShopIn.frame.origin.y + lbShopIn.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextWhRe.textAlignment = .left
        lbTextWhRe.textColor = UIColor.black
        lbTextWhRe.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextWhRe.text = "Kho nhận:"
        lbTextWhRe.sizeToFit()
        viewCell.addSubview(lbTextWhRe)
        lbTextWhRe.frame.origin.y = lbShopIn.frame.origin.y + lbShopIn.frame.size.height + Common.Size(s:20)/2 - lbTextWhRe.frame.height/2
        
        
        lbWhRe.frame = CGRect(x: lbShop.frame.origin.x, y: lbShopIn.frame.origin.y + lbShopIn.frame.size.height, width:lbShop.frame.size.width, height: Common.Size(s:20))
        lbWhRe.textAlignment = .right
        lbWhRe.textColor = UIColor.black
        lbWhRe.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbWhRe.text = "\(item.u_WhsRec)"
        viewCell.addSubview(lbWhRe)
        
        
        lbTextSender.frame = CGRect(x: Common.Size(s:10), y: lbWhRe.frame.origin.y + lbWhRe.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextSender.textAlignment = .left
        lbTextSender.textColor = UIColor.black
        lbTextSender.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextSender.text = "Người gửi:"
        lbTextSender.sizeToFit()
        viewCell.addSubview(lbTextSender)
        lbTextSender.frame.origin.y = lbWhRe.frame.origin.y + lbWhRe.frame.size.height + Common.Size(s:20)/2 - lbTextSender.frame.height/2
        
        lbSender.frame = CGRect(x: lbShop.frame.origin.x, y: lbWhRe.frame.origin.y + lbWhRe.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:20))
        lbSender.textAlignment = .right
        lbSender.textColor = UIColor.black
        lbSender.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbSender.text = "\(item.createBy)"
        viewCell.addSubview(lbSender)
        
        lbTextApprovedBy.frame = CGRect(x: Common.Size(s:10), y: lbSender.frame.origin.y + lbSender.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextApprovedBy.textAlignment = .left
        lbTextApprovedBy.textColor = UIColor.black
        lbTextApprovedBy.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextApprovedBy.text = "Người duyệt:"
        lbTextApprovedBy.sizeToFit()
        viewCell.addSubview(lbTextApprovedBy)
        lbTextApprovedBy.frame.origin.y = lbSender.frame.origin.y + lbSender.frame.size.height + Common.Size(s:20)/2 - lbTextApprovedBy.frame.height/2
        
        lbApprovedBy.frame = CGRect(x: lbShop.frame.origin.x, y: lbSender.frame.origin.y + lbSender.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:20))
        lbApprovedBy.textAlignment = .right
        lbApprovedBy.textColor = UIColor.black
        lbApprovedBy.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbApprovedBy.text = "\(item.updateBy)"
        viewCell.addSubview(lbApprovedBy)
        
        lbTextStatus.frame = CGRect(x: Common.Size(s:10), y: lbApprovedBy.frame.origin.y + lbApprovedBy.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextStatus.textAlignment = .left
        lbTextStatus.textColor = UIColor.black
        lbTextStatus.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextStatus.text = "Trạng thái:"
        lbTextStatus.sizeToFit()
        viewCell.addSubview(lbTextStatus)
        lbTextStatus.frame.origin.y = lbApprovedBy.frame.origin.y + lbApprovedBy.frame.size.height + Common.Size(s:20)/2 - lbTextStatus.frame.height/2
        
        lbStatus.frame = CGRect(x: lbShop.frame.origin.x, y: lbApprovedBy.frame.origin.y + lbApprovedBy.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:20))
        lbStatus.textAlignment = .right
        lbStatus.textColor = UIColor.black
        lbStatus.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbStatus.text = "\(item.statusName)"
        viewCell.addSubview(lbStatus)
        if(item.statusCode == "O"){
            lbStatus.textColor = UIColor.blue
        }else  if(item.statusCode == "D"){
            lbStatus.textColor = UIColor.green
        }else  if(item.statusCode == "H"){
            lbStatus.textColor = UIColor.red
        }
        
        lbTextNote.frame = CGRect(x: Common.Size(s:10), y: lbStatus.frame.origin.y + lbStatus.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:27))
        lbTextNote.textAlignment = .left
        lbTextNote.textColor = UIColor.black
        lbTextNote.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextNote.text = "Ghi chú:"
        lbTextNote.sizeToFit()
        viewCell.addSubview(lbTextNote)
        lbTextNote.frame.origin.y = lbStatus.frame.origin.y + lbStatus.frame.size.height + Common.Size(s:27)/2 - lbTextNote.frame.height/2
        
        lbNote.frame = CGRect(x: lbShop.frame.origin.x, y: lbStatus.frame.origin.y + lbStatus.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:27))
        lbNote.textAlignment = .right
        lbNote.textColor = UIColor.black
        lbNote.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbNote.text = "\(item.remarks)"
        lbNote.numberOfLines = 2
        viewCell.addSubview(lbNote)
    }
}
