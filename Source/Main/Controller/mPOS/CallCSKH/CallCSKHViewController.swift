//
//  CallCSKHViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 7/29/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CallCSKHViewController: UIViewController, CustomSegmentControlDelegate {
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var number = 0
    var list = [CallCSKH]()
    var btnSearch: UIBarButtonItem!
    var btnBack: UIBarButtonItem!
    
    var filterList = [CallCSKH]()
    var searchBarContainer:SearchBarContainerView!
    var tabType = "1"
    var codeSegmented = CustomSegmentControl()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        self.loadData(type: "1")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Gọi chăm sóc khách hàng"
        self.view.backgroundColor = .white
        
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btnBack = UIBarButtonItem(customView: btBackIcon)
        self.navigationItem.leftBarButtonItems = [btnBack]
        
        let btSearchIcon = UIButton.init(type: .custom)
        btSearchIcon.setImage(#imageLiteral(resourceName: "Search"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        btSearchIcon.addTarget(self, action: #selector(actionSearchAssets), for: UIControl.Event.touchUpInside)
        btnSearch = UIBarButtonItem(customView: btSearchIcon)
        self.navigationItem.rightBarButtonItems = [btnSearch]
        
        //search bar custom
        let searchBar = UISearchBar()
        searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
        searchBarContainer.searchBar.showsCancelButton = true
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        if #available(iOS 13.0, *) {
            searchBarContainer.searchBar.searchTextField.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }
        searchBarContainer.searchBar.delegate = self
        
        if #available(iOS 11.0, *) {
            searchBarContainer.searchBar.placeholder = "Tìm theo tên khách hàng"
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Tìm theo tên khách hàng",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        
        codeSegmented.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s: 40))
        codeSegmented.setButtonTitles(buttonTitles: ["DS GỌI HÔM NAY", "LỊCH SỬ GỌI"])
        self.view.addSubview(codeSegmented)
        codeSegmented.backgroundColor = .white
        codeSegmented.selectorViewColor = UIColor(netHex:0x00955E)
        codeSegmented.selectorTextColor = .black
        codeSegmented.unSelectorViewColor = UIColor.lightGray
        codeSegmented.unSelectorTextColor = UIColor.lightGray
        codeSegmented.delegate = self
        self.view.bringSubviewToFront(codeSegmented)
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: codeSegmented.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: tableViewHeight - Common.Size(s: 50)))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(CallNote20Cell.self, forCellReuseIdentifier: "callNote20Cell")
        tableView.tableFooterView = UIView()
        
        self.addDoneButtonOnKeyboard()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
        
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
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func change(to index:Int) {
        print("segmentedControlCustom index changed to \(index)")
        switch index {
        case 0:
            self.tabType = "1"
            self.loadData(type: "1")
        case 1:
            self.tabType = "2"
            self.loadData(type: "2")
        default:
            break
        }
    }
    
    func loadData(type: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            APIManager.mpos_FRT_Call_Customer_GetData(type: "\(type)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.list = rs
                        self.filterList = rs
                        
                        if(rs.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có danh sách gọi.\n:/", viewController: self.tableView)
                        }else{
                            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                        }
                        self.tableView.reloadData()
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

extension CallCSKHViewController: UITableViewDelegate, UITableViewDataSource, CallNote20CellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.searchBarContainer.searchBar.text ?? ""
        if !(key.isEmpty) {
            return filterList.count
        }else{
           return list.count
        }
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CallNote20Cell = tableView.dequeueReusableCell(withIdentifier: "callNote20Cell", for: indexPath) as! CallNote20Cell
        let key = self.searchBarContainer.searchBar.text ?? ""
        if !(key.isEmpty) {
            let item = filterList[indexPath.row]
            cell.item = item
            cell.delegate = self
            cell.setUpCell(tabType: "\(self.tabType)")
        } else {
            let item = list[indexPath.row]
            cell.item = item
            cell.delegate = self
            cell.setUpCell(tabType: "\(self.tabType)")
        }
        cellHeight = cell.estimateCellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func callKH(callCSKHItem: CallCSKH) {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn có chắc chắn thực hiện cuộc gọi vào sđt \(callCSKHItem.Phone)?", preferredStyle: .alert)
        let actionCall = UIAlertAction(title: "Gọi", style: .default) { (_) in
            APIManager.mpos_FRT_Call_Customer_UpdateInfo(ID: "\(callCSKHItem.ID)".trim(), Phone: callCSKHItem.Phone.trim()) { (rsCode, msg, err) in
                if err.count <= 0 {
                    if rsCode == 1 {
                        guard let number = URL(string: "tel://" + callCSKHItem.Phone.trim()) else { return }
                        UIApplication.shared.open(number)
                        self.loadData(type: "\(self.tabType)")
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        let actionCalcel = UIAlertAction(title: "Huỷ", style: .default, handler: nil)
        alert.addAction(actionCalcel)
        alert.addAction(actionCall)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func hideKeyBoard() {
        self.searchBarContainer.searchBar.resignFirstResponder()
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.searchBarContainer.searchBar.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        self.searchBarContainer.searchBar.resignFirstResponder()
    }
}


extension CallCSKHViewController: UISearchBarDelegate {
    
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
        search(key: "\(searchBar.text!)")
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
        if key.count > 0 {
            filterList = list.filter({($0.CustomerName.localizedCaseInsensitiveContains(key)) || ($0.Phone.localizedCaseInsensitiveContains(key))})
        } else {
            filterList = list
        }
        tableView.reloadData()
    }
}

//------CELL
protocol CallNote20CellDelegate:AnyObject {
    func callKH(callCSKHItem: CallCSKH)
}

class CallNote20Cell:UITableViewCell {
    var estimateCellHeight:CGFloat = 0
    weak var delegate:CallNote20CellDelegate?
    var item:CallCSKH?
    
    func setUpCell(tabType: String) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let viewContent = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        viewContent.backgroundColor = .white
        self.addSubview(viewContent)
        
        let lbTenKH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: (viewContent.frame.width - Common.Size(s: 30))/3 + Common.Size(s: 5), height: Common.Size(s: 20)))
        lbTenKH.text = "Tên khách hàng: "
        lbTenKH.font = UIFont.systemFont(ofSize: 14)
        lbTenKH.textColor = UIColor.darkGray
        viewContent.addSubview(lbTenKH)
        
        let lbTenKHText = UILabel(frame: CGRect(x: lbTenKH.frame.origin.x + lbTenKH.frame.width, y: lbTenKH.frame.origin.y, width: lbTenKH.frame.width, height: Common.Size(s: 20)))
        lbTenKHText.text = "\(item?.CustomerName ?? "")"
        lbTenKHText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbTenKHText)
        
        let lbTenKHTextHeight: CGFloat = lbTenKHText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTenKHText.optimalHeight + Common.Size(s: 5))
        lbTenKHText.numberOfLines = 0
        lbTenKHText.frame = CGRect(x: lbTenKHText.frame.origin.x, y: lbTenKHText.frame.origin.y, width: lbTenKHText.frame.width, height: lbTenKHTextHeight)
        
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTenKHText.frame.origin.y + lbTenKHTextHeight, width: (viewContent.frame.width - Common.Size(s: 30))/3 + Common.Size(s: 5), height: Common.Size(s: 20)))
        lbSdt.text = "SĐT khách hàng: "
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        lbSdt.textColor = UIColor.darkGray
        viewContent.addSubview(lbSdt)
        
        let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.origin.x + lbSdt.frame.width, y: lbSdt.frame.origin.y, width: (viewContent.frame.width - Common.Size(s: 30)) * 2/3 - Common.Size(s: 5), height: Common.Size(s: 20)))
        lbSdtText.text = "\(item?.Phone ?? "")"
        lbSdtText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSdtText)
        
        let lbCallDate = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x + lbTenKHText.frame.width + Common.Size(s: 3), y: lbTenKH.frame.origin.y, width: lbSdtText.frame.width - lbTenKH.frame.width - Common.Size(s: 3), height: Common.Size(s: 20)))
        lbCallDate.text = "\(item?.CallDate ?? "")"
        lbCallDate.font = UIFont.systemFont(ofSize: 11)
        lbCallDate.textAlignment = .right
        viewContent.addSubview(lbCallDate)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái: "
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        lbTrangThai.textColor = UIColor.darkGray
        viewContent.addSubview(lbTrangThai)
        
        let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width, y: lbTrangThai.frame.origin.y, width: lbSdtText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "\(item?.Status ?? "")"
        lbTrangThaiText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbTrangThaiText)
        
        if item?.Status == "Chưa gọi" {
            lbTrangThaiText.textColor = UIColor(netHex: 0xcc0c2f)
        } else {
            lbTrangThaiText.textColor = UIColor(netHex: 0x109e59)
        }
        
        let lbCreateDate = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.font = UIFont.systemFont(ofSize: 14)
        lbCreateDate.textColor = UIColor.darkGray
        viewContent.addSubview(lbCreateDate)
        
        let lbCreateDateText = UILabel(frame: CGRect(x: lbCreateDate.frame.origin.x + lbCreateDate.frame.width, y: lbCreateDate.frame.origin.y, width: lbSdtText.frame.width, height: Common.Size(s: 20)))
        lbCreateDateText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbCreateDateText)
        
        if tabType == "1" {
            lbCreateDate.text = "Ngày tạo: "
            lbCreateDateText.text = "\(item?.DateAddList ?? "")"
        } else {
            lbCreateDate.text = "Nhân viên gọi: "
            lbCreateDateText.text = "\(item?.EmployeeNameCall ?? "")"
        }
        
        let lbCreateDateTextHeight: CGFloat = lbCreateDateText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbCreateDateText.optimalHeight + Common.Size(s: 5))
        lbCreateDateText.numberOfLines = 0
        lbCreateDateText.frame = CGRect(x: lbCreateDateText.frame.origin.x, y: lbCreateDateText.frame.origin.y, width: lbCreateDateText.frame.width, height: lbCreateDateTextHeight)
        
        let lbSPCu = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbCreateDateText.frame.origin.y + lbCreateDateTextHeight, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbSPCu.text = "Sản phẩm cũ: "
        lbSPCu.font = UIFont.systemFont(ofSize: 14)
        lbSPCu.textColor = UIColor.darkGray
        viewContent.addSubview(lbSPCu)
        
        let lbSPCuText = UILabel(frame: CGRect(x: lbSPCu.frame.origin.x + lbSPCu.frame.width, y: lbSPCu.frame.origin.y, width: lbSdtText.frame.width - Common.Size(s: 25), height: Common.Size(s: 20)))
        lbSPCuText.text = "\(item?.Model ?? "")"
        lbSPCuText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbSPCuText)
        
        let lbSPCuTextHeight: CGFloat = lbSPCuText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbSPCuText.optimalHeight + Common.Size(s: 5))
        lbSPCuText.numberOfLines = 0
        lbSPCuText.frame = CGRect(x: lbSPCuText.frame.origin.x, y: lbSPCuText.frame.origin.y, width: lbSPCuText.frame.width, height: lbSPCuTextHeight)
        
        let imgCall = UIImageView(frame: CGRect(x: lbSPCuText.frame.origin.x + lbSPCuText.frame.width + Common.Size(s: 5), y: lbSPCuText.frame.origin.y, width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgCall.image = #imageLiteral(resourceName: "Call 1")
        imgCall.contentMode = .scaleAspectFit
        viewContent.addSubview(imgCall)
        
        let tapCall = UITapGestureRecognizer(target: self, action: #selector(actionCall))
        imgCall.isUserInteractionEnabled = true
        imgCall.addGestureRecognizer(tapCall)
        
        let line = UIView(frame: CGRect(x: 0, y: lbSPCuText.frame.origin.y + lbSPCuTextHeight + Common.Size(s: 10), width: viewContent.frame.width, height: Common.Size(s: 2)))
        line.backgroundColor = .lightGray
        viewContent.addSubview(line)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y, width: viewContent.frame.width, height: line.frame.origin.y + line.frame.height)
        
        estimateCellHeight = viewContent.frame.origin.y + viewContent.frame.height
    }
    
    @objc func actionCall() {
        self.delegate?.callKH(callCSKHItem: self.item ?? CallCSKH(ID: 0, ShopCode: "", ShopName: "", Phone: "", CustomerName: "", Model: "", Status: "", DateAddList: "", EmployeeNameCall: "", CallDate: ""))
    }
}
