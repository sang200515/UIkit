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
class HoSoCanXuLyMiraaViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView  =   UITableView()
    var items: [HistoryOrderByUser] = []
    var listTemp:[HistoryOrderByUser] = []
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!

    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HS cần xử lý"
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
     
        
        
        
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
        MPOSAPIManager.mpos_FRT_SP_mirae_history_order_byuser_HD_pending(handler: { (results, err) in
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
    func setupUI(list: [HistoryOrderByUser]){
        tableView.frame = CGRect(x: 0, y:0, width: loadingView.frame.size.width, height: self.view.frame.size.height )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemHSXLHistoryMiraeTableViewCell.self, forCellReuseIdentifier: "ItemHSXLHistoryMiraeTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        loadingView.addSubview(tableView)
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //        Cache.indexRow = -1
        let item:HistoryOrderByUser = items[indexPath.row]
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_mirae_history_order_byID(IDMPOS: "\(item.Docentry)") { [weak self](header,sodetail, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    var listLineProduct:[LineProductMirae] = []
                    var listLinePromotion:[LinePromotionMirae] = []
                    if(sodetail.count > 0){
                        for item in sodetail{
                            if(item.U_PROMOS == "Y"){
                                let promotion = LinePromotionMirae(Quantity:item.Quantity
                                    , Price:item.Price
                                    , Quantity1: 0
                                    , Dscription:item.Dscription
                                    , U_Imei:item.U_Imei
                                    , ItemCode:item.ItemCode
                                    , U_PROMOS:item.U_PROMOS)
                                listLinePromotion.append(promotion)
                            }else{
                                let product = LineProductMirae(Quantity:item.Quantity
                                    , Price:Float(item.Price)
                                    , Quantity1: 0
                                    , Dscription:item.Dscription
                                    , U_Imei:item.U_Imei
                                    , ItemCode:item.ItemCode
                                    , U_PROMOS:item.U_PROMOS)
                                listLineProduct.append(product)
                            }
                            
                        }
                    }
                    
                    let newViewController2 = DetailSOMiraeViewController()
                    newViewController2.lineProductMirae = listLineProduct
                    newViewController2.linePromotionMirae = listLinePromotion
                    newViewController2.historyMirae = header[0]
                    newViewController2.historyUser = item
                    self.navigationController?.pushViewController(newViewController2, animated: true)
                    
                    
                    
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
        let cell = ItemHSXLHistoryMiraeTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemHSXLHistoryMiraeTableViewCell")
        let item:HistoryOrderByUser = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:320);
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
   
}

class ItemHSXLHistoryMiraeTableViewCell: UITableViewCell {
    
    //
    var donhang:UILabel!
    var ngay:UILabel!
    var tenKH:UILabel!
    var cmnd:UILabel!
    var sdt:UILabel!
    var lydo:UILabel!
    var trangthaiDH:UILabel!
    var soHD:UILabel!
    var soPhieu:UILabel!
    var tinhtrang:UILabel!
    var sohopdong:UILabel!
    
    var btHoanTat:UIButton!
    var btHuy:UIButton!
    var callLogImage:UILabel!
    var trangthaiCallLog:UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        donhang = UILabel()
        donhang.textColor = UIColor(netHex:0x00955E)
        donhang.numberOfLines = 0
        donhang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(donhang)
        
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
        
        cmnd = UILabel()
        cmnd.textColor = UIColor.black
        cmnd.numberOfLines = 0
        cmnd.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(cmnd)
        
        sdt = UILabel()
        sdt.textColor = UIColor.black
        sdt.numberOfLines = 0
        sdt.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(sdt)
        
        lydo = UILabel()
        lydo.textColor = UIColor.black
        lydo.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        
        lydo.numberOfLines = 0
        lydo.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lydo.minimumScaleFactor = 0.8
        
        contentView.addSubview(lydo)
        
        trangthaiDH = UILabel()
        trangthaiDH.numberOfLines = 0
        trangthaiDH.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(trangthaiDH)
        
        soHD = UILabel()
        soHD.textColor = UIColor(netHex:0x00955E)
        soHD.numberOfLines = 0
        soHD.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(soHD)
        
        sohopdong = UILabel()
        sohopdong.textColor = UIColor.red
        sohopdong.numberOfLines = 0
        sohopdong.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(sohopdong)
        
        soPhieu = UILabel()
        soPhieu.textColor = UIColor.black
        soPhieu.numberOfLines = 0
        soPhieu.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(soPhieu)
        
        tinhtrang = UILabel()
        tinhtrang.textColor = UIColor.black
        tinhtrang.numberOfLines = 0
        tinhtrang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(tinhtrang)
        
        btHoanTat = UIButton()
        
        btHoanTat.setTitle("Hoàn tất", for: .normal)
        contentView.addSubview(btHoanTat)
        
        btHuy = UIButton()
        // btHuy.text = "Huỷ"
        btHuy.setTitle("Huỷ", for: .normal)
        contentView.addSubview(btHuy)
        
        callLogImage = UILabel()
        callLogImage.textColor = UIColor.black
        callLogImage.numberOfLines = 0
        callLogImage.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(callLogImage)
        
        trangthaiCallLog = UILabel()
        trangthaiCallLog.textColor = UIColor.black
        trangthaiCallLog.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        
        trangthaiCallLog.numberOfLines = 0
        trangthaiCallLog.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        trangthaiCallLog.minimumScaleFactor = 0.8
        
        contentView.addSubview(trangthaiCallLog)
    }
    var so1:HistoryOrderByUser?
    func setup(so:HistoryOrderByUser){
        so1 = so
        
//        donhang.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:140) ,height: Common.Size(s:16))
//        donhang.text = "MPOS \(so.SoMPOS)"
        //idDK.text = "IDDK: \(so.IDDK)"
        
        ngay.frame = CGRect(x:  Common.Size(s:10) , y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        ngay.text = "\(so.Ngay)"
        
        tenKH.frame = CGRect(x: Common.Size(s:10),y: ngay.frame.origin.y + ngay.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        tenKH.text = so.FullName
        
        cmnd.frame = CGRect(x:  Common.Size(s:10),y: tenKH.frame.origin.y + tenKH.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        cmnd.text = "CMND: \(so.IDCard)"
        
        sdt.frame = CGRect(x: Common.Size(s:10),y: cmnd.frame.origin.y + cmnd.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        sdt.text = "SĐT: \(so.PhoneNumber)"
        
        lydo.frame = CGRect(x: Common.Size(s:10),y: sdt.frame.origin.y + sdt.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:48))
        lydo.text = "Lý do từ chối: \(so.reason_cance_messagess)"
        
        lydo.lineBreakMode = .byWordWrapping
        lydo.numberOfLines = 0
        lydo.sizeToFit()
        
//        trangthaiDH.frame = CGRect(x: Common.Size(s:10),y: lydo.frame.origin.y + lydo.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
//        trangthaiDH.text = "Trạng thái ĐH: \(so.TTDH)"
        
//        callLogImage.frame = CGRect(x: Common.Size(s:10),y: lydo.frame.origin.y + lydo.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
//        callLogImage.text = "CallLog hình ảnh: \(so.RequestID)"
//
//        trangthaiCallLog.frame = CGRect(x: Common.Size(s:10),y: callLogImage.frame.origin.y + callLogImage.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:48))
//        trangthaiCallLog.text = "Trạng thái duyệt CallLog: \(so.ApprovedCall)"
//        trangthaiCallLog.lineBreakMode = .byWordWrapping
//            trangthaiCallLog.numberOfLines = 0
//            trangthaiCallLog.sizeToFit()
        
        
        
        soHD.frame = CGRect(x: Common.Size(s:10),y: lydo.frame.origin.y + lydo.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:180) ,height: Common.Size(s:16))
        soHD.text = "Mã xác nhận: \(so.processId_Mirae)"
        

        
        soPhieu.frame = CGRect(x: Common.Size(s:10),y: soHD.frame.origin.y + soHD.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        soPhieu.text = "Phiếu ĐK MPOS: \(so.Docentry)"
        
        sohopdong.frame = CGRect(x: Common.Size(s:10),y: soPhieu.frame.origin.y + soPhieu.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        sohopdong.text = "Số hợp đồng: \(so.ContractNumber)"
        
        tinhtrang.frame = CGRect(x: Common.Size(s:10),y: sohopdong.frame.origin.y + sohopdong.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
//        tinhtrang.text = so.TTHS
//        if (so.TTHS == "Đã gửi sang mirae") {
//            tinhtrang.textColor = UIColor.init(netHex: 0x5a9bec)
//        }
//        if (so.TTHS == "Đã duyệt") {
//            tinhtrang.textColor = UIColor.init(netHex: 0x1ea165)
//        }
//        if (so.TTHS == "Đã hủy") {
//            tinhtrang.textColor = UIColor.init(netHex: 0xff0000)
//        }
        
        btHoanTat.frame = CGRect(x: tinhtrang.frame.origin.x + tinhtrang.frame.size.width + Common.Size(s:10),y: soHD.frame.origin.y + soHD.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        
        
        btHuy.frame = CGRect(x: btHoanTat.frame.origin.x + btHoanTat.frame.size.width + Common.Size(s:10),y: soHD.frame.origin.y + soHD.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        
        
    }
    
    
}
