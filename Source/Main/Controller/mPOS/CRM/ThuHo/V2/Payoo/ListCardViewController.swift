//
//  ListCardViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/30/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
protocol ListCardViewControllerDelegate: NSObjectProtocol {
    func returnCard(item:CardTypeFromPOSResult,ind:Int)
    func returnClose()
}
class ListCardViewController: UIViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    var delegate:ListCardViewControllerDelegate?
    var tableView: UITableView = UITableView()
    var items: [CardTypeFromPOSResult] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ListCardViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.title = "Kỳ thanh toán"
        self.view.backgroundColor = .white
        
        let note = UILabel(frame: CGRect(x: 10, y: 5, width: self.view.frame.size.width - 20, height: 100))
        note.textColor = UIColor.red
        note.numberOfLines = 0
        note.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        note.text = "Không áp dụng thanh toán đối với những loại thẻ: Visa, Master Card, Amex và tín dụng khác"
        self.view.addSubview(note)
        
        tableView.frame = CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height - 100)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemCardTypeTableViewCell.self, forCellReuseIdentifier: "ItemCardTypeTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        
        MPOSAPIManager.Get_CardType_From_POS { (result, err) in
            self.items = result
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemCardTypeTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemCardTypeTableViewCell")
        let item:CardTypeFromPOSResult = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item:CardTypeFromPOSResult = items[indexPath.row]
        self.navigationController?.popViewController(animated: true)
        delegate?.returnCard(item: item, ind: 0)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:55);
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
        delegate?.returnClose()
    }
}
class ItemCardTypeTableViewCell: UITableViewCell {
    var address: UILabel!
    var name: UILabel!
    var dateCreate: UILabel!
    var numMPOS: UILabel!
    var numPOS: UILabel!
    var status: UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(name)
        
        address = UILabel()
        address.textColor = UIColor.gray
        address.numberOfLines = 1
        address.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(address)
        
    }
    
    func setup(so:CardTypeFromPOSResult){
        
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        name.text = "\(so.Text)"
        
        address.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5),width: name.frame.size.width ,height: Common.Size(s:13))
        address.text = "Phí: \(so.PercentFee)%"
        
    }
    
}

