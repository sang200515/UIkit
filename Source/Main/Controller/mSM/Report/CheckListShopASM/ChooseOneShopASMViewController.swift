//
//  ChooseOneShopASMViewController.swift
//  fptshop
//
//  Created by Apple on 8/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol ChooseOneShopASMViewControllerDelegate: AnyObject {
    func getShop(shop: ShopByASM)
}

class ChooseOneShopASMViewController: UIViewController {

    var tableView: UITableView!
    var listShop:[ShopByASM] = []
    weak var delegate: ChooseOneShopASMViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "Shop"
        //        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationItem.hidesBackButton = true
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        backView.addSubview(btBackIcon)
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listShop = mSMApiManager.LoadShopByASM().Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if self.listShop.count > 0 {
                    self.setUpView()
                } else {
                    let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
                    emptyView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
                    self.view.addSubview(emptyView);
                }
            }
        }

    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
       
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
    }
}


extension ChooseOneShopASMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listShop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }
        
        let shop = self.listShop[indexPath.row]
        cell?.textLabel?.text = shop.TenShop
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shop = self.listShop[indexPath.row]
        self.delegate?.getShop(shop: shop)
        self.navigationController?.popViewController(animated: true)
    }
    
}
