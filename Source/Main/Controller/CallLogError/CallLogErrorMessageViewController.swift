//
//  CallLogErrorMessageViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/17/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class CallLogErrorMessageViewController: UIViewController ,UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource, UITableViewDelegate{
    var scrollView:UIScrollView!
    var CallLog_ReqId:Int! = 0
    var titleCallLog: String = ""
    
    var tableView: UITableView = UITableView()
    var items: [CallLogErrorMessage] = []
    var viewBoxComment: UIView!
    var tfComment:UITextField!
 let typePaymentView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.title = "TRAO ĐỔI CALLLOG"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(CallLogErrorMessageViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN GỬI"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        let detailView = UIView()
        detailView.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        detailView.backgroundColor = UIColor.white
        scrollView.addSubview(detailView)
        
        let lbTelecom = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: detailView.frame.width/3 - Common.Size(s: 15), height: Common.Size(s: 18)))
        lbTelecom.text = "Mã CallLog:"
        lbTelecom.textColor = UIColor.lightGray
        lbTelecom.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbTelecom)
        
        let lbValueTelecom = UILabel(frame: CGRect(x: lbTelecom.frame.size.width + lbTelecom.frame.origin.x, y: lbTelecom.frame.origin.y, width: detailView.frame.width * 2/3 - Common.Size(s: 15), height: lbTelecom.frame.size.height))
        lbValueTelecom.text = "\(self.CallLog_ReqId!)"
        lbValueTelecom.textColor = UIColor.black
        lbValueTelecom.textAlignment = .left
        lbValueTelecom.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValueTelecom)
        
        let lbPriceCard = UILabel(frame: CGRect(x: lbTelecom.frame.origin.x, y: lbTelecom.frame.origin.y + lbTelecom.frame.size.height + Common.Size(s: 5), width: lbTelecom.frame.size.width, height: lbTelecom.frame.size.height * 2))
        lbPriceCard.text = "Tiêu đề:"
        lbPriceCard.textColor = UIColor.lightGray
        lbPriceCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbPriceCard)
        
        let lbValuePriceCard = UILabel(frame: CGRect(x: lbPriceCard.frame.size.width + lbPriceCard.frame.origin.x, y: lbPriceCard.frame.origin.y, width: lbValueTelecom.frame.size.width, height: lbValueTelecom.frame.size.height * 2))
         lbValuePriceCard.text = "\(titleCallLog)"
        lbValuePriceCard.textColor = UIColor.black
        lbValuePriceCard.textAlignment = .left
        lbValuePriceCard.numberOfLines = 2
        lbValuePriceCard.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        detailView.addSubview(lbValuePriceCard)
        detailView.frame.size.height = lbPriceCard.frame.size.height + lbPriceCard.frame.origin.y + Common.Size(s: 10)
        
        
      
        typePaymentView.frame = CGRect(x: 0, y: detailView.frame.origin.y + detailView.frame.size.height , width: scrollView.frame.size.width, height: 0)
        typePaymentView.backgroundColor = UIColor.clear
        scrollView.addSubview(typePaymentView)
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "NỘI DUNG TRAO ĐỔI"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        typePaymentView.addSubview(label2)
        
        tableView.frame = CGRect(x: 0, y: label2.frame.origin.y + label2.frame.size.height + Common.Size(s:1), width: self.view.frame.width, height: self.view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemMessageTableViewCell.self, forCellReuseIdentifier: "ItemMessageTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        typePaymentView.addSubview(tableView)
        tableView.isScrollEnabled = false
        
        viewBoxComment = UIView(frame: CGRect(x: tableView.frame.origin.x, y: tableView.frame.size.height + tableView.frame.origin.y, width: tableView.frame.size.width, height: Common.Size(s:45)))
        viewBoxComment.backgroundColor = .white
        typePaymentView.addSubview(viewBoxComment)
        
        tfComment = UITextField(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: viewBoxComment.frame.size.width - Common.Size(s:10) , height: Common.Size(s:30)));
        tfComment.placeholder = "Nhập trao đổi"
        tfComment.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfComment.keyboardType = UIKeyboardType.default
        tfComment.layer.cornerRadius = 15
        tfComment.layer.borderColor = UIColor.lightGray.cgColor
        tfComment.layer.borderWidth = 0.5
        tfComment.returnKeyType = UIReturnKeyType.send
        tfComment.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfComment.delegate = self
        tfComment.addPadding(.left(10))
        tfComment.addPadding(.right(10))
        viewBoxComment.addSubview(tfComment)
        
        typePaymentView.frame.size.height = viewBoxComment.frame.size.height + viewBoxComment.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: typePaymentView.frame.size.height + typePaymentView.frame.origin.y + ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) + Common.Size(s:5))

        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tải thông tin ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
         let nc = NotificationCenter.default
        MPOSAPIManager.BaoLoiNguoiDung__GetConv(p_RequestId: self.CallLog_ReqId!) { (results, err) in
            
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.items = results
                    self.tableView.reloadData()
                }else{
                    let popup = PopupDialog(title: "THÔNG BÁO", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        self.navigationController?.popViewController(animated: true)
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == UIReturnKeyType.send)
        {
            let message = tfComment.text!
            if(!message.isEmpty){
                let newViewController = LoadingViewController()
                newViewController.content = "Đang gửi trao đổi ..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                 let nc = NotificationCenter.default
                MPOSAPIManager.BaoLoiNguoiDung__PushConv(p_RequestId: self.CallLog_ReqId, p_Message: message) { (success, err) in

                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            self.tfComment.text = ""
                            textField.resignFirstResponder()
                            
                            let popup = PopupDialog(title: "THÔNG BÁO", message: success, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                self.navigationController?.popViewController(animated: true)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
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
        }
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemMessageTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemMessageTableViewCell")
        let item:CallLogErrorMessage = items[indexPath.row]

        cell.avatar.image = #imageLiteral(resourceName: "avatar")
       
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd H:m:s"
//        let date = dateFormatter.date(from: "\(Common.UTCToLocal(date:item.updated_at))")
        cell.quanlityChange.text = "\(item.TimeCreate_Format)"
        
        cell.title.text = "\(item.EmployeeCode)-\(item.EmployeeName)"
        cell.quanlity.text = item.Message
        //        cell.setup(so: item)
        cell.selectionStyle = .none
        //        cell.backgroundColor = .yellow
        //        cell.accessoryType = .disclosureIndicator
        
        if(indexPath.row >= items.count - 1){
            DispatchQueue.main.async(execute: {
                var frame = self.tableView.frame
                frame.size.height = self.tableView.contentSize.height
                self.tableView.frame = frame
                self.viewBoxComment.frame.origin.y = tableView.frame.size.height + tableView.frame.origin.y
                self.typePaymentView.frame.size.height = self.viewBoxComment.frame.size.height + self.viewBoxComment.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.typePaymentView.frame.size.height + self.typePaymentView.frame.origin.y + ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) + Common.Size(s:5))
            })
        }
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    //    {
    //        return Common.Size(s:67)
    //    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
class ItemMessageTableViewCell: UITableViewCell {
    
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
        avatar.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        avatar.contentMode = .scaleAspectFill
        avatar.layer.masksToBounds = false
        avatar.layer.cornerRadius = Common.Size(s: 30)/2
        avatar.clipsToBounds = true
        
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
        title.trailingAnchor.constraint(equalTo: quanlityChange.leadingAnchor).isActive = true
        title.numberOfLines = 0
        title.textColor =  .black
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        
        
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
