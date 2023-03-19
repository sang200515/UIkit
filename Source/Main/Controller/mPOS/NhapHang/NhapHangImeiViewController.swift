//
//  NhapHangImeiViewController.swift
//  mPOS
//
//  Created by tan on 8/15/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import AVFoundation
class NhapHangImeiViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate,ScanBarcodeImeiNhapHangViewControllerDelegate{
    
    
    
    var scrollView:UIScrollView!
    var viewImei:UIView!
    var viewTableImei:UITableView  =   UITableView()
    var tfImei:UITextField!
    var listImei:[String] = []
    
    var productNhap:ProductNhap?
    var btHoanTat:UIButton!
    
    func scanSuccessVoucher(_ viewController: ScanBarcodeImeiNhapHangViewController, scan: String) {
        print("Result \(scan)")
        var isCheck:Bool = false
        for item in self.listImei{
            if(item == scan){
                isCheck = true
                break
            }
        }
        if(isCheck == true){
          
          
            
            let title = "Thông báo"
            let popup = PopupDialog(title: title, message: "Imei này đã được nhập", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        // check imei toan list
        var listImeiCache:[String] = []
        var isCheckImeiAllList = false
        for item in Cache.listPO{
            for itemProduct in item.listProductNhap{
                for Imei in itemProduct.listImei{
                    listImeiCache.append(Imei)
                }
            }
        }
        print("\(listImeiCache.count)")
        for imei in listImeiCache{
            if(scan == imei){
                isCheckImeiAllList = true
                break
            }
        }
        if(isCheckImeiAllList == true){
     
            
            
            let title = "Thông báo"
            let popup = PopupDialog(title: title, message: "Imei này đã được nhập", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            
            return
            
        }
        
        self.listImei.append(scan)
        self.viewTableImei.reloadData()
        
    }
    
    
    
    
    override func viewDidLoad() {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Danh sách Imei"
        
        if(productNhap != nil){
            self.listImei = (self.productNhap?.listImei)! 
        }
        
        
        tfImei = UITextField(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:80) , height: Common.Size(s:40)));
        tfImei.placeholder = "Nhập imei"
        tfImei.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfImei.borderStyle = UITextField.BorderStyle.roundedRect
        tfImei.autocorrectionType = UITextAutocorrectionType.no
        tfImei.keyboardType = UIKeyboardType.default
        tfImei.returnKeyType = UIReturnKeyType.done
        tfImei.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfImei.delegate = self
        scrollView.addSubview(tfImei)
        tfImei.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        
        let btnScan = UIImageView(frame:CGRect(x: tfImei.frame.size.width + tfImei.frame.origin.x + Common.Size(s: 10) , y:  tfImei.frame.origin.y, width: Common.Size(s:25), height: tfImei.frame.size.height));
        btnScan.image = #imageLiteral(resourceName: "scan_barcode_1")
        btnScan.contentMode = .scaleAspectFit
        
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(actionIntentBarcodeImei))
        btnScan.addGestureRecognizer(tap1)
        btnScan.isUserInteractionEnabled = true
        
        
        scrollView.addSubview(btnScan)
        
        
        viewImei = UIView(frame: CGRect(x:Common.Size(s: 10),y:tfImei.frame.origin.y + tfImei.frame.size.height ,width: scrollView.frame.size.width - Common.Size(s: 20),height: scrollView.frame.size.height))
        scrollView.addSubview(viewImei)
        
        
        setupUI(list: self.listImei)
        
    }
    
