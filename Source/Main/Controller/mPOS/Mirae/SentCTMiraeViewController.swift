//
//  SentCTMiraeViewController.swift
//  fptshop
//
//  Created by tan on 8/29/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import DLRadioButton
class SentCTMiraeViewController : UIViewController,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    var barClose : UIBarButtonItem!
    var tableView: UITableView  =   UITableView()
    var tfInput:UITextField!
    var items: [AllDocumentsMirae] = []
    var switchAll:UISwitch!
    override func viewDidLoad() {
        self.title = "Gửi bản cứng chứng từ"
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        
        
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(SentCTMiraeViewController.backButton), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        let newBackButton = UIBarButtonItem(title: "Gửi", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.actionSkip(sender:)))
        self.navigationItem.rightBarButtonItem = newBackButton
        
        let lblTitle = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: self.view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitle.textAlignment = .left
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitle.text = "Nhập số đơn hợp đồng / CMND"
        self.view.addSubview(lblTitle)
        
        tfInput = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblTitle.frame.origin.y + lblTitle.frame.size.height + Common.Size(s:5), width: self.view.frame.size.width - Common.Size(s:70) , height: Common.Size(s:40)));
        tfInput.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfInput.borderStyle = UITextField.BorderStyle.roundedRect
        tfInput.autocorrectionType = UITextAutocorrectionType.no
        tfInput.keyboardType = UIKeyboardType.numberPad
        tfInput.returnKeyType = UIReturnKeyType.done
        tfInput.clearButtonMode = UITextField.ViewMode.whileEditing
        tfInput.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfInput.delegate = self
        self.view.addSubview(tfInput)
        tfInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        
        let btnScan = UIImageView(frame:CGRect(x: tfInput.frame.size.width + tfInput.frame.origin.x + Common.Size(s: 10) , y:  tfInput.frame.origin.y, width: Common.Size(s:25), height: tfInput.frame.size.height));
        btnScan.image = #imageLiteral(resourceName: "MaGD")
        btnScan.contentMode = .scaleAspectFit
        self.view.addSubview(btnScan)
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(actionScan(_:)))
        btnScan.isUserInteractionEnabled = true
        btnScan.addGestureRecognizer(tapScan)
        
        
        
        switchAll = UISwitch(frame:CGRect(x: Common.Size(s:15), y: tfInput.frame.size.height + tfInput.frame.origin.y + Common.Size(s:10), width: 0, height: 0))
        switchAll.addTarget(self, action: #selector(SentCTMiraeViewController.switchStateDidChange(_:)), for: .valueChanged)
        switchAll.setOn(false, animated: false)
        switchAll.onTintColor = UIColor(netHex:0x00955E)
             switchAll.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
         self.view.addSubview(switchAll)
        
        let lblAll = UILabel(frame: CGRect(x: switchAll.frame.origin.x + switchAll.frame.size.width + Common.Size(s: 10), y: switchAll.frame.origin.y - Common.Size(s: 5), width:self.view.frame.size.width, height: Common.Size(s:30)))
        lblAll.textAlignment = .left
        lblAll.textColor = UIColor.black
        lblAll.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        lblAll.text = "Chọn tất cả"
         self.view.addSubview(lblAll)
        
        //---
        
        tableView.frame = CGRect(x: 0, y: switchAll.frame.origin.y + switchAll.frame.size.height + Common.Size(s:10), width:self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s:190) )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemDocumentMiraeTableViewCell.self, forCellReuseIdentifier: "ItemDocumentMiraeTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Common.Size(s:300)
        self.view.addSubview(tableView)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tải danh sách đơn hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.mpos_FRT_Mirae_getAll_Documents(Key: "") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                self.items = results
                if(results.count <= 0){
                    TableViewHelper.EmptyMessage(message: "Không có đơn hàng.\n:/", viewController: self.tableView)
                }else{
                    TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                }
                self.tableView.reloadData()
            }
        }
    
        NotificationCenter.default.addObserver(self, selector: #selector(showCTMirae), name: Notification.Name("LoadMiraeCT"), object: nil)
    }
    
    @objc func showCTMirae(notification:Notification) -> Void {
        
        MPOSAPIManager.mpos_FRT_Mirae_getAll_Documents(Key: "") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                NotificationCenter.default.post(name: Notification.Name("dismissLoading"), object: nil)
                self.items = results
                if(results.count <= 0){
                    TableViewHelper.EmptyMessage(message: "Không có đơn hàng.\n:/", viewController: self.tableView)
                }else{
                    TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func backButton(){

        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func actionSkip(sender: UIBarButtonItem){
        var listDoc:[AllDocumentsMirae] = []
        for item in items{
            if(item.isSelect == true){
                listDoc.append(item)
            }
        }
        if(listDoc.count > 0){
            
            let base64 = self.parseXML(listDoc: listDoc).toBase64()
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang lưu thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.mpos_FRT_Mirae_Check_Documents_Info(Info: base64) { (results, err) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(err.count <= 0){
                        if(results[0].Result == 1){
                            let vc = DetailBillInfoViewControllerV2()
                            vc.isMirae = true
                            vc.ProcessID = results[0].ContractNumber
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            let title = "THÔNG BÁO"
                            let popup = PopupDialog(title: title, message: results[0].Message  , buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }else{
                        let title = "THÔNG BÁO"
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
            
        }else{
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng chọn hợp đồng !!!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                self.tfInput.becomeFirstResponder()
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        
    }
    @objc func actionScan(_: UITapGestureRecognizer){
        if(self.tfInput.text == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng nhập số hợp đồng/cmnd !!!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                self.tfInput.becomeFirstResponder()
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        self.actionSearch(Key:self.tfInput.text!)
  
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfInput){
//            if(tfInput.text == ""){
//                let title = "THÔNG BÁO"
//                let popup = PopupDialog(title: title, message: "Vui lòng nhập số hợp đồng/cmnd !!!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                    print("Completed")
//                }
//                let buttonOne = CancelButton(title: "OK") {
//
//                }
//                popup.addButtons([buttonOne])
//                self.present(popup, animated: true, completion: nil)
//                return
//            }
            self.actionSearch(Key:self.tfInput.text!)
        }
    }
    func actionSearch(Key:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tải danh sách hợp đồng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.mpos_FRT_Mirae_getAll_Documents(Key: "\(Key)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                self.items = results
                if(results.count <= 0){
                    TableViewHelper.EmptyMessage(message: "Không có hợp đồng.\n:/", viewController: self.tableView)
                }else{
                    TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //let item:AllDocumentsMirae = items[indexPath.row]
      
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemDocumentMiraeTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemDocumentMiraeTableViewCell")
        let item:AllDocumentsMirae = items[indexPath.row]
        cell.setup(so: item)
        if(item.isSelect == true){
            cell.radioButton.isSelected = true
        }else{
            cell.radioButton.isSelected = false
        }
        cell.soHD.text = "Số HĐ: \(item.ContractNumber)"
        cell.cmnd.text = "CMND: \(item.IDCard)"
        cell.hoten.text = "Họ tên: \(item.FullName)"
        cell.ngay.text = "Ngày: \(item.DateComplete)"
        cell.trangthai.text = "Trạng thái: \(item.Status)"
        if(item.StatusCode == "O"){
            cell.trangthai.textColor = .red
        }
        cell.lydo.text = "Lý do từ chối: \(item.Note)"
        cell.lydo.sizeToFit()
//        cell.amount.text = "Số lượng: \(item.SL)"
//        cell.soPOS.text = "Số ĐH: \(item.SoDH_POS)"
//        cell.phone.text = "\(item.SDT)"
   
        if(item.Highlight == 1){
            cell.soHD.textColor = .red
            cell.cmnd.textColor = .red
            cell.hoten.textColor = .red
            cell.ngay.textColor = .red
            cell.trangthai.textColor = .red
            cell.lydo.textColor = .red
        }
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch){
     
        if (switchAll.isOn == true){
            for item in items{
                item.isSelect = true
            }
            self.tableView.reloadData()
            
        }else{
            for item in items{
                item.isSelect = false
            }
            self.tableView.reloadData()
        }
  
    }
    func parseXML(listDoc:[AllDocumentsMirae])->String{
        var rs:String = "<line>"
        for item in listDoc {
        
            

            
            rs = rs + "<item ProcessId=\"\(item.ProcessId)\" ContractNumber=\"\(item.ContractNumber)\" IdCard=\"\(item.IDCard)\" FullName=\"\(item.FullName)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
}


class ItemDocumentMiraeTableViewCell: UITableViewCell {
    var phone = UILabel()
    var amount = UILabel()
    var viewBottom = UIView()
 
  
    var soPOS = UILabel()
    var soDate = UILabel()
    var ngay = UILabel()
    let soHD = UILabel()
    let lydo = UILabel()
    var iconPhone = UIImageView()
    var cmnd = UILabel()
    var hoten = UILabel()
    var trangthai = UILabel()
    var radioButton = DLRadioButton()
    var so1:AllDocumentsMirae?
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(radioButton)
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        radioButton.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        radioButton.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitleColor(UIColor.black, for: UIControl.State());
        radioButton.iconColor = UIColor.black;
        radioButton.indicatorColor = UIColor.black;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(ItemDocumentMiraeTableViewCell.logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        // configure titleLabel
        contentView.addSubview(soHD)
        soHD.translatesAutoresizingMaskIntoConstraints = false
        soHD.leadingAnchor.constraint(equalTo: radioButton.leadingAnchor,constant: Common.Size(s:20)).isActive = true
        soHD.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        soHD.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        soHD.numberOfLines = 0
        soHD.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        
        // configure authorLabel
      
        
        contentView.addSubview(viewBottom)
        viewBottom.translatesAutoresizingMaskIntoConstraints = false
        viewBottom.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        viewBottom.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        viewBottom.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        viewBottom.topAnchor.constraint(equalTo: soHD.bottomAnchor, constant: Common.Size(s:5)).isActive = true

        viewBottom.addSubview(cmnd)
        cmnd.frame = CGRect(x: 0,y: Common.Size(s: 5),width: UIScreen.main.bounds.size.width ,height: Common.Size(s:20))
        cmnd.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        cmnd.textColor = UIColor.black
        
        viewBottom.addSubview(hoten)
        hoten.frame = CGRect(x: 0,y: cmnd.frame.origin.y + cmnd.frame.size.height,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:20))
        hoten.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        hoten.textColor = UIColor.black
        viewBottom.addSubview(ngay)
        ngay.frame = CGRect(x: 0,y: hoten.frame.origin.y + hoten.frame.size.height,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:20))
        ngay.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        ngay.textColor = UIColor.black
        
        viewBottom.addSubview(trangthai)
        trangthai.frame = CGRect(x: 0,y: ngay.frame.origin.y + ngay.frame.size.height,width: UIScreen.main.bounds.size.width ,height: Common.Size(s:20))
        trangthai.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        trangthai.textColor = UIColor.black
     
        viewBottom.addSubview(lydo)
        lydo.frame = CGRect(x: 0,y: trangthai.frame.origin.y + trangthai.frame.size.height,width: UIScreen.main.bounds.size.width ,height:Common.Size(s:50))
        lydo.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lydo.textColor = UIColor.black
        lydo.numberOfLines = 0
        
     
       
     
        
           viewBottom.heightAnchor.constraint(equalToConstant: lydo.frame.size.height + lydo.frame.origin.y + Common.Size(s: 5)).isActive = true
//        contentView.addSubview(lydo)
//        lydo.translatesAutoresizingMaskIntoConstraints = false
//        lydo.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
//        //        product.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
//        lydo.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
//        lydo.topAnchor.constraint(equalTo: viewBottom.bottomAnchor, constant: Common.Size(s:5)).isActive = true
//        lydo.numberOfLines = 0
//        lydo.font = UIFont.systemFont(ofSize: Common.Size(s:13))
//        lydo.textColor = UIColor.black
        
 
        
   

        
        
       
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(so:AllDocumentsMirae){
        so1 = so
        
    }
    
    @objc @IBAction fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            if(radioButton.isSelected == true){
                if(so1?.isSelect == true){
                    so1?.isSelect = false
                    radioButton.isSelected = false
                }else{
                    so1?.isSelect = true
                }
           
            }else{
            
            }
            
        }
    }

}
