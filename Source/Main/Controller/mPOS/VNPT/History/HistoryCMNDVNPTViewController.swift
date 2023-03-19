//
//  LichSuMuaHangMiraeViewController.swift
//  fptshop
//
//  Created by tan on 5/30/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import PopupDialog
class HistoryCMNDVNPTViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView  =   UITableView()
    var items: [HistoryVNPT] = []
    var listTemp:[HistoryVNPT] = []
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    let searchController = UISearchController(searchResultsController: nil)
    var cmnd:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lịch sử mua hàng KH: \(self.cmnd!)"
        self.view.backgroundColor = .white
        
        navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(HistoryCMNDVNPTViewController.backButton), for: UIControl.Event.touchUpInside)
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
        searchController.searchBar.scopeButtonTitles = ["CMND", "SĐT","Số MPOS"]
        searchController.searchBar.delegate = self
        
        
        
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
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
        MPOSAPIManager.mpos_FRT_SP_VNPT_load_history(keyword: "\(self.cmnd!)", handler: { (results, err) in
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
    func setupUI(list: [HistoryVNPT]){
        tableView.frame = CGRect(x: 0, y:0, width: loadingView.frame.size.width, height: self.view.frame.size.height )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchItemSOHistoryCMNDVNPTTableViewCell.self, forCellReuseIdentifier: "SearchItemSOHistoryCMNDVNPTTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        loadingView.addSubview(tableView)
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //        Cache.indexRow = -1
        let item:HistoryVNPT = items[indexPath.row]
        let newViewController = DetailSOHistoryVNPTViewController()
        newViewController.historyVNPT = item
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = SearchItemSOHistoryVNPTTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SearchItemSOHistoryVNPTTableViewCell")
        let item:HistoryVNPT = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:320)
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
            if (scope == "CMND"){
                
                
                self.items.removeAll()
                
                self.items = self.listTemp.filter { "\($0.CMND)".contains(searchText) }
                
                
                tableView.reloadData()
            }else if (scope == "SĐT"){
                
                
                self.items.removeAll()
                
                self.items = self.listTemp.filter { "\($0.SDT)".contains(searchText) }
                
                tableView.reloadData()
            }else if (scope == "Số MPOS"){
                
                
                self.items.removeAll()
                
                self.items = self.listTemp.filter { "\($0.SOMPOS)".contains(searchText) }
                
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
}
extension HistoryCMNDVNPTViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
}

extension HistoryCMNDVNPTViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
class SearchItemSOHistoryCMNDVNPTTableViewCell: UITableViewCell {
    
    
    var cmnd:UILabel!
    var ngaymua:UILabel!
    var hoten:UILabel!
    var sdt:UILabel!
    var nv:UILabel!
    var shop:UILabel!
    var soSO:UILabel!
    var tongtien:UILabel!
    var soCallLog:UILabel!
    var tinhTrangCallLog:UILabel!
    var lydotuchoi:UILabel!
    var nguoiduyet:UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        
        
        cmnd = UILabel()
        cmnd.textColor = UIColor.black
        cmnd.numberOfLines = 0
        cmnd.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(cmnd)
        
        
        ngaymua = UILabel()
        ngaymua.textColor = UIColor.black
        ngaymua.numberOfLines = 0
        ngaymua.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(ngaymua)
        
        hoten = UILabel()
        hoten.textColor = UIColor.black
        hoten.numberOfLines = 0
        hoten.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(hoten)
        
        
        sdt = UILabel()
        sdt.textColor = UIColor.black
        sdt.numberOfLines = 0
        sdt.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(sdt)
        
        nv = UILabel()
        nv.textColor = UIColor.black
        nv.numberOfLines = 0
        nv.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(nv)
        
        shop = UILabel()
        shop.textColor = UIColor.black
        shop.numberOfLines = 0
        shop.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(shop)
        
        
        soSO = UILabel()
        soSO.textColor = UIColor.black
        soSO.numberOfLines = 0
        soSO.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(soSO)
        
        tongtien = UILabel()
        tongtien.textColor = UIColor.black
        tongtien.numberOfLines = 0
        tongtien.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(tongtien)
        
        soCallLog = UILabel()
        soCallLog.textColor = UIColor.black
        soCallLog.numberOfLines = 0
        soCallLog.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(soCallLog)
        
        tinhTrangCallLog = UILabel()
        tinhTrangCallLog.textColor = UIColor.black
        tinhTrangCallLog.numberOfLines = 0
        tinhTrangCallLog.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(tinhTrangCallLog)
        
        
        lydotuchoi = UILabel()
        lydotuchoi.textColor = UIColor.black
        lydotuchoi.numberOfLines = 0
        lydotuchoi.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(lydotuchoi)
        
        nguoiduyet = UILabel()
        nguoiduyet.textColor = UIColor.black
        nguoiduyet.numberOfLines = 0
        nguoiduyet.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(nguoiduyet)
        
    }
    var so1:HistoryVNPT?
    func setup(so:HistoryVNPT){
        so1 = so
        
        cmnd.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        cmnd.text = "CMND \(so.CMND)"
        //idDK.text = "IDDK: \(so.IDDK)"
        ngaymua.frame = CGRect(x: Common.Size(s:10),y: cmnd.frame.size.height + cmnd.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        ngaymua.text = "Ngày mua: \(so.CMND)"
        
        hoten.frame = CGRect(x: Common.Size(s:10),y: ngaymua.frame.size.height + ngaymua.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        hoten.text = "Họ tên: \(so.TenKH)"
        
        sdt.frame = CGRect(x: Common.Size(s:10),y: hoten.frame.size.height + hoten.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        sdt.text = "SĐT: \(so.SDT)"
        
        nv.frame = CGRect(x: Common.Size(s:10),y: sdt.frame.size.height + sdt.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        nv.text = "NV bán hàng: \(so.tenNV)"
        
        
        shop.frame = CGRect(x: Common.Size(s:10),y: nv.frame.size.height + nv.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        shop.text = "Cửa hàng: \(so.ShopName)"
        
        
        soSO.frame = CGRect(x: Common.Size(s:10),y: shop.frame.size.height + shop.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        soSO.text = "Số MPOS: \(so.SOMPOS)"
        
        tongtien.frame = CGRect(x: Common.Size(s:10),y: soSO.frame.size.height + soSO.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
          tongtien.text = "Tổng tiền: \(Common.convertCurrency(value: so.TongTien))"
        
        
        soCallLog.frame = CGRect(x: Common.Size(s:10),y: tongtien.frame.size.height + tongtien.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        soCallLog.text = "Số CallLog: \(so.SoCalllog)"
        
        tinhTrangCallLog.frame = CGRect(x: Common.Size(s:10),y: soCallLog.frame.size.height + soCallLog.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        tinhTrangCallLog.text = "Tình Trạng CallLog: \(so.TTCalllog)"
        
        lydotuchoi.frame = CGRect(x: Common.Size(s:10),y: tinhTrangCallLog.frame.size.height + tinhTrangCallLog.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        lydotuchoi.text = "Lý do từ chối: \(so.return_mgs_calllog)"
        
        
        nguoiduyet.frame = CGRect(x: Common.Size(s:10),y: lydotuchoi.frame.size.height + lydotuchoi.frame.origin.y + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:40) ,height: Common.Size(s:16))
        nguoiduyet.text = "Người duyệt: \(so.tenNVcalllog)"
        
    }
    
    
}
