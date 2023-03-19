//
//  HistoryReceiveMoneyViettelPayViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/24/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import PopupDialog
class HistoryReceiveMoneyViettelPayViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{

    
    var tableView: UITableView  =   UITableView()
    var items: [InitTransferHeader] = []
    
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    var barRight: UIBarButtonItem!
    var refreshControl = UIRefreshControl()
    var listTemp:[InitTransferHeader] = []
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lịch sử GD nhận tiền"
        self.view.backgroundColor = .white
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        navigationController?.navigationBar.isTranslucent = false
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(HistoryReceiveMoneyViettelPayViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Nhập từ khoá tìm..."
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
                navigationController?.navigationBar.isTranslucent = true
            }
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["SĐT", "Số MPOS"]
        searchController.searchBar.delegate = self
        
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.subviews.forEach { $0.removeFromSuperview() }
        
        loadingView  = UIView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        //UIApplication.shared.statusBarFrame.height + Cache.heightNav
        self.view.addSubview(loadingView)
        
        //loading
        let frameLoading = CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y:loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50))
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor(netHex:0x47B054)
        loading = NVActivityIndicatorView(frame: frameLoading,
                                          type: .ballClipRotateMultiple)
        loading.startAnimating()
        loadingView.addSubview(loading)
        
        var logo : UIImageView
        logo  = UIImageView(frame:CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y: loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50)));
        logo.image = UIImage(named:"Cancel File-100")
        logo.contentMode = .scaleAspectFit
        loadingView.addSubview(logo)
        
        logo.isHidden = true
        
        let productNotFound = "Đang load danh sách đơn hàng"
        let lbNotFound = UILabel(frame: CGRect(x: 0, y: loading.frame.origin.y + loading.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width, height: Common.Size(s:22)))
        lbNotFound.textAlignment = .center
        lbNotFound.textColor = UIColor.lightGray
        lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        lbNotFound.text = productNotFound
        loadingView.addSubview(lbNotFound)
        MPOSAPIManager.GetInitTransferHeaders(handler: { (results, err) in
            if(results.count > 0){
                self.loading.stopAnimating()
                lbNotFound.isHidden = true
                self.items = results
                 self.listTemp = results
                self.setupUI(list: results)
            }else{
                lbNotFound.text = "Không tìm thấy giao dịch!"
                logo.isHidden = false
                lbNotFound.isHidden = false
                self.loading.stopAnimating()
            }
        })
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Tên") {
        if(searchText.count > 0){
            let searchText =  searchText.folding(options: .diacriticInsensitive, locale: nil)
            if (scope == "SĐT"){
                
                
                self.items.removeAll()
                
                self.items = self.listTemp.filter { "\($0.sender_msisdn)".contains(searchText) }
                
                tableView.reloadData()
            }else if (scope == "Số MPOS"){
                self.items.removeAll()
                
                self.items = self.listTemp.filter { "\($0.docentry)".contains(searchText) }
                tableView.reloadData()
            }
            if(self.items.count <= 0){
                TableViewHelper.EmptyMessage(message: "Không tìm thấy từ khoá cần tìm.\r\nVui lòng kiểm tra lại.", viewController: self.tableView)
            }else{
                TableViewHelper.removeEmptyMessage(viewController: self.tableView)
            }
            self.tableView.reloadData()
        }else{
            self.items.removeAll()
            self.items = self.listTemp
            self.tableView.reloadData()
        }
    }
    
    func setupUI(list: [InitTransferHeader]){
        tableView.frame = CGRect(x: 0, y:0, width: loadingView.frame.size.width, height: self.view.frame.size.height )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemReceiveMoneyViettelPayTableViewCell.self, forCellReuseIdentifier: "ItemReceiveMoneyViettelPayTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        loadingView.addSubview(tableView)
  
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        //        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        //        refreshControl.attributedTitle = NSAttributedString(string: "Đang load dữ liệu ...", attributes: secondAttributes)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let item:InitTransferHeader = items[indexPath.row]
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy chi tiết lịch sử giao dịch..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.GetInitTransferDetails(docentry: "\(item.docentry)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                
                if(err.count <= 0){
                    results[0].NgayGiaoDich = item.NgayGiaoDich
                    let newViewController = DetailHistoryReceiveMoneyViettelPayViewController()
                    newViewController.detail = results[0]
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                    
                    
                }else{
                    let title = "Thông báo"
                    
                    
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                }
            }
        }
        
        
        
        
        
        
    }
    @objc func actionUpdate(){
        
        let newViewController = UpdateTransferMoneyViettelPayViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemReceiveMoneyViettelPayTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemReceiveMoneyViettelPayTableViewCell")
        let item:InitTransferHeader = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:135);
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    ////        if(Cache.indexRow != -1){
    ////            self.items.remove(at: Cache.indexRow)
    ////            tableView.reloadData()
    ////            Cache.indexRow = -1
    ////        }
    //    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc private func refreshData(_ sender: Any) {
        // Fetch Weather Data

        MPOSAPIManager.GetInitTransferHeaders(handler: { (results, err) in
            if(results.count > 0){
                self.refreshControl.endRefreshing()

                self.items = results
                self.tableView.reloadData()
            }else{

                self.refreshControl.endRefreshing()
            }
        })
    }
}
extension HistoryReceiveMoneyViettelPayViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension HistoryReceiveMoneyViettelPayViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
class ItemReceiveMoneyViettelPayTableViewCell: UITableViewCell {
    
