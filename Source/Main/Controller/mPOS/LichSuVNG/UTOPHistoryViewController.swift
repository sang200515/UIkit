//
//  UTOPHistoryViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 12/3/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Presentr

class UTOPHistoryViewController: UIViewController {
    
    var tfFromDate:UITextField!
    var tfToDate:UITextField!
    static var valueToDate:String = ""
    static var valueFromDate:String = ""
    var chooseTfDate = ""
    var btnLoadHistory: UIButton!
    var tableView: UITableView!
    var listUTOPHistory: [InstallApp_Utop] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var filterUtop = [InstallApp_Utop]()
    
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
        //        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String, scrop: String = "All") {
        filterUtop = listUTOPHistory.filter({( item : InstallApp_Utop) -> Bool in
            return ("\(item.PhoneNum)".contains(searchText)) || ("\(item.OS)".lowercased().contains(searchText))
        })
        if(tableView != nil){
           tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Lịch sử cài đặt UTOP"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Nhập mã lỗi..."
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .red
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                textfield.textColor = UIColor(netHex:0x00579c)
                textfield.tintColor = UIColor(netHex:0x00579c)
                if let backgroundview = textfield.subviews.first {
                    // Background color
                    backgroundview.backgroundColor = UIColor.white
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 5;
                    backgroundview.clipsToBounds = true;
                }
                if let navigationbar = self.navigationController?.navigationBar {
                    navigationbar.barTintColor = UIColor(patternImage: Common.imageLayerForGradientBackground(searchBar: (self.searchController.searchBar)))
                }
            }
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        

