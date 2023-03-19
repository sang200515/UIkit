//
//  LichSuGiaoDichGrabViewController.swift
//  fptshop
//
//  Created by tan on 5/13/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class LichSuGiaoDichGrabViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    

    var scrollView:UIView!
    var viewTableLichSu:UITableView  =   UITableView()
    
    var listPhieuGiaoDich:[HistoryGrab] = []
    override func viewDidLoad() {
        self.title = "Lịch sử giao dịch"
        scrollView  = UIView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - 44-(UIApplication.shared.statusBarFrame.height + 0.0)))
        self.view.addSubview(scrollView)
        
        self.getLichSu()
        
    }
    
    
    func setupUI(list: [HistoryGrab]){
        let _:CGFloat = UIScreen.main.bounds.size.width
        
        
        viewTableLichSu.frame = CGRect(x: 0, y:0, width: scrollView.frame.size.width, height: scrollView.frame.size.height )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTableLichSu.dataSource = self
        viewTableLichSu.delegate = self
        viewTableLichSu.register(ItemLichSuGrabTableViewCell.self, forCellReuseIdentifier: "ItemLichSuGrabTableViewCell")
        viewTableLichSu.tableFooterView = UIView()
        viewTableLichSu.backgroundColor = UIColor.white
        
        
        scrollView.addSubview(viewTableLichSu)
        //navigationController?.navigationBar.isTranslucent = false
        
        
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTableLichSu.frame.origin.y + viewTableLichSu.frame.size.height + Common.Size(s: 20) + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPhieuGiaoDich.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemLichSuGrabTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemLichSuGrabTableViewCell")
        let item:HistoryGrab = self.listPhieuGiaoDich[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:100);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let item:HistoryGrab = self.listPhieuGiaoDich[indexPath.row]
        let newViewController = PhieuGiaoDichGrabViewController()
        newViewController.phone = item.customerPhone
        newViewController.tenKH = item.customerName
        newViewController.ngaygiaodich = item.NgayHoanTat
        newViewController.soMpos = "\(item.Docentry)"
        newViewController.soPhieu = item.systemTrace
        newViewController.mapayoo = item.MaGD_NCC
        newViewController.tinhtrang = item.TinhTrangThuTien
        newViewController.tongtien = "\(item.moneyAmount)"
        newViewController.hinhthuctt = item.Hinhthucthanhtoan
        newViewController.mafrt = item.systemTrace
         newViewController.maKH = "\(item.customerId)"
        newViewController.biensoxe = "\(item.addingInput)"
          newViewController.isNapTien = false
        newViewController.nv = item.NV
        newViewController.maVoucher = "\(item.U_Voucher)"

       
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }
    
    func getLichSu(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy lịch sử giao dịch..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.PayOfflineBillBEHistory_Grab() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                
                if(err.count <= 0){
                    self.listPhieuGiaoDich.removeAll()
                    self.listPhieuGiaoDich = results
                    self.setupUI(list: self.listPhieuGiaoDich)
                    self.viewTableLichSu.reloadData()
             
                    
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
}
class ItemLichSuGrabTableViewCell: UITableViewCell {
    var sothuebao: UILabel!
    
    var tenkh: UILabel!
    var ngaygiaodich: UILabel!
    
    var nguoigiaodich:UILabel!
    var cuahang:UILabel!
    var sompos:UILabel!
    var sophieu:UILabel!
    var magiaodich:UILabel!
    var user:UILabel!
    
    var hinhthuc:UILabel!
    var tinhtrang:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        sothuebao = UILabel()
        sothuebao.textColor = UIColor(netHex:0x47B054)
        sothuebao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        sothuebao.numberOfLines = 1
        contentView.addSubview(sothuebao)
        
        
  
        
        
        
        ngaygiaodich = UILabel()
        ngaygiaodich.textColor = UIColor.black
        ngaygiaodich.numberOfLines = 1
        ngaygiaodich.font = ngaygiaodich.font.withSize(12)
        contentView.addSubview(ngaygiaodich)
        
        
        
        nguoigiaodich = UILabel()
        nguoigiaodich.textColor = UIColor.black
        nguoigiaodich.font = nguoigiaodich.font.withSize(12)
        nguoigiaodich.numberOfLines = 1
        contentView.addSubview(nguoigiaodich)
        
        cuahang = UILabel()
        cuahang.textColor = UIColor.red
        cuahang.font = cuahang.font.withSize(12)
        cuahang.numberOfLines = 1
        contentView.addSubview(cuahang)
        
        
        sompos = UILabel()
        sompos.textColor = UIColor.red
        sompos.font = sompos.font.withSize(12)
        sompos.numberOfLines = 1
        contentView.addSubview(sompos)
        
        sophieu = UILabel()
        sophieu.textColor = UIColor.red
        sophieu.font = sophieu.font.withSize(12)
        sophieu.numberOfLines = 1
        contentView.addSubview(sophieu)
        
        hinhthuc = UILabel()
        hinhthuc.textColor = UIColor.init(netHex: 0x339999)
        hinhthuc.font =  UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        hinhthuc.numberOfLines = 1
        contentView.addSubview(hinhthuc)
        
        tinhtrang = UILabel()
        tinhtrang.textColor = UIColor.init(netHex: 0x339999)
        tinhtrang.font =  UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        tinhtrang.numberOfLines = 1
        contentView.addSubview(tinhtrang)
 
        
    }
    var so1:HistoryGrab?
    func setup(so:HistoryGrab){
        so1 = so
        
        sothuebao.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width:  Common.Size(s: 200) ,height: Common.Size(s:16))
        sothuebao.text = "\(so.customerPhone)"
        
        ngaygiaodich.frame = CGRect(x: sothuebao.frame.size.width + sothuebao.frame.origin.x + Common.Size(s: 10) ,y:  Common.Size(s:10) ,width:  Common.Size(s: 105) ,height: Common.Size(s:16))
        ngaygiaodich.text = "\(so.NgayHoanTat)"
        
        sompos.frame = CGRect(x:  Common.Size(s:10),y: sothuebao.frame.origin.y + sothuebao.frame.size.height + Common.Size(s: 10) ,width:  Common.Size(s: 200) ,height: Common.Size(s:16))
        sompos.text = "Số MPOS: \(so.Docentry)"
   
        
        sophieu.frame = CGRect(x: sompos.frame.origin.x + sompos.frame.size.width + Common.Size(s:10),y: sompos.frame.origin.y ,width: Common.Size(s: 100) ,height: Common.Size(s:16))
        sophieu.text = "Số Phiếu: \(so.systemTrace)"
        
        hinhthuc.frame = CGRect(x:  Common.Size(s:8),y: sompos.frame.origin.y + sompos.frame.size.height + Common.Size(s: 10) ,width:  Common.Size(s: 180) ,height: Common.Size(s:16))
        hinhthuc.text = " Hình thức: \(so.Hinhthucthanhtoan)"
   
        
        tinhtrang.frame = CGRect(x: hinhthuc.frame.origin.x + hinhthuc.frame.size.width ,y: sompos.frame.origin.y + sompos.frame.size.height + Common.Size(s: 10) ,width:  Common.Size(s: 300) ,height: Common.Size(s:16))
        tinhtrang.text = "Tình trạng: \(so.TrangThai)"
    
        
    }
    
    
}
