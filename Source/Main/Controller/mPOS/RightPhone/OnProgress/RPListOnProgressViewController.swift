//
//  RightPhoneCompleteProgressViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/7/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
class RPListOnProgressViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,ItemRPOnProgressTableViewCellDelegate {
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
    
    
    var tableView: UITableView  =   UITableView()
    var items: [ItemRPOnProgress] = []
    var listTemp:[ItemRPOnProgress] = []
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    var cellHeight:CGFloat = 0
    
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    
    let searchController = UISearchController(searchResultsController: nil)
    var isType:String = ""
    
    override func viewDidLoad() {
        
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
        let productNotFound = "Đang load danh sách..."
        let lbNotFound = UILabel(frame: CGRect(x: 0, y: loading.frame.origin.y + loading.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width, height: Common.Size(s:22)))
        lbNotFound.textAlignment = .center
        lbNotFound.textColor = UIColor.lightGray
        lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        lbNotFound.text = productNotFound
        loadingView.addSubview(lbNotFound)
        MPOSAPIManager.mpos_FRT_SP_SK_load_header(keysearch: "", handler: { (results, err) in
            if(results.count > 0){
                self.loading.stopAnimating()
                lbNotFound.isHidden = true
                self.items = []
                for item in results{
                    if(item.Status == "P" ||  item.Status == "O" || item.Status == "D" || item.Status == "N" || item.Status == "U"){
                        self.items.append(item)
                    }
                }
                
                self.listTemp = self.items
                
                self.setupUI(list: results)
            }else{
                lbNotFound.text = "Không tìm thấy dữ liệu!"
                logo.isHidden = false
                lbNotFound.isHidden = false
                self.loading.stopAnimating()
            }
        })
        
    }
    func setupUI(list: [ItemRPOnProgress]){
        tableView.frame = CGRect(x: 0, y:0, width: loadingView.frame.size.width, height: self.view.frame.size.height )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemRPOnProgressTableViewCell.self, forCellReuseIdentifier: "ItemRPOnProgressTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        loadingView.addSubview(tableView)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let item:ItemRPOnProgress = items[indexPath.row]
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
                        }else{
                            let newViewController = DepositPaymentRPViewController()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemRPOnProgressTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemRPOnProgressTableViewCell")
        let item:ItemRPOnProgress = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        self.cellHeight = cell.estimateCellHeight
              cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
protocol ItemRPOnProgressTableViewCellDelegate {
    
    func tabClickView(itemRPOnProgress:ItemRPOnProgress)
}
class ItemRPOnProgressTableViewCell: UITableViewCell {
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
    var lbMposNumber:UILabel!
    
    var estimateCellHeight: CGFloat = 0
    var delegate: ItemRPOnProgressTableViewCellDelegate?
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        lbMposNumber = UILabel()
        lbMposNumber.textColor = UIColor(netHex:0x00955E)
        lbMposNumber.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(lbMposNumber)
        
        imei = UILabel()
        imei.textColor = UIColor.black
        imei.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
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
        
        //add  lbMposNumber
        lbMposNumber.frame = CGRect(x: Common.Size(s:10),y:Common.Size(s:10) ,width: (UIScreen.main.bounds.size.width - Common.Size(s:20)) * 2/5,height: Common.Size(s:20))
        lbMposNumber.text = "Số Mpos: \(so.docentry)"
        lbMposNumber.textAlignment = .left
        //-------------
        
        imei.frame = CGRect(x: lbMposNumber.frame.origin.x + lbMposNumber.frame.width,y: lbMposNumber.frame.origin.y ,width: (UIScreen.main.bounds.size.width - Common.Size(s:20)) * 3/5, height: Common.Size(s:20))
        imei.text = "Imei: \(so.imei)"
        imei.textAlignment = .right
        
        date.frame = CGRect(x: Common.Size(s:10),y:imei.frame.size.height + imei.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        date.text = "Ngày tạo: \(so.date)"
        date.textAlignment = .left
        
        seller.frame = CGRect(x: Common.Size(s:10),y:date.frame.size.height + date.frame.origin.y +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
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
        if(so.Status == "U"){
            viewImage.frame.size.height = Common.Size(s:16)
        }
        
        self.estimateCellHeight = viewImage.frame.origin.y + viewImage.frame.height + Common.Size(s: 15)
        
        
    }
    @objc func tabClick(){
        
        delegate!.tabClickView(itemRPOnProgress: so1!)
        
        
    }
}
