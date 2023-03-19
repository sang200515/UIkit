//
//  ChooseGoiCuocBSV2ViewController.swift
//  mPOS
//
//  Created by tan on 9/19/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ChooseGoiCuocBSV2ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var telecom:ProviderName?
    var scrollView:UIScrollView!
    var listGoiCuoc:[GoiCuocBookSimV2] = []
    var viewTableGoiCuoc:UITableView  =   UITableView()
    var viewGoiCuoc:UIView!
    
    var barSearchRight : UIBarButtonItem!
    var window: UIWindow?
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.blue
        self.title = "\(telecom!.NhaMang)"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(ChooseGoiCuocBSV2ViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        let btSearchIcon = UIButton.init(type: .custom)
        
        btSearchIcon.setImage(#imageLiteral(resourceName: "list"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.addTarget(self, action: #selector(ChooseGoiCuocBSV2ViewController.showListSimByShop), for: UIControl.Event.touchUpInside)
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barSearchRight = UIBarButtonItem(customView: btSearchIcon)
        
        
        
        
        
        self.navigationItem.rightBarButtonItems = [barSearchRight]
        
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
      

        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin gói cước..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getListGoiCuocBookSimV2(NhaMang: "\(telecom!.NhaMang)") { (results,IsLogin,p_Status, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(IsLogin == "1"){
                    let title = "Thông báo"
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                        let defaults = UserDefaults.standard
                        defaults.removeObject(forKey: "UserName")
                        defaults.removeObject(forKey: "Password")
                        defaults.removeObject(forKey: "mDate")
                        defaults.removeObject(forKey: "mCardNumber")
                        defaults.removeObject(forKey: "typePhone")
                        defaults.removeObject(forKey: "mPrice")
                        defaults.removeObject(forKey: "mPriceCardDisplay")
                        defaults.removeObject(forKey: "CRMCodeLogin")
                        defaults.synchronize()
//                        MPOSAPIManager.removeDeviceToken()
                        // Initialize the window
                        self.window = UIWindow.init(frame: UIScreen.main.bounds)
                        
                        // Set Background Color of window
                        self.window?.backgroundColor = UIColor.white
                        
                        // Allocate memory for an instance of the 'MainViewController' class
                        let mainViewController = LoginViewController()
                        
                        // Set the root view controller of the app's window
                        self.window!.rootViewController = mainViewController
                        
                        // Make the window visible
                        self.window!.makeKeyAndVisible()
                        
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
                if(p_Status == "0"){
         
                     self.showDialog(message: err)
                    return
                    
                }
                if(err.count <= 0){
                    self.listGoiCuoc.removeAll()
                    self.listGoiCuoc = results
                    self.loadGoiCuoc()
                    
                }else{
                    self.showDialog(message: err)
                }
            }
        }
        
    }
    func loadGoiCuoc(){
        
        
        // step 1
        let lbTep1 = UILabel(frame: CGRect(x:Common.Size(s:10), y: 0, width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: Common.Size(s:35)))
        lbTep1.textAlignment = .left
        lbTep1.textColor = UIColor(netHex:0x47B054)
        lbTep1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTep1.text = "Vui lòng chọn gói cước"
        scrollView.addSubview(lbTep1)
        
        viewGoiCuoc = UIView(frame: CGRect(x:Common.Size(s: 5),y:lbTep1.frame.origin.y + lbTep1.frame.size.height ,width: scrollView.frame.size.width - Common.Size(s: 20),height: scrollView.frame.size.height))
        //        viewSearchSim.backgroundColor = .yellow
        scrollView.addSubview(viewGoiCuoc)
        
        
        
        viewTableGoiCuoc.frame = CGRect(x: 0, y: 0, width: viewGoiCuoc.frame.size.width, height: Common.Size(s: 800) )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTableGoiCuoc.dataSource = self
        viewTableGoiCuoc.delegate = self
        viewTableGoiCuoc.register(ItemGoiCuocV2TableViewCell.self, forCellReuseIdentifier: "ItemGoiCuocV2TableViewCell")
        viewTableGoiCuoc.tableFooterView = UIView()
        viewTableGoiCuoc.backgroundColor = UIColor.white
        
        viewGoiCuoc.addSubview(viewTableGoiCuoc)
        navigationController?.navigationBar.isTranslucent = false
        
        viewGoiCuoc.frame.size.height = viewTableGoiCuoc.frame.size.height + viewTableGoiCuoc.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewGoiCuoc.frame.origin.y + viewGoiCuoc.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listGoiCuoc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemGoiCuocV2TableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemGoiCuocV2TableViewCell")
        let item:GoiCuocBookSimV2 = self.listGoiCuoc[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        //cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:98);
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:GoiCuocBookSimV2 = self.listGoiCuoc[indexPath.row]
        let newViewController = ChonSoV2ViewController()
        newViewController.telecom = self.telecom
        newViewController.goiCuoc = item
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func showListSimByShop(){
        let newViewController2 = SearchGoiCuocViewController()
        newViewController2.self.telecom = self.telecom
        self.navigationController?.pushViewController(newViewController2, animated: true)
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
        //        let newViewController2 = ChooseTelecomBookSimV2ViewController()
        //
        //        self.navigationController?.pushViewController(newViewController2, animated: true)
    }
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
    
}
class ItemGoiCuocV2TableViewCell: UITableViewCell {
    var tensanpham: UILabel!
    var masanpham: UILabel!
    var gia: UILabel!
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        tensanpham = UILabel()
        tensanpham.textColor = UIColor.black
        
        tensanpham.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        
        tensanpham.numberOfLines = 0
        tensanpham.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        tensanpham.minimumScaleFactor = 0.8
        
        
        contentView.addSubview(tensanpham)
        
        masanpham = UILabel()
        masanpham.textColor = UIColor.black
        masanpham.numberOfLines = 1
        masanpham.font = masanpham.font.withSize(12)
        contentView.addSubview(masanpham)
        
        
        gia = UILabel()
        gia.textColor = UIColor.red
        gia.numberOfLines = 1
        gia.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(gia)
        
        
        
    }
    var so1:GoiCuocBookSimV2?
    func setup(so:GoiCuocBookSimV2){
        so1 = so
        tensanpham.frame = CGRect(x: Common.Size(s:5),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:30))
        tensanpham.text = "\(so.TenSP)"
        
        
        masanpham.frame = CGRect(x:Common.Size(s:5) ,y: tensanpham.frame.origin.y +  tensanpham.frame.size.height + Common.Size(s: 10),width: tensanpham.frame.size.width ,height: Common.Size(s:16))
        masanpham.text = "Mã SP: \(so.MaSP)"
        
        
        gia.frame = CGRect(x:Common.Size(s:5) ,y: masanpham.frame.origin.y +  masanpham.frame.size.height + Common.Size(s: 10),width: tensanpham.frame.size.width ,height: Common.Size(s:16))
        let giacuoc = Common.convertCurrencyV2(value: so.GiaCuoc)
        gia.text = "Giá Cước: \(giacuoc) VNĐ"
        
        
        
    }
    
    
}
