//
//  UpdateTargetPDViewController.swift
//  fptshop
//
//  Created by tan on 2/25/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import  PopupDialog
class UpdateTargetPDViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate {
    
    var scrollView:UIView!
    var tfTenPD: SearchTextField!
    var tfSoTarget: UITextField!
    var tfThang: SearchTextField!
    var tfGhiChu: UITextField!
    var btSearch:UIButton!
    var btSave:UIButton!
     var viewTable:UITableView  =   UITableView()
    var listCuratorPD:[CuratorPD] = []
    var curatorCode:String = ""
    var lstInfoCurator:[InfoUpdateTarget] = []
 
    var lstThang:[String] = ["1","2","3","4","5","6","7","8","9","10","11","12"]
   
     var barSearchRight : UIBarButtonItem!
    

    override func viewDidLoad() {
        self.title = "Target PD của FFriends"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        let btSearchIcon = UIButton.init(type: .custom)
        
        btSearchIcon.setImage(#imageLiteral(resourceName: "ReloadPO"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.addTarget(self, action: #selector(refeshButton), for: UIControl.Event.touchUpInside)
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barSearchRight = UIBarButtonItem(customView: btSearchIcon)
        
        
        
        
        
        self.navigationItem.rightBarButtonItems = [barSearchRight]
        
     
        
        scrollView  = UIView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - 44-(UIApplication.shared.statusBarFrame.height + 0.0)))
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let lblTenPD = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s:2), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTenPD.textAlignment = .left
        lblTenPD.textColor = UIColor.black
        lblTenPD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTenPD.text = "Tên PD"
        scrollView.addSubview(lblTenPD)
        
        tfTenPD = SearchTextField(frame: CGRect(x: Common.Size(s: 10), y: lblTenPD.frame.origin.y + lblTenPD.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfTenPD.placeholder = "Chọn tên PD"
        tfTenPD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfTenPD.borderStyle = UITextField.BorderStyle.roundedRect
        tfTenPD.autocorrectionType = UITextAutocorrectionType.no
        tfTenPD.keyboardType = UIKeyboardType.default
        tfTenPD.returnKeyType = UIReturnKeyType.done
        tfTenPD.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfTenPD.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTenPD.delegate = self
        scrollView.addSubview(tfTenPD)
        
        tfTenPD.startVisible = true
        tfTenPD.theme.bgColor = UIColor.white
        tfTenPD.theme.fontColor = UIColor.black
        tfTenPD.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTenPD.theme.cellHeight = Common.Size(s:40)
        tfTenPD.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lblSoTarget = UILabel(frame: CGRect(x: Common.Size(s: 10), y: tfTenPD.frame.origin.y + tfTenPD.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSoTarget.textAlignment = .left
        lblSoTarget.textColor = UIColor.black
        lblSoTarget.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSoTarget.text = "Số Target"
        scrollView.addSubview(lblSoTarget)
        
     
        
        
        tfSoTarget = UITextField(frame: CGRect(x: Common.Size(s: 10), y: lblSoTarget.frame.origin.y + lblSoTarget.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        tfSoTarget.placeholder = ""
        tfSoTarget.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfSoTarget.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoTarget.autocorrectionType = UITextAutocorrectionType.no
        tfSoTarget.keyboardType = UIKeyboardType.numberPad
        tfSoTarget.returnKeyType = UIReturnKeyType.done
        tfSoTarget.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSoTarget.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoTarget.delegate = self
        scrollView.addSubview(tfSoTarget)
        tfSoTarget.placeholder = "Vui lòng nhập số tiền Target"
        tfSoTarget.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        
        let lblThang = UILabel(frame: CGRect(x: Common.Size(s: 10), y: tfSoTarget.frame.origin.y + tfSoTarget.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblThang.textAlignment = .left
        lblThang.textColor = UIColor.black
        lblThang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblThang.text = "Tháng"
        scrollView.addSubview(lblThang)
        
        tfThang = SearchTextField(frame: CGRect(x: Common.Size(s: 10), y: lblThang.frame.origin.y + lblThang.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfThang.placeholder = "Chọn tháng"
        tfThang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfThang.borderStyle = UITextField.BorderStyle.roundedRect
        tfThang.autocorrectionType = UITextAutocorrectionType.no
        tfThang.keyboardType = UIKeyboardType.numberPad
        tfThang.returnKeyType = UIReturnKeyType.done
        tfThang.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfThang.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfThang.delegate = self
        scrollView.addSubview(tfThang)
        
        tfThang.startVisible = true
        tfThang.theme.bgColor = UIColor.white
        tfThang.theme.fontColor = UIColor.black
        tfThang.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfThang.theme.cellHeight = Common.Size(s:40)
        tfThang.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        let lblGhiChu = UILabel(frame: CGRect(x: Common.Size(s: 10), y: tfThang.frame.origin.y + tfThang.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblGhiChu.textAlignment = .left
        lblGhiChu.textColor = UIColor.black
        lblGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblGhiChu.text = "Lý do cập nhật"
        scrollView.addSubview(lblGhiChu)
        
        tfGhiChu = UITextField(frame: CGRect(x: Common.Size(s: 10), y: lblGhiChu.frame.origin.y + lblGhiChu.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40)))
        tfGhiChu.placeholder = ""
        tfGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfGhiChu.borderStyle = UITextField.BorderStyle.roundedRect
        tfGhiChu.autocorrectionType = UITextAutocorrectionType.no
        tfGhiChu.keyboardType = UIKeyboardType.default
        tfGhiChu.returnKeyType = UIReturnKeyType.done
        tfGhiChu.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfGhiChu.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoTarget.delegate = self

        tfGhiChu.placeholder = "Lý do cập nhật"
        scrollView.addSubview(tfGhiChu)
        
        btSearch = UIButton()
        btSearch.frame = CGRect(x: tfGhiChu.frame.origin.x, y: tfGhiChu.frame.origin.y + tfGhiChu.frame.size.height + Common.Size(s:10), width: Common.Size(s: 100), height: Common.Size(s: 30))
        btSearch.backgroundColor = UIColor(netHex:0x339966)
        btSearch.setTitle("Tìm kiếm", for: .normal)
        btSearch.addTarget(self, action: #selector(actionSearch), for: .touchUpInside)
        btSearch.layer.borderWidth = 0.5
        btSearch.layer.borderColor = UIColor.white.cgColor
        btSearch.layer.cornerRadius = 3
        scrollView.addSubview(btSearch)
        btSearch.clipsToBounds = true
        
        btSave = UIButton()
        btSave.frame = CGRect(x: btSearch.frame.origin.x + btSearch.frame.size.width + Common.Size(s: 80), y: tfGhiChu.frame.origin.y + tfGhiChu.frame.size.height + Common.Size(s:10), width: Common.Size(s: 100), height: Common.Size(s: 30))
        btSave.backgroundColor = UIColor(netHex:0xEF4A40)
        btSave.setTitle("Lưu", for: .normal)
        btSave.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
        btSave.layer.borderWidth = 0.5
        btSave.layer.borderColor = UIColor.white.cgColor
        btSave.layer.cornerRadius = 3
        scrollView.addSubview(btSave)
        btSave.clipsToBounds = true
        
        viewTable.frame = CGRect(x: tfGhiChu.frame.origin.x, y:btSave.frame.origin.y + btSave.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: self.view.frame.size.height - 400)
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTable.dataSource = self
        viewTable.delegate = self
        //        viewTable.backgroundColor = UIColor.yellow
        viewTable.register(ItemCuratorNameTableViewCell.self, forCellReuseIdentifier: "ItemCuratorNameTableViewCell")
        viewTable.tableFooterView = UIView()
        viewTable.backgroundColor = UIColor.white
        
        scrollView.addSubview(viewTable)
        
        tfTenPD.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            self.tfTenPD.text = item.title
            
            let obj1 =  self.listCuratorPD.filter{ "\($0.CuratorName)" == "\(item.title)" }.first
            if let obj = obj1?.CuratorCode {
                self.curatorCode = "\(obj)"
            }
            
            
        }
        tfThang.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            self.tfThang.text = item.title
            
            
            
            
        }
        self.mpos_sp_UpdateTargetPD_GetPD()
        
    }
    
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    @objc func refeshButton(){
        
        self.tfTenPD.resignFirstResponder()
        self.tfThang.resignFirstResponder()
        
        self.tfTenPD.text = ""
       // self.tfThang.text = ""
        self.tfGhiChu.text = ""
        self.tfSoTarget.text = ""
        
      
        self.curatorCode = ""
        let date = Date()
        self.tfThang.text = "\(date.monthAsString())"
    
        self.lstInfoCurator.removeAll()
        self.viewTable.reloadData()
    }
    
    func mpos_sp_UpdateTargetPD_GetPD(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy danh sách tên PD..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_sp_UpdateTargetPD_GetPD() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listCuratorPD = results
                    var lstCuratorTemp:[String] = []
                    for item in results {
                        lstCuratorTemp.append(item.CuratorName)
                    }
                    self.tfTenPD.filterStrings(lstCuratorTemp)
                    self.tfThang.filterStrings(self.lstThang)
                    let date = Date()
                    self.tfThang.text = "\(date.monthAsString())"
                   
                    
                }else{
               
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstInfoCurator.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemCuratorNameTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemCuratorNameTableViewCell")
        let item:InfoUpdateTarget = self.lstInfoCurator[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:90);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            
            
            
            let item:InfoUpdateTarget = self.lstInfoCurator[indexPath.row]
            print("\(indexPath.row)")
            
            let popup = PopupDialog(title: "Thông báo", message: "Bạn có muốn xoá mục này!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = DefaultButton(title: "Xoá") {
                self.actionDelete(CuratorCode:item.PD_Code,Thang:"\(item.Thang)",IDTarget:"\(item.IDTarget)")
            }
            let buttonTwo = CancelButton(title: "Không"){
                
            }
            popup.addButtons([buttonOne,buttonTwo])
            self.present(popup, animated: true, completion: nil)
        }
        
    }
    
    @objc func actionSave(){
        if(self.tfTenPD.text == "" || self.curatorCode == ""){
            
          
            self.showDialog(message: "Vui lòng chọn tên pd!")
            return
        }
        var money = tfSoTarget.text!
        money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        if(money.isEmpty){
         
            self.showDialog(message: "Vui lòng nhập số tiền Target !")
            return
        }
        if(Int(self.tfThang.text!)! > 12 || Int(self.tfThang.text!)! == 0){
           
            self.showDialog(message: "Vui lòng nhập đúng tháng !")
            return
        }
        
        self.actionSaveInfo(money: money)
    }
    func actionSaveInfo(money:String){
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lưu thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_sp_UpdateTargerPD_Saveinfo(CuratorCode: self.curatorCode, Target: "\(money)", Note: self.tfGhiChu.text!) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results[0].Result == 1){
                        let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            self.getInfo_Curator(CuratorCode: self.curatorCode)
                        })
                        self.present(alert, animated: true)
                    }else{
                
                        self.showDialog(message: results[0].Message)
                    }
 
                }else{
            
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    @objc func actionSearch(){
      
        if(self.tfTenPD.text == ""){
            self.curatorCode = ""
        }
        self.getInfo_Curator(CuratorCode:self.curatorCode)
    }
    func getInfo_Curator(CuratorCode:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tìm kiếm thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_sp_UpdateTargerPD_GetInfo(CuratorCode:CuratorCode,Thang:self.tfThang.text!) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.lstInfoCurator.removeAll()
                    self.lstInfoCurator = results
                    
                    self.viewTable.reloadData()
                
                    
                    
                }else{
              
                    self.showDialog(message: err)
                }
            }
        }
    }
    func actionDelete(CuratorCode:String,Thang:String,IDTarget:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang xoá thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_sp_UpdateTargerPD_Delete(CuratorCode:CuratorCode,Thang: Thang,IDTarget: IDTarget) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results[0].Result == 1){
                        let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            self.getInfo_Curator(CuratorCode: self.curatorCode)
                        })
                        self.present(alert, animated: true)
                    }else{
               
                        self.showDialog(message: results[0].Message)
                    }
                    
                    
                    
                }else{
                  
                    self.showDialog(message: err)
                }
            }
        }
    }
    
    @objc func textFieldDidChangeMoney(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            
        }else{
            textField.text = ""
            
        }
        
    }
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}
class ItemCuratorNameTableViewCell: UITableViewCell {
    var name: UILabel!
    var targetnum:UILabel!
    var thang: UILabel!
   
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor.red
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        
        
        
        name.numberOfLines = 0
        name.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        name.minimumScaleFactor = 0.8
        
        
        
        
        contentView.addSubview(name)
        
        
        targetnum = UILabel()
        targetnum.textColor = UIColor.black
        
        
        targetnum.numberOfLines = 0
        targetnum.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        targetnum.minimumScaleFactor = 0.8
        
        
        targetnum.font = targetnum.font.withSize(14)
        contentView.addSubview(targetnum)
        
        thang = UILabel()
        thang.textColor = UIColor.black
        thang.numberOfLines = 1
        thang.font = thang.font.withSize(14)
        contentView.addSubview(thang)
        
        
        
        
        
        
        
        
    }
    var so1:InfoUpdateTarget?
    func setup(so:InfoUpdateTarget){
        so1 = so
        
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        name.text = "\(so.HoTenPD)"
        
        
        
        
        
        targetnum.frame = CGRect(x: Common.Size(s:10),y: name.frame.origin.y + name.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width,height: Common.Size(s:16))
        
        targetnum.text = "Số target: \(Common.convertCurrencyFloatV2(value: so.SoTarget))"
        
        
        
        
        thang.frame = CGRect(x: Common.Size(s:10),y: targetnum.frame.origin.y + targetnum.frame.size.height + Common.Size(s: 5),width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        thang.text = "Tháng: \(so.Thang)"
        
        
        
        
        
    }
    
    
    
}
extension Date {
    func monthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("M")
        return df.string(from: self)
    }
    
}
