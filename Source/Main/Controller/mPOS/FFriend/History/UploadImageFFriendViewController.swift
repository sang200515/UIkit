//
//  UploadImageFFriendViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
//import EPSignature
import PopupDialog
class UploadImageFFriendViewController: UIViewController,EPSignatureDelegate{
    
    var scrollView:UIScrollView!
    
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    
    var viewImageCMNDSau:UIView!
    var imgViewCMNDSau: UIImageView!
    
    var viewImageAvatar:UIView!
    var imgViewAvatar: UIImageView!
    
    var viewImageSign:UIView!
    var imgViewSign: UIImageView!
    
    var viewInfoCMNDTruoc:UIView!
    var viewInfoCMNDSau:UIView!
    var viewInfoAvatar:UIView!
    var viewInfoSign:UIView!
    
    var posImageUpload:Int = -1
    
    var btUploadImages:UIButton!
    
    var idCardCode:String?
    var name:String = "MINH"
    var nameBank:String = "ZZZ"
    var cmnd:String = "AAA"
    
    var traTruoc:String = "0 đ"
    var tongDonHang:String = "0 đ"
    var conLai:String = "0 đ"
    var idFinal:String = ""
    
    var viewInfoDetailOrder:UIView!
    var listImei:[UILabel] = []
    
    var ocfdFFriend:OCRDFFriend?
    