    func setupUI(list: [String]){
        viewTableImei.frame = CGRect(x: 0, y: Common.Size(s: 10), width: viewImei.frame.size.width, height: Common.Size(s: 350) )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTableImei.dataSource = self
        viewTableImei.delegate = self
        viewTableImei.register(ItemImeiTableViewCell.self, forCellReuseIdentifier: "ItemImeiTableViewCell")
        viewTableImei.tableFooterView = UIView()
        viewTableImei.backgroundColor = UIColor.white
        
        viewImei.addSubview(viewTableImei)
        navigationController?.navigationBar.isTranslucent = false
        
        viewImei.frame.size.height = viewTableImei.frame.size.height + viewTableImei.frame.origin.y + Common.Size(s:10)
        btHoanTat = UIButton()
        btHoanTat.frame = CGRect(x: Common.Size(s: 30), y: viewImei.frame.origin.y + viewImei.frame.size.height , width: scrollView.frame.size.width - Common.Size(s:60),height: Common.Size(s:40))
        btHoanTat.backgroundColor = UIColor(netHex:0x47B054)
        btHoanTat.setTitle("Hoàn tất", for: .normal)
        btHoanTat.addTarget(self, action: #selector(actionHoanTat), for: .touchUpInside)
        btHoanTat.layer.borderWidth = 0.5
        btHoanTat.layer.borderColor = UIColor.white.cgColor
        btHoanTat.layer.cornerRadius = 3
        scrollView.addSubview(btHoanTat)
        btHoanTat.clipsToBounds = true
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btHoanTat.frame.origin.y + btHoanTat.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listImei.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemImeiTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemImeiTableViewCell")
        let item:String = self.listImei[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:40);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            let imei:String = self.listImei[indexPath.row]
            if let index = self.listImei.firstIndex(of: imei) {
                self.listImei.remove(at: index)
            }
            self.viewTableImei.reloadData()
        }
        
    }
    @objc func actionIntentBarcodeImei(){
        
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            print("Result \(code)")
            var isCheck:Bool = false
            for item in self.listImei{
                if(item == code){
                    isCheck = true
                    break
                }
            }
            if(isCheck == true){
                
                
                
                let title = "Thông báo"
                let popup = PopupDialog(title: title, message: "Imei này đã được nhập", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                return
            }
            
            // check imei toan list
            var listImeiCache:[String] = []
            var isCheckImeiAllList = false
            for item in Cache.listPO{
                for itemProduct in item.listProductNhap{
                    for Imei in itemProduct.listImei{
                        listImeiCache.append(Imei)
                    }
                }
            }
            print("\(listImeiCache.count)")
            for imei in listImeiCache{
                if(code == imei){
                    isCheckImeiAllList = true
                    break
                }
            }
            if(isCheckImeiAllList == true){
                
                
                
                let title = "Thông báo"
                let popup = PopupDialog(title: title, message: "Imei này đã được nhập", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                
                return
                
            }
            
            self.listImei.append(code)
            self.viewTableImei.reloadData()
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfImei){
            
            let imei = textField.text!
            if(imei == ""){
                return
            }
            var isCheck:Bool = false
            for item in self.listImei{
                if(item == imei){
                    isCheck = true
                    break
                }
            }
            if(isCheck == true){
            
                
                let title = "Thông báo"
                let popup = PopupDialog(title: title, message: "Imei này đã được nhập", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                
                return
            }
            
            // check imei toan list
            var listImeiCache:[String] = []
            var isCheckImeiAllList = false
            for item in Cache.listPO{
                for itemProduct in item.listProductNhap{
                    for Imei in itemProduct.listImei{
                        listImeiCache.append(Imei)
                    }
                }
            }
            print("\(listImeiCache.count)")
            for imei2 in listImeiCache{
                if(imei2 == imei){
                    isCheckImeiAllList = true
                    break
                }
            }
            if(isCheckImeiAllList == true){
                
                
                let title = "Thông báo"
                let popup = PopupDialog(title: title, message: "Imei này đã được nhập", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                
                return
                
            }
            
            self.listImei.append(imei)
            self.viewTableImei.reloadData()
            self.tfImei.text = ""
            
        }
    }
    
    @objc func actionHoanTat(){
        var isCheckSL:Bool = false
        var slDat:Int = 0
        for item in Cache.listPO{
            for itemProduct in item.listProductNhap{
                if(itemProduct.ItemName == productNhap?.ItemName && itemProduct.poNum == productNhap?.poNum){
                    itemProduct.listImei = []
                    itemProduct.listImei = self.listImei
                    if(itemProduct.SLDat < self.listImei.count){
                        isCheckSL = true
                        slDat = itemProduct.SLDat
                        break
                    }
                    itemProduct.slnhap = self.listImei.count
                    item.isInput = true
                    print("\(itemProduct.listImei.count)")
                    
                    break
                }
            }
        }
        if(isCheckSL == false){
            
            
            
            navigationController?.popViewController(animated: true)
        }else{
            
   
            
            let popup = PopupDialog(title: "Thông báo", message: "Số lượng nhập không được lớn hơn số lượng đặt: \(slDat)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
        
    }
    
}

class ItemImeiTableViewCell: UITableViewCell {
    var titleImei:UILabel!
    var imei:UILabel!
    var delete:UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        
        
        //
        imei = UILabel()
        imei.textColor = UIColor.black
        imei.font = imei.font.withSize(14)
        //tenSP.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        
        
        contentView.addSubview(imei)
        
    }
    var so1:String?
    func setup(so:String){
        so1 = so
        
        
        imei.frame = CGRect(x: Common.Size(s: 10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 10) ,height: Common.Size(s:16))
        imei.text = so
        
        
        
        
    }
}

