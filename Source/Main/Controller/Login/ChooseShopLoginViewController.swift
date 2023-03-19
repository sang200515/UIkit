//
//  ChooseShopLoginViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/9/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class ChooseShopLoginViewController: UIViewController {
    
    var listShopLogin:[ShopLogin] = []
    var cellHeight:CGFloat = 0
    var user:User?
    var password:String?
    var codeCRM:String?
    var tableViewChooseShop: UITableView = UITableView()
    var is_getaway:Int?
    override func viewDidLoad() {
        self.title = "Chọn Shop Đăng Nhập"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.navigationController?.navigationBar.isTranslucent = false
        //self.navigationItem.setHidesBackButton(true, animated:true)
        
        let lbTitle = UILabel(frame: CGRect(x: 0, y: Common.Size(s:10), width: view.frame.size.width , height: Common.Size(s:20)))
        lbTitle.textAlignment = .center
        lbTitle.textColor = UIColor.red
        lbTitle.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbTitle.text = "Chọn Shop đăng nhập"
        view.addSubview(lbTitle)
        
        
        
        tableViewChooseShop.frame = CGRect(x: Common.Size(s:10), y: lbTitle.frame.size.height + lbTitle.frame.origin.y + Common.Size(s:10), width: self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s:10))
        tableViewChooseShop.dataSource = self
        tableViewChooseShop.delegate = self
        tableViewChooseShop.register(ItemShopLoginChooseTableViewCell.self, forCellReuseIdentifier: "ItemShopLoginChooseTableViewCell")
        tableViewChooseShop.tableFooterView = UIView()
        tableViewChooseShop.backgroundColor = UIColor.white
        view.addSubview(tableViewChooseShop)
        self.loadShopLogin()
        
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    func loadShopLogin(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        APIManager.mpos_FRT_SP_authen_get_list_shop_by_user(UserID: "\(user!.UserName)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
      
                if(err.count <= 0){
                    self.listShopLogin.removeAll()
                    self.listShopLogin = results
                    self.tableViewChooseShop.reloadData()
                
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    func goToMain(){
        let mainViewController = MainViewController()
        //        let mainView = UINavigationController(rootViewController: mainViewController)
        UIApplication.shared.keyWindow?.rootViewController = mainViewController
    }
}

extension ChooseShopLoginViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listShopLogin.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemShopLoginChooseTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemShopLoginChooseTableViewCell")
        let item:ShopLogin = listShopLogin[indexPath.row]
        cell.setup(so: item,indexNum: indexPath.row)
        cell.selectionStyle = .none
       
        self.cellHeight = cell.estimateCellHeight
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
     }

     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:ShopLogin = listShopLogin[indexPath.row]
        user?.ShopName = item.ShopName
        user?.ShopCode = item.ShopCode
        if(is_getaway == 0){
       
            let defaults = UserDefaults.standard
            defaults.set(user!.UserName, forKey: "Username")
            defaults.set(user!.UserName, forKey: "Username_Login")
            defaults.set(password!, forKey: "password")
            defaults.set(codeCRM!, forKey: "CRMCode")
            defaults.set(Cache.is_getaway, forKey: "is_getaway")
            defaults.synchronize()
            Cache.user = user!
            
            APIManager.registerDeviceToken()
            self.goToMain()
        }else{
            let defaults = UserDefaults.standard
            defaults.set(user!.UserName, forKey: "Username")
            defaults.set(user!.UserName, forKey: "Username_Login")
            defaults.set(password, forKey: "password")
            defaults.set("654321", forKey: "CRMCode")
            defaults.set(Cache.is_getaway, forKey: "is_getaway")
            defaults.synchronize()
            //
            APIManager.registerDeviceToken()
            self.goToMain()
        }
       
    }
}
class ItemShopLoginChooseTableViewCell:UITableViewCell{
    var lblNameShop:UILabel!
    var lblIndex:UILabel!
    var indexNum:Int = 0
    var estimateCellHeight: CGFloat = 0
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        
        lblIndex = UILabel()
        lblIndex.textColor = UIColor.black
        lblIndex.numberOfLines = 0
        lblIndex.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(lblIndex)
        
        
        lblNameShop = UILabel()
        lblNameShop.textColor = UIColor.black
        lblNameShop.numberOfLines = 0
        lblNameShop.textAlignment = .left
        lblNameShop.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(lblNameShop)
        
    
        
        
        
        
    }
    var so1:ShopLogin?
    func setup(so:ShopLogin,indexNum:Int){
        so1 = so
        self.indexNum = indexNum
        lblIndex.frame = CGRect(x: 0,y: Common.Size(s:10) , width: Common.Size(s: 20), height: Common.Size(s:15))
        lblIndex.text = "\(indexNum + 1)."
        
        lblNameShop.frame = CGRect(x:lblIndex.frame.size.width + lblIndex.frame.origin.x + Common.Size(s:10),y: Common.Size(s:10) , width: UIScreen.main.bounds.size.width, height: Common.Size(s:15))
        lblNameShop.text = "\(so.ShopName)"
        
        self.estimateCellHeight = lblNameShop.frame.origin.y + lblNameShop.frame.height + Common.Size(s: 15)

        
    }
}
