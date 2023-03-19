//
//  HistoryViettelVASViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 3/18/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryViettelVASViewController: UIViewController {
    
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    lazy var searchBar:UISearchBar = UISearchBar()
    var list = [ViettelVASHistory]()
    var filterList = [ViettelVASHistory]()
    private let calendar: AVCalendarViewController = AVCalendarViewController.calendar
    private var selectedDate: AVDate?
    var lbFromDateText: UILabel!
    var lbToDateText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Tìm theo số phiếu/số điện thoại"
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.font = UIFont.systemFont(ofSize: 13)
            let placeholderLabel = searchBar.searchTextField.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.font = UIFont.italicSystemFont(ofSize: 13.0)
        } else {
            // Fallback on earlier versions
            let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideUISearchBar?.font = UIFont.systemFont(ofSize: 13)
            let placeholderLabel = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.font = UIFont.italicSystemFont(ofSize: 13.0)
        }
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        self.navigationItem.titleView = searchBar
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        
        self.searchBar.addDoneButtonOnKeyboard()
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
//        view.addGestureRecognizer(tap)

        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:30))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:30), height: Common.Size(s:40))
        viewLeftNav.addSubview(btBackIcon)
        
        let lbFromDate = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: (self.view.frame.width - Common.Size(s: 30))/2 - Common.Size(s: 5), height: Common.Size(s: 20)))
        lbFromDate.text = "Từ ngày:"
        lbFromDate.font = UIFont.boldSystemFont(ofSize: 13)
        self.view.addSubview(lbFromDate)
        
        lbFromDateText = UILabel(frame: CGRect(x: lbFromDate.frame.origin.x, y: lbFromDate.frame.origin.y + lbFromDate.frame.height, width: lbFromDate.frame.width, height: Common.Size(s: 25)))
        lbFromDateText.text = ""
        lbFromDateText.font = UIFont.systemFont(ofSize: 13)
        lbFromDateText.layer.cornerRadius = 5
        lbFromDateText.layer.borderWidth = 0.5
        lbFromDateText.layer.borderColor = UIColor.lightGray.cgColor
        lbFromDateText.tag = 1
        self.view.addSubview(lbFromDateText)
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(handleCalendar(sender:)))
        lbFromDateText.isUserInteractionEnabled = true
        lbFromDateText.addGestureRecognizer(tapFromDate)
        
        let lbToDate = UILabel(frame: CGRect(x: lbFromDate.frame.origin.x + lbFromDate.frame.width + Common.Size(s: 10), y: Common.Size(s: 10), width: lbFromDate.frame.width, height: Common.Size(s: 20)))
        lbToDate.text = "Đến ngày:"
        lbToDate.font = UIFont.boldSystemFont(ofSize: 13)
        self.view.addSubview(lbToDate)
        
        lbToDateText = UILabel(frame: CGRect(x: lbToDate.frame.origin.x, y: lbToDate.frame.origin.y + lbToDate.frame.height, width: lbToDate.frame.width, height: Common.Size(s: 25)))
        lbToDateText.text = ""
        lbToDateText.font = UIFont.systemFont(ofSize: 13)
        lbToDateText.layer.cornerRadius = 5
        lbToDateText.layer.borderWidth = 0.5
        lbToDateText.layer.borderColor = UIColor.lightGray.cgColor
        lbToDateText.tag = 2
        self.view.addSubview(lbToDateText)
        
        let tapToDate = UITapGestureRecognizer(target: self, action: #selector(handleCalendar(sender:)))
        lbToDateText.isUserInteractionEnabled = true
        lbToDateText.addGestureRecognizer(tapToDate)
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height

        tableView = UITableView(frame: CGRect(x: 0, y: lbToDateText.frame.origin.y + lbToDateText.frame.height + Common.Size(s: 15), width: self.view.frame.width, height: tableViewHeight - lbToDateText.frame.origin.y - lbToDateText.frame.height - Common.Size(s: 20)))
        self.view.addSubview(tableView)
        tableView.isUserInteractionEnabled = true
        
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "VASViettelHistoryCell", bundle: nil), forCellReuseIdentifier: "VASViettelHistoryCell")
        tableView.tableFooterView = UIView()
        
        ////set calenda
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        let startOfMonth = calendar.date(from: components)
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let strFrom = dateFormatter.string(from: startOfMonth ?? Date())
        lbFromDateText.text = " \(strFrom)"
        
        let strTo = dateFormatter.string(from: Date())
        self.lbToDateText.text = " \(strTo)"
        
        if self.tableView != nil {
            self.loadDataHistory()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(didCloseAVCalendar), name: NSNotification.Name.init("didCloseAVCalendar"), object: nil)
    }
    
    @objc func didCloseAVCalendar() {
        self.loadDataHistory()
    }
    
    @objc func handleCalendar(sender: UIGestureRecognizer) {
        calendar.dateStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x594166),
                                                              textColor: .white,
                                                              highlightColor: UIColor(netHex: 0x7ec0c4).withAlphaComponent(0.5))
        calendar.yearStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x594166),
                                                              textColor: .black, highlightColor: .white)
        calendar.monthStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x2f3c5f),
                                                               textColor: .black,
                                                               highlightColor: UIColor.white)
        calendar.subscriber = { [weak self] (date) in guard let checkedSelf = self else { return }
            if date != nil {
                checkedSelf.selectedDate = date
                let selectedDate = Date(timeIntervalSince1970: TimeInterval(date?.doubleVal ?? 0))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let str = dateFormatter.string(from: selectedDate)
                
                let view = sender.view ?? UIView()
                if view.tag == 1 {
                    self?.lbFromDateText.text = " \(str)"
                } else {
                    self?.lbToDateText.text = " \(str)"
                }
            }
        }
        calendar.preSelectedDate = selectedDate
        self.present(calendar, animated: false, completion: nil)
    }

    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func hideKeyBoard() {
        self.searchBar.resignFirstResponder()
    }
    
    func loadDataHistory() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.ViettelVAS_GetHistory(fromDate: "\((self.lbFromDateText.text ?? "").trim())", toDate: "\((self.lbToDateText.text ?? "").trim())", parentCategoryIds: "9de91c80-4b2a-43da-bf33-cf054ef36a2d") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.list = rs
                        self.filterList = rs
                        if(self.list.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có lịch sử.\n:/", viewController: self.tableView)
                        } else {
                            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                        }
                        self.tableView.reloadData()
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

