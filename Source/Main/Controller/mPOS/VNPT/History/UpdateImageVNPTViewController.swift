//
//  UpdateImageVNPTViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 12/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import PopupDialog
class UpdateImageVNPTViewController: UIViewController{
    var tfPhoneNumber:SkyFloatingLabelTextFieldWithIcon!
    var tfUserName:SkyFloatingLabelTextFieldWithIcon!
    var tfCMND:SkyFloatingLabelTextFieldWithIcon!
    var url_cmnd_matTruoc:String = ""
    var url_cmnd_matsau:String = ""
    var url_anh_chandung:String = ""
    var url_phieumuahang:String = ""
    var imagePicker = UIImagePickerController()
    var scrollView:UIScrollView!
    var viewInfoCMNDTruoc:UIView!
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    
    //--
    //--
    var viewInfoCMNDSau:UIView!
    var viewImageCMNDSau:UIView!
    var imgViewCMNDSau: UIImageView!
    
    var viewInfoChanDung:UIView!
    var viewImageChanDung:UIView!
    var imgViewChanDung: UIImageView!
    
    
    var posImageUpload:Int = -1
    var viewInfoPhieuMuaHang:UIView!
    var viewImagePhieuMuaHang:UIView!
    var imgViewPhieuMuaHang: UIImageView!
    var btUpload:UIButton!
    var historyVNPT:HistoryVNPT?
    override func viewDidLoad() {
        
        self.title = "Upload hình ảnh KH"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(UpdateImageVNPTViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        
        
        
        //input name info
        tfUserName = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width:  UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40) ), iconType: .image);
        tfUserName.placeholder = "Nhập họ tên"
        tfUserName.title = "Tên khách hàng"
        tfUserName.iconImage = UIImage(named: "name")
        tfUserName.tintColor = UIColor(netHex:0x04AB6E)
        tfUserName.lineColor = UIColor.gray
        tfUserName.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserName.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserName.lineHeight = 0.5
        tfUserName.selectedLineHeight = 0.5
        tfUserName.clearButtonMode = .whileEditing
        
        
        tfUserName.text = Cache.name
        scrollView.addSubview(tfUserName)
        tfUserName.text = self.historyVNPT!.TenKH
        tfUserName.isUserInteractionEnabled = false
        
        //input phone number
        tfPhoneNumber = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: tfUserName.frame.origin.y + tfUserName.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)), iconType: .image)
        
        tfPhoneNumber.placeholder = "Nhập số điện thoại"
        tfPhoneNumber.title = "Số điện thoại"
        tfPhoneNumber.iconImage = UIImage(named: "phone_number")
        tfPhoneNumber.tintColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.lineColor = UIColor.gray
        tfPhoneNumber.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.lineHeight = 0.5
        tfPhoneNumber.selectedLineHeight = 0.5
        tfPhoneNumber.clearButtonMode = .whileEditing
        
        
        tfPhoneNumber.text = Cache.phone
        tfPhoneNumber.keyboardType = .numberPad
        scrollView.addSubview(tfPhoneNumber)
        tfPhoneNumber.text = "\(self.historyVNPT!.SDT)"
        
        tfPhoneNumber.isUserInteractionEnabled = false
        
        
        
        //input email
        tfCMND = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ), iconType: .image);
        tfCMND.placeholder = "Nhập CMND"
        tfCMND.title = "CMND"
        tfCMND.iconImage = UIImage(named: "email")
        tfCMND.tintColor = UIColor(netHex:0x04AB6E)
        tfCMND.lineColor = UIColor.gray
        tfCMND.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfCMND.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfCMND.lineHeight = 0.5
        tfCMND.selectedLineHeight = 0.5
        tfCMND.clearButtonMode = .whileEditing
        
        scrollView.addSubview(tfCMND)
        
        tfCMND.text = self.historyVNPT!.CMND
        tfCMND.isUserInteractionEnabled = false
        
        viewInfoCMNDTruoc = UIView(frame: CGRect(x:0,y:tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDTruoc.clipsToBounds = true
        scrollView.addSubview(viewInfoCMNDTruoc)
        
        let lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDTruoc.textAlignment = .left
        lbTextCMNDTruoc.textColor = UIColor.black
        lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDTruoc.text = "Mặt trước CMND"
        viewInfoCMNDTruoc.addSubview(lbTextCMNDTruoc)
        
        viewImageCMNDTruoc = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDTruoc.frame.origin.y + lbTextCMNDTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDTruoc.layer.borderWidth = 0.5
        viewImageCMNDTruoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDTruoc.layer.cornerRadius = 3.0
        viewInfoCMNDTruoc.addSubview(viewImageCMNDTruoc)
        
        let viewCMNDTruocButton = UIImageView(frame: CGRect(x: viewImageCMNDTruoc.frame.size.width/2 - (viewImageCMNDTruoc.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDTruoc.frame.size.height * 2/3, height: viewImageCMNDTruoc.frame.size.height * 2/3))
        viewCMNDTruocButton.image = UIImage(named:"AddImage")
        viewCMNDTruocButton.contentMode = .scaleAspectFit
        viewImageCMNDTruoc.addSubview(viewCMNDTruocButton)
        
        let lbPDKButtonCMNDTruoc = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDTruoc.frame.size.height/3))
        lbPDKButtonCMNDTruoc.textAlignment = .center
        lbPDKButtonCMNDTruoc.textColor = UIColor(netHex:0xc2c2c2)
        lbPDKButtonCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDKButtonCMNDTruoc.text = "Thêm hình ảnh"
        viewImageCMNDTruoc.addSubview(lbPDKButtonCMNDTruoc)
        viewInfoCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        
        let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
        viewImageCMNDTruoc.isUserInteractionEnabled = true
        viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
        
        
        viewInfoCMNDSau = UIView(frame: CGRect(x:0,y:viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDSau.clipsToBounds = true
        scrollView.addSubview(viewInfoCMNDSau)
        
        let lbTextCMNDSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDSau.textAlignment = .left
        lbTextCMNDSau.textColor = UIColor.black
        lbTextCMNDSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDSau.text = "Mặt sau CMND"
        viewInfoCMNDSau.addSubview(lbTextCMNDSau)
        
        viewImageCMNDSau = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDTruoc.frame.origin.y + lbTextCMNDTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDSau.layer.borderWidth = 0.5
        viewImageCMNDSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDSau.layer.cornerRadius = 3.0
        viewInfoCMNDSau.addSubview(viewImageCMNDSau)
        
        let viewCMNDSauButton = UIImageView(frame: CGRect(x: viewImageCMNDTruoc.frame.size.width/2 - (viewImageCMNDTruoc.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDTruoc.frame.size.height * 2/3, height: viewImageCMNDTruoc.frame.size.height * 2/3))
        viewCMNDSauButton.image = UIImage(named:"AddImage")
        viewCMNDSauButton.contentMode = .scaleAspectFit
        viewImageCMNDSau.addSubview(viewCMNDSauButton)
        
        let lbPDKButtonCMNDSau = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDTruoc.frame.size.height/3))
        lbPDKButtonCMNDSau.textAlignment = .center
        lbPDKButtonCMNDSau.textColor = UIColor(netHex:0xc2c2c2)
        lbPDKButtonCMNDSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDKButtonCMNDSau.text = "Thêm hình ảnh"
        viewImageCMNDSau.addSubview(lbPDKButtonCMNDSau)
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        
        let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
        viewImageCMNDSau.isUserInteractionEnabled = true
        viewImageCMNDSau.addGestureRecognizer(tapShowCMNDSau)
        
        
        //
        
        
        viewInfoPhieuMuaHang = UIView(frame: CGRect(x:0,y:viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
            viewInfoPhieuMuaHang.clipsToBounds = true
            scrollView.addSubview(viewInfoPhieuMuaHang)
            
            let lbTextPhieuMuaHang = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
            lbTextPhieuMuaHang.textAlignment = .left
            lbTextPhieuMuaHang.textColor = UIColor.black
            lbTextPhieuMuaHang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbTextPhieuMuaHang.text = "Phiếu mua hàng"
            viewInfoPhieuMuaHang.addSubview(lbTextPhieuMuaHang)
            
            viewImagePhieuMuaHang = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextPhieuMuaHang.frame.origin.y + lbTextPhieuMuaHang.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
            viewImagePhieuMuaHang.layer.borderWidth = 0.5
            viewImagePhieuMuaHang.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
            viewImagePhieuMuaHang.layer.cornerRadius = 3.0
            viewInfoPhieuMuaHang.addSubview(viewImagePhieuMuaHang)
            
            let viewPhieuMuaHangButton = UIImageView(frame: CGRect(x: viewImagePhieuMuaHang.frame.size.width/2 - (viewImagePhieuMuaHang.frame.size.height * 2/3)/2, y: 0, width: viewImagePhieuMuaHang.frame.size.height * 2/3, height: viewImagePhieuMuaHang.frame.size.height * 2/3))
            viewPhieuMuaHangButton.image = UIImage(named:"AddImage")
            viewPhieuMuaHangButton.contentMode = .scaleAspectFit
            viewImagePhieuMuaHang.addSubview(viewPhieuMuaHangButton)
            
            let lbPDKButtonPhieuMuaHang = UILabel(frame: CGRect(x: 0, y: viewPhieuMuaHangButton.frame.size.height + viewPhieuMuaHangButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImagePhieuMuaHang.frame.size.height/3))
            lbPDKButtonPhieuMuaHang.textAlignment = .center
            lbPDKButtonPhieuMuaHang.textColor = UIColor(netHex:0xc2c2c2)
            lbPDKButtonPhieuMuaHang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbPDKButtonPhieuMuaHang.text = "Thêm hình ảnh"
            viewImagePhieuMuaHang.addSubview(lbPDKButtonPhieuMuaHang)
            viewInfoPhieuMuaHang.frame.size.height = viewImagePhieuMuaHang.frame.size.height + viewImagePhieuMuaHang.frame.origin.y
            
            let tapShowPhieuMuaHang = UITapGestureRecognizer(target: self, action: #selector(self.tapShowPhieuMuaHang))
            viewImagePhieuMuaHang.isUserInteractionEnabled = true
            viewImagePhieuMuaHang.addGestureRecognizer(tapShowPhieuMuaHang)
        
        
        
        //
        viewInfoChanDung = UIView(frame: CGRect(x:0,y:viewInfoPhieuMuaHang.frame.size.height + viewInfoPhieuMuaHang.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoChanDung.clipsToBounds = true
        scrollView.addSubview(viewInfoChanDung)
        
        let lbTextChanDung = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextChanDung.textAlignment = .left
        lbTextChanDung.textColor = UIColor.black
        lbTextChanDung.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextChanDung.text = "Chân dung khách hàng"
        viewInfoChanDung.addSubview(lbTextChanDung)
        
        viewImageChanDung = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextChanDung.frame.origin.y + lbTextChanDung.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageChanDung.layer.borderWidth = 0.5
        viewImageChanDung.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageChanDung.layer.cornerRadius = 3.0
        viewInfoChanDung.addSubview(viewImageChanDung)
        
        let viewChanDungButton = UIImageView(frame: CGRect(x: viewImageCMNDTruoc.frame.size.width/2 - (viewImageCMNDTruoc.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDTruoc.frame.size.height * 2/3, height: viewImageCMNDTruoc.frame.size.height * 2/3))
        viewChanDungButton.image = UIImage(named:"AddImage")
        viewChanDungButton.contentMode = .scaleAspectFit
        viewImageChanDung.addSubview(viewChanDungButton)
        
        let lbPDKButtonChanDung = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDTruoc.frame.size.height/3))
        lbPDKButtonChanDung.textAlignment = .center
        lbPDKButtonChanDung.textColor = UIColor(netHex:0xc2c2c2)
        lbPDKButtonChanDung.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDKButtonChanDung.text = "Thêm hình ảnh"
        viewImageChanDung.addSubview(lbPDKButtonChanDung)
        viewInfoChanDung.frame.size.height = viewImageChanDung.frame.size.height + viewImageChanDung.frame.origin.y
        
        let tapShowChanDung = UITapGestureRecognizer(target: self, action: #selector(self.tapShowChanDung))
        viewImageChanDung.isUserInteractionEnabled = true
        viewImageChanDung.addGestureRecognizer(tapShowChanDung)
        //
        
        
    
        
        btUpload = UIButton()
        btUpload.frame = CGRect(x: Common.Size(s:15), y: viewInfoChanDung.frame.origin.y + viewInfoChanDung.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40) * 1.1)
        btUpload.backgroundColor = UIColor(netHex:0x00955E)
        btUpload.setTitle("Xác nhận", for: .normal)
        btUpload.addTarget(self, action: #selector(actionConfirm), for: .touchUpInside)
        btUpload.layer.borderWidth = 0.5
        btUpload.layer.borderColor = UIColor.white.cgColor
        btUpload.layer.cornerRadius = 5.0
        scrollView.addSubview(btUpload)
        
        
    }
    @objc func actionConfirm(){
        if(self.url_cmnd_matTruoc == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng upload cmnd mặt trước !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        if(self.url_cmnd_matsau == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng upload cmnd mặt sau !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        if(self.url_phieumuahang == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng upload phiếu mua hàng !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        if(self.url_anh_chandung == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng upload ảnh KH !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh, vui lòng chờ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
           self.navigationController?.present(newViewController, animated: true, completion: nil)
           let nc = NotificationCenter.default
           
        MPOSAPIManager.mpos_FRT_sp_vnpt_update_image_KH(docentry:"\(self.historyVNPT!.Docentry)",url_cmnd_mattruoc:self.url_cmnd_matTruoc,url_cmnd_matsau:self.url_cmnd_matsau,url_PhieuMuaHang:self.url_phieumuahang,url_kh:self.url_anh_chandung) { (p_status,message,err) in
               nc.post(name: Notification.Name("dismissLoading"), object: nil)
               let when = DispatchTime.now() + 0.5
               DispatchQueue.main.asyncAfter(deadline: when) {
                   if(err.count <= 0){
                       if (p_status == 1) {
                           let title = "THÔNG BÁO"
                           let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                               print("Completed")
                           }
                           let buttonOne = CancelButton(title: "OK") {
                               _ = self.navigationController?.popToRootViewController(animated: true)
                               self.dismiss(animated: true, completion: nil)
                               let nc = NotificationCenter.default
                               nc.post(name: Notification.Name("SearchCMNDVNPT"), object: nil)
                               
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
    }
    
    @objc func backButton(){
          _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
          
      }
    
    @objc  func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowChanDung(sender:UITapGestureRecognizer) {
        self.posImageUpload = 3
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowPhieuMuaHang(sender:UITapGestureRecognizer) {
        self.posImageUpload = 4
        self.thisIsTheFunctionWeAreCalling()
    }
    
    func imageCMNDTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDTruoc.frame.size.width / sca
        viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.size.width, height: heightImage))
        imgViewCMNDTruoc.contentMode = .scaleAspectFit
        imgViewCMNDTruoc.image = image
        viewImageCMNDTruoc.addSubview(imgViewCMNDTruoc)
        viewImageCMNDTruoc.frame.size.height = imgViewCMNDTruoc.frame.size.height + imgViewCMNDTruoc.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        
        viewInfoCMNDSau.frame.origin.y =  viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s: 10)
        
        
        viewInfoPhieuMuaHang.frame.origin.y =  viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s: 10)
        viewInfoChanDung.frame.origin.y = viewInfoPhieuMuaHang.frame.size.height + viewInfoPhieuMuaHang.frame.origin.y + Common.Size(s: 10)
        
        btUpload.frame.origin.y = viewInfoChanDung.frame.origin.y + viewInfoChanDung.frame.size.height + Common.Size(s:10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImage(image: self.imgViewCMNDTruoc.image!,type:"1")
            
            
        }
        
        
    }
    func imageCMNDSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDSau.frame.size.width / sca
        viewImageCMNDSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDSau.frame.size.width, height: heightImage))
        imgViewCMNDSau.contentMode = .scaleAspectFit
        imgViewCMNDSau.image = image
        viewImageCMNDSau.addSubview(imgViewCMNDSau)
        viewImageCMNDSau.frame.size.height = imgViewCMNDSau.frame.size.height + imgViewCMNDSau.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        
               viewInfoPhieuMuaHang.frame.origin.y =  viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s: 10)
        viewInfoChanDung.frame.origin.y = viewInfoPhieuMuaHang.frame.size.height + viewInfoPhieuMuaHang.frame.origin.y + Common.Size(s: 10)
 
 
        btUpload.frame.origin.y = viewInfoChanDung.frame.origin.y + viewInfoChanDung.frame.size.height + Common.Size(s:10)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImage( image: self.imgViewCMNDSau.image!,type: "2")
            
        }
        
        
    }
    func imageChanDung(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageChanDung.frame.size.width / sca
        viewImageChanDung.subviews.forEach { $0.removeFromSuperview() }
        imgViewChanDung  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageChanDung.frame.size.width, height: heightImage))
        imgViewChanDung.contentMode = .scaleAspectFit
        imgViewChanDung.image = image
        viewImageChanDung.addSubview(imgViewCMNDSau)
        viewImageChanDung.frame.size.height = imgViewChanDung.frame.size.height + imgViewChanDung.frame.origin.y
        viewInfoChanDung.frame.size.height = viewImageChanDung.frame.size.height + viewImageChanDung.frame.origin.y
        
        
       
            btUpload.frame.origin.y = viewInfoChanDung.frame.origin.y + viewInfoChanDung.frame.size.height + Common.Size(s:10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImage( image: self.imgViewCMNDSau.image!,type: "4")
            
        }
        
        
    }
    
    func imagePhieuMuaHang(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImagePhieuMuaHang.frame.size.width / sca
        viewImagePhieuMuaHang.subviews.forEach { $0.removeFromSuperview() }
        imgViewPhieuMuaHang  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImagePhieuMuaHang.frame.size.width, height: heightImage))
        imgViewPhieuMuaHang.contentMode = .scaleAspectFit
        imgViewPhieuMuaHang.image = image
        viewImagePhieuMuaHang.addSubview(imgViewPhieuMuaHang)
        viewImagePhieuMuaHang.frame.size.height = imgViewPhieuMuaHang.frame.size.height + imgViewPhieuMuaHang.frame.origin.y
        viewInfoPhieuMuaHang.frame.size.height = viewImagePhieuMuaHang.frame.size.height + viewImagePhieuMuaHang.frame.origin.y
        
         viewInfoChanDung.frame.origin.y = viewInfoPhieuMuaHang.frame.size.height + viewInfoPhieuMuaHang.frame.origin.y + Common.Size(s: 10)
         btUpload.frame.origin.y = viewInfoChanDung.frame.origin.y + viewInfoChanDung.frame.size.height + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImage(image: self.imgViewPhieuMuaHang.image!,type: "3")
            
        }
        
        
    }
    func uploadImage(image:UIImage,type:String){
        let newViewController = LoadingViewController()
             newViewController.content = "Đang upload hình ảnh, vui lòng chờ..."
             newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
             newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
             self.navigationController?.present(newViewController, animated: true, completion: nil)
             let nc = NotificationCenter.default
             
             if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageScanCMND) as NSData?{
                 let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
                 MPOSAPIManager.mpos_FRT_Image_VNPT(CMND:"",IDMpos:"",Base64:"\(strBase64)",Type:type) { (result,err) in
                     nc.post(name: Notification.Name("dismissLoading"), object: nil)
                     let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        if(err.count <= 0){
                            if (type == "1") {
                                self.url_cmnd_matTruoc = result
                            }
                            if (type == "2"){
                                self.url_cmnd_matsau = result
                                
                            }
                            if (type == "3"){
                                self.url_phieumuahang = result
                            }
                            if(type == "4"){
                                self.url_anh_chandung = result
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
             }
    }
}
extension UpdateImageVNPTViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        self.openCamera()
        //        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        //        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
        //            self.openCamera()
        //        }))
        //
        //        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
        //            self.openGallary()
        //        }))
        //
        //        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        //
        //        /*If you want work actionsheet on ipad
        //         then you have to use popoverPresentationController to present the actionsheet,
        //         otherwise app will crash on iPad */
        //        switch UIDevice.current.userInterfaceIdiom {
        //        case .pad:
        //            //            alert.popoverPresentationController?.sourceView = sender
        //            //            alert.popoverPresentationController?.sourceRect = sender.bounds
        //            alert.popoverPresentationController?.permittedArrowDirections = .up
        //        default:
        //            break
        //        }
        //        self.present(alert, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        if (self.posImageUpload == 1){
            self.imageCMNDTruoc(image: image)
        }else if (self.posImageUpload == 2){
            self.imageCMNDSau(image: image)
        }else if (self.posImageUpload == 3){
            self.imageChanDung(image: image)
        }else if (self.posImageUpload == 4){
            self.imagePhieuMuaHang(image: image)
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
