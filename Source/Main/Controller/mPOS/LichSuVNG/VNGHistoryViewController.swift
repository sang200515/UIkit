//
//  VNGHistoryViewController.swift
//  fptshop
//
//  Created by Apple on 9/26/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Presentr

class VNGHistoryViewController: UIViewController {
    
    var tfFromDate:UITextField!
    var tfToDate:UITextField!
    static var valueToDate:String = ""
    static var valueFromDate:String = ""
    var chooseTfDate = ""
    var btnLoadHistory: UIButton!
    var tableView: UITableView!
    var listVNGHistory: [ReportInstallVNG] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var filterVNG = [ReportInstallVNG]()
    
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
        filterVNG = listVNGHistory.filter({( item : ReportInstallVNG) -> Bool in
            return "\(item.IMEI)".contains(searchText)
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
        
        self.title = "Lịch sử cài đặt VNG"
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
        btnLoadHistory.addTarget(self, action: #selector(loadHistoryVNG), for: .touchUpInside)
        self.view.addSubview(btnLoadHistory)
        
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: btnLoadHistory.frame.origin.y + btnLoadHistory.frame.height + Common.Size(s: 15), width: self.view.frame.width, height: self.view.frame.height - (btnLoadHistory.frame.origin.y + btnLoadHistory.frame.height + Common.Size(s: 15))))
        tableView.register(VNGHistoryCell.self, forCellReuseIdentifier: "vngHistoryCell")
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
    
    @objc func loadHistoryVNG() {
        
        guard let fromDate = tfFromDate.text, !fromDate.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn thời gian từ!")
            return
        }
        
        guard let toDate = tfToDate.text, !toDate.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn thời gian đến!")
            return
        }
        
        self.listVNGHistory.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.mpos_FRT_Report_InstallApp(imei: "", fromDate: fromDate, toDate: toDate, handler: { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs.count > 0 {
                            for item in rs {
                                self.listVNGHistory.append(item)
                            }
                            self.setUpTableView()
                        } else {
                            self.showAlert(title: "Thông báo", message: "Không có danh sách cài đặt VNG!")
                        }
                    } else {
                        self.showAlert(title: "Thông báo", message: "\(err)")
                    }
                }
            })
        }
    }

}

class VNGHistoryCell: UITableViewCell {
    
