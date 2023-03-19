//
//  HistoryTribiFlightViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 1/7/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
class HistoryTribiFlightViewController:  UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView  =   UITableView()
    var items: [HistoryFlightTribi] = []
    var listTemp:[HistoryFlightTribi] = []
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lịch sử mua vé"
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(HistoryTribiFlightViewController.backButton), for: UIControl.Event.touchUpInside)
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
        searchController.searchBar.scopeButtonTitles = ["SĐT", "Mã ĐH","Mã đặt vé"]
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
        MPOSAPIManager.mpos_FRT_Flight_Tripi_GetHistory(Key: "",Type:"", handler: { (results, err) in
            if(results.count > 0){
                self.loading.stopAnimating()
                lbNotFound.isHidden = true
                self.items = results
                self.listTemp = results
                
                self.setupUI(list: results)
            }else{
                lbNotFound.text = "Không tìm thấy đơn hàng!"
                logo.isHidden = false
                lbNotFound.isHidden = false
                self.loading.stopAnimating()
            }
        })
    }
    func setupUI(list: [HistoryFlightTribi]){
        tableView.frame = CGRect(x: 0, y:0, width: loadingView.frame.size.width, height: self.view.frame.size.height )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchItemHistoryTribiFlightTableViewCell.self, forCellReuseIdentifier: "SearchItemHistoryTribiFlightTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        loadingView.addSubview(tableView)
        
        
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //        Cache.indexRow = -1
        let item:HistoryFlightTribi = items[indexPath.row]
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default


        MPOSAPIManager.mpos_FRT_Flight_Tripi_GetDetailInfor(docentry: "\(item.DocEntry)") { (results,err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
              
                    results[0].SoMPOS = item.SO_MPOS
                    let newViewController = DetailHistoryTribiViewController()
                        newViewController.detailTribi = results[0]
                    self.navigationController?.pushViewController(newViewController, animated: true)



                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in

                    })
                    self.present(alert, animated: true)
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = SearchItemHistoryTribiFlightTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SearchItemHistoryTribiFlightTableViewCell")
        let item:HistoryFlightTribi = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:200);
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
    func filterContentForSearchText(_ searchText: String, scope: String = "Tên") {
        if(searchText.count > 0){
            let searchText =  searchText.folding(options: .diacriticInsensitive, locale: nil)
            if (scope == "SĐT"){
                
                self.searchInfo(Key: searchText, Type: "1")
            }else if (scope == "Mã ĐH"){
                self.searchInfo(Key: searchText, Type: "2")
            }else if(scope == "Mã đặt vé"){
                self.searchInfo(Key: searchText, Type: "3")
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
    
    func searchInfo(Key:String,Type:String){
        MPOSAPIManager.mpos_FRT_Flight_Tripi_GetHistory(Key: Key,Type:Type, handler: { (results, err) in
                 if(results.count > 0){
                     self.items.removeAll()
                     self.items = results
                    self.tableView.reloadData()
                 }else{
                    
                 }
             })
    }
}
extension HistoryTribiFlightViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
}

extension HistoryTribiFlightViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
class SearchItemHistoryTribiFlightTableViewCell: UITableViewCell {
    
    //
    var sompos:UILabel!
    var ngay:UILabel!
    var bookingID:UILabel!
    var tenKH:UILabel!
    var sdt:UILabel!
    var email:UILabel!
    var tongtien:UILabel!
    var trangthai:UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        sompos = UILabel()
        sompos.textColor = UIColor(netHex:0x00955E)
        sompos.numberOfLines = 0
        sompos.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(sompos)
        
        ngay = UILabel()
        ngay.textColor = UIColor.gray
        ngay.numberOfLines = 0
        ngay.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(ngay)
        
        bookingID = UILabel()
        bookingID.textColor = UIColor.black
        bookingID.numberOfLines = 0
        bookingID.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(bookingID)
        
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
        
        email = UILabel()
        email.textColor = UIColor.black
        email.numberOfLines = 0
        email.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(email)
        
        
        tongtien = UILabel()
        tongtien.textColor = UIColor.red
        tongtien.numberOfLines = 0
        tongtien.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(tongtien)
        
        trangthai = UILabel()
        trangthai.textColor = UIColor(netHex:0x00955E)
        trangthai.font = UIFont.boldSystemFont(ofSize: 13)
        
        contentView.addSubview(trangthai)
        
    
    }
    var so1:HistoryFlightTribi?
    func setup(so:HistoryFlightTribi){
        so1 = so
        
        sompos.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        sompos.text = "Số MPOS \(so.SO_MPOS)"
        sompos.textAlignment = .left
        
        ngay.frame = CGRect(x: 0,y:  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        ngay.text = "\(so.bookedDate)"
        ngay.textAlignment = .right
        
        bookingID.frame = CGRect(x: Common.Size(s:10),y: sompos.frame.size.height + sompos.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        bookingID.text = "Mã đơn hàng: \(so.bookingId)"
        bookingID.textAlignment = .left
        
        tenKH.frame = CGRect(x: Common.Size(s:10),y: bookingID.frame.size.height + bookingID.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        tenKH.text = "Tên KH: \(so.fullName)"
        tenKH.textAlignment = .left
        
        sdt.frame = CGRect(x: Common.Size(s:10),y: tenKH.frame.size.height + tenKH.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        sdt.text = "SĐT: \(so.phone)"
        sdt.textAlignment = .left
        
        email.frame = CGRect(x: Common.Size(s:10),y: sdt.frame.size.height + sdt.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        email.text = "Email: \(so.email)"
        email.textAlignment = .left
        
        tongtien.frame = CGRect(x: Common.Size(s:10),y: email.frame.size.height + email.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        tongtien.text = "Tổng tiền: \(so.finalPriceFormatted)"
        tongtien.textAlignment = .left
        
        trangthai.frame = CGRect(x: Common.Size(s:10),y: tongtien.frame.size.height + tongtien.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 20) ,height: Common.Size(s:30))
         trangthai.text = "\(so.Status)"
        trangthai.lineBreakMode = .byWordWrapping
        trangthai.numberOfLines = 0
        trangthai.sizeToFit()
         trangthai.textAlignment = .left
        
        
    }
    
    
}

