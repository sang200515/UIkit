//
//  NapGalaxyViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 9/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class NapGalaxyViewController: UIViewController {
    
    // MARK: - Properties
    
    private var scrollView: UIScrollView!
    private var scrollViewHeight: CGFloat = 0
    private var lbSdtAlert: UILabel!
    private var itemGoiCuocGalaxy: InfoCustomerGalaxyPlay?
    private var viewGoiCuoc: UIView!
    private var viewGoiCuocInfo: UIView!
    private var tfSdt: UITextField!
    private var customAlert = PopUpGalaxyPay()
    private let btnCheck: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(netHex:0x00955E)
        button.setTitle("Thanh Toán", for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(movePayment), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Nạp Galaxy Play"
        self.view.backgroundColor = .white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: 0, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s: 100)))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
   
        
        let lbSdt = Common.tileLabel(x: Common.Size(s:15), y: Common.Size(s: 15), width: scrollView.frame.width/3 - Common.Size(s: 12), height: Common.Size(s:30), title: "Số điện thoại", fontSize: 14)
        scrollView.addSubview(lbSdt)
  
        tfSdt = Common.inputTextTextField(x: lbSdt.frame.origin.x + lbSdt.frame.width, y: Common.Size(s: 15), width: self.view.frame.width - Common.Size(s: 30) - lbSdt.frame.width, height: Common.Size(s: 30), placeholder: "Nhập sđt", fontSize: 13, isNumber: true)
        //tfSdt.text = "0969460450"
        tfSdt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        scrollView.addSubview(tfSdt)
       
        
        lbSdtAlert = Common.tileLabel(x: Common.Size(s: 15), y: tfSdt.frame.origin.y + tfSdt.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20), title: "Số điện thoại này đã được đăng kí",isBoldStyle: true)
        lbSdtAlert.textColor = UIColor.blue
        lbSdtAlert.isHidden = true
        scrollView.addSubview(lbSdtAlert)
        
        let tapShowInfoGoiCuoc = UITapGestureRecognizer(target: self, action: #selector(showGoiCuocDaDangKy))
        lbSdtAlert.isUserInteractionEnabled = true
        lbSdtAlert.addGestureRecognizer(tapShowInfoGoiCuoc)
        
        

        self.view.addSubview(btnCheck)
        btnCheck.anchor(left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 12,paddingRight: 12)
        btnCheck.setDimensions(width: self.view.frame.width - Common.Size(s:30), height: Common.Size(s:40))
        btnCheck.isHidden = true
    }
    
    func initViewOfferGoiCuoc() {
        let viewGoiCuocInfo = UIView(frame: CGRect(x: 0, y: lbSdtAlert.frame.origin.y + lbSdtAlert.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: Common.Size(s: 35)))
        viewGoiCuocInfo.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        scrollView.addSubview(viewGoiCuocInfo)
        
        
        let lbGoiCuocInfo = Common.tileLabel(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: viewGoiCuocInfo.frame.height, title: "THÔNG TIN GÓI CƯỚC",fontSize: 14)
         lbGoiCuocInfo.textColor = UIColor(netHex:0x069C90)
        viewGoiCuocInfo.addSubview(lbGoiCuocInfo)
        
        viewGoiCuoc = UIView(frame: CGRect(x: 0, y: viewGoiCuocInfo.frame.origin.y + viewGoiCuocInfo.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: Common.Size(s: 50)))
        viewGoiCuoc.backgroundColor = .white
        scrollView.addSubview(viewGoiCuoc)
        initGoiCuoc()
        
        
    }
    func initGoiCuoc(){
        for i in 0..<(self.itemGoiCuocGalaxy!.listOffers.count) {
            let itemOffer = self.itemGoiCuocGalaxy!.listOffers[i]
            
            let view1 = UIView(frame: CGRect(x: 0, y: (CGFloat(i) * Common.Size(s: 35)) + Common.Size(s: 3), width: self.view.frame.width, height: Common.Size(s: 35)))
            view1.backgroundColor = UIColor.white
            viewGoiCuoc.addSubview(view1)
            
            let imgCheck = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 8), width: Common.Size(s: 20), height: Common.Size(s: 20)))
            if itemOffer.isChoose {
                imgCheck.image = UIImage(named: "Checked")
            }else {
                imgCheck.image = UIImage(named: "Check")
            }
            
            imgCheck.tag = i + 1
            imgCheck.contentMode = .scaleAspectFit
            view1.addSubview(imgCheck)
            
            let tapCheck = UITapGestureRecognizer(target: self, action: #selector(chooseGoiCuoc(_:)))
            imgCheck.isUserInteractionEnabled = true
            imgCheck.addGestureRecognizer(tapCheck)
            
            let lbGoiCuocName = UILabel(frame: CGRect(x: imgCheck.frame.origin.x + imgCheck.frame.width + Common.Size(s: 20), y: Common.Size(s: 3), width: view1.frame.width - Common.Size(s: 50) - imgCheck.frame.width, height: Common.Size(s: 17)))
            lbGoiCuocName.text = "\(itemOffer.name)"
            lbGoiCuocName.font = UIFont.boldSystemFont(ofSize: 14)
            view1.addSubview(lbGoiCuocName)
            
            let lbGoiCuocValue = UILabel(frame: CGRect(x: lbGoiCuocName.frame.origin.x, y: lbGoiCuocName.frame.origin.y + lbGoiCuocName.frame.height, width: lbGoiCuocName.frame.width, height: Common.Size(s: 15)))
            lbGoiCuocValue.text = Common.convertCurrencyDoubleV2(value: itemOffer.price)
            lbGoiCuocValue.font = UIFont.systemFont(ofSize: 13)
            lbGoiCuocValue.textColor = .red
            view1.addSubview(lbGoiCuocValue)
        }
        
        viewGoiCuoc.frame = CGRect(x: viewGoiCuoc.frame.origin.x, y: viewGoiCuoc.frame.origin.y, width: viewGoiCuoc.frame.width, height: 4 * Common.Size(s: 38))
        
        scrollViewHeight = viewGoiCuoc.frame.origin.y + viewGoiCuoc.frame.height + ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        scrollView.frame.size.height = scrollViewHeight
    }
    
    // MARK: - API
    
    @objc func getInfoGalaxy() {
         guard let sdt = tfSdt.text, !sdt.isEmpty else {
            
             showDialog(message:"Bạn chưa nhập sđt liên hệ!")
             return
         }
         
         guard sdt.count == 10, (sdt.isNumber() == true) else {
       
             showDialog(message: "Số điện thoại liên hệ không hợp lệ!")
             return
         }
         
         WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
             CRMAPIManager.Galaxy_info_customer(phonenumber: "\(sdt)") { (rs, msg, err) in
                 WaitingNetworkResponseAlert.DismissWaitingAlert {
                     if err.count <= 0 {
                         if rs != nil {
                             self.itemGoiCuocGalaxy = rs!
                             self.lbSdtAlert.isHidden = false
                             self.lbSdtAlert.text = rs?.message ?? ""
                             self.btnCheck.isHidden = false
                             self.initViewOfferGoiCuoc()
                             
                         } else {
                      
                             self.showDialog(message: "\(msg ?? "Truy vấn thuê bao thất bại!")")
                         }
                     } else {
                   
                         self.showDialog(message: err)
                     }
                 }
             }
         }
     }
    
    
    
    // MARK: - Selectors
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfSdt){
            getInfoGalaxy()
        }
        
    }
    
    @objc func chooseGoiCuoc(_ sender: UITapGestureRecognizer) {
          let view:UIView = sender.view!
          let tag = view.tag
          debugPrint("view\(tag)")
          if self.itemGoiCuocGalaxy!.listOffers.count > 0 {
              let itemOffer = self.itemGoiCuocGalaxy?.listOffers[tag - 1]
              itemOffer!.isChoose = !(itemOffer!.isChoose)
              let list = self.itemGoiCuocGalaxy!.listOffers.filter({$0.productcode_frt != itemOffer!.productcode_frt})
              list.forEach({$0.isChoose = false})
              
              viewGoiCuoc.subviews.forEach { $0.removeFromSuperview() }
              initGoiCuoc()
              
              
          }
          
      }
    
    // MARK: - Helpers
    
    
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
 
    
  
    
    @objc func showGoiCuocDaDangKy() {
        if (self.itemGoiCuocGalaxy?.listPlans.count ?? 0) > 0 {

            customAlert = PopUpGalaxyPay()
            customAlert.showAlert(with: "Thông báo", on: self,plans: itemGoiCuocGalaxy!.listPlans)
        }else{
            showDialog(message: "\(itemGoiCuocGalaxy?.message ?? "")")
        }
    }

    @objc func movePayment(){
        
        if itemGoiCuocGalaxy?.listOffers.filter({ item in item.isChoose == true }).count ?? 0 > 0 {
            let controller = PaymentGalaxyPayViewController()
            controller.itemOffer = itemGoiCuocGalaxy?.listOffers.filter({ item in item.isChoose == true })[0]
            controller.itemGoiCuocGalaxy = self.itemGoiCuocGalaxy
            navigationController?.pushViewController(controller, animated: true)
        }
        
        
    }
  
    
}