    func setUpView(item: ReportInstallVNG) {
        self.subviews.forEach({$0.removeFromSuperview()})
        let lbImei = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: (self.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbImei.textColor = UIColor(red: 49/255, green: 148/255, blue: 51/255, alpha: 1)
        lbImei.text = item.IMEI
        lbImei.font = UIFont.boldSystemFont(ofSize: 15)
        self.addSubview(lbImei)
        
        let lbRegisterStatus = UILabel(frame: CGRect(x: lbImei.frame.origin.x + lbImei.frame.width, y: lbImei.frame.origin.y, width: lbImei.frame.width, height: Common.Size(s: 20)))
        lbRegisterStatus.textColor = UIColor.blue
        lbRegisterStatus.text = item.RegisStatus
        lbRegisterStatus.font = UIFont.italicSystemFont(ofSize: 14)
        lbRegisterStatus.textAlignment = .right
        self.addSubview(lbRegisterStatus)
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbImei.frame.origin.y + lbImei.frame.height, width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 1)))
        line.backgroundColor = UIColor.lightGray
        self.addSubview(line)
        
        let lbHeDieuHanh = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.height + Common.Size(s: 10), width: (self.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbHeDieuHanh.textColor = UIColor.lightGray
        lbHeDieuHanh.text = "Hệ điều hành: "
        lbHeDieuHanh.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbHeDieuHanh)
        
        let lbHeDieuHanhText = UILabel(frame: CGRect(x: lbHeDieuHanh.frame.origin.x + lbHeDieuHanh.frame.width, y: lbHeDieuHanh.frame.origin.y, width: lbHeDieuHanh.frame.width, height: Common.Size(s: 20)))
        lbHeDieuHanhText.textColor = UIColor.lightGray
        lbHeDieuHanhText.text = "\(item.OS) "
        lbHeDieuHanhText.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbHeDieuHanhText)
        
        let lbZalo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbHeDieuHanhText.frame.origin.y + lbHeDieuHanhText.frame.height, width: lbHeDieuHanhText.frame.width, height: Common.Size(s: 20)))
        lbZalo.textColor = UIColor.lightGray
        lbZalo.text = "Zalo: "
        lbZalo.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbZalo)
        
        let lbZaloStatus = UILabel(frame: CGRect(x: lbZalo.frame.origin.x + lbZalo.frame.width, y: lbZalo.frame.origin.y, width: lbZalo.frame.width, height: Common.Size(s: 20)))
        lbZaloStatus.textColor = UIColor.lightGray
        lbZaloStatus.text = "\(item.ZaloStatus) "
        lbZaloStatus.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbZaloStatus)
        
        let lbZing = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbZaloStatus.frame.origin.y + lbZaloStatus.frame.height, width: lbHeDieuHanhText.frame.width, height: Common.Size(s: 20)))
        lbZing.textColor = UIColor.lightGray
        lbZing.text = "Zing: "
        lbZing.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbZing)
        
        let lbZingStatus = UILabel(frame: CGRect(x: lbZing.frame.origin.x + lbZing.frame.width, y: lbZing.frame.origin.y, width: lbZing.frame.width, height: Common.Size(s: 20)))
        lbZingStatus.textColor = UIColor.lightGray
        lbZingStatus.text = "\(item.ZingStatus) "
        lbZingStatus.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbZingStatus)
        
        let lbNews = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbZingStatus.frame.origin.y + lbZingStatus.frame.height, width: lbHeDieuHanhText.frame.width, height: Common.Size(s: 20)))
        lbNews.textColor = UIColor.lightGray
        lbNews.text = "Báo Mới: "
        lbNews.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbNews)
        
        let lbNewsStatus = UILabel(frame: CGRect(x: lbNews.frame.origin.x + lbNews.frame.width, y: lbNews.frame.origin.y, width: lbNews.frame.width, height: Common.Size(s: 20)))
        lbNewsStatus.textColor = UIColor.lightGray
        lbNewsStatus.text = "\(item.NewsStatus) "
        lbNewsStatus.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbNewsStatus)
        
        let lbDateUpdate = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNewsStatus.frame.origin.y + lbNewsStatus.frame.height, width: lbHeDieuHanhText.frame.width, height: Common.Size(s: 20)))
        lbDateUpdate.textColor = UIColor.lightGray
        lbDateUpdate.text = "Ngày cập nhật: "
        lbDateUpdate.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbDateUpdate)
        
        let lbDateUpdateText = UILabel(frame: CGRect(x: lbDateUpdate.frame.origin.x + lbDateUpdate.frame.width, y: lbDateUpdate.frame.origin.y, width: lbDateUpdate.frame.width, height: Common.Size(s: 20)))
        lbDateUpdateText.textColor = UIColor.lightGray
        lbDateUpdateText.text = "\(item.LastUpdate) "
        lbDateUpdateText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbDateUpdateText)
        
        let lbPrice = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbDateUpdateText.frame.origin.y + lbDateUpdateText.frame.height, width: lbHeDieuHanhText.frame.width, height: Common.Size(s: 20)))
        lbPrice.textColor = UIColor.lightGray
        lbPrice.text = "Tổng tiền: "
        lbPrice.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbPrice)
        
        let lbPriceValue = UILabel(frame: CGRect(x: lbPrice.frame.origin.x + lbPrice.frame.width, y: lbPrice.frame.origin.y, width: lbPrice.frame.width, height: Common.Size(s: 20)))
        lbPriceValue.textColor = UIColor.red
        lbPriceValue.text = "\(Common.convertCurrency(value: item.Price)) "
        lbPriceValue.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbPriceValue)
        
    }
}

extension VNGHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filterVNG.count
        }
        return listVNGHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:VNGHistoryCell = tableView.dequeueReusableCell(withIdentifier: "vngHistoryCell", for: indexPath) as! VNGHistoryCell
        
        let item:ReportInstallVNG
        if isFiltering() {
            item = filterVNG[indexPath.row]
        } else {
            item = listVNGHistory[indexPath.row]
        }
        
        cell.setUpView(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


extension VNGHistoryViewController:CalendarViewControllerDelegate {
    func getDate(dateString: String) {
        if self.chooseTfDate == "FromDate" {
            self.tfFromDate.text = "\(dateString)"
            VNGHistoryViewController.valueFromDate = "\(dateString)"
        }
        
        if self.chooseTfDate == "ToDate" {
            self.tfToDate.text = "\(dateString)"
            VNGHistoryViewController.valueToDate = "\(dateString)"
        }
    }
}

extension VNGHistoryViewController: UISearchResultsUpdating, UISearchBarDelegate {
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


