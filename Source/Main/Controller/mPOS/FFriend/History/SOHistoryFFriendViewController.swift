//
//  SOHistoryFFriendViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import PopupDialog
class SOHistoryFFriendViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView  =   UITableView()
    var items: [HistoryFFriend] = []
    
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    
    var ocfdFFriend:OCRDFFriend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lịch sử mua hàng"
        self.view.backgroundColor = .white
        
        
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
        MPOSAPIManager.mpos_sp_LichSuMuahang(IDCardCode: "\(self.ocfdFFriend!.IDcardCode)",  handler: {[weak self] (results, err) in
            guard let self = self else {return}
            if(results.count > 0){
                self.loading.stopAnimating()
                lbNotFound.isHidden = true
                self.items = results
                self.setupUI(list: results)
            }else{
                lbNotFound.text = "Không tìm thấy đơn hàng!"
                logo.isHidden = false
                lbNotFound.isHidden = false
                self.loading.stopAnimating()
            }
        })
    }
    func setupUI(list: [HistoryFFriend]){
        tableView.frame = CGRect(x: 0, y:0, width: loadingView.frame.size.width, height: self.view.frame.size.height )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemSOHistoryFFriendTableViewCell.self, forCellReuseIdentifier: "ItemSOHistoryFFriendTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        loadingView.addSubview(tableView)
        navigationController?.navigationBar.isTranslucent = false
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //        Cache.indexRow = -1
        let item:HistoryFFriend = items[indexPath.row]
        if(item.NhomMua == "Y"){
            let newViewController = DetailSOPayDirectlyFFriendViewController()
            newViewController.historyFFriend = item
            newViewController.ocfdFFriend = self.ocfdFFriend!
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            let newViewController = DetailSOFFriendViewController()
            newViewController.historyFFriend = item
            newViewController.ocfdFFriend = self.ocfdFFriend!
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemSOHistoryFFriendTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSOHistoryFFriendTableViewCell")
        let item:HistoryFFriend = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        cell.didTapShowCalllogTT = { url in
            let webView = FFriendWebViewController()
            webView.url = url
            self.navigationController?.pushViewController(webView, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:145);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            let so:HistoryFFriend = self.items[indexPath.row]
            
            // Prepare the popup
            let title = "XOÁ ĐƠN HÀNG"
            let message = "Bạn có chắc xoá đơn hàng IDDK: \(so.IDDK) không?"
            
            // Create the dialog
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            
            // Create first button
            let buttonOne = CancelButton(title: "Huỷ bỏ") {
                
            }
            
            // Create second button
            let buttonTwo = DefaultButton(title: "Xoá") {
                
                MPOSAPIManager.mpos_sp_CancelFormDKSingle_TraGopOnline(IDFormDK: "\(so.IDDK)",UserID: "\(Cache.user!.UserName)", handler: { (result, err) in
                    if(err.count <= 0){
                        let alertController = UIAlertController(title: "THÔNG BÁO", message: "\(result)", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.items.remove(at: indexPath.row)
                            tableView.reloadData()
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    }else{
                        let alertController = UIAlertController(title: "THÔNG BÁO", message: "\(err)", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            tableView.reloadData()
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            }
            
            // Add buttons to dialog
            popup.addButtons([buttonOne, buttonTwo])
            
            // Present dialog
            present(popup, animated: true, completion: nil)
        }
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
}
class ItemSOHistoryFFriendTableViewCell: UITableViewCell {
    var type: UILabel!
    var idDK: UILabel!
    var status: UILabel!
    var total: UILabel!
    var prepay: UILabel!
    var paid: UILabel!
    var moneyLeft: UILabel!
    var addressShop: UILabel!
    var callogID: UILabel!
    var soSO: UILabel!
    
    var didTapShowCalllogTT: ((URL) -> Void)?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        idDK = UILabel()
        idDK.textColor = UIColor.black
        idDK.numberOfLines = 1
        idDK.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        contentView.addSubview(idDK)
        
        type = UILabel()
        type.textColor = UIColor.gray
        type.numberOfLines = 1
        type.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(type)
        
        status = UILabel()
        status.textColor = UIColor.gray
        status.numberOfLines = 1
        status.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(status)
        
        total = UILabel()
        total.textColor = UIColor.gray
        total.numberOfLines = 1
        total.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(total)
        
        prepay = UILabel()
        prepay.textColor = UIColor.gray
        prepay.numberOfLines = 1
        prepay.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(prepay)
        
        status = UILabel()
        status.numberOfLines = 1
        status.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(status)
        
        paid = UILabel()
        paid.textColor = UIColor.gray
        paid.numberOfLines = 1
        paid.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(paid)
        
        moneyLeft = UILabel()
        moneyLeft.textColor = UIColor.black
        moneyLeft.numberOfLines = 1
        moneyLeft.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(moneyLeft)
        
        addressShop = UILabel()
        addressShop.textColor = UIColor.gray
        addressShop.numberOfLines = 1
        addressShop.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(addressShop)
        
        callogID = UILabel()
        callogID.textColor = UIColor.gray
        callogID.numberOfLines = 1
        callogID.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(callogID)
        
        soSO = UILabel()
        soSO.textColor = UIColor.gray
        soSO.numberOfLines = 1
        soSO.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(soSO)
    }
    var so1:HistoryFFriend?
    func setup(so:HistoryFFriend){
        so1 = so
        let lineIDDK = UIView(frame: CGRect(x: Common.Size(s:10), y:Common.Size(s:10), width: 2, height: Common.Size(s:16)))
        lineIDDK.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(lineIDDK)
        
        idDK.frame = CGRect(x: lineIDDK.frame.size.width + lineIDDK.frame.origin.x + Common.Size(s:5),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        idDK.text = "IDDK: \(so.IDDK)"
        
        let lineType = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width*2/3 + Common.Size(s:10), y:lineIDDK.frame.origin.y, width: 2, height: Common.Size(s:16)))
        lineType.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(lineType)
        
        type.frame = CGRect(x:lineType.frame.size.width + lineType.frame.origin.x + Common.Size(s:5) ,y: Common.Size(s:10),width: idDK.frame.size.width ,height: Common.Size(s:16))
        
        if(so.NhomMua == "Y" && so.Is_Credit == false){
            type.text = "Trả thẳng"
        }else if(so.NhomMua == "N" && so.Is_Credit == false){
            type.text = "Trả góp"
        }else if(so.Is_Credit){
            type.text = "Credit"
        }
        
        status.frame = CGRect(x:lineIDDK.frame.origin.x ,y: lineIDDK.frame.origin.y + lineIDDK.frame.size.height +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:13))
        
        status.text = "Trạng thái: \(so.TrangThai)"
        
        let line1 = UIView(frame: CGRect(x: status.frame.origin.x, y:status.frame.origin.y + status.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/2 + Common.Size(s:5), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line2)
        
        let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:line1.frame.origin.y + line1.frame.size.height + Common.Size(s: 5), width: 1, height: Common.Size(s:16)))
        line3.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line3)
        
        let line4 = UIView(frame: CGRect(x: line2.frame.origin.x, y:line2.frame.origin.y + line2.frame.size.height + Common.Size(s: 5), width: 1, height: Common.Size(s:16)))
        line4.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line4)
        
        total.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: UIScreen.main.bounds.size.width/2 - Common.Size(s:10),height:line1.frame.size.height)
        total.text = "Tổng tiền: \(Common.convertCurrencyFloatV2(value: so.ThanhTien))"
        
        prepay.frame = CGRect(x:line2.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: UIScreen.main.bounds.size.width/2 - Common.Size(s:10),height:line1.frame.size.height)
        prepay.text = "Trả trước: \(Common.convertCurrencyFloatV2(value: so.SoTienTraTruoc))"
        
        
        paid.frame = CGRect(x:line3.frame.origin.x + Common.Size(s:5),y: line3.frame.origin.y ,width: UIScreen.main.bounds.size.width/2 - Common.Size(s:10),height:line3.frame.size.height)
        paid.text = "Thanh toán: \(Common.convertCurrencyFloatV2(value: so.SoTienDaThanhToan))"
        
        moneyLeft.frame = CGRect(x:line4.frame.origin.x + Common.Size(s:5),y: line4.frame.origin.y ,width: UIScreen.main.bounds.size.width/2 - Common.Size(s:10),height:line4.frame.size.height)
        moneyLeft.text = "Còn lại: \(Common.convertCurrencyFloatV2(value: so.SoTienConNo))"
        
        addressShop.frame = CGRect(x:line3.frame.origin.x,y: line3.frame.origin.y + line3.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20),height:line3.frame.size.height)
        addressShop.text = "\(so.TenShop)"
        
        //        var statusText: String = ""
        //        if (so.DocStatus == "F"){
        //            statusText = "Hoàn tất"
        if(so.TrangThai == "Đã Hoàn tất"){
            status.textColor = UIColor(netHex:0x4DB748)
        }else{
            status.textColor = UIColor(netHex:0xff0000)
        }
        
        callogID.frame = CGRect(x:line3.frame.origin.x,y: addressShop.frame.origin.y + addressShop.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20),height:line3.frame.size.height)
        callogID.text = "CallLog: \(so.CallogID)"
        
        let tapShowCallogTT = UITapGestureRecognizer(target: self, action: #selector(ItemSOHistoryFFriendTableViewCell.tapShowCallogTT))
        callogID.isUserInteractionEnabled = true
        callogID.addGestureRecognizer(tapShowCallogTT)
        
        soSO.frame = CGRect(x:moneyLeft.frame.origin.x,y: callogID.frame.origin.y,width: UIScreen.main.bounds.size.width - Common.Size(s:20),height:line3.frame.size.height)
        soSO.text = "SO: \(so.SoSO_POS)"
        
        //        }else if (so.DocStatus == "C"){
        //            statusText = "Hủy"
        //            status.textColor = UIColor(netHex:0xff0000)
        //        }else if (so.DocStatus == "D"){
        //            statusText = "Đã thu cọc"
        //            status.textColor = UIColor(netHex:0x0000ff)
        //        }else if (so.DocStatus == "T"){
        //            statusText = "Đã trả hàng"
        //            status.textColor = UIColor(netHex:0xF37022)
        //        }else{
        //            statusText = "Đang xử lý"
        //            status.textColor = UIColor(netHex:0x000000)
        //        }
        
        //        status.frame = CGRect(x:line3.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: idDK.frame.size.width/3,height:line1.frame.size.height)
        //        status.text = "\(statusText)"
    }
    @objc func tapShowCallogTT(){
        if (so1 != nil){
            if("\(so1!.CallogID)" != "" && "\(so1!.CallogID)" != "0"){
                let urlCL = Config.manager.URL_GATEWAY! + "/mpos-cloud-callogoutside/Requests/Details/"
                guard let url = URL(string: "\(urlCL)\(so1!.CallogID)") else {
                    return
                }
                
                self.didTapShowCalllogTT?(url)
            }
        }
        
    }
    
}

