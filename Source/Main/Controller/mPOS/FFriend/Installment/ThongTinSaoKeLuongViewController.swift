//
//  ThongTinSaoKeLuongViewController.swift
//  fptshop
//
//  Created by tan on 4/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ThongTinSaoKeLuongViewController:  UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate{
    var imagePicker = UIImagePickerController()
    var scrollView:UIScrollView!
    var tfThang:SearchTextField!
    var tfSoTienSaoKe:UITextField!
    var viewTableListSaoKeLuong:UITableView  =   UITableView()
    var listSaoKeLuong:[SaoKeLuong] = []
    var btSave:UIButton!
    var IDCardCode:Int?
    var CMND:String?
    var lstThang:[String] = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var lblSaoKeTrungBinh:UILabel!
    var imagesUpload: [String:UIImageView] = [:]
    var nameimagesUpload: [String:String] = [:]
    
    //--
    var viewInfoSaoKeLuong1:UIView!
    var viewImageSaoKeLuong1:UIView!
    var imgViewSaoKeLuong1: UIImageView!
    var viewSaoKeLuong1:UIView!
    //
    //--
    var viewInfoSaoKeLuong2:UIView!
    var viewImageSaoKeLuong2:UIView!
    var imgViewSaoKeLuong2: UIImageView!
    var viewSaoKeLuong2:UIView!
    //
    //--
    var viewInfoSaoKeLuong3:UIView!
    var viewImageSaoKeLuong3:UIView!
    var imgViewSaoKeLuong3: UIImageView!
    var viewSaoKeLuong3:UIView!
    
     var viewUpload:UIView!
    var posImageUpload:Int = -1
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blue
        self.title = "Thông tin sao kê lương"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(ThongTinSaoKeLuongViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
  
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let lbThang = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbThang.textAlignment = .left
        lbThang.textColor = UIColor.black
        lbThang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbThang.text = "Tháng"
        scrollView.addSubview(lbThang)
        
        tfThang = SearchTextField(frame: CGRect(x: Common.Size(s: 10), y: lbThang.frame.origin.y + lbThang.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
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
        tfThang.filterStrings(self.lstThang)
        
        let lbSoTienSaoKe = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfThang.frame.origin.y + tfThang.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSoTienSaoKe.textAlignment = .left
        lbSoTienSaoKe.textColor = UIColor.black
        lbSoTienSaoKe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoTienSaoKe.text = "Số tiền sao kê"
        scrollView.addSubview(lbSoTienSaoKe)
        
        tfSoTienSaoKe = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbSoTienSaoKe.frame.origin.y + lbSoTienSaoKe.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSoTienSaoKe.placeholder = "Vui lòng nhập số tiền sao kê"
        tfSoTienSaoKe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoTienSaoKe.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoTienSaoKe.autocorrectionType = UITextAutocorrectionType.no
        tfSoTienSaoKe.keyboardType = UIKeyboardType.numberPad
        tfSoTienSaoKe.returnKeyType = UIReturnKeyType.done
        tfSoTienSaoKe.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSoTienSaoKe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoTienSaoKe.delegate = self
        tfSoTienSaoKe.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        scrollView.addSubview(tfSoTienSaoKe)
        
        viewUpload = UIView(frame: CGRect(x: 0, y: tfSoTienSaoKe.frame.origin.y + tfSoTienSaoKe.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: Common.Size(s:100) ))
        //        viewUpload.backgroundColor = .red
        scrollView.addSubview(viewUpload)
        
        viewInfoSaoKeLuong1 = UIView(frame: CGRect(x:0,y:0,width:scrollView.frame.size.width, height: 100))
        viewInfoSaoKeLuong1.clipsToBounds = true
        viewUpload.addSubview(viewInfoSaoKeLuong1)
        
        let lbTextSaoKeLuong1 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSaoKeLuong1.textAlignment = .left
        lbTextSaoKeLuong1.textColor = UIColor.black
        lbTextSaoKeLuong1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSaoKeLuong1.text = "Hình Sao Kê Lương"
        viewInfoSaoKeLuong1.addSubview(lbTextSaoKeLuong1)
        
        viewImageSaoKeLuong1 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSaoKeLuong1.frame.origin.y + lbTextSaoKeLuong1.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSaoKeLuong1.layer.borderWidth = 0.5
        viewImageSaoKeLuong1.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSaoKeLuong1.layer.cornerRadius = 3.0
        viewInfoSaoKeLuong1.addSubview(viewImageSaoKeLuong1)
        
        let viewSaoKeLuong1Button = UIImageView(frame: CGRect(x: viewImageSaoKeLuong1.frame.size.width/2 - (viewImageSaoKeLuong1.frame.size.height * 2/3)/2, y: 0, width: viewImageSaoKeLuong1.frame.size.height * 2/3, height: viewImageSaoKeLuong1.frame.size.height * 2/3))
        viewSaoKeLuong1Button.image = UIImage(named:"AddImage")
        viewSaoKeLuong1Button.contentMode = .scaleAspectFit
        viewImageSaoKeLuong1.addSubview(viewSaoKeLuong1Button)
        
        let lbSaoKeLuong1Button = UILabel(frame: CGRect(x: 0, y: viewSaoKeLuong1Button.frame.size.height + viewSaoKeLuong1Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSaoKeLuong1.frame.size.height/3))
        lbSaoKeLuong1Button.textAlignment = .center
        lbSaoKeLuong1Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSaoKeLuong1Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSaoKeLuong1Button.text = "Thêm hình ảnh"
        viewImageSaoKeLuong1.addSubview(lbSaoKeLuong1Button)
        viewInfoSaoKeLuong1.frame.size.height = viewImageSaoKeLuong1.frame.size.height + viewImageSaoKeLuong1.frame.origin.y
        let tapShowSaoKeLuong1 = UITapGestureRecognizer(target: self, action: #selector(ThongTinSaoKeLuongViewController.tapShowSaoKeLuong1))
        viewImageSaoKeLuong1.isUserInteractionEnabled = true
        viewImageSaoKeLuong1.addGestureRecognizer(tapShowSaoKeLuong1)
 
        viewUpload.frame.size.height = viewInfoSaoKeLuong1.frame.size.height + viewInfoSaoKeLuong1.frame.origin.y
        
        // button luu
        btSave = UIButton()
        btSave.frame = CGRect(x: tfSoTienSaoKe.frame.origin.x, y: viewUpload.frame.origin.y + viewUpload.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s: 40))
//        btSave.backgroundColor = UIColor(netHex:0x47B054)
        btSave.backgroundColor = UIColor.red
        btSave.setTitle("Lưu", for: .normal)
        btSave.addTarget(self, action: #selector(actionLuu), for: .touchUpInside)
        btSave.layer.borderWidth = 0.5
        btSave.layer.borderColor = UIColor.white.cgColor
        btSave.layer.cornerRadius = 3
        scrollView.addSubview(btSave)
        btSave.clipsToBounds = true
        
        tfThang.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            self.tfThang.text = item.title

        }
        
        lblSaoKeTrungBinh = UILabel(frame: CGRect(x: Common.Size(s:15), y: btSave.frame.origin.y + btSave.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSaoKeTrungBinh.textAlignment = .left
        lblSaoKeTrungBinh.textColor = UIColor.blue
        lblSaoKeTrungBinh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        scrollView.addSubview(lblSaoKeTrungBinh)
        
        let width:CGFloat = UIScreen.main.bounds.size.width
        viewTableListSaoKeLuong.frame = CGRect(x: 0, y: lblSaoKeTrungBinh.frame.origin.y + lblSaoKeTrungBinh.frame.size.height + Common.Size(s:10), width: width, height: Common.Size(s: 270) )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTableListSaoKeLuong.dataSource = self
        viewTableListSaoKeLuong.delegate = self
        viewTableListSaoKeLuong.register(ItemSaoKeLuongTableViewCell.self, forCellReuseIdentifier: "ItemSaoKeLuongTableViewCell")
        viewTableListSaoKeLuong.tableFooterView = UIView()
        viewTableListSaoKeLuong.backgroundColor = UIColor.white
        
        scrollView.addSubview(viewTableListSaoKeLuong)
        navigationController?.navigationBar.isTranslucent = false
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTableListSaoKeLuong.frame.origin.y + viewTableListSaoKeLuong.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        self.actionLoadData()
      
  
    }
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    func actionLoadData(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tìm kiếm thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.sp_mpos_Getinfo_SaoKeLuong(IDCardCode: "\(IDCardCode!)",CMND:"\(CMND!)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listSaoKeLuong.removeAll()
                    self.listSaoKeLuong = results
                 
                    self.viewTableListSaoKeLuong.reloadData()
                    
                   Cache.listIDSaoKeLuongFFriend = ""
                    if(results.count > 0){
                        self.lblSaoKeTrungBinh.text = "Trung bình: \(Common.convertCurrencyV2(value: results[0].TrungBinh))"
                        if(results.count == 1){
                            Cache.listIDSaoKeLuongFFriend = "\(results[0].ID)"
                        }else{
                            for item in results{
                                Cache.listIDSaoKeLuongFFriend = "\(item.ID),\(Cache.listIDSaoKeLuongFFriend)"
                            }
                        }
                    }
                    print( Cache.listIDSaoKeLuongFFriend)
                    
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @objc func actionLuu(){
        self.tfThang.resignFirstResponder()
        self.tfSoTienSaoKe.resignFirstResponder()
        if(self.tfThang.text == ""){
            let alert = UIAlertController(title: "Thông báo", message: " Vui lòng chọn tháng !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfSoTienSaoKe.text == ""){
            let alert = UIAlertController(title: "Thông báo", message: " Vui lòng nhập số tiền sao kê  !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if(Int(self.tfThang.text!)! > 12){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn nhập đúng tháng trong năm !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        imagesUpload.removeAll()
        if(imgViewSaoKeLuong1 != nil){
            if(Cache.CRD_SaoKeLuong1 == ""){
                imagesUpload.updateValue(imgViewSaoKeLuong1, forKey: "15")
                print("stt 15")
            }
            if(Cache.CRD_SaoKeLuong2 == "" && Cache.CRD_SaoKeLuong1 != ""){
                imagesUpload.updateValue(imgViewSaoKeLuong1, forKey: "16")
                print("stt 16")
            }
            if(Cache.CRD_SaoKeLuong3 == "" && Cache.CRD_SaoKeLuong2 != "" && Cache.CRD_SaoKeLuong1 != ""){
                imagesUpload.updateValue(imgViewSaoKeLuong1, forKey: "17")
                print("stt 17")
            }
        
        }

        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        self.nameimagesUpload.removeAll()
        uploadImage(loading:newViewController)
        
        

    }
    
    func actionDelete(IDSaoKe:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang xoá thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.sp_mpos_info_SaoKeLuong_Huy(IDSaoKe:IDSaoKe) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results[0].Result == 1){
                        let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                self.actionLoadData()
                        })
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
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
            self.tfSoTienSaoKe.text = str
        }else{
            textField.text = ""
            self.tfSoTienSaoKe.text = ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSaoKeLuong.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemSaoKeLuongTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSaoKeLuongTableViewCell")
        let item:SaoKeLuong = self.listSaoKeLuong[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:60);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
//        let item:SaoKeLuong = self.listSaoKeLuong[indexPath.row]

        
        
        
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            
            
            
            let item:SaoKeLuong = self.listSaoKeLuong[indexPath.row]
            print("\(indexPath.row)")
            
            let popup = PopupDialog(title: "Thông báo", message: "Bạn có muốn xoá mục này!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = DefaultButton(title: "Xoá") {
                self.actionDelete(IDSaoKe:"\(item.ID)")
            }
            let buttonTwo = CancelButton(title: "Không"){
                
            }
            popup.addButtons([buttonOne,buttonTwo])
            self.present(popup, animated: true, completion: nil)
        }
        
    }
    
    @objc  func tapShowSaoKeLuong1(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSaoKeLuong2(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSaoKeLuong3(sender:UITapGestureRecognizer) {
        self.posImageUpload = 3
        self.thisIsTheFunctionWeAreCalling()
    }
    
    func imageSaoKeLuong1(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSaoKeLuong1.frame.size.width / sca
        viewImageSaoKeLuong1.subviews.forEach { $0.removeFromSuperview() }
        imgViewSaoKeLuong1  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSaoKeLuong1.frame.size.width, height: heightImage))
        imgViewSaoKeLuong1.contentMode = .scaleAspectFit
        imgViewSaoKeLuong1.image = image
        viewImageSaoKeLuong1.addSubview(imgViewSaoKeLuong1)
        viewImageSaoKeLuong1.frame.size.height = imgViewSaoKeLuong1.frame.size.height + imgViewSaoKeLuong1.frame.origin.y
        viewInfoSaoKeLuong1.frame.size.height = viewImageSaoKeLuong1.frame.size.height + viewImageSaoKeLuong1.frame.origin.y
        
        viewUpload.frame.size.height = viewInfoSaoKeLuong1.frame.size.height + viewInfoSaoKeLuong1.frame.origin.y
        btSave.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        lblSaoKeTrungBinh.frame.origin.y = btSave.frame.origin.y + btSave.frame.size.height + Common.Size(s:20)
        viewTableListSaoKeLuong.frame.origin.y = lblSaoKeTrungBinh.frame.origin.y + lblSaoKeTrungBinh.frame.size.height + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTableListSaoKeLuong.frame.origin.y + viewTableListSaoKeLuong.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSaoKeLuong2(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSaoKeLuong1.frame.size.width / sca
        viewImageSaoKeLuong2.subviews.forEach { $0.removeFromSuperview() }
        imgViewSaoKeLuong2  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSaoKeLuong2.frame.size.width, height: heightImage))
        imgViewSaoKeLuong2.contentMode = .scaleAspectFit
        imgViewSaoKeLuong2.image = image
        viewImageSaoKeLuong2.addSubview(imgViewSaoKeLuong2)
        viewImageSaoKeLuong2.frame.size.height = imgViewSaoKeLuong2.frame.size.height + imgViewSaoKeLuong2.frame.origin.y
        viewInfoSaoKeLuong2.frame.size.height = viewImageSaoKeLuong2.frame.size.height + viewImageSaoKeLuong2.frame.origin.y
        
        viewInfoSaoKeLuong3.frame.origin.y = viewInfoSaoKeLuong2.frame.size.height + viewInfoSaoKeLuong2.frame.origin.y + Common.Size(s: 10)
        viewUpload.frame.size.height = viewInfoSaoKeLuong3.frame.size.height + viewInfoSaoKeLuong3.frame.origin.y
        btSave.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        lblSaoKeTrungBinh.frame.origin.y = btSave.frame.origin.y + btSave.frame.size.height + Common.Size(s:20)
        viewTableListSaoKeLuong.frame.origin.y = lblSaoKeTrungBinh.frame.origin.y + lblSaoKeTrungBinh.frame.size.height + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTableListSaoKeLuong.frame.origin.y + viewTableListSaoKeLuong.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSaoKeLuong3(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSaoKeLuong1.frame.size.width / sca
        viewImageSaoKeLuong3.subviews.forEach { $0.removeFromSuperview() }
        imgViewSaoKeLuong3  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSaoKeLuong3.frame.size.width, height: heightImage))
        imgViewSaoKeLuong3.contentMode = .scaleAspectFit
        imgViewSaoKeLuong3.image = image
        viewImageSaoKeLuong3.addSubview(imgViewSaoKeLuong3)
        viewImageSaoKeLuong3.frame.size.height = imgViewSaoKeLuong3.frame.size.height + imgViewSaoKeLuong3.frame.origin.y
        viewInfoSaoKeLuong3.frame.size.height = viewImageSaoKeLuong3.frame.size.height + viewImageSaoKeLuong3.frame.origin.y
        
        viewUpload.frame.size.height = viewInfoSaoKeLuong3.frame.size.height + viewInfoSaoKeLuong3.frame.origin.y
        btSave.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        lblSaoKeTrungBinh.frame.origin.y = btSave.frame.origin.y + btSave.frame.size.height + Common.Size(s:20)
        viewTableListSaoKeLuong.frame.origin.y = lblSaoKeTrungBinh.frame.origin.y + lblSaoKeTrungBinh.frame.size.height + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTableListSaoKeLuong.frame.origin.y + viewTableListSaoKeLuong.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func resizeImageWidth(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    func uploadImage(loading:LoadingViewController){
        let nc = NotificationCenter.default
        if(imagesUpload.count > 0){
            
            let item = imagesUpload.popFirst()
            if(item?.value.image == nil){
                MPOSAPIManager.UploadImage_CalllogScoring(IdCardCode: "0", base64: "", type: "\((item?.key)!)", CMND: self.CMND ?? "") { (result, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        if(err.count <= 0){
                            self.nameimagesUpload.removeAll()
                            self.nameimagesUpload.updateValue("\(result)", forKey: "\((item?.key)!)")
                            print("NAME \(result)")
                            self.uploadImage(loading: loading)
                        }else{
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let title = "THÔNG BÁO(1)"
                                let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    print("base64 \("")")
                                    print("type: \((item?.key)!)")
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }
                    }
                    
                }
            }else{
                if let imageData:NSData = (item?.value.image!)!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                    let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
                    MPOSAPIManager.UploadImage_CalllogScoring(IdCardCode: "0", base64: strBase64, type: "\((item?.key)!)", CMND: self.CMND ?? "") { (result, err) in
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            if(err.count <= 0){
                                self.nameimagesUpload.removeAll()
                                self.nameimagesUpload.updateValue("\(result)", forKey: "\((item?.key)!)")
                                print("NAME \(result)")
                                self.uploadImage(loading: loading)
                            }else{
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let title = "THÔNG BÁO(1)"
                                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                        print("base64 \(strBase64)")
                                        print("type: \((item?.key)!)")
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                            }
                        }
                        
                    }
                }
            }
      
        }else{
     
          
          
            var urlSaoKeLuong = ""
            for item in self.nameimagesUpload {
                 urlSaoKeLuong = item.value
            }
           
      
            let swiftyString = self.tfSoTienSaoKe.text!.replacingOccurrences(of: ".", with: "")
            print(swiftyString)
            let newViewController = LoadingViewController()
            newViewController.content = "Đang lưu thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.sp_mpos_Update_ThongTinSaoKeLuong(IDCardCode:"\(IDCardCode!)",Thang:tfThang.text!,Luong:swiftyString,CMND: CMND!,UrlSaoKe:urlSaoKeLuong) { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(results[0].Result == 1){
                            let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                self.tfThang.text = ""
                                self.tfSoTienSaoKe.text = ""
                                self.imgViewSaoKeLuong1  = UIImageView(frame: CGRect(x: 0, y: 0, width: self.viewImageSaoKeLuong1.frame.size.width, height: 0))
                                self.imgViewSaoKeLuong1.contentMode = .scaleAspectFit
                              
                                self.viewImageSaoKeLuong1.subviews.forEach { $0.removeFromSuperview() }
                                self.viewImageSaoKeLuong1.frame.size.width = self.scrollView.frame.size.width - Common.Size(s:30)
                                 self.viewImageSaoKeLuong1.frame.size.height = Common.Size(s:100)
                                let viewSaoKeLuong1Button = UIImageView(frame: CGRect(x: self.viewImageSaoKeLuong1.frame.size.width/2 - (self.viewImageSaoKeLuong1.frame.size.height * 2/3)/2, y: 0, width: self.viewImageSaoKeLuong1.frame.size.height * 2/3, height: self.viewImageSaoKeLuong1.frame.size.height * 2/3))
                                viewSaoKeLuong1Button.image = UIImage(named:"AddImage")
                                viewSaoKeLuong1Button.contentMode = .scaleAspectFit
                                self.viewImageSaoKeLuong1.addSubview(viewSaoKeLuong1Button)
                                
                                let lbSaoKeLuong1Button = UILabel(frame: CGRect(x: 0, y: viewSaoKeLuong1Button.frame.size.height + viewSaoKeLuong1Button.frame.origin.y, width: self.scrollView.frame.size.width - Common.Size(s:30), height: self.viewImageSaoKeLuong1.frame.size.height/3))
                                lbSaoKeLuong1Button.textAlignment = .center
                                lbSaoKeLuong1Button.textColor = UIColor(netHex:0xc2c2c2)
                                lbSaoKeLuong1Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                                lbSaoKeLuong1Button.text = "Thêm hình ảnh"
                                self.viewImageSaoKeLuong1.addSubview(lbSaoKeLuong1Button)
                                self.viewInfoSaoKeLuong1.frame.size.height = self.viewImageSaoKeLuong1.frame.size.height + self.viewImageSaoKeLuong1.frame.origin.y
                                let tapShowSaoKeLuong1 = UITapGestureRecognizer(target: self, action: #selector(ThongTinSaoKeLuongViewController.tapShowSaoKeLuong1))
                                self.viewImageSaoKeLuong1.isUserInteractionEnabled = true
                                self.viewImageSaoKeLuong1.addGestureRecognizer(tapShowSaoKeLuong1)
                                
                                self.viewUpload.frame.size.height = self.viewInfoSaoKeLuong1.frame.size.height + self.viewInfoSaoKeLuong1.frame.origin.y
                                self.btSave.frame.origin.y = self.viewUpload.frame.size.height + self.viewUpload.frame.origin.y + Common.Size(s:20)
                                self.lblSaoKeTrungBinh.frame.origin.y = self.btSave.frame.origin.y + self.btSave.frame.size.height + Common.Size(s:20)
                                self.viewTableListSaoKeLuong.frame.origin.y = self.lblSaoKeTrungBinh.frame.origin.y + self.lblSaoKeTrungBinh.frame.size.height + Common.Size(s:10)
                                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewTableListSaoKeLuong.frame.origin.y + self.viewTableListSaoKeLuong.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
                                
                                for item in self.nameimagesUpload {
                                    let type:String = item.key
                                    
                                    if (type == "15"){
                                        Cache.CRD_SaoKeLuong1 = item.value
                                    
                                    }
                                    if (type == "16"){
                                        Cache.CRD_SaoKeLuong2 = item.value
                                    
                                    }
                                    if (type == "17"){
                                        Cache.CRD_SaoKeLuong3 = item.value
                                    
                                    }
                                }
                                
                                self.actionLoadData()
                            })
                            self.present(alert, animated: true)
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: results[0].Message, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                        
                        
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                }
            }
         
   
        }
    }
}
class ItemSaoKeLuongTableViewCell: UITableViewCell {
    var stt: UILabel!
    