    var isUploadAvatar:Bool?
    var isUploadSign:Bool?
    var isUploadCMNDTruoc:Bool?
    var isUploadCMNDSau:Bool?
    var imagePicker = UIImagePickerController()
    var historyFFriend:HistoryFFriend?
    override func viewDidLoad() {
        super.viewDidLoad()
        if(ocfdFFriend == nil){
            self.navigationItem.setHidesBackButton(true, animated:true)
        }
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Phiếu đăng ký mua hàng"
        
        let lbTextName = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextName.textAlignment = .left
        lbTextName.textColor = UIColor.black
        lbTextName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextName.text = "Tên hội viên"
        scrollView.addSubview(lbTextName)
        
        let lbName = UILabel(frame: CGRect(x: Common.Size(s:15), y:lbTextName.frame.size.height + lbTextName.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbName.textAlignment = .left
        lbName.textColor = UIColor.black
        lbName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        if(ocfdFFriend != nil){
            lbName.text = "\(ocfdFFriend!.CardName)"
        }else{
            lbName.text = "\(Cache.ocfdFFriend!.CardName)"
        }
        scrollView.addSubview(lbName)
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbName.frame.size.height + lbName.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "CMND"
        scrollView.addSubview(lbTextCMND)
        
        let lbCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y:lbTextCMND.frame.size.height + lbTextCMND.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbCMND.textAlignment = .left
        lbCMND.textColor = UIColor.black
        lbCMND.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        
        if(ocfdFFriend != nil){
            lbCMND.text = "\(ocfdFFriend!.CMND)"
        }else{
            lbCMND.text = "\(Cache.ocfdFFriend!.CMND)"
        }
        scrollView.addSubview(lbCMND)
        
        
        viewInfoCMNDTruoc = UIView(frame: CGRect(x:0,y:lbCMND.frame.origin.y + lbCMND.frame.size.height,width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDTruoc.clipsToBounds = true
        scrollView.addSubview(viewInfoCMNDTruoc)
        
        let lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDTruoc.textAlignment = .left
        lbTextCMNDTruoc.textColor = UIColor.black
        lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDTruoc.text = "Mặt trước CMND + IMEI"
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
        
        let lbCMNDTruocButton = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: viewImageCMNDTruoc.frame.size.width, height: viewImageCMNDTruoc.frame.size.height/3))
        lbCMNDTruocButton.textAlignment = .center
        lbCMNDTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton.text = "Thêm hình ảnh"
        viewImageCMNDTruoc.addSubview(lbCMNDTruocButton)
        
        if(self.ocfdFFriend != nil && isUploadCMNDTruoc != nil){
            let lbStatusUploadCMNDTruoc = UILabel(frame: CGRect(x:0,y:0,width:viewImageCMNDTruoc.frame.size.width,height:viewImageCMNDTruoc.frame.size.height))
            lbStatusUploadCMNDTruoc.textColor = UIColor.white
            lbStatusUploadCMNDTruoc.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbStatusUploadCMNDTruoc.textAlignment = .center
            lbStatusUploadCMNDTruoc.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewImageCMNDTruoc.addSubview(lbStatusUploadCMNDTruoc)
            lbStatusUploadCMNDTruoc.text = "Đã duyệt CMND (Mặt trước)"
        }else{
            let tapShowUQTN2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowUQTN2))
            viewImageCMNDTruoc.isUserInteractionEnabled = true
            viewImageCMNDTruoc.addGestureRecognizer(tapShowUQTN2)
        }
        
        viewInfoCMNDSau = UIView(frame: CGRect(x:0,y:viewImageCMNDTruoc.frame.origin.y + viewImageCMNDTruoc.frame.size.height,width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDSau.clipsToBounds = true
        viewInfoCMNDTruoc.addSubview(viewInfoCMNDSau)
        
        let lbTextCMNDSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDSau.textAlignment = .left
        lbTextCMNDSau.textColor = UIColor.black
        lbTextCMNDSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDSau.text = "Mặt sau CMND + IMEI"
        viewInfoCMNDSau.addSubview(lbTextCMNDSau)
        
        viewImageCMNDSau = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDSau.frame.origin.y + lbTextCMNDSau.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDSau.layer.borderWidth = 0.5
        viewImageCMNDSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDSau.layer.cornerRadius = 3.0
        viewInfoCMNDSau.addSubview(viewImageCMNDSau)
        
        let viewCMNDSauButton = UIImageView(frame: CGRect(x: viewImageCMNDSau.frame.size.width/2 - (viewImageCMNDSau.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDSau.frame.size.height * 2/3, height: viewImageCMNDSau.frame.size.height * 2/3))
        viewCMNDSauButton.image = UIImage(named:"AddImage")
        viewCMNDSauButton.contentMode = .scaleAspectFit
        viewImageCMNDSau.addSubview(viewCMNDSauButton)
        
        let lbCMNDSauButton = UILabel(frame: CGRect(x: 0, y: viewCMNDSauButton.frame.size.height + viewCMNDSauButton.frame.origin.y, width: viewImageCMNDSau.frame.size.width, height: viewImageCMNDSau.frame.size.height/3))
        lbCMNDSauButton.textAlignment = .center
        lbCMNDSauButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDSauButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDSauButton.text = "Thêm hình ảnh"
        viewImageCMNDSau.addSubview(lbCMNDSauButton)
        
        
        
        if(self.ocfdFFriend != nil && isUploadCMNDSau != nil){
            let lbStatusUploadCMNDSau = UILabel(frame: CGRect(x:0,y:0,width:viewImageCMNDSau.frame.size.width,height:viewImageCMNDSau.frame.size.height))
            lbStatusUploadCMNDSau.textColor = UIColor.white
            lbStatusUploadCMNDSau.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbStatusUploadCMNDSau.textAlignment = .center
            lbStatusUploadCMNDSau.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewImageCMNDSau.addSubview(lbStatusUploadCMNDSau)
            lbStatusUploadCMNDSau.text = "Đã duyệt CMND (Mặt sau)"
        }else{
            let tapShowUQTN3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowUQTN3))
            viewImageCMNDSau.isUserInteractionEnabled = true
            viewImageCMNDSau.addGestureRecognizer(tapShowUQTN3)
        }
        
        viewInfoAvatar = UIView(frame: CGRect(x:0,y:viewImageCMNDSau.frame.origin.y + viewImageCMNDSau.frame.size.height,width:scrollView.frame.size.width, height: 100))
        viewInfoAvatar.clipsToBounds = true
        viewInfoCMNDSau.addSubview(viewInfoAvatar)
        
        let lbTextAvatar = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextAvatar.textAlignment = .left
        lbTextAvatar.textColor = UIColor.black
        lbTextAvatar.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextAvatar.text = "Nhân viên trao sản phẩm cho KH"
        viewInfoAvatar.addSubview(lbTextAvatar)
        
        viewImageAvatar = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextAvatar.frame.origin.y + lbTextAvatar.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageAvatar.layer.borderWidth = 0.5
        viewImageAvatar.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageAvatar.layer.cornerRadius = 3.0
        viewInfoAvatar.addSubview(viewImageAvatar)
        
        let viewAvatarButton = UIImageView(frame: CGRect(x: viewImageAvatar.frame.size.width/2 - (viewImageAvatar.frame.size.height * 2/3)/2, y: 0, width: viewImageAvatar.frame.size.height * 2/3, height: viewImageAvatar.frame.size.height * 2/3))
        viewAvatarButton.image = UIImage(named:"AddImage")
        viewAvatarButton.contentMode = .scaleAspectFit
        viewImageAvatar.addSubview(viewAvatarButton)
        
        let lbAvatarButton = UILabel(frame: CGRect(x: 0, y: viewAvatarButton.frame.size.height + viewAvatarButton.frame.origin.y, width: viewImageCMNDSau.frame.size.width, height: viewImageAvatar.frame.size.height/3))
        lbAvatarButton.textAlignment = .center
        lbAvatarButton.textColor = UIColor(netHex:0xc2c2c2)
        lbAvatarButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbAvatarButton.text = "Thêm hình ảnh"
        viewImageAvatar.addSubview(lbAvatarButton)
        
        
        
        if(self.ocfdFFriend != nil && isUploadAvatar != nil){
            let lbStatusUploadAvatar = UILabel(frame: CGRect(x:0,y:0,width:viewImageAvatar.frame.size.width,height:viewImageAvatar.frame.size.height))
            lbStatusUploadAvatar.textColor = UIColor.white
            lbStatusUploadAvatar.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbStatusUploadAvatar.textAlignment = .center
            lbStatusUploadAvatar.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewImageAvatar.addSubview(lbStatusUploadAvatar)
            lbStatusUploadAvatar.text = "Đã duyệt ảnh chân dung KH"
        }else{
            let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
            viewImageAvatar.isUserInteractionEnabled = true
            viewImageAvatar.addGestureRecognizer(tapShowCMNDTruoc)
        }
        
        
        viewInfoSign = UIView(frame: CGRect(x:0,y:viewImageAvatar.frame.origin.y + viewImageAvatar.frame.size.height,width:scrollView.frame.size.width, height: 100))
        viewInfoSign.clipsToBounds = true
        viewInfoAvatar.addSubview(viewInfoSign)
        
        let lbTextSign = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSign.textAlignment = .left
        lbTextSign.textColor = UIColor.black
        lbTextSign.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSign.text = "Chữ ký khách hàng"
        viewInfoSign.addSubview(lbTextSign)
        
        viewImageSign = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSign.frame.origin.y + lbTextSign.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSign.layer.borderWidth = 0.5
        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSign.layer.cornerRadius = 3.0
        viewInfoSign.addSubview(viewImageSign)
        
        let viewSignButton = UIImageView(frame: CGRect(x: viewImageSign.frame.size.width/2 - (viewImageSign.frame.size.height * 2/3)/2, y: 0, width: viewImageSign.frame.size.height * 2/3, height: viewImageSign.frame.size.height * 2/3))
        viewSignButton.image = UIImage(named:"AddImage")
        viewSignButton.contentMode = .scaleAspectFit
        viewImageSign.addSubview(viewSignButton)
        
        let lbSignButton = UILabel(frame: CGRect(x: 0, y: viewSignButton.frame.size.height + viewSignButton.frame.origin.y, width: viewImageSign.frame.size.width, height: viewImageSign.frame.size.height/3))
        lbSignButton.textAlignment = .center
        lbSignButton.textColor = UIColor(netHex:0xc2c2c2)
        lbSignButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSignButton.text = "Thêm hình ảnh"
        viewImageSign.addSubview(lbSignButton)
        
        if(self.ocfdFFriend != nil && isUploadSign != nil){
            let lbStatusUploadSign = UILabel(frame: CGRect(x:0,y:0,width:viewImageSign.frame.size.width,height:viewImageSign.frame.size.height))
            lbStatusUploadSign.textColor = UIColor.white
            lbStatusUploadSign.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbStatusUploadSign.textAlignment = .center
            lbStatusUploadSign.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewImageSign.addSubview(lbStatusUploadSign)
            lbStatusUploadSign.text = "Đã duyệt chữ ký KH"
        }else{
            let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
            viewImageSign.isUserInteractionEnabled = true
            viewImageSign.addGestureRecognizer(tapShowCMNDSau)
        }
        
        viewInfoSign.frame.size.height = viewImageSign.frame.size.height + viewImageSign.frame.origin.y
        viewInfoAvatar.frame.size.height = viewInfoSign.frame.size.height + viewInfoSign.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewInfoAvatar.frame.size.height + viewInfoAvatar.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        
        btUploadImages = UIButton()
        btUploadImages.frame = CGRect(x: lbName.frame.origin.x, y: viewInfoCMNDTruoc.frame.origin.y + viewInfoCMNDTruoc.frame.size.height + Common.Size(s:20), width: lbName.frame.size.width, height: Common.Size(s: 40) * 1.2)
        btUploadImages.backgroundColor = UIColor(netHex:0xEF4A40)
        btUploadImages.setTitle("Lưu hình ảnh", for: .normal)
        btUploadImages.addTarget(self, action: #selector(actionUpload), for: .touchUpInside)
        btUploadImages.layer.borderWidth = 0.5
        btUploadImages.layer.borderColor = UIColor.white.cgColor
        btUploadImages.layer.cornerRadius = 3
        scrollView.addSubview(btUploadImages)
        viewInfoDetailOrder = UIView(frame: CGRect(x:0,y:btUploadImages.frame.origin.y + btUploadImages.frame.size.height,width:scrollView.frame.size.width, height: 100))
        scrollView.addSubview(viewInfoDetailOrder)
        if(ocfdFFriend != nil){
            viewInfoDetailOrder.frame.size.height = 0
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImages.frame.origin.y + btUploadImages.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
        }else{
            
            let soViewPhone = UIView()
            
            viewInfoDetailOrder.addSubview(soViewPhone)
            soViewPhone.frame = CGRect(x: lbName.frame.origin.x, y:  Common.Size(s:20), width: btUploadImages.frame.size.width, height: 100)
            
            let lbSODetail = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:20)))
            lbSODetail.textAlignment = .left
            lbSODetail.textColor = UIColor(netHex:0x47B054)
            lbSODetail.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
            lbSODetail.text = "THÔNG TIN ĐƠN HÀNG"
            soViewPhone.addSubview(lbSODetail)
            
            let line1 = UIView(frame: CGRect(x: soViewPhone.frame.size.width * 1.3/10, y:lbSODetail.frame.origin.y + lbSODetail.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
            line1.backgroundColor = UIColor(netHex:0x47B054)
            soViewPhone.addSubview(line1)
            let line2 = UIView(frame: CGRect(x: 0, y:line1.frame.origin.y + line1.frame.size.height, width: soViewPhone.frame.size.width, height: 1))
            line2.backgroundColor = UIColor(netHex:0x47B054)
            soViewPhone.addSubview(line2)
            
            let lbStt = UILabel(frame: CGRect(x: 0, y: line1.frame.origin.y, width: line1.frame.origin.x, height: line1.frame.size.height))
            lbStt.textAlignment = .center
            lbStt.textColor = UIColor(netHex:0x47B054)
            lbStt.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbStt.text = "STT"
            soViewPhone.addSubview(lbStt)
            
            let lbInfo = UILabel(frame: CGRect(x: line1.frame.origin.x, y: line1.frame.origin.y, width: lbSODetail.frame.size.width - line1.frame.origin.x, height: line1.frame.size.height))
            lbInfo.textAlignment = .center
            lbInfo.textColor = UIColor(netHex:0x47B054)
            lbInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbInfo.text = "Sản phẩm"
            soViewPhone.addSubview(lbInfo)
            
            var indexY = line2.frame.origin.y
            var indexHeight: CGFloat = line2.frame.origin.y + line2.frame.size.height
            var num = 0
            var totalPay:Float = 0.0
            for item in Cache.cartsFF{
                num = num + 1
                totalPay = totalPay + (item.product.price * Float(item.quantity))
                let soViewLine = UIView()
                soViewPhone.addSubview(soViewLine)
                soViewLine.frame = CGRect(x: 0, y: indexY, width: soViewPhone.frame.size.width, height: 50)
                let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
                line3.backgroundColor = UIColor(netHex:0x47B054)
                soViewLine.addSubview(line3)
                
                let nameProduct = "\(item.product.name)"
                let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewPhone.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
                let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 3, width: soViewPhone.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
                lbNameProduct.textAlignment = .left
                lbNameProduct.textColor = UIColor.black
                lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbNameProduct.text = nameProduct
                lbNameProduct.numberOfLines = 3
                soViewLine.addSubview(lbNameProduct)
                
                let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewPhone.frame.size.width - line3.frame.origin.x - 1, height: 1))
                line4.backgroundColor = UIColor(netHex:0x47B054)
                soViewLine.addSubview(line4)
                
                let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:14)))
                lbQuantityProduct.textAlignment = .left
                lbQuantityProduct.textColor = UIColor.black
                lbQuantityProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                if (item.product.qlSerial == "Y"){
                    lbQuantityProduct.text = "IMEI: \((item.imei))"
                }else{
                    lbQuantityProduct.text = "Số lượng: \((item.quantity))"
                }
                listImei.append(lbQuantityProduct)
                
                lbQuantityProduct.numberOfLines = 1
                soViewLine.addSubview(lbQuantityProduct)
                
                let lbPriceProduct = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height: Common.Size(s:14)))
                lbPriceProduct.textAlignment = .left
                lbPriceProduct.textColor = UIColor(netHex:0xEF4A40)
                lbPriceProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbPriceProduct.text = "Giá: \(Common.convertCurrencyFloat(value: (item.product.price)))"
                lbPriceProduct.numberOfLines = 1
                soViewLine.addSubview(lbPriceProduct)
                
                
                let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
                lbSttValue.textAlignment = .center
                lbSttValue.textColor = UIColor.black
                lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbSttValue.text = "\(num)"
                soViewLine.addSubview(lbSttValue)
                
                soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height + Common.Size(s:5))
                line3.frame.size.height = soViewLine.frame.size.height
                
                indexHeight = indexHeight + soViewLine.frame.size.height
                indexY = indexY + soViewLine.frame.size.height + soViewLine.frame.origin.x
            }
            
            soViewPhone.frame.size.height = indexHeight
            
            
            let lbTotal = UILabel(frame: CGRect(x:  Common.Size(s:15), y: soViewPhone.frame.origin.y + soViewPhone.frame.size.height + Common.Size(s:20), width: btUploadImages.frame.size.width, height: Common.Size(s:20)))
            lbTotal.textAlignment = .left
            lbTotal.textColor = UIColor(netHex:0x47B054)
            lbTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
            lbTotal.text = "THÔNG TIN THANH TOÁN"
            viewInfoDetailOrder.addSubview(lbTotal)
            
            let lbTotalText = UILabel(frame: CGRect(x:  Common.Size(s:15), y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: btUploadImages.frame.size.width, height: Common.Size(s:25)))
            lbTotalText.textAlignment = .left
            lbTotalText.textColor = UIColor.black
            lbTotalText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
            lbTotalText.text = "Tổng đơn hàng:"
            viewInfoDetailOrder.addSubview(lbTotalText)
            
            
            let lbTotalValue = UILabel(frame: CGRect(x:  Common.Size(s:15), y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: btUploadImages.frame.size.width, height: Common.Size(s:25)))
            lbTotalValue.textAlignment = .right
            lbTotalValue.textColor = UIColor(netHex:0xEF4A40)
            lbTotalValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
            lbTotalValue.text = Common.convertCurrencyFloat(value: totalPay)
            viewInfoDetailOrder.addSubview(lbTotalValue)
            
            let lbDiscountText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbTotalText.frame.origin.y + lbTotalText.frame.size.height, width: btUploadImages.frame.size.width, height: Common.Size(s:25)))
            lbDiscountText.textAlignment = .left
            lbDiscountText.textColor = UIColor.black
            lbDiscountText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
            lbDiscountText.text = "Trả trước:"
            viewInfoDetailOrder.addSubview(lbDiscountText)
            
            let lbDiscountValue = UILabel(frame: CGRect(x: lbTotalValue.frame.origin.x, y: lbDiscountText.frame.origin.y , width: btUploadImages.frame.size.width, height: Common.Size(s:25)))
            lbDiscountValue.textAlignment = .right
            lbDiscountValue.textColor = UIColor(netHex:0xEF4A40)
            lbDiscountValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
            lbDiscountValue.text = traTruoc
            viewInfoDetailOrder.addSubview(lbDiscountValue)
            
            let lbPayText = UILabel(frame: CGRect(x: lbDiscountText.frame.origin.x, y: lbDiscountText.frame.origin.y + lbDiscountText.frame.size.height, width: btUploadImages.frame.size.width, height: Common.Size(s:25)))
            lbPayText.textAlignment = .left
            lbPayText.textColor = UIColor.black
            lbPayText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
            lbPayText.text = "Số tiền còn lại:"
            viewInfoDetailOrder.addSubview(lbPayText)
            
            let lbPayValue = UILabel(frame: CGRect(x: lbPayText.frame.origin.x, y: lbPayText.frame.origin.y , width: btUploadImages.frame.size.width, height: Common.Size(s:25)))
            lbPayValue.textAlignment = .right
            lbPayValue.textColor = UIColor(netHex:0xEF4A40)
            lbPayValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
            lbPayValue.text = conLai
            viewInfoDetailOrder.addSubview(lbPayValue)
            
            viewInfoDetailOrder.frame.size.height = lbPayText.frame.size.height + lbPayText.frame.origin.y
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetailOrder.frame.origin.y + viewInfoDetailOrder.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
            
        }
    }
    func actionOpenMenuLeft() {
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionUpload(){
        if(self.ocfdFFriend == nil){
            
            if (imgViewCMNDTruoc == nil){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa có ảnh CMND mặt trước", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                    
                })
                self.present(alert, animated: true)
                
                return
            }
            if (imgViewCMNDSau == nil){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa có ảnh CMND mặt sau", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            if (imgViewAvatar == nil){
                
                let alert = UIAlertController(title: "Thông báo", message:  "Chưa có ảnh chân dung khách hàng", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            if (imgViewSign == nil){
                let alert = UIAlertController(title: "Thông báo", message:  "Chưa có chữ ký khách hàng", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang upload hình ảnh ..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            if let imageDataCMNDTruoc:NSData = imgViewCMNDTruoc.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                let strBase64CMNDTruoc = imageDataCMNDTruoc.base64EncodedString(options: .endLineWithLineFeed)
                
                if let imageDataSau:NSData = imgViewCMNDSau.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                    let strBase64CMNDSau = imageDataSau.base64EncodedString(options: .endLineWithLineFeed)
                    
                    if let imageDataAvatar:NSData = imgViewAvatar.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                        let strBase64Avatar = imageDataAvatar.base64EncodedString(options: .endLineWithLineFeed)
                        
                        let imageSign:UIImage = self.resizeImage(image: imgViewSign.image!,newHeight: 80)!
                        if let imageDataSign:NSData = imageSign.jpegData(compressionQuality: 0.75) as NSData?{
                            let strBase64Sign = imageDataSign.base64EncodedString(options: .endLineWithLineFeed)
                            
                            MPOSAPIManager.mpos_sp_UploadHinhAnhPDK(IDFinal: "\(self.idFinal)", ShopCode: "\(Cache.user!.ShopCode)", UserID: "\(Cache.user!.UserName)", ChuKy: strBase64Sign, DiviceType: "2", str64_CMNDMT: strBase64CMNDTruoc, str64_CMNDMS: strBase64CMNDSau, str64_ChanDung: strBase64Avatar, handler: { (results, err) in
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    if(err.count <= 0){
                                        let title = "THÔNG BÁO"
                                        let popup = PopupDialog(title: title, message: results, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                            print("Completed")
                                        }
                                        let buttonOne = CancelButton(title: "OK") {
                                            Cache.itemsPromotionTempFF.removeAll()
                                            Cache.cartsFF.removeAll()
                                            _ = self.navigationController?.popToRootViewController(animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                            let myDict = ["CMND": ""]
                                            let nc = NotificationCenter.default
                                            nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                    }else{
                                        let title = "THÔNG BÁO"
                                        let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                            print("Completed")
                                        }
                                        let buttonOne = CancelButton(title: "Thử lại") {
                                            
                                        }
                                        let buttonTwo = CancelButton(title: "Đóng") {
                                            Cache.itemsPromotionTempFF.removeAll()
                                            Cache.cartsFF.removeAll()
                                            _ = self.navigationController?.popToRootViewController(animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                        popup.addButtons([buttonOne,buttonTwo])
                                        self.present(popup, animated: true, completion: nil)
                                    }
                                }
                            })
                        }
                    }
                }
            }
            
        }else{
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang upload hình ảnh ..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            var strBase64CMNDTruoc:String = ""
            var strBase64CMNDSau:String = ""
            var strBase64Avatar:String = ""
            var strBase64Sign:String = ""
            
            if (isUploadCMNDTruoc == nil){
                if(imgViewCMNDTruoc == nil){
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let alert = UIAlertController(title: "Thông báo", message:   "Chưa có ảnh CMND mặt trước", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    return
                }else{
                    if let imageDataCMNDTruoc:NSData = imgViewCMNDTruoc.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                        strBase64CMNDTruoc = imageDataCMNDTruoc.base64EncodedString(options: .endLineWithLineFeed)
                    }
                }
            }
            if (isUploadCMNDSau == nil){
                if(imgViewCMNDSau == nil){
                    
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let alert = UIAlertController(title: "Thông báo", message:   "Chưa có ảnh CMND mặt sau", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    return
                }else{
                    if let imageDataSau:NSData = imgViewCMNDSau.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                        strBase64CMNDSau = imageDataSau.base64EncodedString(options: .endLineWithLineFeed)
                        
                    }
                }
            }
            if ( isUploadAvatar == nil){
                if(imgViewAvatar == nil){
                    
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let alert = UIAlertController(title: "Thông báo", message:  "Chưa có ảnh chân dung khách hàng", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    return
                }else{
                    if let imageDataAvatar:NSData = imgViewAvatar.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                        strBase64Avatar = imageDataAvatar.base64EncodedString(options: .endLineWithLineFeed)
                    }
                }
            }
            if (isUploadSign == nil){
                if(imgViewSign == nil){
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        
                        let alert = UIAlertController(title: "Thông báo", message:   "Chưa có chữ ký khách hàng", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    return
                }else{
                    let imageSign:UIImage = self.resizeImage(image: imgViewSign.image!,newHeight: 80)!
                    if let imageDataSign:NSData = imageSign.jpegData(compressionQuality: 0.75) as NSData?{
                        strBase64Sign = imageDataSign.base64EncodedString(options: .endLineWithLineFeed)
                    }
                }
            }
            //            let nameCMNDTruoc =  "\(self.ocfdFFriend!.MaCongTy)_\(self.ocfdFFriend!.CMND)_\(self.idFinal)_2.jpg"
            //            let nameCMNDSau =  "\(self.ocfdFFriend!.MaCongTy)_\(self.ocfdFFriend!.CMND)_\(self.idFinal)_3.jpg"
            //            let nameAvatar =  "\(self.ocfdFFriend!.MaCongTy)_\(self.ocfdFFriend!.CMND)_\(self.idFinal)_4.jpg"
            MPOSAPIManager.mpos_sp_UploadHinhAnhPDK(IDFinal: "\(self.idFinal)", ShopCode: "\(Cache.user!.ShopCode)", UserID: "\(Cache.user!.UserName)", ChuKy: strBase64Sign, DiviceType: "2", str64_CMNDMT: strBase64CMNDTruoc, str64_CMNDMS: strBase64CMNDSau, str64_ChanDung: strBase64Avatar, handler: { (results, err) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(err.count <= 0){
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: results, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            Cache.itemsPromotionTempFF.removeAll()
                            Cache.cartsFF.removeAll()
                            _ = self.navigationController?.popToRootViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                            let myDict = ["CMND": ""]
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }else{
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "Thử lại") {
                            
                        }
                        let buttonTwo = CancelButton(title: "Đóng") {
                            Cache.itemsPromotionTempFF.removeAll()
                            Cache.cartsFF.removeAll()
                            _ = self.navigationController?.popToRootViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }
                        popup.addButtons([buttonOne,buttonTwo])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            })
        }
        
    }
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
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
    func uploadAPI(IdCardCode:String,Link_UQTN_1:String,Link_UQTN_2:String,Link_UQTN_3:String,Link_CMNDMT:String,Link_CMNDMS:String,UserID:String){
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_sp_UploadChungTuHinhAnh(IdCardCode: IdCardCode, Link_UQTN_1: Link_UQTN_1, Link_UQTN_2: Link_UQTN_2, Link_UQTN_3: Link_UQTN_3, Link_CMNDMT: Link_CMNDMT, Link_CMNDMS: Link_CMNDMS, UserID: UserID) { (success, err) in
            
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    // Prepare the popup
                    let title = "THÔNG BÁO"
                    // Create the dialog
                    let popup = PopupDialog(title: title, message: success, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    
                    // Create first button
                    let buttonOne = CancelButton(title: "OK") {
                        
                        //                    _ = self.navigationController?.popToRootViewController(animated: true)
                        //                    self.dismiss(animated: true, completion: nil)
                        //
                        //                    let myDict = ["CMND": cmnd]
                        //                    let nc = NotificationCenter.default
                        //                    nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                        
                    }
                    // Add buttons to dialog
                    popup.addButtons([buttonOne])
                    
                    // Present dialog
                    self.present(popup, animated: true, completion: nil)
                }else{
                    // Prepare the popup
                    let title = "THÔNG BÁO"
                    // Create the dialog
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    
                    // Create first button
                    let buttonOne = CancelButton(title: "OK") {
                        
                        //                    _ = self.navigationController?.popToRootViewController(animated: true)
                        //                    self.dismiss(animated: true, completion: nil)
                        //
                        //                    let myDict = ["CMND": cmnd]
                        //                    let nc = NotificationCenter.default
                        //                    nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                        
                    }
                    // Add buttons to dialog
                    popup.addButtons([buttonOne])
                    
                    // Present dialog
                    self.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
    
    func tapShowUQTN1(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowUQTN2(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowUQTN3(sender:UITapGestureRecognizer) {
        self.posImageUpload = 3
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 4
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
         self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        
        let width = viewImageSign.frame.size.width - Common.Size(s:10)
        
        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        let heightImage:CGFloat = width / sca
        viewImageSign.subviews.forEach { $0.removeFromSuperview() }
        imgViewSign  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.size.width, height: heightImage))
        imgViewSign.contentMode = .scaleAspectFit
        imgViewSign.image = cropImage(image: signatureImage, toRect: boundingRect)
        viewImageSign.addSubview(imgViewSign)
        viewImageSign.frame.size.height = imgViewSign.frame.size.height + imgViewSign.frame.origin.y
        viewInfoSign.frame.size.height = viewImageSign.frame.size.height + viewImageSign.frame.origin.y
        viewInfoAvatar.frame.size.height = viewInfoSign.frame.size.height + viewInfoSign.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewInfoAvatar.frame.size.height + viewInfoAvatar.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        btUploadImages.frame.origin.y = viewInfoCMNDTruoc.frame.origin.y + viewInfoCMNDTruoc.frame.size.height + Common.Size(s:20)
        viewInfoDetailOrder.frame.origin.y = btUploadImages.frame.origin.y + btUploadImages.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetailOrder.frame.origin.y + viewInfoDetailOrder.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height  + Common.Size(s: 20))
        
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
        
    }
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    func imageUQTN2(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDTruoc.frame.size.width / sca
        viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s: 30), height: heightImage))
        imgViewCMNDTruoc.contentMode = .scaleAspectFit
        imgViewCMNDTruoc.image = image
        
        viewImageCMNDTruoc.addSubview(imgViewCMNDTruoc)
        viewImageCMNDTruoc.frame.size.height = imgViewCMNDTruoc.frame.origin.y + imgViewCMNDTruoc.frame.size.height
        viewInfoCMNDSau.frame.origin.y = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        btUploadImages.frame.origin.y = viewInfoCMNDTruoc.frame.origin.y + viewInfoCMNDTruoc.frame.size.height + Common.Size(s:20)
        
        viewInfoDetailOrder.frame.origin.y = btUploadImages.frame.origin.y + btUploadImages.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetailOrder.frame.origin.y + viewInfoDetailOrder.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
    }
    func imageUQTN3(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDSau.frame.size.width / sca
        viewImageCMNDSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.size.width, height: heightImage))
        imgViewCMNDSau.contentMode = .scaleAspectFit
        imgViewCMNDSau.image = image
        viewImageCMNDSau.addSubview(imgViewCMNDSau)
        
        viewImageCMNDSau.frame.size.height = imgViewCMNDSau.frame.origin.y + imgViewCMNDSau.frame.size.height
        viewInfoAvatar.frame.origin.y = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewInfoAvatar.frame.size.height + viewInfoAvatar.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        btUploadImages.frame.origin.y = viewInfoCMNDTruoc.frame.origin.y + viewInfoCMNDTruoc.frame.size.height + Common.Size(s:20)
        viewInfoDetailOrder.frame.origin.y = btUploadImages.frame.origin.y + btUploadImages.frame.size.height
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetailOrder.frame.origin.y + viewInfoDetailOrder.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height  + Common.Size(s: 20))
    }
    func imageCMNDTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageAvatar.frame.size.width / sca
        viewImageAvatar.subviews.forEach { $0.removeFromSuperview() }
        imgViewAvatar  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.size.width, height: heightImage))
        imgViewAvatar.contentMode = .scaleAspectFit
        imgViewAvatar.image = image
        viewImageAvatar.addSubview(imgViewAvatar)
        viewImageAvatar.frame.size.height = imgViewAvatar.frame.size.height + imgViewAvatar.frame.origin.y
        viewInfoSign.frame.origin.y = viewImageAvatar.frame.size.height + viewImageAvatar.frame.origin.y
        viewInfoAvatar.frame.size.height = viewInfoSign.frame.size.height + viewInfoSign.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewInfoAvatar.frame.size.height + viewInfoAvatar.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        btUploadImages.frame.origin.y = viewInfoCMNDTruoc.frame.origin.y + viewInfoCMNDTruoc.frame.size.height + Common.Size(s:20)
        viewInfoDetailOrder.frame.origin.y = btUploadImages.frame.origin.y + btUploadImages.frame.size.height
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetailOrder.frame.origin.y + viewInfoDetailOrder.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height  + Common.Size(s: 20))
    }
    func imageCMNDSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSign.frame.size.width / sca
        viewImageSign.subviews.forEach { $0.removeFromSuperview() }
        imgViewSign  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.size.width, height: heightImage))
        imgViewSign.contentMode = .scaleAspectFit
        imgViewSign.image = image
        viewImageSign.addSubview(imgViewSign)
        viewImageSign.frame.size.height = imgViewSign.frame.size.height + imgViewSign.frame.origin.y
        viewInfoSign.frame.size.height = viewImageSign.frame.size.height + viewImageSign.frame.origin.y
        viewInfoAvatar.frame.size.height = viewInfoSign.frame.size.height + viewInfoSign.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewInfoAvatar.frame.size.height + viewInfoAvatar.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        btUploadImages.frame.origin.y = viewInfoCMNDTruoc.frame.origin.y + viewInfoCMNDTruoc.frame.size.height + Common.Size(s:20)
        viewInfoDetailOrder.frame.origin.y = btUploadImages.frame.origin.y + btUploadImages.frame.size.height
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoDetailOrder.frame.origin.y + viewInfoDetailOrder.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height  + Common.Size(s: 20))
    }
}
extension UploadImageFFriendViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        if(self.historyFFriend != nil){
            if(self.historyFFriend!.Flag_album == 0){
                self.openCamera()
            }else{
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
        }else{
              self.openCamera()
        }
   
       
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // image is our desired image
        if (self.posImageUpload == 1){
            //            self.imageUQTN1(image: image)
        }else if (self.posImageUpload == 2){
            self.imageUQTN2(image: image)
        } else if (self.posImageUpload == 3){
            self.imageUQTN3(image: image)
        }else if (self.posImageUpload == 4){
            self.imageCMNDTruoc(image: image)
        }else if (self.posImageUpload == 5){
            self.imageCMNDSau(image: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}


