//
//  ChooseTypeCardRightPhoneViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
protocol ChooseBankRightPhoneViewControllerDelegate: NSObjectProtocol {
    func returnService(item:BankRP)
}
class ChooseBankRightPhoneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var delegate:ChooseBankRightPhoneViewControllerDelegate?
    var barClose : UIBarButtonItem!
    
    var tableView: UITableView = UITableView()
    var items: [BankRP] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCandies = [BankRP]()
    
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    var ind:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Chọn ngân hàng"
        self.navigationController?.navigationBar.isTranslucent = false
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(ChooseBankRightPhoneViewController.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemLoaiTheCellRPView.self, forCellReuseIdentifier: "ItemLoaiTheCellRPView")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        self.view.addSubview(tableView)
        
        
        MPOSAPIManager.mpos_FRT_SP_SK_nganhang() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                self.items = results
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    @objc func actionClose(){
        //        self.dismiss(animated: false, completion: nil)
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = ItemLoaiTheCellRPView(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemLoaiTheCellRPView")
        let item:BankRP = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let item:BankRP = items[indexPath.row]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.navigationController?.popViewController(animated: false)
            self.dismiss(animated: false, completion: nil)
        }
        
        
        delegate?.returnService(item:item)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:40);
    }
}


class ItemLoaiTheCellRPView: UITableViewCell {
    var type: UILabel!
    var name: UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(name)
        
    }
    
    func setup(so:BankRP){
        name.frame = CGRect(x: Common.Size(s:10),y: 0 ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:40))
        name.text = "\(so.name)"
    }
}