extension HistoryViettelVASViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VASViettelHistoryCell", for: indexPath) as! VASViettelHistoryCell
        var item: ViettelVASHistory
        let key = searchBar.text ?? ""
        if key.count > 0 {
            item = filterList[indexPath.row]
        } else {
            item = list[indexPath.row]
        }
        cell.bindCell(item: item)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.resignFirstResponder()
        var item: ViettelVASHistory
        let key = searchBar.text ?? ""
        if key.count > 0 {
            item = filterList[indexPath.row]
        } else {
            item = list[indexPath.row]
        }
        let vc = HistoryViettelPackageDetail()
        vc.isBacktoPre = true
        vc.idTransaction = item.orderId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HistoryViettelVASViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func search(key:String){
        if key.count > 0 {
            filterList = list.filter({($0.customerPhoneNumber.localizedCaseInsensitiveContains(key)) || ($0.billNo.localizedCaseInsensitiveContains(key))})
        } else {
            filterList = list
        }
        tableView.reloadData()
    }
}

class ViettelVASHistoryCell: UITableViewCell {
    var estimateCellHeight:CGFloat = 0
    
    func setupCell(item: ViettelVASHistory){
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .white
        
        let viewContent = UIView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: self.contentView.frame.width - Common.Size(s: 10), height: self.frame.height))
        viewContent.backgroundColor = UIColor(netHex: 0xF8F4F5)
        viewContent.layer.cornerRadius = 5
        self.addSubview(viewContent)
        
        
        let lbMposNum = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 5), width: (viewContent.frame.width - Common.Size(s: 20))/2, height: Common.Size(s: 20)))
        lbMposNum.text = "MPOS: \(item.billNo)"
        lbMposNum.font = UIFont.boldSystemFont(ofSize: 15)
        lbMposNum.textColor = UIColor(netHex: 0x109e59)
        viewContent.addSubview(lbMposNum)

        let lbCreateDate = UILabel(frame: CGRect(x: lbMposNum.frame.origin.x + lbMposNum.frame.width, y: Common.Size(s: 5), width: lbMposNum.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.font = UIFont.systemFont(ofSize: 13)
        lbCreateDate.textAlignment = .right
        lbCreateDate.text = "\(Common.convertDateISO8601(dateString: item.creationTime))"
        viewContent.addSubview(lbCreateDate)
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 10), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 3), width: viewContent.frame.width - Common.Size(s: 20), height: Common.Size(s: 1)))
        line.backgroundColor = .lightGray
        viewContent.addSubview(line)
        
        let lbNVDauNoi = UILabel(frame: CGRect(x: Common.Size(s: 10), y: line.frame.origin.y + line.frame.height + Common.Size(s: 5), width: (line.frame.width)/3 + Common.Size(s: 15), height: Common.Size(s: 20)))
        lbNVDauNoi.text = "NV giao dịch:"
        lbNVDauNoi.font = UIFont.systemFont(ofSize: 14)
        lbNVDauNoi.textColor = .lightGray
        viewContent.addSubview(lbNVDauNoi)
        
        let lbNVDauNoiText = UILabel(frame: CGRect(x: lbNVDauNoi.frame.origin.x + lbNVDauNoi.frame.width, y: lbNVDauNoi.frame.origin.y, width: (line.frame.width * 2/3) - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbNVDauNoiText.text = "\(item.employeeName)"
        lbNVDauNoiText.font = UIFont.systemFont(ofSize: 14)
        lbNVDauNoiText.textAlignment = .right
        viewContent.addSubview(lbNVDauNoiText)
        
        let lbNVDauNoiTextHeight:CGFloat = lbNVDauNoiText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVDauNoiText.optimalHeight + Common.Size(s: 5))
        lbNVDauNoiText.numberOfLines = 0
        lbNVDauNoiText.frame = CGRect(x: lbNVDauNoiText.frame.origin.x, y: lbNVDauNoiText.frame.origin.y, width: lbNVDauNoiText.frame.width, height: lbNVDauNoiTextHeight)
        
        let lbSdtKH = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbNVDauNoiText.frame.origin.y + lbNVDauNoiTextHeight, width: lbNVDauNoi.frame.width, height: Common.Size(s: 20)))
        lbSdtKH.text = "Sđt khách hàng:"
        lbSdtKH.font = UIFont.systemFont(ofSize: 14)
        lbSdtKH.textColor = .lightGray
        viewContent.addSubview(lbSdtKH)
        
        let lbSdtKHText = UILabel(frame: CGRect(x: lbSdtKH.frame.origin.x + lbSdtKH.frame.width, y: lbSdtKH.frame.origin.y, width: lbNVDauNoiText.frame.width, height: Common.Size(s: 20)))
        lbSdtKHText.text = "\(item.customerPhoneNumber)"
        lbSdtKHText.font = UIFont.systemFont(ofSize: 14)
        lbSdtKHText.textAlignment = .right
        lbSdtKHText.textColor = UIColor(netHex:0x00955E)
        viewContent.addSubview(lbSdtKHText)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbSdtKHText.frame.origin.y + lbSdtKHText.frame.height, width: lbNVDauNoi.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        lbTrangThai.textColor = .lightGray
        viewContent.addSubview(lbTrangThai)
        
        let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width, y: lbTrangThai.frame.origin.y, width: lbNVDauNoiText.frame.width, height: Common.Size(s: 20)))
        if let statusCode = CreateOrderResultViettelPay_SOM(rawValue: item.orderStatus) {
            lbTrangThaiText.text = statusCode.message
        } else {
            lbTrangThaiText.text = "\(item.orderStatus)"
        }
        
        lbTrangThaiText.font = UIFont.systemFont(ofSize: 14)
        lbTrangThaiText.textAlignment = .right
        lbTrangThaiText.textColor = UIColor(netHex:0x00955E)
        viewContent.addSubview(lbTrangThaiText)
        
        let lbTrangThaiTextHeight:CGFloat = lbTrangThaiText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTrangThaiText.optimalHeight + Common.Size(s: 5))
        lbTrangThaiText.numberOfLines = 0
        lbTrangThaiText.frame = CGRect(x: lbTrangThaiText.frame.origin.x, y: lbTrangThaiText.frame.origin.y, width: lbTrangThaiText.frame.width, height: lbTrangThaiTextHeight)
        
        let lbGoiCuoc = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height, width: lbNVDauNoi.frame.width + Common.Size(s: 30), height: Common.Size(s: 20)))
        lbGoiCuoc.text = "Gói cước:"
        lbGoiCuoc.font = UIFont.systemFont(ofSize: 14)
        lbGoiCuoc.textColor = .lightGray
        viewContent.addSubview(lbGoiCuoc)
        
        let lbGoiCuocText = UILabel(frame: CGRect(x: lbGoiCuoc.frame.origin.x + lbGoiCuoc.frame.width, y: lbGoiCuoc.frame.origin.y, width: lbNVDauNoiText.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbGoiCuocText.font = UIFont.systemFont(ofSize: 14)
        lbGoiCuocText.textAlignment = .right
        lbGoiCuocText.text = "\(item.productName)"
        viewContent.addSubview(lbGoiCuocText)
        
        let lbGoiCuocTextHeight:CGFloat = lbGoiCuocText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbGoiCuocText.optimalHeight + Common.Size(s: 5))
        lbGoiCuocText.numberOfLines = 0
        lbGoiCuocText.frame = CGRect(x: lbGoiCuocText.frame.origin.x, y: lbGoiCuocText.frame.origin.y, width: lbGoiCuocText.frame.width, height: lbGoiCuocTextHeight)
        
        let lbTongTien = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbGoiCuocText.frame.origin.y + lbGoiCuocText.frame.height, width: lbNVDauNoi.frame.width, height: Common.Size(s: 20)))
        lbTongTien.text = "Tổng tiền:"
        lbTongTien.font = UIFont.systemFont(ofSize: 14)
        lbTongTien.textColor = .lightGray
        viewContent.addSubview(lbTongTien)
        
        let lbTongTienText = UILabel(frame: CGRect(x: lbTongTien.frame.origin.x + lbTongTien.frame.width, y: lbTongTien.frame.origin.y, width: lbNVDauNoiText.frame.width, height: Common.Size(s: 20)))
        lbTongTienText.text = "\(Common.convertCurrencyDoubleV2(value: item.totalAmountIncludingFee))VNĐ"
        lbTongTienText.font = UIFont.systemFont(ofSize: 14)
        lbTongTienText.textAlignment = .right
        lbTongTienText.textColor = .red
        viewContent.addSubview(lbTongTienText)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y , width: viewContent.frame.width, height: lbTongTienText.frame.origin.y + lbTongTienText.frame.height)
        
        estimateCellHeight = viewContent.frame.origin.y + viewContent.frame.height + Common.Size(s: 5)
    }
}