        let lbTextFromDate = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: (UIScreen.main.bounds.size.width - Common.Size(s: 45))/2, height: Common.Size(s: 15)))
        lbTextFromDate.textAlignment = .left
        lbTextFromDate.textColor = UIColor.black
        lbTextFromDate.font = UIFont.systemFont(ofSize:13)
        lbTextFromDate.text = "Thời gian từ (*)"
        self.view.addSubview(lbTextFromDate)
        
        tfFromDate = UITextField(frame: CGRect(x: lbTextFromDate.frame.origin.x, y: lbTextFromDate.frame.origin.y + lbTextFromDate.frame.size.height + Common.Size(s: 5), width: lbTextFromDate.frame.size.width, height: Common.Size(s: 35)))
        tfFromDate.placeholder = "Chọn ngày"
        tfFromDate.font = UIFont.systemFont(ofSize: 13)
        tfFromDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfFromDate.autocorrectionType = UITextAutocorrectionType.no
        tfFromDate.keyboardType = UIKeyboardType.default
        tfFromDate.returnKeyType = UIReturnKeyType.done
        tfFromDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfFromDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfFromDate.isUserInteractionEnabled = false
        
        let fromdate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let fromDateStr = dateFormatter.string(from: fromdate)
        tfFromDate.text = fromDateStr
        self.view.addSubview(tfFromDate)
        
        let viewFromDate: UIView = UIView(frame: tfFromDate.frame)
        self.view.addSubview(viewFromDate)
        
        let viewFromDateImage: UIImageView = UIImageView(frame: CGRect(x: viewFromDate.frame.size.width - viewFromDate.frame.size.height, y: viewFromDate.frame.size.height/4, width: viewFromDate.frame.size.height, height: viewFromDate.frame.size.height/2))
        viewFromDateImage.image = UIImage(named:"Calender2")
        viewFromDateImage.contentMode = .scaleAspectFit
        viewFromDate.addSubview(viewFromDateImage)
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFromDate(_:)))
        viewFromDate.addGestureRecognizer(tapFromDate)
        
        let lbTextToDate = UILabel(frame: CGRect(x: lbTextFromDate.frame.size.width + lbTextFromDate.frame.origin.x + Common.Size(s: 15), y: lbTextFromDate.frame.origin.y, width: lbTextFromDate.frame.size.width, height: Common.Size(s: 15)))
        lbTextToDate.textAlignment = .left
        lbTextToDate.textColor = UIColor.black
        lbTextToDate.font = UIFont.systemFont(ofSize: 13)
        lbTextToDate.text = "Thời gian đến (*)"
        self.view.addSubview(lbTextToDate)
        
        tfToDate = UITextField(frame: CGRect(x: lbTextToDate.frame.origin.x, y: lbTextToDate.frame.origin.y + lbTextToDate.frame.size.height + Common.Size(s: 5), width: lbTextToDate.frame.size.width, height: Common.Size(s: 35)))
        tfToDate.placeholder = "Chọn ngày"
        tfToDate.font = UIFont.systemFont(ofSize: 13)
        tfToDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfToDate.autocorrectionType = UITextAutocorrectionType.no
        tfToDate.keyboardType = UIKeyboardType.default
        tfToDate.returnKeyType = UIReturnKeyType.done
        tfToDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfToDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfToDate.isUserInteractionEnabled = false
        
        let todate = Date()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let toDateStr = dateFormatter.string(from: todate)
        tfToDate.text = toDateStr
        self.view.addSubview(tfToDate)
        
        let viewToDate: UIView = UIView(frame: tfToDate.frame)
        self.view.addSubview(viewToDate)
        
        let viewToDateImage: UIImageView = UIImageView(frame: CGRect(x: viewFromDate.frame.size.width - viewFromDate.frame.size.height, y: viewFromDate.frame.size.height/4, width: viewFromDate.frame.size.height, height: viewFromDate.frame.size.height/2))
        viewToDateImage.image = UIImage(named:"Calender2")
        viewToDateImage.contentMode = .scaleAspectFit
        viewToDate.addSubview(viewToDateImage)
        
        let tapToDate = UITapGestureRecognizer(target: self, action: #selector(self.handleTapToDate(_:)))
        viewToDate.addGestureRecognizer(tapToDate)
        
        btnLoadHistory = UIButton(frame: CGRect(x: Common.Size(s: 15), y: tfToDate.frame.origin.y + tfToDate.frame.height + Common.Size(s: 15), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnLoadHistory.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnLoadHistory.layer.cornerRadius = 5
        btnLoadHistory.setTitle("LOAD LỊCH SỬ", for: .normal)
        btnLoadHistory.addTarget(self, action: #selector(loadHistoryUTOP), for: .touchUpInside)
        self.view.addSubview(btnLoadHistory)
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: btnLoadHistory.frame.origin.y + btnLoadHistory.frame.height + Common.Size(s: 15), width: self.view.frame.width, height: self.view.frame.height - (btnLoadHistory.frame.origin.y + btnLoadHistory.frame.height + Common.Size(s: 15))))
        tableView.register(UTOPHistoryCell.self, forCellReuseIdentifier: "utopHistoryCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTapToDate(_ sender: UITapGestureRecognizer? = nil) {
        
        self.chooseTfDate = "ToDate"
        let calendarVC = CalendarViewController()
        self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
        calendarVC.delegate = self
    }
    
    @objc func handleTapFromDate(_ sender: UITapGestureRecognizer? = nil) {
        
        self.chooseTfDate = "FromDate"
        let calendarVC = CalendarViewController()
        self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
        calendarVC.delegate = self
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func loadHistoryUTOP() {
        guard let fromDate = tfFromDate.text, !fromDate.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn thời gian từ!")
            return
        }
        
        guard let toDate = tfToDate.text, !toDate.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn thời gian đến!")
            return
        }
        
        self.listUTOPHistory.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Report_InstallApp_Utop(fromDate: fromDate, toDate: toDate) { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs.count > 0 {
                            for item in rs {
                                self.listUTOPHistory.append(item)
                            }
                            self.setUpTableView()
                        } else {
                            self.showAlert(title: "Thông báo", message: "Không có danh sách cài đặt UTOP!")
                        }
                    } else {
                        self.showAlert(title: "Thông báo", message: "\(err)")
                    }
                }
            }
        }
    }
    
}

class UTOPHistoryCell: UITableViewCell {
    //he dieu hah, sdt,ngay cap nhat, tong tien
    
    func setUpView(item: InstallApp_Utop) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: (self.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbTrangThai.textColor = UIColor.darkGray
        lbTrangThai.text = "Trạng thái: "
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbTrangThai)
        
