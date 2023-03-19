//
//  MPOSNotificationViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/27/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class MPOSNotificationViewController:UIViewController ,UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView = UITableView()
    var items: [NotificationObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Thông báo"
        UIApplication.shared.applicationIconBadgeNumber = 0
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(MPOSNotificationViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height -  (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemGiftTableViewCell.self, forCellReuseIdentifier: "ItemGiftTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        
        APIManager.sp_mpos_FRT_SP_GetNotify_oneapp { (results, err) in
            self.items = results
            if(self.items.count <= 0){
                TableViewHelper.EmptyMessage(message: "Không có thông báo.\n:/", viewController: self.tableView)
            }else{
                TableViewHelper.removeEmptyMessage(viewController: self.tableView)
            }
            self.tableView.reloadData()
        }
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemGiftTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemGiftTableViewCell")
        let item:NotificationObject = items[indexPath.row]
        if(item.is_level == 1){
            cell.avatar.image = #imageLiteral(resourceName: "Notification-1")
        }else if(item.is_level == 2){
            cell.avatar.image = #imageLiteral(resourceName: "Notification-2")
        }else if(item.is_level == 3){
            cell.avatar.image = #imageLiteral(resourceName: "Notification-3")
        }
        cell.quanlityChange.text = ""
        let fullNameArr = item.Createdate.components(separatedBy: ".")
        if(fullNameArr.count > 0){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from: "\(fullNameArr[0])")
            if date != nil {
                cell.quanlityChange.text = "\(date!.timeAgoDisplay())"
            }
         
        }
        cell.title.text = item.Title
       
        cell.quanlity.text = item.NoiDung
        
        if(item.is_read == 1){
            cell.title.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            cell.quanlity.textColor = .gray
        }else{
            cell.title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            cell.quanlity.textColor = .black
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            let item:NotificationObject = items[indexPath.row]
            APIManager.sp_mpos_FRT_SP_delete_notify(IDNotify: "\(item.ID)") { (result, err) in
                if(result == 1){
                    tableView.beginUpdates()
                    self.items.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .none)
                    tableView.endUpdates()
                    tableView.reloadData()
                }else{
                    let popup = PopupDialog(title: "THÔNG BÁO", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:NotificationObject = items[indexPath.row]
        APIManager.sp_mpos_FRT_SP_notify_update(IDNotify: "\(item.ID)", type: "1", handler: { (result, err) in
            tableView.beginUpdates()
            self.items[indexPath.row].is_read = 1
            tableView.endUpdates()
            tableView.reloadData()
        })
        if item.URL != "" {
            if let url = URL(string: item.URL) {
                UIApplication.shared.open(url)
            }
            return
        }
        if(item.System_Name == "Inside"){
//             self.navigationController?.popViewController(animated: true)
            let tabInside = TabInsideViewController()
            self.navigationController?.pushViewController(tabInside, animated: true)
            let nc = NotificationCenter.default
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                let myDict = ["INSIDE_URL": item.URL]
                nc.post(name: Notification.Name("showTabInside"), object: myDict)
            }
        }else if(item.System_Name == "CallLog"){
            if(item.CallLog_ReqId > 0 && item.CallLog_TypeId == 1){
                let vc = CallLogErrorMessageViewController()
                vc.CallLog_ReqId =  item.CallLog_ReqId
                vc.titleCallLog = item.Title
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if(item.System_Name == "Camera"){
            let vc = CameraNotifyViewController()
            vc.CallLog_ReqId =  item.CallLog_ReqId
            vc.titleCallLog = item.Title
            vc.noiDung = item.NoiDung
            self.navigationController?.pushViewController(vc, animated: true)

        }else if(item.System_Name.contains("ASM")){
            let vc = KhaiThacComboHomQuaViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if(item.System_Name == "Mirae"){
            let vc = TabLichSuViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if(item.System_Name == "CMS"){
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                let newViewController = NewsDetailViewController()
                newViewController.newsID = item.URL
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        
    }
}
class ItemGiftTableViewCell: UITableViewCell {
    
    var avatar = UIImageView()
    var quanlityChange = UILabel()
    var title = UILabel()
    var quanlity = UILabel()
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor,
                                        constant: -10).isActive = true
        avatar.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        avatar.contentMode = .scaleAspectFit
        
        contentView.addSubview(quanlityChange)
        quanlityChange.translatesAutoresizingMaskIntoConstraints = false
        quanlityChange.widthAnchor.constraint(equalToConstant: Common.Size(s: 60)).isActive = true
        quanlityChange.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        quanlityChange.topAnchor.constraint(equalTo: avatar.topAnchor).isActive = true
        quanlityChange.numberOfLines = 0
        quanlityChange.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        quanlityChange.textColor = .gray
        quanlityChange.textAlignment = .right
        
        // configure titleLabel
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: avatar.trailingAnchor,constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        title.numberOfLines = 0
        title.textColor =  .black
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        
        // configure authorLabel
        contentView.addSubview(quanlity)
        quanlity.translatesAutoresizingMaskIntoConstraints = false
        quanlity.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        quanlity.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        quanlity.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        quanlity.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        quanlity.numberOfLines = 0
        quanlity.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        quanlity.textColor = .gray
        
    }
}
