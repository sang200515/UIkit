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
class SearchItemCompleteRPViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,ItemSearchRPCompleteTableViewCellDelegate,ItemSearchRPOnProgressTableViewCellDelegate {
    func tabClickView(itemRPOnProgress: ItemRPOnProgress) {
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_SK_view_image(Docentry: "\(itemRPOnProgress.docentry)") { (image,descriptionRightPhone, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    let newViewController = ViewImageRPViewController()
                    if(image.count > 0){
                        newViewController.rsImage = image[0]
                    }
                    
                    newViewController.rsDescription = descriptionRightPhone[0]
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
    
    
    func tabClickViewComplete(headerCompleteRP:HeaderCompleteRP) {
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_SK_view_image(Docentry: "\(headerCompleteRP.docentry)") { (image,descriptionRightPhone, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    let newViewController = ViewImageRPViewController()
                    if(image.count > 0){
                        newViewController.rsImage = image[0]
                    }
                    
                    newViewController.rsDescription = descriptionRightPhone[0]
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
    
    
    var tableView: UITableView  =   UITableView()
    var items: [HeaderCompleteRP] = []
    var listTemp:[HeaderCompleteRP] = []
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    let searchController = UISearchController(searchResultsController: nil)
    var cellHeight:CGFloat = 0
    
    
    var selectTab:Int = 0
    var itemsOnProgress:[ItemRPOnProgress] = []
    var listTempOnProgress:[ItemRPOnProgress] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lịch sử mua hàng"
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
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
        searchController.searchBar.scopeButtonTitles = ["Đã xử lý", "Chờ xử lý"]
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
        MPOSAPIManager.mpos_FRT_SP_SK_header_complete(keysearch:"",handler: { (results, err) in
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
    func setupUI(list: [HeaderCompleteRP]){
        tableView.frame = CGRect(x: 0, y:0, width: loadingView.frame.size.width, height: self.view.frame.size.height )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemRPSearchCompleteTableViewCell.self, forCellReuseIdentifier: "ItemRPSearchCompleteTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        loadingView.addSubview(tableView)
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //        Cache.indexRow = -1
        if(self.selectTab == 0){
            let item:HeaderCompleteRP = items[indexPath.row]
            
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.mpos_FRT_SP_SK_header_complete_detail(docentry: "\(item.docentry)") { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        
                        
                        let newViewController = RPDetailCompleteProgressViewController()
                        newViewController.headerCompleteDetailRP = results[0]
                        self.navigationController?.pushViewController(newViewController, animated: true)
                        
                        
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                }
            }
        }else{
            let item:ItemRPOnProgress = itemsOnProgress[indexPath.row]
            if(item.Status == "N"){ // moi nhan tu rcheck => chuyen man hinh cap nhat thong tin
                
                
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang kiểm tra thông tin..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                
                MPOSAPIManager.mpos_FRT_SP_SK_viewdetail_Rcheck(docentry: "\(item.docentry)") { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            
                            
                            let newViewController = RegisterRightPhoneViewController()
                            newViewController.itemRPOnProgress = item
                            newViewController.detailRPRcheck = results[0]
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
            if(item.Status == "U"){//upload bien ban ban giao
                let newViewController = LoadingViewController()
                newViewController.content = "Đang kiểm tra thông tin..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                
                MPOSAPIManager.mpos_FRT_SP_SK_viewdetail_Rcheck(docentry: "\(item.docentry)") { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            
                            
                            let newViewController = UploadSignDocRightPhoneViewController()
                            newViewController.itemRPOnProgress = item
                            newViewController.detailRPRcheck = results[0]
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
            if(item.Status == "O"){ //Chu may dang ban tren rightphone => chuyen qua man hinh huy
                
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang lấy chi tiết giao dịch ..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                
                MPOSAPIManager.mpos_FRT_SP_SK_viewdetail_all(docentry:"\(item.docentry)") { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            
                            let newViewController = RejectRightPhoneViewController()
                            newViewController.detailRPAll = results[0]
                            newViewController.itemRPOnProgress = item
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
            if(item.Status == "P"){ // Khach hang da dat mua tren RightPhone => Chuyen man hinh thanh toan
                /* Phat sinh 2 truong hop
                 1. Neu cung shop chuyen man hinh thanh toan button hoan tat coc ()
                 2. Neu khac shop chuyen man hinh thanh toan button hoan tat */
                let newViewController = LoadingViewController()
                newViewController.content = "Đang lấy chi tiết giao dịch ..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                
                MPOSAPIManager.mpos_FRT_SP_SK_view_detail_after_sale_rightphone(Docentry:"\(item.docentry)") { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            
                            if(results[0].KhacShop == "N"){
                                let newViewController = PaymentRightPhoneViewController()
                                newViewController.detailAfterSaleRP = results[0]
                                newViewController.itemRPOnProgress = item
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            
                            
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                    }
                }
                
            }
            if(item.Status == "D"){ // Khach hang da coc FPT => Chuyen qua man hinh thanh toan cung shop button hoan tat
                let newViewController = LoadingViewController()
                newViewController.content = "Đang lấy chi tiết giao dịch ..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                
                MPOSAPIManager.mpos_FRT_SP_SK_view_detail_after_sale_rightphone(Docentry:"\(item.docentry)") { (results, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            
                            
                            let newViewController = PaymentRightPhoneViewController()
                            newViewController.detailAfterSaleRP = results[0]
                            newViewController.itemRPOnProgress = item
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
        }
        
        
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(selectTab == 0){
            return items.count
        }else{
            return itemsOnProgress.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(selectTab == 0){
            let cell = ItemRPSearchCompleteTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemRPSearchCompleteTableViewCell")
            let item:HeaderCompleteRP = items[indexPath.row]
            cell.setup(so: item)
            cell.delegate = self
            cell.selectionStyle = .none
            self.cellHeight = cell.estimateCellHeight
            return cell
        }else{
            let cell = ItemSearchRPOnProgressTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSearchRPOnProgressTableViewCell")
            let item:ItemRPOnProgress = itemsOnProgress[indexPath.row]
            cell.setup(so: item)
            cell.delegate = self
            cell.selectionStyle = .none
            self.cellHeight = cell.estimateCellHeight
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return cellHeight
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
            if (scope == "Đã xử lý"){
                
                
                //                self.items.removeAll()
                //
                //                self.items = self.listTemp.filter { "\($0.IDCard)".contains(searchText) }
                //
                //
                //                tableView.reloadData()
                self.actionSearch(Keyword:searchText,Type:"3")
            }else if (scope == "Chờ xử lý"){
                
                
                //                self.items.removeAll()
                //
                //                self.items = self.listTemp.filter { "\($0.PhoneNumber)".contains(searchText) }
                //
                //                tableView.reloadData()
                self.actionSearch(Keyword:searchText,Type:"4")
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
    func ChangeContentForSearchText(_ searchText: String, selectedScope:Int) {
        self.selectTab = selectedScope
        if (selectedScope == 0){
            tableView.register(ItemRPSearchCompleteTableViewCell.self, forCellReuseIdentifier: "ItemRPSearchCompleteTableViewCell")
            
        }else if (selectedScope == 1){
            // self.tableView.removeFromSuperview()
            tableView.register(ItemSearchRPOnProgressTableViewCell.self, forCellReuseIdentifier: "ItemSearchRPOnProgressTableViewCell")
            
            MPOSAPIManager.mpos_FRT_SP_SK_load_header(keysearch: "", handler: { (results, err) in
                if(results.count > 0){
                    
                    self.itemsOnProgress.removeAll()
                    for item in results{
                        if(item.Status == "P" ||  item.Status == "O" || item.Status == "D" || item.Status == "N"){
                            self.itemsOnProgress.append(item)
                        }
                    }
                    
                    self.listTempOnProgress = self.itemsOnProgress
                    self.tableView.reloadData()
                }else{
                    
                }
            })
            
        }
    }
    func actionSearch(Keyword:String,Type:String){
        if(self.selectTab == 0){
            MPOSAPIManager.mpos_FRT_SP_SK_header_complete(keysearch:Keyword,handler: { (results, err) in
                if(results.count > 0){
                    
                    self.items.removeAll()
                    self.items = results
                    
                    
                    self.tableView.reloadData()
                }else{
                    
                    
                }
            })
        }else{
            MPOSAPIManager.mpos_FRT_SP_SK_load_header(keysearch:Keyword,handler: { (results, err) in
                if(results.count > 0){
                    
                    self.itemsOnProgress.removeAll()
                    for item in results{
                        if(item.Status == "P" ||  item.Status == "O" || item.Status == "D" || item.Status == "N"){
                            self.itemsOnProgress.append(item)
                        }
                    }
                    
                    self.listTempOnProgress = self.itemsOnProgress
                    self.tableView.reloadData()
                }else{
                    
                    
                }
            })
        }
    
    }
}
extension SearchItemCompleteRPViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        ChangeContentForSearchText(searchBar.text!, selectedScope: selectedScope)
    }
    
}

extension SearchItemCompleteRPViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
protocol ItemSearchRPCompleteTableViewCellDelegate {
    
    func tabClickViewComplete(headerCompleteRP:HeaderCompleteRP)
}
class ItemRPSearchCompleteTableViewCell: UITableViewCell {
    var imei:UILabel!
    var price:UILabel!
    var seller:UILabel!
    var phoneSeller:UILabel!
    var buyer:UILabel!
    var phoneBuyer:UILabel!
    var productName:UILabel!
    var date:UILabel!
    var Status:UILabel!
    var viewImage:UILabel!
    var estimateCellHeight: CGFloat = 0
    var delegate: ItemSearchRPCompleteTableViewCellDelegate?
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        imei = UILabel()
        imei.textColor = UIColor(netHex:0x00955E)
        imei.numberOfLines = 0
        imei.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(imei)
        
        price = UILabel()
        price.textColor = .black
        price.numberOfLines = 0
        price.font = UIFont.boldSystemFont(ofSize: 14)
        contentView.addSubview(price)
        
        
        seller = UILabel()
        seller.textColor = .black
        seller.numberOfLines = 0
        seller.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(seller)
        
        phoneSeller = UILabel()
        phoneSeller.textColor = .black
        phoneSeller.numberOfLines = 0
        phoneSeller.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(phoneSeller)
        
        
        buyer = UILabel()
        buyer.textColor = .black
        buyer.numberOfLines = 0
        buyer.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(buyer)
        
        
        phoneBuyer = UILabel()
        phoneBuyer.textColor = .black
        phoneBuyer.numberOfLines = 0
        phoneBuyer.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(phoneBuyer)
        
        productName = UILabel()
        productName.textColor = .black
        productName.numberOfLines = 0
        productName.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(productName)
        
        date = UILabel()
        date.textColor = .black
        date.numberOfLines = 0
        date.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(date)
        
        
        Status = UILabel()
        Status.textColor = UIColor(netHex:0x00955E)
        Status.numberOfLines = 0
        Status.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(Status)
        
        
        viewImage = UILabel()
        viewImage.textColor = .blue
        viewImage.numberOfLines = 0
        viewImage.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(viewImage)
        
        
    }
    var so1:HeaderCompleteRP?
    func setup(so:HeaderCompleteRP){
        so1 = so
        
        imei.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width -  Common.Size(s:10),height: Common.Size(s:16))
        imei.text = "Imei: \(so.IMEI)"
        imei.textAlignment = .left
        
        
        date.frame = CGRect(x: Common.Size(s:10),y:  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width -  Common.Size(s:20),height: Common.Size(s:16))
        date.text = "\(so.Ngay)"
        date.textAlignment = .right
        
        
        
        seller.frame = CGRect(x: Common.Size(s:10),y:imei.frame.size.height + imei.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        seller.text = "Người bán: \(so.Sale_Name)"
        seller.textAlignment = .left
        
        
        
        phoneSeller.frame = CGRect(x: Common.Size(s:10),y:seller.frame.size.height + seller.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        phoneSeller.text = "SĐT người bán: \(so.Sale_phone)"
        phoneSeller.textAlignment = .left
        
        buyer.frame = CGRect(x: Common.Size(s:10),y:phoneSeller.frame.size.height + phoneSeller.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        buyer.text = "Người mua: \(so.Buy_Name)"
        buyer.textAlignment = .left
        
        
        
        phoneBuyer.frame = CGRect(x: Common.Size(s:10),y:buyer.frame.size.height + buyer.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        phoneBuyer.text = "SĐT người mua: \(so.Buy_phone)"
        phoneBuyer.textAlignment = .left
        
        productName.frame = CGRect(x: Common.Size(s: 10),y:phoneBuyer.frame.size.height + phoneBuyer.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        productName.text = "Tên sản phẩm: \(so.ItemName)"
        productName.textAlignment = .left
        
        let productNameTextHeight:CGFloat = Status.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : Status.optimalHeight
        productName.numberOfLines = 0
        productName.frame = CGRect(x: productName.frame.origin.x, y: productName.frame.origin.y, width: productName.frame.width, height: productNameTextHeight)
        
        
        
        price.frame = CGRect(x: Common.Size(s:10),y:productName.frame.size.height + productName.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:140) ,height: Common.Size(s:16))
        price.text = "Giá: \(Common.convertCurrencyFloat(value: so.Sale_price))"
        
        
        
        
        
        
        Status.frame = CGRect(x: Common.Size(s:10),y:price.frame.size.height + price.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        Status.text = "Trạng thái: \(so.TrangThai)"
        Status.textAlignment = .left
        
        
        let StatusTextHeight:CGFloat = Status.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : Status.optimalHeight
        Status.numberOfLines = 0
        Status.frame = CGRect(x: Status.frame.origin.x, y: Status.frame.origin.y, width: Status.frame.width, height: StatusTextHeight)
        
        viewImage.frame = CGRect(x: Common.Size(s: 10),y:Status.frame.size.height + Status.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 30),height: Common.Size(s:16))
        viewImage.text = "Xem chi tiết"
        viewImage.textAlignment = .right
        
        let tapClick = UITapGestureRecognizer(target: self, action: #selector(ItemRPCompleteTableViewCell.tabClick))
        viewImage.isUserInteractionEnabled = true
        viewImage.addGestureRecognizer(tapClick)
        
        
        self.estimateCellHeight = viewImage.frame.origin.y + viewImage.frame.height + Common.Size(s: 15)
        
        
        
        
    }
    @objc func tabClick(){
        
        delegate!.tabClickViewComplete(headerCompleteRP: so1!)
        
        
    }
}
protocol ItemSearchRPOnProgressTableViewCellDelegate {
    
    func tabClickView(itemRPOnProgress:ItemRPOnProgress)
}
class ItemSearchRPOnProgressTableViewCell: UITableViewCell {
    var imei:UILabel!
    var price:UILabel!
    var seller:UILabel!
    var phoneSeller:UILabel!
    var buyer:UILabel!
    var phoneBuyer:UILabel!
    var productName:UILabel!
    var date:UILabel!
    var Status:UILabel!
    var viewImage:UILabel!
    var estimateCellHeight: CGFloat = 0
    var delegate: ItemSearchRPOnProgressTableViewCellDelegate?
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        imei = UILabel()
        imei.textColor = UIColor(netHex:0x00955E)
        imei.numberOfLines = 0
        imei.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(imei)
        
        price = UILabel()
        price.textColor = .black
        price.numberOfLines = 0
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        contentView.addSubview(price)
        
        
        seller = UILabel()
        seller.textColor = .black
        seller.numberOfLines = 0
        seller.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(seller)
        
        phoneSeller = UILabel()
        phoneSeller.textColor = .black
        phoneSeller.numberOfLines = 0
        phoneSeller.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(phoneSeller)
        
        
        buyer = UILabel()
        buyer.textColor = .black
        buyer.numberOfLines = 0
        buyer.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(buyer)
        
        
        phoneBuyer = UILabel()
        phoneBuyer.textColor = .black
        phoneBuyer.numberOfLines = 0
        phoneBuyer.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(phoneBuyer)
        
        productName = UILabel()
        productName.textColor = .black
        productName.numberOfLines = 0
        productName.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(productName)
        
        date = UILabel()
        date.textColor = .black
        date.numberOfLines = 0
        date.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(date)
        
        
        Status = UILabel()
        Status.textColor = UIColor(netHex:0x00955E)
        Status.numberOfLines = 0
        Status.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(Status)
        
        viewImage = UILabel()
        viewImage.textColor = .blue
        viewImage.numberOfLines = 0
        viewImage.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(viewImage)
        
    }
    var so1:ItemRPOnProgress?
    func setup(so:ItemRPOnProgress){
        so1 = so
        
        imei.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:30) ,height: Common.Size(s:16))
        imei.text = "Imei: \(so.imei)"
        imei.textAlignment = .left
        
        
        
        date.frame = CGRect(x: Common.Size(s:10),y:Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:30) ,height: Common.Size(s:16))
        date.text = "\(so.date)"
        date.textAlignment = .right
        
        
        
        seller.frame = CGRect(x: Common.Size(s:10),y:imei.frame.size.height + imei.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        seller.text = "Người bán: \(so.seller)"
        seller.textAlignment = .left
        
        
        
        phoneSeller.frame = CGRect(x: Common.Size(s:10),y:seller.frame.size.height + seller.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        phoneSeller.text = "SĐT người bán: \(so.phoneSeller)"
        phoneSeller.textAlignment = .left
        
        
        
        productName.frame = CGRect(x: Common.Size(s: 10),y:phoneSeller.frame.size.height + phoneSeller.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        productName.text = "Tên sản phẩm: \(so.nameProduct)"
        productName.textAlignment = .left
        
        let productNameTextHeight:CGFloat = Status.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : Status.optimalHeight
        productName.numberOfLines = 0
        productName.frame = CGRect(x: productName.frame.origin.x, y: productName.frame.origin.y, width: productName.frame.width, height: productNameTextHeight)
        
        
        price.frame = CGRect(x: Common.Size(s:10),y:productName.frame.size.height + productName.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:140) ,height: Common.Size(s:16))
        price.text = "Giá: \(Common.convertCurrency(value: so.price))"
        price.textColor = .black
        
        
        Status.frame = CGRect(x: Common.Size(s:10),y:price.frame.size.height + price.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        Status.text = "Trạng thái: \(so.trangthai)"
        Status.textAlignment = .left
        
        
        let StatusTextHeight:CGFloat = Status.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : Status.optimalHeight
        Status.numberOfLines = 0
        Status.frame = CGRect(x: Status.frame.origin.x, y: Status.frame.origin.y, width: Status.frame.width, height: StatusTextHeight)
        
        
        
        viewImage.frame = CGRect(x: Common.Size(s: 10),y:Status.frame.size.height + Status.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 30),height: 0)
        viewImage.text = "Xem chi tiết"
        viewImage.textAlignment = .right
        
        let tapClick = UITapGestureRecognizer(target: self, action: #selector(ItemRPCompleteTableViewCell.tabClick))
        viewImage.isUserInteractionEnabled = true
        viewImage.addGestureRecognizer(tapClick)
        if( so.Status == "O" ){
            viewImage.frame.size.height = Common.Size(s:16)
        }
        if(so.Status == "D"){
            viewImage.frame.size.height = Common.Size(s:16)
        }
        if(so.Status == "P"){
            viewImage.frame.size.height = Common.Size(s:16)
        }
        
        self.estimateCellHeight = viewImage.frame.origin.y + viewImage.frame.height + Common.Size(s: 15)
        
        
    }
    @objc func tabClick(){
        
        delegate!.tabClickView(itemRPOnProgress: so1!)
        
        
    }
}