        let lbStatus = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width, y: lbTrangThai.frame.origin.y, width: lbTrangThai.frame.width, height: Common.Size(s: 20)))
        lbStatus.text = "\(item.StatusApp)"
        lbStatus.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbStatus)
        
        if item.StatusApp == "Mở app thành công!" {
            lbStatus.textColor = UIColor(red: 49/255, green: 148/255, blue: 51/255, alpha: 1)
        } else {
            lbStatus.textColor = UIColor(red: 255/255, green: 168/255, blue: 1/255, alpha: 1)
        }
        
        let lbHeDieuHanh = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbStatus.frame.origin.y + lbStatus.frame.height, width: (self.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbHeDieuHanh.textColor = UIColor.darkGray
        lbHeDieuHanh.text = "Hệ điều hành: "
        lbHeDieuHanh.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbHeDieuHanh)
        
        let lbHeDieuHanhText = UILabel(frame: CGRect(x: lbHeDieuHanh.frame.origin.x + lbHeDieuHanh.frame.width, y: lbHeDieuHanh.frame.origin.y, width: lbHeDieuHanh.frame.width, height: Common.Size(s: 20)))
        lbHeDieuHanhText.textColor = UIColor.darkGray
        lbHeDieuHanhText.text = "\(item.OS) "
        lbHeDieuHanhText.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbHeDieuHanhText)
        
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbHeDieuHanhText.frame.origin.y + lbHeDieuHanhText.frame.height, width: lbHeDieuHanhText.frame.width, height: Common.Size(s: 20)))
        lbSdt.textColor = UIColor.darkGray
        lbSdt.text = "Số điện thoại: "
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSdt)
        
        let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.origin.x + lbSdt.frame.width, y: lbSdt.frame.origin.y, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbSdtText.textColor = UIColor.darkGray
        lbSdtText.text = "\(item.PhoneNum) "
        lbSdtText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSdtText)
        
        let lbUpdateDate = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbHeDieuHanhText.frame.width, height: Common.Size(s: 20)))
        lbUpdateDate.textColor = UIColor.darkGray
        lbUpdateDate.text = "Ngày cập nhật: "
        lbUpdateDate.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbUpdateDate)
        
        let lbUpdateDateText = UILabel(frame: CGRect(x: lbUpdateDate.frame.origin.x + lbUpdateDate.frame.width, y: lbUpdateDate.frame.origin.y, width: lbSdtText.frame.width, height: Common.Size(s: 20)))
        lbUpdateDateText.textColor = UIColor.darkGray
        lbUpdateDateText.text = "\(item.LastUpdate) "
        lbUpdateDateText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbUpdateDateText)
        
        let lbPrice = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbUpdateDateText.frame.origin.y + lbUpdateDateText.frame.height, width: lbHeDieuHanhText.frame.width, height: Common.Size(s: 20)))
        lbPrice.textColor = UIColor.darkGray
        lbPrice.text = "Tổng tiền: "
        lbPrice.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbPrice)
        
        let lbPriceValue = UILabel(frame: CGRect(x: lbPrice.frame.origin.x + lbPrice.frame.width, y: lbPrice.frame.origin.y, width: lbPrice.frame.width, height: Common.Size(s: 20)))
        lbPriceValue.textColor = UIColor(red: 194/255, green: 54/255, blue: 22/255, alpha: 1)
        lbPriceValue.text = "\(Common.convertCurrency(value: item.Payment)) "
        lbPriceValue.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbPriceValue)
    }
}

extension UTOPHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filterUtop.count
        }
        return listUTOPHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UTOPHistoryCell = tableView.dequeueReusableCell(withIdentifier: "utopHistoryCell", for: indexPath) as! UTOPHistoryCell
        
        let item:InstallApp_Utop
        if isFiltering() {
            item = filterUtop[indexPath.row]
        } else {
            item = listUTOPHistory[indexPath.row]
        }
        
        cell.setUpView(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


extension UTOPHistoryViewController:CalendarViewControllerDelegate {
    func getDate(dateString: String) {
        if self.chooseTfDate == "FromDate" {
            self.tfFromDate.text = "\(dateString)"
            UTOPHistoryViewController.valueFromDate = "\(dateString)"
        }
        
        if self.chooseTfDate == "ToDate" {
            self.tfToDate.text = "\(dateString)"
            UTOPHistoryViewController.valueToDate = "\(dateString)"
        }
    }
}

extension UTOPHistoryViewController: UISearchResultsUpdating, UISearchBarDelegate {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text ?? "", scrop: "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.navigationController?.navigationBar.isTranslucent = true
        return true
    }
}

