//
//  HistoryCheckInViewController.swift
//  fptshop
//
//  Created by Apple on 1/24/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//
//  HistoryViewController.swift
//  fptshop
//
//  Created by Apple on 1/22/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Presentr

class HistoryCheckInViewController: UIViewController {
    
    var tableView: UITableView!
    var listHistory = [PGCheckIn]()
    var lblFromDate: UILabel!
    var imgCalendarFrom: UIImageView!
    var imgCalendarTo: UIImageView!
    var imgNext: UIImageView!
    var lblToDate: UILabel!
    var btnListHistory: UIButton!
    var cellHeight:CGFloat = 0
    var typeDate = 0
    var isPGDetail = false
    var filterList = [PGCheckIn]()
    var pgInfo: PGInfo?
    
    var btnBack: UIBarButtonItem!
    var btnSearch: UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s:35), height: Common.Size(s:45))
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btnBack = UIBarButtonItem(customView: btBackIcon)
        self.navigationItem.leftBarButtonItems = [btnBack]
        
        if self.isPGDetail {
            self.title = "Nhân viên \(self.pgInfo?.fullName ?? "")"
        } else {
            self.title = "Shop \(Cache.user?.ShopCode ?? "")"
            
            
            let btSearchIcon = UIButton.init(type: .custom)
            btSearchIcon.setImage(#imageLiteral(resourceName: "Search"), for: UIControl.State.normal)
            btSearchIcon.imageView?.contentMode = .scaleAspectFit
            btSearchIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s: 35), height: Common.Size(s: 50)/2)
            btSearchIcon.addTarget(self, action: #selector(actionSearchAssets), for: UIControl.Event.touchUpInside)
            btnSearch = UIBarButtonItem(customView: btSearchIcon)
            self.navigationItem.rightBarButtonItems = [btnSearch]
            
            //search bar custom
            let searchBar = UISearchBar()
            searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
            searchBarContainer.searchBar.showsCancelButton = true
            searchBarContainer.searchBar.addDoneButtonOnKeyboard()
            searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: Common.Size(s: 44))
            if #available(iOS 13.0, *) {
                searchBarContainer.searchBar.searchTextField.backgroundColor = .white
            } else {
                // Fallback on earlier versions
            }
            searchBarContainer.searchBar.delegate = self
            
            if #available(iOS 11.0, *) {
                searchBarContainer.searchBar.placeholder = "Tìm theo CMND"
            }else{
                searchBarContainer.searchBar.searchBarStyle = .minimal
                let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
                textFieldInsideSearchBar?.textColor = .white
                
                let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
                glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                glassIconView?.tintColor = .white
                textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Tìm theo CMND",
                                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
                clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
                clearButton?.tintColor = .white
            }
        }
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        setUpView()
        showListHistory()

    }
    
    func getDateString() -> String{
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    
    func setUpView() {
        
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s: 40)))
        topView.backgroundColor = UIColor.white
        self.view.addSubview(topView)
        //date
        lblFromDate = UILabel(frame: CGRect(x: 0, y: 0, width: topView.frame.width/2 - Common.Size(s: 35), height: topView.frame.height))
        lblFromDate.textAlignment = .center
        lblFromDate.font = UIFont.systemFont(ofSize: 13)
        lblFromDate.text = getDateString()
        lblFromDate.tag = 1
        topView.addSubview(lblFromDate)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        let startOfMonth = calendar.date(from: components)
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let strFrom = dateFormatter.string(from: startOfMonth ?? Date())
        lblFromDate.text = strFrom
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(showCalendar1))
        lblFromDate.isUserInteractionEnabled = true
        tapFromDate.numberOfTapsRequired = 1
        tapFromDate.delegate = self as? UIGestureRecognizerDelegate
        lblFromDate.addGestureRecognizer(tapFromDate)
        
        //img
        imgCalendarFrom = UIImageView(frame: CGRect(x: lblFromDate.frame.origin.x + lblFromDate.frame.width, y: (lblFromDate.frame.height/2) - Common.Size(s: 5), width: Common.Size(s: 10), height: Common.Size(s: 10)))
        imgCalendarFrom.image = #imageLiteral(resourceName: "sort-down")
        topView.addSubview(imgCalendarFrom)
        
        imgNext = UIImageView(frame: CGRect(x: imgCalendarFrom.frame.origin.x + imgCalendarFrom.frame.width + Common.Size(s: 10), y: imgCalendarFrom.frame.origin.y, width: Common.Size(s: 20), height: Common.Size(s: 10)))
        imgNext.image = #imageLiteral(resourceName: "right-arrow")
        topView.addSubview(imgNext)
        
        
        lblToDate = UILabel(frame: CGRect(x: imgNext.frame.origin.x + imgNext.frame.width + Common.Size(s: 10) , y: lblFromDate.frame.origin.y, width: lblFromDate.frame.width, height: lblFromDate.frame.height))
        lblToDate.textAlignment = .center
        lblToDate.font = UIFont.systemFont(ofSize: 13)
        lblToDate.text = getDateString()
        lblToDate.tag = 2
        topView.addSubview(lblToDate)
        
        let tapToDate = UITapGestureRecognizer(target: self, action: #selector(showCalendar1))
        lblToDate.isUserInteractionEnabled = true
        tapToDate.numberOfTapsRequired = 1
        tapToDate.delegate = self as? UIGestureRecognizerDelegate
        lblToDate.addGestureRecognizer(tapToDate)
        
        imgCalendarTo = UIImageView(frame: CGRect(x: lblToDate.frame.origin.x + lblToDate.frame.width, y: imgCalendarFrom.frame.origin.y, width: Common.Size(s: 10), height: Common.Size(s: 10)))
        imgCalendarTo.image = #imageLiteral(resourceName: "sort-down")
        topView.addSubview(imgCalendarTo)
        
        tableView = UITableView(frame: CGRect(x: 0, y: topView.frame.height + Common.Size(s: 15), width: self.view.frame.width, height: self.view.frame.height - (self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height - topView.frame.height - Common.Size(s: 5)))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(PGCell.self, forCellReuseIdentifier: "pgCell")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showListHistory() {
        guard let str_FromDate = lblFromDate.text, !str_FromDate.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập ngày check in!")
            return
        }

        guard let str_ToDate = lblToDate.text, !str_ToDate.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập ngày check out!")
            return
        }
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/yyyy"
        let d1 = dateformatter.date(from: str_FromDate)
        let d2 = dateformatter.date(from: str_ToDate)
        
        let newFormat = DateFormatter()
        newFormat.dateFormat = "yyyy-MM-dd"
        let strFrom = newFormat.string(from: d1 ?? Date())
        let strTo = newFormat.string(from: d2 ?? Date())
        
        self.listHistory.removeAll()
        self.filterList.removeAll()
        if self.isPGDetail {
            self.getHistoryByPG(fromDate: "\(strFrom)", toDate: "\(strTo)", personalID: "\(self.pgInfo?.personalID ?? "")")
        } else {
            self.getHistoryByWareHouse(fromDate: "\(strFrom)", toDate: "\(strTo)")
        }
    }
    
    func getHistoryByWareHouse(fromDate: String, toDate: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Lấy danh sách lịch sử PG trong shop...") {
            CRMAPIManager.PG_loadcheckinbywarehouse(fromdate: "\(fromDate)", todate: "\(toDate)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.listHistory = rs
                        self.filterList = rs
                        if(rs.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có danh sách lịch sử \nPG trong shop \(Cache.user?.ShopCode ?? "")\n:/", viewController: self.tableView)
                        }else{
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
    
    func getHistoryByPG(fromDate: String, toDate: String, personalID: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Lấy danh sách lịch sử chấm công của PG...") {
            CRMAPIManager.PG_loadcheckinbypersonalid(fromdate: "\(fromDate)", todate: "\(toDate)", personalid: "\(personalID)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.listHistory = rs
                        self.filterList = rs
                        if(rs.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có danh sách lịch sử chấm công \nPG \(self.pgInfo?.fullName ?? personalID)\n:/", viewController: self.tableView)
                        }else{
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
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func showCalendar1(_ sender: UIGestureRecognizer) {
        let view = sender.view ?? UIView()
        self.typeDate = view.tag
        let calendarVC = CalendarViewController()
        self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
        calendarVC.delegate = self
    }
    
    @objc func actionSearchAssets() {
        self.searchBarContainer.searchBar.text = ""
        navigationItem.titleView = searchBarContainer
        self.searchBarContainer.searchBar.alpha = 0
        navigationItem.setRightBarButtonItems(nil, animated: true)
        navigationItem.setLeftBarButtonItems(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBarContainer.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBarContainer.searchBar.becomeFirstResponder()
        })
    }
    
    @objc func hideKeyBoard() {
        if self.searchBarContainer != nil {
            self.searchBarContainer.searchBar.resignFirstResponder()
        }
    }
}

extension HistoryCheckInViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in

        })
        self.navigationItem.setLeftBarButton(btnBack, animated: true)
        self.navigationItem.setRightBarButton(btnSearch, animated: true)
        search(key: "")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(key: "\(searchBar.text ?? "")")
        self.navigationItem.setLeftBarButton(btnBack, animated: true)
        self.navigationItem.setRightBarButton(btnSearch, animated: true)

        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in

        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }

    func search(key:String){
        if key.isEmpty {
            filterList = self.listHistory
        } else {
            filterList = self.listHistory.filter({
                ("\("\($0.personalID)")".localizedCaseInsensitiveContains(key))
                
            })
        }
        tableView.reloadData()
    }
}


