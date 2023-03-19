//
//  InstallmentOnlineVC.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 30/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown


class InstallmentOnlineVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var handingLineView: UIView!
    @IBOutlet weak var handedLineView: UIView!
    @IBOutlet weak var waitingLineView: UIView!
    @IBOutlet weak var handedLabel: UILabel!
    @IBOutlet weak var handingLabel: UILabel!
    @IBOutlet weak var waitingdLabel: UILabel!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var dropdownLabel: UILabel!
    @IBOutlet weak var searchTxt: UITextField!
    
    var listWaiting: [DataOrder] = []
    var filteredWating: [DataOrder] = []
    var listWaitingNew: [OrderNewItem] = []
    var filteredWatingNew: [OrderNewItem] = []
    var listOrderHanding: [HistoryIsdetailData] = []
    var filteredHanding: [HistoryIsdetailData] = []
    
    var listHanded: [HistoryIsdetailData] = []
    var filteredListHanded: [HistoryIsdetailData] = []
    let dropDownMenu = DropDown()
    var choosingOption = 0
    var currentTab = 0
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InstallmentHistoryCell", bundle: nil), forCellReuseIdentifier: "InstallmentHistoryCell")
        self.title = "Mirae online"
        onchangeColor(tab: 0)
        
        getOrderWaiting()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(setupDrop))
        self.dropDownView.addGestureRecognizer(gesture)
        
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Xong", style: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        searchTxt.inputAccessoryView = toolbar
        searchTxt.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Tải lại dữ liệu")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAll), name: NSNotification.Name("ReloadListInstallMent"), object: nil)
    }
    
    private func setupNav() {
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(backAction(_:)), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        if currentTab == 0 {
            getOrderWaiting()
        } else if currentTab == 1 {
            getOrderHanding()
        } else {
            getOrderHistory()
        }
        refreshControl.endRefreshing()
    }
    
    
    func clearAll() {
        listWaiting.removeAll()
        filteredWating.removeAll()
        listWaitingNew.removeAll()
        filteredWatingNew.removeAll()
        listOrderHanding.removeAll()
        filteredHanding.removeAll()
        
        listHanded.removeAll()
        filteredListHanded.removeAll()
        tableView.reloadData()
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if currentTab == 0 {
            switch choosingOption {
            case 0:
                if textField.text?.trim() != "" {
                    filteredWatingNew = listWaitingNew.filter({$0.PosSoNum.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredWatingNew = listWaitingNew
                }
            case 1:
                if textField.text?.trim() != "" {
                    filteredWatingNew = listWaitingNew.filter({$0.NationalIdNum.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredWatingNew = listWaitingNew
                }
            case 2:
                if textField.text?.trim() != "" {
                    filteredWatingNew = listWaitingNew.filter({$0.PhoneNumber.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredWatingNew = listWaitingNew
                }
            case 3:
                if textField.text?.trim() != "" {
                    filteredWatingNew = listWaitingNew.filter({$0.ContractNumber.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredWatingNew = listWaitingNew
                }
            default:
                print("")
            }
        } else if currentTab == 1 {
            switch choosingOption {
            case 0:
                if textField.text?.trim() != "" {
                    filteredHanding = listOrderHanding.filter({$0.soNumber.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredHanding = listOrderHanding
                }
            case 1:
                if textField.text?.trim() != "" {
                    filteredHanding = listOrderHanding.filter({$0.nationalIdNum.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredHanding = listOrderHanding
                }
            case 2:
                if textField.text?.trim() != "" {
                    filteredHanding = listOrderHanding.filter({$0.phoneNumber.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredHanding = listOrderHanding
                }
            case 3:
                if textField.text?.trim() != "" {
                    filteredHanding = listOrderHanding.filter({$0.contractNumber.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredHanding = listOrderHanding
                }
            default:
                print("")
            }
        } else {
            // handed
            switch choosingOption {
            case 4:
                if textField.text?.trim() != "" {
                    filteredListHanded = listHanded.filter({$0.soNumber.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredListHanded = listHanded
                }
            case 1:
                if textField.text?.trim() != "" {
                    filteredListHanded = listHanded.filter({$0.nationalIdNum.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredListHanded = listHanded
                }
            case 2:
                if textField.text?.trim() != "" {
                    filteredListHanded = listHanded.filter({$0.phoneNumber.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredListHanded = listHanded
                }
            case 3:
                if textField.text?.trim() != "" {
                    filteredListHanded = listHanded.filter({$0.contractNumber.lowercased().contains(find: textField.text?.lowercased() ?? "")})
                } else {
                    filteredListHanded = listHanded
                }
            default:
                print("")
            }
        }
        
        self.tableView.reloadData()
    }
    
    @objc func reloadAll() {
        if currentTab == 0 {
            getOrderWaiting()
        } else if currentTab == 1 {
            getOrderHanding()
        } else {
            // handed
            getOrderHistory()
        }
    }
    @objc func doneButtonAction() {
        print("searched")
        self.view.endEditing(true)
    }
    
    func getOrderHanding() {
        var params: [String: Any] = [:]
        params["employeeCode"] = Cache.user?.UserName ?? ""
        params["shopCode"] = Cache.user?.ShopCode ?? ""
        params["isDetail"] = false
        params["isFinalized"] = false
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "") {
            InstallmentApiManager.shared.getInstallmentHistory(params: params) {[weak self] (response, _, error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if error != "" {
                        self?.showPopup(with: error, completion: nil)
                    } else {
                        guard let res = response else {return}
                        if res.isSuccess {
                            self?.listOrderHanding = res.data
                            self?.filteredHanding = res.data
                        } else {
                            self?.showPopup(with: res.message, completion: nil)
                        }
                    }
                    self?.refreshControl.endRefreshing()
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func getOrderWaiting() {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "") {
            InstallmentApiManager().getCustomerOrderHanding { [weak self] (orderdata, error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if error != "" {
                        self?.showPopup(with: error, completion:  nil)
                        self?.listWaiting = []
                    } else {
                        guard let detail = orderdata else {
                            print("detail nil")
                            return
                        }
                        if detail.IsSuccess {
                            self?.listWaitingNew = detail.Data
                            self?.filteredWatingNew = detail.Data
                        } else {
                            self?.showPopup(with: detail.Message, completion: nil)
                        }
                    }
                    self?.refreshControl.endRefreshing()
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func getOrderHistory() {
        var params: [String: Any] = [:]
        params["employeeCode"] = Cache.user?.UserName ?? ""
        params["shopCode"] = Cache.user?.ShopCode ?? ""
        params["isDetail"] = false
        params["isFinalized"] = true
        
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "") {
            InstallmentApiManager.shared.getInstallmentHistory(params: params) {[weak self] (history, _, error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if error != "" {
                        self?.showPopup(with: error, completion: nil)
                    } else {
                        if !(history?.isSuccess ?? false) {
                            self?.showPopup(with: history?.message ?? "", completion: nil)
                            self?.listHanded.removeAll()
                            self?.tableView.reloadData()
                        } else {
                            self?.listHanded.removeAll()
                            self?.listHanded = history?.data ?? []
                            self?.filteredListHanded = history?.data ?? []
                            self?.tableView.reloadData()
                        }
                        self?.refreshControl.endRefreshing()
                    }
                }
            }
        }
    }
    
    func showPopup(with error: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: "Thông Báo", message: error, preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let back = completion {
                back()
            }
        }
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func setupDrop() {
        dropDownMenu.anchorView = dropDownView
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.dataSource = ["Số đơn hàng", "Số CMND", "Số ĐT", "Số HĐ"]
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            self?.choosingOption = index
            self?.dropdownLabel.text = item
        }
        dropDownMenu.show()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onlickHanding() {
        clearAll()
        currentTab = 1
        onchangeColor(tab: 1)
        getOrderHanding()
    }
    
    @IBAction func onlickWaiting() {
        clearAll()
        currentTab = 0
        onchangeColor(tab: 0)
        getOrderWaiting()
    }
    
    @IBAction func onlickhanded() {
        clearAll()
        currentTab = 2
        onchangeColor(tab: 2)
        getOrderHistory()
    }
    
    func onchangeColor(tab: Int) {
        switch tab {
        case 0:
            self.waitingLineView.backgroundColor = Constants.COLORS.bold_green
            self.waitingdLabel.textColor = Constants.COLORS.bold_green
            
            self.handingLineView.backgroundColor = UIColor.white
            self.handingLabel.textColor = Constants.COLORS.text_gray
            self.handedLineView.backgroundColor = UIColor.white
            self.handedLabel.textColor = Constants.COLORS.text_gray
        case 1:
            self.waitingLineView.backgroundColor = UIColor.white
            self.waitingdLabel.textColor = Constants.COLORS.text_gray
            
            self.handingLineView.backgroundColor = Constants.COLORS.bold_green
            self.handingLabel.textColor = Constants.COLORS.bold_green
            
            self.handedLineView.backgroundColor = UIColor.white
            self.handedLabel.textColor = Constants.COLORS.text_gray
        case 2:
            self.waitingLineView.backgroundColor = UIColor.white
            self.waitingdLabel.textColor = Constants.COLORS.text_gray
            
            self.handingLineView.backgroundColor = UIColor.white
            self.handingLabel.textColor = Constants.COLORS.text_gray
            
            self.handedLineView.backgroundColor = Constants.COLORS.bold_green
            self.handedLabel.textColor = Constants.COLORS.bold_green
        default:
            print("ok")
        }
    }
    
}


extension InstallmentOnlineVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentTab {
        case 0:
            return filteredWatingNew.count
        case 1:
            return filteredHanding.count
        case 2:
            return filteredListHanded.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 217
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "InstallmentHistoryCell", for: indexPath) as! InstallmentHistoryCell
        if currentTab == 0 {
            let item = filteredWatingNew[indexPath.row]
            cell.bindcellNew(with: item)
        } else if currentTab == 1 {
            let item = filteredHanding[indexPath.row]
            cell.bindcell2(with: item)
        } else {
            let item = filteredListHanded[indexPath.row]
            cell.bindcell2(with: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentTab == 0 {
            let vc = DetailOrderVC()
            vc.handingItem = filteredWatingNew[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else if currentTab == 1 {
            let vc = DetailOrderVC()
            vc.docEntryHistory = "\(filteredHanding[indexPath.row].docEntry)"
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = DetailOrderVC()
            vc.docEntryHistory = "\(filteredListHanded[indexPath.row].docEntry)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