    //
    var soMPOS:UILabel!
    var ngay:UILabel!
    var tenKH:UILabel!
    
    var sdt:UILabel!
    var sotien:UILabel!
    
    var tinhtrang:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        soMPOS = UILabel()
        soMPOS.textColor = UIColor(netHex:0x00955E)
        soMPOS.numberOfLines = 0
        soMPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(soMPOS)
        
        ngay = UILabel()
        ngay.textColor = UIColor.gray
        ngay.numberOfLines = 0
        ngay.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(ngay)
        
        tenKH = UILabel()
        tenKH.textColor = UIColor.black
        tenKH.numberOfLines = 0
        tenKH.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(tenKH)
        
        
        
        sdt = UILabel()
        sdt.textColor = UIColor.black
        sdt.numberOfLines = 0
        sdt.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(sdt)
        
        
        
        sotien = UILabel()
        sotien.textColor = UIColor.black
        sotien.numberOfLines = 0
        sotien.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(sotien)
        
        tinhtrang = UILabel()
        tinhtrang.textColor = UIColor.black
        tinhtrang.numberOfLines = 0
        tinhtrang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(tinhtrang)
        
        
    }
    var so1:InitTransferHeader?
    func setup(so:InitTransferHeader){
        so1 = so
        //
        soMPOS.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:140) ,height: Common.Size(s:16))
        soMPOS.text = "MPOS \(so.docentry)"
        //idDK.text = "IDDK: \(so.IDDK)"
        //
        ngay.frame = CGRect(x: soMPOS.frame.origin.x + soMPOS.frame.size.width , y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        ngay.text = "\(so.NgayGiaoDich)"
        //
        tenKH.frame = CGRect(x: Common.Size(s:10),y: soMPOS.frame.origin.y + soMPOS.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        tenKH.text = "Họ tên KH nhận: \(so.receiver_name)"
        
        //
        sdt.frame = CGRect(x: Common.Size(s:10),y: tenKH.frame.origin.y + tenKH.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        sdt.text = "SĐT: \(so.sender_msisdn)"
        //
        sotien.frame = CGRect(x: Common.Size(s:10),y: sdt.frame.origin.y + sdt.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        sotien.text = "Số tiền: \(Common.convertCurrency(value: so.amount))"
        
        tinhtrang.frame = CGRect(x: Common.Size(s:10),y: sotien.frame.origin.y + sotien.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        tinhtrang.text = so.TrangThai
        if(so.TrangThai == "Đã gửi"){
            tinhtrang.textColor = UIColor.init(netHex: 0x3399CC)
        }else{
            tinhtrang.textColor = .red
        }
        
        
        
        
    }
    
    
}