extension HistoryCheckInViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PGCell = tableView.dequeueReusableCell(withIdentifier: "pgCell", for: indexPath) as! PGCell
        cell.subviews.forEach({$0.removeFromSuperview()})
        let pgCheckIn = filterList[indexPath.row]
        cell.setUpCell(pgCheckIn: pgCheckIn)
        cellHeight = cell.estimateCellHeight
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}


class PGCell: UITableViewCell {
    
    var lblFullName: UILabel!
    var lblVendor: UILabel!
    var lblCheckInDate: UILabel!
    var lblCheckOutDate: UILabel!
    var lblShopName: UILabel!
    var lblIdCard: UILabel!
    
    var estimateCellHeight: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    func setUpCell(pgCheckIn: PGCheckIn) {
        
        let lblName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 8), width: (self.contentView.frame.width - Common.Size(s: 15))/3, height: Common.Size(s: 15)))
        lblName.text = "Họ tên:"
        lblName.font = UIFont.systemFont(ofSize: 13)
        lblName.textColor = UIColor.lightGray
        self.addSubview(lblName)
        
        lblFullName = UILabel(frame: CGRect(x: lblName.frame.width, y: lblName.frame.origin.y, width: self.contentView.frame.width - lblName.frame.width - Common.Size(s: 15), height: Common.Size(s: 15)))
        lblFullName.font = UIFont.boldSystemFont(ofSize: 13)
        lblFullName.text = "\(pgCheckIn.fullName)"
        self.addSubview(lblFullName)
        
        //
        let lblDoiTac = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblFullName.frame.origin.y + lblFullName.frame.height + Common.Size(s: 5), width: lblName.frame.width, height: Common.Size(s: 15)))
        lblDoiTac.text = "Đối tác:"
        lblDoiTac.font = UIFont.systemFont(ofSize: 13)
        lblDoiTac.textColor = UIColor.lightGray
        self.addSubview(lblDoiTac)
        
        lblVendor = UILabel(frame: CGRect(x: lblFullName.frame.origin.x, y: lblDoiTac.frame.origin.y, width: lblFullName.frame.width, height: Common.Size(s: 15)))
        lblVendor.text = "\(pgCheckIn.doiTac)"
        lblVendor.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblVendor)
        
        let lblVendorHeight:CGFloat = lblVendor.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lblVendor.optimalHeight
        lblVendor.numberOfLines = 0
        lblVendor.frame = CGRect(x: lblVendor.frame.origin.x, y: lblVendor.frame.origin.y, width: lblVendor.frame.width, height: lblVendorHeight)
        
        let lblCmnd = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblVendor.frame.origin.y + lblVendorHeight + Common.Size(s: 5), width: lblName.frame.width, height: Common.Size(s: 15)))
        lblCmnd.text = "CMND:"
        lblCmnd.font = UIFont.systemFont(ofSize: 13)
        lblCmnd.textColor = UIColor.lightGray
        self.addSubview(lblCmnd)
        
        lblIdCard = UILabel(frame: CGRect(x: lblFullName.frame.origin.x, y: lblCmnd.frame.origin.y, width: lblFullName.frame.width, height: Common.Size(s: 15)))
        lblIdCard.text = "\(pgCheckIn.personalID)"
        lblIdCard.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblIdCard)
        //
        let lblCheckIn = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblIdCard.frame.origin.y + lblIdCard.frame.height + Common.Size(s: 5), width: lblName.frame.width, height: Common.Size(s: 15)))
        lblCheckIn.text = "Check in:"
        lblCheckIn.textColor = UIColor.lightGray
        lblCheckIn.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblCheckIn)
        
        lblCheckInDate = UILabel(frame: CGRect(x: lblFullName.frame.origin.x, y: lblCheckIn.frame.origin.y, width: lblFullName.frame.width, height: Common.Size(s: 15)))
        lblCheckInDate.text = "\(pgCheckIn.checkIN)"
        lblCheckInDate.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblCheckInDate)
        //
        let lblCheckOut = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblCheckInDate.frame.origin.y + lblCheckInDate.frame.height + Common.Size(s: 5), width: lblName.frame.width, height: Common.Size(s: 15)))
        lblCheckOut.text = "Check-out:"
        lblCheckOut.textColor = UIColor.lightGray
        lblCheckOut.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblCheckOut)
        
        lblCheckOutDate = UILabel(frame: CGRect(x: lblFullName.frame.origin.x, y: lblCheckOut.frame.origin.y, width: lblFullName.frame.width, height: Common.Size(s: 15)))
        lblCheckOutDate.text = "\(pgCheckIn.checkOut)"
        lblCheckOutDate.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblCheckOutDate)
        
        //
        let lblShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblCheckOutDate.frame.origin.y + lblCheckOutDate.frame.height + Common.Size(s: 5), width: lblName.frame.width, height: Common.Size(s: 15)))
        lblShop.text = "Shop:"
        lblShop.textColor = UIColor.lightGray
        lblShop.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblShop)
        
        lblShopName = UILabel(frame: CGRect(x: lblFullName.frame.origin.x, y: lblShop.frame.origin.y, width: lblFullName.frame.width, height: Common.Size(s: 15)))
        lblShopName.font = UIFont.systemFont(ofSize: 13)
        lblShopName.text = "\(pgCheckIn.wareHouseName)"
        lblShopName.frame = CGRect(x: lblShopName.frame.origin.x, y: lblShopName.frame.origin.y, width: lblShopName.frame.width, height: 15)
        lblShopName.numberOfLines = 0
        self.addSubview(lblShopName)
        
        let lblShopNameHeight:CGFloat = lblShopName.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : (lblShopName.optimalHeight + Common.Size(s: 5))
        lblShopName.numberOfLines = 0
        lblShopName.frame = CGRect(x: lblShopName.frame.origin.x, y: lblShopName.frame.origin.y, width: lblShopName.frame.width, height: lblShopNameHeight)
        
        estimateCellHeight = lblShopName.frame.origin.y + lblShopNameHeight + Common.Size(s: 8)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
    }
}

extension HistoryCheckInViewController: CalendarViewControllerDelegate {
    func getDate(dateString: String) {
        let str = dateString.replace("-", withString: "/")
        if self.typeDate == 1 {
            self.lblFromDate.text = str
        } else {
            self.lblToDate.text = str
        }
        self.showListHistory()
    }
}