    var thang: UILabel!
    var sotien: UILabel!
 
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        stt = UILabel()
        stt.textColor = UIColor.black
        stt.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        stt.numberOfLines = 1
        contentView.addSubview(stt)
        
        thang = UILabel()
        thang.textColor = UIColor.black
        thang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        thang.numberOfLines = 1
        contentView.addSubview(thang)
        
        sotien = UILabel()
        sotien.textColor = UIColor.red
        sotien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        sotien.numberOfLines = 1
        contentView.addSubview(sotien)
        
        
        
    }
    var so1:SaoKeLuong?
    func setup(so:SaoKeLuong){
        so1 = so
        
        stt.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 100) ,height: Common.Size(s:16))
        stt.text = "STT: \(so.STT)"
  
        thang.frame = CGRect(x: stt.frame.size.width + stt.frame.origin.x,y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        thang.text = "Tháng: \(so.Thang)"

        sotien.frame = CGRect(x: Common.Size(s:10),y: thang.frame.size.height + thang.frame.origin.y + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:16))
        sotien.text = "Số tiền sao kê: \(Common.convertCurrencyV2(value: so.Luong))"
        
        
    }
    
    
}

extension ThongTinSaoKeLuongViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            //            alert.popoverPresentationController?.sourceView = sender
            //            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        if (self.posImageUpload == 1){
            self.imageSaoKeLuong1(image: image)
        }else if (self.posImageUpload == 2){
            
            self.imageSaoKeLuong2(image: image)
        }else if (self.posImageUpload == 3){
            self.imageSaoKeLuong3(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}
