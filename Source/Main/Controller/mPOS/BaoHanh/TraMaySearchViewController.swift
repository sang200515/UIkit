//
//  TraMaySearchViewController.swift
//  mPOS
//
//  Created by sumi on 8/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import PopupDialog
import NVActivityIndicatorView
import DropDown
import AVFoundation
class TraMaySearchViewController: UIViewController {
    
    var arrType:[String] = ["Imei","Số điện thoại","Số phiếu"]
    var typeButton:UIButton!
    var typeDropDown = DropDown()
    var loading:NVActivityIndicatorView!

    var arrPhieuBH = [TraMay_LoadThongTinPhieuTraKHResult]()
    //var aPhieuBH = TraMay_LoadThongTinPhieuTraKHResult()
    var scrollView:UIScrollView!
    var btnDone:UIButton!
    var edtTenChuXe:UITextField!
    var mChoose:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        initView()
        self.SetUpDropDownType()
        // Do any additional setup after loading the view.
    }
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func buttonClickedType() {
        typeDropDown.show()
    }
    
    
    @objc func TapScan()
    {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.edtTenChuXe.text = code
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    
    func SetUpDropDownType()
    {
        
        typeDropDown.anchorView = typeButton
        typeDropDown.bottomOffset = CGPoint(x: 0, y: typeButton.bounds.height)
        typeDropDown.dataSource = arrType
        typeDropDown.selectionAction = { [unowned self] (index, item) in
            self.typeButton.setTitle(item, for: .normal)
            print("chon \(index)")
            self.mChoose = index
            
        }
    }
    
    @objc func ClickDone()
    {
        self.edtTenChuXe.resignFirstResponder()
        if(self.edtTenChuXe.text == ""){
            self.ShowDialog(mMess: "Vui lòng nhập imei/số phiếu/số điện thoại!!!")
            return
        }
        if(mChoose == 2)
        {
            //            let newViewController = TraMayGetInfoController()
            //            newViewController.mSoDH = self.edtTenChuXe.text
            //            self.navigationController?.pushViewController(newViewController, animated: true)
            GetDataLoadThongTinPhieuTraKH(p_MaPhieuBH: "\((self.edtTenChuXe.text)!)", p_Imei: "",p_SDT: "",p_ShopTraMay: "\(Cache.user!.ShopCode)")
        }
        else if(mChoose == 1)
        {
            GetDataLoadThongTinPhieuTraKH(p_MaPhieuBH: "0", p_Imei: "",p_SDT: "\((self.edtTenChuXe.text)!)",p_ShopTraMay: "\(Cache.user!.ShopCode)")
        }
        else if(mChoose == 0)
        {
            GetDataLoadThongTinPhieuTraKH(p_MaPhieuBH: "0",p_Imei: "\((self.edtTenChuXe.text)!)",p_SDT: "",p_ShopTraMay: "\(Cache.user!.ShopCode)")
        }
        
        
        //        let newViewController = TraMaySearchListController()
        //        newViewController.arrPhieuBH = self.arrPhieuBH
        //
        //        self.navigationController?.pushViewController(newViewController, animated: true)
        //         GetDataLoadThongTinPhieuTraKH(p_Imei: "8999669",p_SDT: "",p_ShopTraMay: "30204")
    }
    
    
    
    
    func GetDataLoadThongTinPhieuTraKH(p_MaPhieuBH:String,p_Imei: String,p_SDT: String,p_ShopTraMay: String)
    {
   
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tìm kiếm thông tin bảo hành..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.GetLoadThongTinPhieuTraKH(p_MaPhieuBH:p_MaPhieuBH,p_Imei: p_Imei,p_SDT: p_SDT,p_ShopTraMay: p_ShopTraMay){ (error: Error? , success: Bool,result: [TraMay_LoadThongTinPhieuTraKHResult]!) in
         
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if success
                {
                    if(result != nil && result.count > 0 )
                    {
                        
                        self.arrPhieuBH.removeAll()
                        for i in 0 ..< result.count
                        {
                            self.arrPhieuBH.append(result[i])
                            
                            
                        }
                        print("counttt \(result.count)")
                        let newViewController = TraMaySearchListController()
                        newViewController.arrPhieuBH = self.arrPhieuBH
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                    else
                    {
                        self.ShowDialog(mMess: "Không tìm thấy kết quả, vui lòng tìm kiếm từ khóa khác")
                    }
                    
                }
                else
                {
                    self.ShowDialog(mMess: "Không tìm thấy kết quả, vui lòng tìm kiếm từ khóa khác")
                }
            }
      
        }
    }
    
    func ShowDialog(mMess:String)
    {
        let title = "THÔNG BÁO"
        let message = "\(mMess)"
    
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        let buttonOne = DefaultButton(title: "OK") {
            
        }
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    
    func initView()
    {
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        let lbType = UILabel(frame: CGRect(x: Common.Size(s:15), y:  Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbType.textAlignment = .left
        lbType.textColor = UIColor.black
        lbType.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbType.text = "Chọn loại (*)"
        
        
        typeButton = NiceButton(frame: CGRect(x: lbType.frame.origin.x, y: lbType.frame.origin.y + lbType.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - 30, height: Common.Size(s:40) ))
        
        typeButton.contentHorizontalAlignment = .left
        typeButton.tintColor = UIColor.red
        typeButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        typeButton.setTitleColor(UIColor.black ,for: .normal)
        typeButton.setTitle("Imei", for: .normal)
        typeButton.layer.borderWidth = 0.5
        typeButton.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        typeButton.layer.cornerRadius = 3.0
        typeButton.addTarget(self, action:#selector(self.buttonClickedType), for: .touchUpInside)
        
        
        let viewRightType = UIView(frame: CGRect(x: typeButton.frame.origin.x + typeButton.frame.size.width - typeButton.frame.size.height,y: typeButton.frame.origin.y + typeButton.frame.size.height / 4 ,width: typeButton.frame.size.height / 2, height: typeButton.frame.size.height / 2))
        viewRightType.backgroundColor = UIColor.white
        
        var iconRightType : UIImageView
        iconRightType  = UIImageView(frame:CGRect(x: 0 , y: 0, width: viewRightType.frame.size.width, height: viewRightType.frame.size.height));
        iconRightType.image = #imageLiteral(resourceName: "dropdown")
        iconRightType.contentMode = .scaleAspectFit
        viewRightType.addSubview(iconRightType)
        
        
        
        
        
        let lbTenChuXe = UILabel(frame: CGRect(x: Common.Size(s:15), y: typeButton.frame.size.height + typeButton.frame.origin.y +  Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTenChuXe.textAlignment = .left
        lbTenChuXe.textColor = UIColor.black
        lbTenChuXe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTenChuXe.text = "Nhập sđt/ Số phiếu bảo hành/ Imei (*)"
        
        
        
        ///sdt
        
        edtTenChuXe = UITextField(frame: CGRect(x: 15 , y: lbTenChuXe.frame.origin.y + lbTenChuXe.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTenChuXe.placeholder = ""
        edtTenChuXe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTenChuXe.borderStyle = UITextField.BorderStyle.roundedRect
        edtTenChuXe.autocorrectionType = UITextAutocorrectionType.no
        edtTenChuXe.keyboardType = UIKeyboardType.numberPad
        edtTenChuXe.returnKeyType = UIReturnKeyType.done
        edtTenChuXe.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTenChuXe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        //////////
        
        ////rightview Spinner NCC
        edtTenChuXe.rightViewMode = UITextField.ViewMode.always
        
        let imageMaHD = UIImageView(frame: CGRect(x: edtTenChuXe.frame.size.height/4, y: edtTenChuXe.frame.size.height/4, width: edtTenChuXe.frame.size.height/2, height: edtTenChuXe.frame.size.height/2))
        imageMaHD.image = #imageLiteral(resourceName: "Counter")
        imageMaHD.contentMode = UIView.ContentMode.scaleAspectFit
        let rightViewMaHD = UIView()
        rightViewMaHD.addSubview(imageMaHD)
        rightViewMaHD.frame = CGRect(x: 0, y: 0, width: edtTenChuXe.frame.size.height, height: edtTenChuXe.frame.size.height)
        edtTenChuXe.rightView = rightViewMaHD
        
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(self.TapScan))
        rightViewMaHD.isUserInteractionEnabled = true
        rightViewMaHD.addGestureRecognizer(tapScan)
        
        btnDone = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width - 20)) / 2, y: edtTenChuXe.frame.origin.y + edtTenChuXe.frame.size.height + 10, width: UIScreen.main.bounds.size.width - 20 , height: Common.Size(s:40)));
        
        
        btnDone.setTitle("Tìm kiếm",for: .normal)
        btnDone.backgroundColor = UIColor(netHex:0xdb474f)
        btnDone.layer.cornerRadius = 5
        btnDone.layer.borderWidth = 1
        btnDone.layer.borderColor = UIColor.white.cgColor
        
        btnDone.setTitleColor(UIColor(netHex:0xffffff), for: .normal)
        btnDone.titleLabel!.font =  UIFont(name: "Helvetica", size: 20)
        btnDone.addTarget(self, action: #selector(ClickDone), for: UIControl.Event.touchDown)
        ////////
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(lbType)
        self.scrollView.addSubview(typeButton)
        self.scrollView.addSubview(lbTenChuXe)
        self.scrollView.addSubview(edtTenChuXe)
        self.scrollView.addSubview(btnDone)
        self.scrollView.addSubview(viewRightType)
        
  
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    
    
    
}
