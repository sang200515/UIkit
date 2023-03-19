//
//  UploadUQTNViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
//import EPSignature
import PopupDialog
class UploadUQTNViewController: UIViewController,EPSignatureDelegate{
          var imagePicker = UIImagePickerController()
    var scrollView:UIScrollView!
    
    var viewImageUQTN1:UIView!
    var imgViewUQTN1: UIImageView!
    var viewUQTN1:UIView!
    
    var viewImageUQTN2:UIView!
    var imgViewUQTN2: UIImageView!
    var viewUQTN2:UIView!
    
    var viewImageUQTN3:UIView!
    var imgViewUQTN3: UIImageView!
    var viewUQTN3:UIView!
    
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    var viewCMNDTruoc:UIView!
    
    var viewImageCMNDSau:UIView!
    var imgViewCMNDSau: UIImageView!
    var viewCMNDSau:UIView!
    
    var viewInfoUQTN2:UIView!
    var viewInfoUQTN3:UIView!
    var viewInfoCMNDTruoc:UIView!
    var viewInfoCMNDSau:UIView!
    
    var posImageUpload:Int = -1
    
    var btUploadImages:UIButton!
    
    var idCardCode:String?
    var name:String?
    var nameBank:String?
    var cmnd:String?
    
    var isUploadUQTN1:Bool?
    var isUploadUQTN2:Bool?
    var isUploadUQTN3:Bool?
    var isUploadCMNDTruoc:Bool?
    var isUploadCMNDSau:Bool?
    
    var lbStatusUploadUQTN1: UILabel!
    var lbStatusUploadUQTN2: UILabel!
    var lbStatusUploadUQTN3: UILabel!
    var lbStatusUploadCMNDTruoc: UILabel!
    var lbStatusUploadCMNDSau:UILabel!
    var rolesImage:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Uỷ Quyền Trích Nợ NH"
        
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
        lbName.text = "\(name!)"
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
        lbCMND.text = "\(cmnd!)"
        scrollView.addSubview(lbCMND)
        
        let lbTextBank = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbCMND.frame.size.height + lbCMND.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBank.textAlignment = .left
        lbTextBank.textColor = UIColor.black
        lbTextBank.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBank.text = "Ngân hàng"
        scrollView.addSubview(lbTextBank)
        
        let lbBank = UILabel(frame: CGRect(x: Common.Size(s:15), y:lbTextBank.frame.size.height + lbTextBank.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbBank.textAlignment = .left
        lbBank.textColor = UIColor.black
        lbBank.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbBank.text =  "\(nameBank!)"
        scrollView.addSubview(lbBank)
        
        let lbTextUQTN1 = UILabel(frame: CGRect(x: Common.Size(s:15), y:lbBank.frame.size.height + lbBank.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextUQTN1.textAlignment = .left
        lbTextUQTN1.textColor = UIColor.black
        lbTextUQTN1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextUQTN1.text = "UQTN (Trang 1) (*)"
        scrollView.addSubview(lbTextUQTN1)
        
        viewImageUQTN1 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextUQTN1.frame.origin.y + lbTextUQTN1.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageUQTN1.layer.borderWidth = 0.5
        viewImageUQTN1.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageUQTN1.layer.cornerRadius = 3.0
        scrollView.addSubview(viewImageUQTN1)
        
        let viewUQTN1Button = UIImageView(frame: CGRect(x: viewImageUQTN1.frame.size.width/2 - (viewImageUQTN1.frame.size.height * 2/3)/2, y: 0, width: viewImageUQTN1.frame.size.height * 2/3, height: viewImageUQTN1.frame.size.height * 2/3))
        viewUQTN1Button.image = UIImage(named:"AddImage")
        viewUQTN1Button.contentMode = .scaleAspectFit
        viewImageUQTN1.addSubview(viewUQTN1Button)
        
        let lbUQTN1Button = UILabel(frame: CGRect(x: 0, y: viewUQTN1Button.frame.size.height + viewUQTN1Button.frame.origin.y, width: viewImageUQTN1.frame.size.width, height: viewImageUQTN1.frame.size.height/3))
        lbUQTN1Button.textAlignment = .center
        lbUQTN1Button.textColor = UIColor(netHex:0xc2c2c2)
        lbUQTN1Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbUQTN1Button.text = "Thêm hình ảnh"
        viewImageUQTN1.addSubview(lbUQTN1Button)
        
        if(isUploadUQTN1 != nil){
            lbStatusUploadUQTN1 = UILabel(frame: CGRect(x:0,y:0,width:viewImageUQTN1.frame.size.width,height:viewImageUQTN1.frame.size.height))
            lbStatusUploadUQTN1.textColor = UIColor.white
            lbStatusUploadUQTN1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbStatusUploadUQTN1.textAlignment = .center
            lbStatusUploadUQTN1.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewImageUQTN1.addSubview(lbStatusUploadUQTN1)
            lbStatusUploadUQTN1.text = "Đã duyệt UQTN (Trang 1)"
        }else{
            let tapShowUQTN1 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowUQTN1))
            viewImageUQTN1.isUserInteractionEnabled = true
            viewImageUQTN1.addGestureRecognizer(tapShowUQTN1)
        }
        
        viewInfoUQTN2 = UIView(frame: CGRect(x:0,y:viewImageUQTN1.frame.origin.y + viewImageUQTN1.frame.size.height,width:scrollView.frame.size.width, height: 100))
        //                viewInfoUQTN2.backgroundColor = .red
        viewInfoUQTN2.clipsToBounds = true
        scrollView.addSubview(viewInfoUQTN2)
        
        let lbTextUQTN2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextUQTN2.textAlignment = .left
        lbTextUQTN2.textColor = UIColor.black
        lbTextUQTN2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextUQTN2.text = "UQTN (Trang 2)"
        viewInfoUQTN2.addSubview(lbTextUQTN2)
        
        viewImageUQTN2 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextUQTN2.frame.origin.y + lbTextUQTN2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageUQTN2.layer.borderWidth = 0.5
        viewImageUQTN2.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageUQTN2.layer.cornerRadius = 3.0
        viewInfoUQTN2.addSubview(viewImageUQTN2)
        
        let viewUQTN2Button = UIImageView(frame: CGRect(x: viewImageUQTN2.frame.size.width/2 - (viewImageUQTN2.frame.size.height * 2/3)/2, y: 0, width: viewImageUQTN2.frame.size.height * 2/3, height: viewImageUQTN2.frame.size.height * 2/3))
        viewUQTN2Button.image = UIImage(named:"AddImage")
        viewUQTN2Button.contentMode = .scaleAspectFit
        viewImageUQTN2.addSubview(viewUQTN2Button)
        
        let lbUQTN2Button = UILabel(frame: CGRect(x: 0, y: viewUQTN2Button.frame.size.height + viewUQTN2Button.frame.origin.y, width: viewImageUQTN2.frame.size.width, height: viewImageUQTN2.frame.size.height/3))
        lbUQTN2Button.textAlignment = .center
        lbUQTN2Button.textColor = UIColor(netHex:0xc2c2c2)
        lbUQTN2Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbUQTN2Button.text = "Thêm hình ảnh"
        viewImageUQTN2.addSubview(lbUQTN2Button)
        
        
        
        if(isUploadUQTN2 != nil){
            lbStatusUploadUQTN2 = UILabel(frame: CGRect(x:0,y:0,width:viewImageUQTN2.frame.size.width,height:viewImageUQTN2.frame.size.height))
            lbStatusUploadUQTN2.textColor = UIColor.white
            lbStatusUploadUQTN2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbStatusUploadUQTN2.textAlignment = .center
            lbStatusUploadUQTN2.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewImageUQTN2.addSubview(lbStatusUploadUQTN2)
            lbStatusUploadUQTN2.text = "Đã duyệt UQTN (Trang 2)"
        }else{
            let tapShowUQTN2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowUQTN2))
            viewImageUQTN2.isUserInteractionEnabled = true
            viewImageUQTN2.addGestureRecognizer(tapShowUQTN2)
        }
        
        viewInfoUQTN3 = UIView(frame: CGRect(x:0,y:viewImageUQTN2.frame.origin.y + viewImageUQTN2.frame.size.height,width:scrollView.frame.size.width, height: 100))
        //                        viewInfoUQTN2.backgroundColor = .red
        viewInfoUQTN3.clipsToBounds = true
        viewInfoUQTN2.addSubview(viewInfoUQTN3)
        
        let lbTextUQTN3 = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextUQTN3.textAlignment = .left
        lbTextUQTN3.textColor = UIColor.black
        lbTextUQTN3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextUQTN3.text = "UQTN (Trang 3)"
        viewInfoUQTN3.addSubview(lbTextUQTN3)
        
        viewImageUQTN3 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextUQTN3.frame.origin.y + lbTextUQTN3.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageUQTN3.layer.borderWidth = 0.5
        viewImageUQTN3.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageUQTN3.layer.cornerRadius = 3.0
        viewInfoUQTN3.addSubview(viewImageUQTN3)
        
        let viewUQTN3Button = UIImageView(frame: CGRect(x: viewImageUQTN3.frame.size.width/2 - (viewImageUQTN3.frame.size.height * 2/3)/2, y: 0, width: viewImageUQTN3.frame.size.height * 2/3, height: viewImageUQTN3.frame.size.height * 2/3))
        viewUQTN3Button.image = UIImage(named:"AddImage")
        viewUQTN3Button.contentMode = .scaleAspectFit
        viewImageUQTN3.addSubview(viewUQTN3Button)
        
        let lbUQTN3Button = UILabel(frame: CGRect(x: 0, y: viewUQTN3Button.frame.size.height + viewUQTN3Button.frame.origin.y, width: viewImageUQTN3.frame.size.width, height: viewImageUQTN3.frame.size.height/3))
        lbUQTN3Button.textAlignment = .center
        lbUQTN3Button.textColor = UIColor(netHex:0xc2c2c2)
        lbUQTN3Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbUQTN3Button.text = "Thêm hình ảnh"
        viewImageUQTN3.addSubview(lbUQTN3Button)
        
        
        
        if(isUploadUQTN3 != nil){
            lbStatusUploadUQTN3 = UILabel(frame: CGRect(x:0,y:0,width:viewImageUQTN3.frame.size.width,height:viewImageUQTN3.frame.size.height))
            lbStatusUploadUQTN3.textColor = UIColor.white
            lbStatusUploadUQTN3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbStatusUploadUQTN3.textAlignment = .center
            lbStatusUploadUQTN3.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewImageUQTN3.addSubview(lbStatusUploadUQTN3)
            lbStatusUploadUQTN3.text = "Đã duyệt UQTN (Trang 3)"
            
        }else{
            let tapShowUQTN3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowUQTN3))
            viewImageUQTN3.isUserInteractionEnabled = true
            viewImageUQTN3.addGestureRecognizer(tapShowUQTN3)
        }
        
        viewInfoCMNDTruoc = UIView(frame: CGRect(x:0,y:viewImageUQTN3.frame.origin.y + viewImageUQTN3.frame.size.height,width:scrollView.frame.size.width, height: 100))
        //         viewInfoUQTN2.backgroundColor = .red
        viewInfoCMNDTruoc.clipsToBounds = true
        viewInfoUQTN3.addSubview(viewInfoCMNDTruoc)
        
        let lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDTruoc.textAlignment = .left
        lbTextCMNDTruoc.textColor = UIColor.black
        lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDTruoc.text = "Mặt trước CMND (*)"
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
        
        let lbCMNDTruocButton = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: viewImageUQTN3.frame.size.width, height: viewImageCMNDTruoc.frame.size.height/3))
        lbCMNDTruocButton.textAlignment = .center
        lbCMNDTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton.text = "Thêm hình ảnh"
        viewImageCMNDTruoc.addSubview(lbCMNDTruocButton)
        
        
        
        if(isUploadCMNDTruoc != nil){
            lbStatusUploadCMNDTruoc = UILabel(frame: CGRect(x:0,y:0,width:viewImageCMNDTruoc.frame.size.width,height:viewImageCMNDTruoc.frame.size.height))
            lbStatusUploadCMNDTruoc.textColor = UIColor.white
            lbStatusUploadCMNDTruoc.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbStatusUploadCMNDTruoc.textAlignment = .center
            lbStatusUploadCMNDTruoc.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewImageCMNDTruoc.addSubview(lbStatusUploadCMNDTruoc)
            lbStatusUploadCMNDTruoc.text = "Đã duyệt CMND (Mặt trước)"
        }else{
            let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
            viewImageCMNDTruoc.isUserInteractionEnabled = true
            viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
        }
        
        
        viewInfoCMNDSau = UIView(frame: CGRect(x:0,y:viewImageCMNDTruoc.frame.origin.y + viewImageCMNDTruoc.frame.size.height,width:scrollView.frame.size.width, height: 100))
        //         viewInfoUQTN2.backgroundColor = .red
        viewInfoCMNDSau.clipsToBounds = true
        viewInfoCMNDTruoc.addSubview(viewInfoCMNDSau)
        
        let lbTextCMNDSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDSau.textAlignment = .left
        lbTextCMNDSau.textColor = UIColor.black
        lbTextCMNDSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDSau.text = "Mặt sau CMND (*)"
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
        
        if(isUploadCMNDSau != nil){
            lbStatusUploadCMNDSau = UILabel(frame: CGRect(x:0,y:0,width:viewImageCMNDSau.frame.size.width,height:viewImageCMNDSau.frame.size.height))
            lbStatusUploadCMNDSau.textColor = UIColor.white
            lbStatusUploadCMNDSau.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbStatusUploadCMNDSau.textAlignment = .center
            lbStatusUploadCMNDSau.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewImageCMNDSau.addSubview(lbStatusUploadCMNDSau)
            lbStatusUploadCMNDSau.text = "Đã duyệt CMND (Mặt sau)"
        }else{
            let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
            viewImageCMNDSau.isUserInteractionEnabled = true
            viewImageCMNDSau.addGestureRecognizer(tapShowCMNDSau)
        }
        
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        viewInfoUQTN3.frame.size.height = viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y
        viewInfoUQTN2.frame.size.height = viewInfoUQTN3.frame.size.height + viewInfoUQTN3.frame.origin.y
        
        btUploadImages = UIButton()
        btUploadImages.frame = CGRect(x: lbName.frame.origin.x, y: viewInfoUQTN2.frame.origin.y + viewInfoUQTN2.frame.size.height + Common.Size(s:20), width: lbName.frame.size.width, height: Common.Size(s: 40) * 1.2)
        btUploadImages.backgroundColor = UIColor(netHex:0xEF4A40)
        btUploadImages.setTitle("Lưu hình ảnh", for: .normal)
        btUploadImages.addTarget(self, action: #selector(actionUpload), for: .touchUpInside)
        btUploadImages.layer.borderWidth = 0.5
        btUploadImages.layer.borderColor = UIColor.white.cgColor
        btUploadImages.layer.cornerRadius = 3
        
        scrollView.addSubview(btUploadImages)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImages.frame.origin.y + btUploadImages.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
    }
    @objc func actionUpload(){
        if (isUploadUQTN1 == nil && isUploadUQTN2 == nil && isUploadUQTN3 == nil && isUploadCMNDTruoc == nil && isUploadCMNDSau == nil){
            if (imgViewUQTN1 == nil){
                self.showDialog(message: "Chưa có ảnh Uỷ quyền trích nợ (Trang 1)")
                return
            }
            if (imgViewCMNDTruoc == nil){
                self.showDialog(message: "Chưa có ảnh CMND mặt trước")
                return
            }
            if (imgViewCMNDSau == nil){
                self.showDialog(message: "Chưa có ảnh CMND mặt sau")
                return
            }
            if(idCardCode == nil){
                self.showDialog(message: "Chưa thông tin ID hội viên")
                return
            }
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang đăng ký thông tin KH..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            if let imageDataUQTN:NSData = imgViewUQTN1.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                let strBase64UQTN1 = imageDataUQTN.base64EncodedString(options: .endLineWithLineFeed)
                
                if let imageDataCMNDMT:NSData = imgViewCMNDTruoc.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                    let strBase64CMNDMT = imageDataCMNDMT.base64EncodedString(options: .endLineWithLineFeed)
                    
                    
                    if let imageDataCMNDMS:NSData = imgViewCMNDSau.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                        let strBase64CMNDMS = imageDataCMNDMS.base64EncodedString(options: .endLineWithLineFeed)
                        
                        if(imgViewUQTN2 != nil && imgViewUQTN3 != nil){
                            
                            if let imageDataUQTN2:NSData = imgViewUQTN2.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                                let strBase64UQTN2 = imageDataUQTN2.base64EncodedString(options: .endLineWithLineFeed)
                                
                                
                                if let imageDataUQTN3:NSData = imgViewUQTN3.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                                    let strBase64UQTN3 = imageDataUQTN3.base64EncodedString(options: .endLineWithLineFeed)
                                    // call
                                    self.uploadAPI(IdCardCode: "\(idCardCode!)", Link_UQTN_1: strBase64UQTN1, Link_UQTN_2: strBase64UQTN2, Link_UQTN_3: strBase64UQTN3, Link_CMNDMT: strBase64CMNDMT, Link_CMNDMS: strBase64CMNDMS, UserID: "\(Cache.user!.UserName)")
                                }
                            }
                        }else if(imgViewUQTN2 != nil){
                            
                            if let imageDataUQTN2:NSData = imgViewUQTN2.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                                let strBase64UQTN2 = imageDataUQTN2.base64EncodedString(options: .endLineWithLineFeed)
                                let strBase64UQTN3 = ""
                                // call
                                self.uploadAPI(IdCardCode: "\(idCardCode!)", Link_UQTN_1: strBase64UQTN1, Link_UQTN_2: strBase64UQTN2, Link_UQTN_3: strBase64UQTN3, Link_CMNDMT: strBase64CMNDMT, Link_CMNDMS: strBase64CMNDMS, UserID: "\(Cache.user!.UserName)")
                            }
                        }else if(imgViewUQTN3 != nil){
                            
                            if let imageDataUQTN3:NSData = imgViewUQTN3.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                                let strBase64UQTN3 = imageDataUQTN3.base64EncodedString(options: .endLineWithLineFeed)
                                let strBase64UQTN2 = ""
                                // call
                                self.uploadAPI(IdCardCode: "\(idCardCode!)", Link_UQTN_1: strBase64UQTN1, Link_UQTN_2: strBase64UQTN2, Link_UQTN_3: strBase64UQTN3, Link_CMNDMT: strBase64CMNDMT, Link_CMNDMS: strBase64CMNDMS, UserID: "\(Cache.user!.UserName)")
                            }
                        }else{
                            let strBase64UQTN3 = ""
                            let strBase64UQTN2 = ""
                            // call
                            self.uploadAPI(IdCardCode: "\(idCardCode!)", Link_UQTN_1: strBase64UQTN1, Link_UQTN_2: strBase64UQTN2, Link_UQTN_3: strBase64UQTN3, Link_CMNDMT: strBase64CMNDMT, Link_CMNDMS: strBase64CMNDMS, UserID: "\(Cache.user!.UserName)")
                        }
                    }
                }
            }
        }else{
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang upload thông tin KH..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            var strBase64UQTN1:String = ""
            var strBase64CMNDMT:String = ""
            var strBase64CMNDMS:String = ""
            var strBase64UQTN2:String = ""
            var strBase64UQTN3:String = ""
            if(isUploadUQTN1 == nil){
                if (imgViewUQTN1 == nil){
                    
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        self.showDialog(message: "Chưa có ảnh Uỷ quyền trích nợ (Trang 1)")
                    }
                    return
                }
                
                if let imageDataUQTN:NSData = imgViewUQTN1.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                    strBase64UQTN1 = imageDataUQTN.base64EncodedString(options: .endLineWithLineFeed)
                }
            }
            if(isUploadCMNDTruoc == nil){
                if (imgViewCMNDTruoc == nil){
                    
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        self.showDialog(message: "Chưa có ảnh CMND mặt trước")
                    }
                    return
                }
                
                if let imageDataCMNDMT:NSData = imgViewCMNDTruoc.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                    strBase64CMNDMT = imageDataCMNDMT.base64EncodedString(options: .endLineWithLineFeed)
                    
                }
            }
            if(isUploadCMNDSau == nil){
                if (imgViewCMNDSau == nil){
                    
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        self.showDialog(message: "Chưa có ảnh CMND mặt sau")
                    }
                    return
                }
                
                if let imageDataCMNDMS:NSData = imgViewCMNDSau.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                    strBase64CMNDMS   = imageDataCMNDMS.base64EncodedString(options: .endLineWithLineFeed)
                }
            }
            if(isUploadUQTN2 == nil && imgViewUQTN2 != nil){
                
                if let imageDataUQTN2:NSData = imgViewUQTN2.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                    strBase64UQTN2 = imageDataUQTN2.base64EncodedString(options: .endLineWithLineFeed)
                    
                }
            }
            if(isUploadUQTN3 == nil &&  imgViewUQTN3 != nil){
                
                if let imageDataUQTN3:NSData = imgViewUQTN3.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                    strBase64UQTN3 = imageDataUQTN3.base64EncodedString(options: .endLineWithLineFeed)
                }
            }
            
            if(isUploadUQTN1 == nil && strBase64UQTN1 == ""){
                
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    self.showDialog(message:  "Chưa tạo ảnh Uỷ quyền trích nợ (Trang 1). Vui lòng thử lại!")
                }
                return
            }
            if(isUploadCMNDTruoc == nil && strBase64CMNDMT == ""){
                
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    self.showDialog(message: "Chưa tạo ảnh CMND (Mặt trước). Vui lòng thử lại!")
                }
                return
            }
            if(isUploadCMNDSau == nil && strBase64CMNDMS == ""){
                
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    self.showDialog(message: "Chưa tạo ảnh CMND (Mặt sau). Vui lòng thử lại!")
                }
                return
            }
            
            self.uploadAPI(IdCardCode: "\(idCardCode!)", Link_UQTN_1: strBase64UQTN1, Link_UQTN_2: strBase64UQTN2, Link_UQTN_3: strBase64UQTN3, Link_CMNDMT: strBase64CMNDMT, Link_CMNDMS: strBase64CMNDMS, UserID: "\(Cache.user!.UserName)")
        }
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
                        
                        _ = self.navigationController?.popToRootViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                        
                        let myDict = ["CMND": self.cmnd]
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                        
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
    func resizeImageWidth(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    @objc func tapShowUQTN1(sender:UITapGestureRecognizer) {
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
        self.posImageUpload = 5
        self.thisIsTheFunctionWeAreCalling()
    }
    func imageUQTN1(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageUQTN1.frame.size.width / sca
        viewImageUQTN1.subviews.forEach { $0.removeFromSuperview() }
        imgViewUQTN1  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageUQTN1.frame.size.width, height: heightImage))
        imgViewUQTN1.contentMode = .scaleAspectFit
        imgViewUQTN1.image = image
        
        viewImageUQTN1.addSubview(imgViewUQTN1)
        viewImageUQTN1.frame.size.height = imgViewUQTN1.frame.origin.y + imgViewUQTN1.frame.size.height
        viewInfoUQTN2.frame.origin.y = viewImageUQTN1.frame.size.height + viewImageUQTN1.frame.origin.y
        btUploadImages.frame.origin.y = viewInfoUQTN2.frame.origin.y + viewInfoUQTN2.frame.size.height + Common.Size(s:20)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImages.frame.origin.y + btUploadImages.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 40))
    }
    func imageUQTN2(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageUQTN2.frame.size.width / sca
        viewImageUQTN2.subviews.forEach { $0.removeFromSuperview() }
        imgViewUQTN2  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageUQTN1.frame.size.width, height: heightImage))
        imgViewUQTN2.contentMode = .scaleAspectFit
        imgViewUQTN2.image = image
        
        viewImageUQTN2.addSubview(imgViewUQTN2)
        viewImageUQTN2.frame.size.height = imgViewUQTN2.frame.origin.y + imgViewUQTN2.frame.size.height
        viewInfoUQTN3.frame.origin.y = viewImageUQTN2.frame.size.height + viewImageUQTN2.frame.origin.y
        viewInfoUQTN2.frame.size.height = viewInfoUQTN3.frame.size.height + viewInfoUQTN3.frame.origin.y
        btUploadImages.frame.origin.y = viewInfoUQTN2.frame.origin.y + viewInfoUQTN2.frame.size.height + Common.Size(s:20)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImages.frame.origin.y + btUploadImages.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 40))
    }
    func imageUQTN3(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageUQTN3.frame.size.width / sca
        viewImageUQTN3.subviews.forEach { $0.removeFromSuperview() }
        imgViewUQTN3  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageUQTN2.frame.size.width, height: heightImage))
        imgViewUQTN3.contentMode = .scaleAspectFit
        imgViewUQTN3.image = image
        viewImageUQTN3.addSubview(imgViewUQTN3)
        
        viewImageUQTN3.frame.size.height = imgViewUQTN3.frame.origin.y + imgViewUQTN3.frame.size.height
        viewInfoCMNDTruoc.frame.origin.y = viewImageUQTN3.frame.size.height + viewImageUQTN3.frame.origin.y
        viewInfoUQTN3.frame.size.height = viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y
        viewInfoUQTN2.frame.size.height = viewInfoUQTN3.frame.size.height + viewInfoUQTN3.frame.origin.y
        btUploadImages.frame.origin.y = viewInfoUQTN2.frame.origin.y + viewInfoUQTN2.frame.size.height + Common.Size(s:20)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImages.frame.origin.y + btUploadImages.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 40))
    }
    func imageCMNDTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDTruoc.frame.size.width / sca
        viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageUQTN2.frame.size.width, height: heightImage))
        imgViewCMNDTruoc.contentMode = .scaleAspectFit
        imgViewCMNDTruoc.image = image
        viewImageCMNDTruoc.addSubview(imgViewCMNDTruoc)
        viewImageCMNDTruoc.frame.size.height = imgViewCMNDTruoc.frame.size.height + imgViewCMNDTruoc.frame.origin.y
        viewInfoCMNDSau.frame.origin.y = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        viewInfoUQTN3.frame.size.height = viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y
        viewInfoUQTN2.frame.size.height = viewInfoUQTN3.frame.size.height + viewInfoUQTN3.frame.origin.y
        btUploadImages.frame.origin.y = viewInfoUQTN2.frame.origin.y + viewInfoUQTN2.frame.size.height + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImages.frame.origin.y + btUploadImages.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 40))
    }
    func imageCMNDSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDSau.frame.size.width / sca
        viewImageCMNDSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageUQTN2.frame.size.width, height: heightImage))
        imgViewCMNDSau.contentMode = .scaleAspectFit
        imgViewCMNDSau.image = image
        viewImageCMNDSau.addSubview(imgViewCMNDSau)
        viewImageCMNDSau.frame.size.height = imgViewCMNDSau.frame.size.height + imgViewCMNDSau.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
        viewInfoUQTN3.frame.size.height = viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y
        viewInfoUQTN2.frame.size.height = viewInfoUQTN3.frame.size.height + viewInfoUQTN3.frame.origin.y
        btUploadImages.frame.origin.y = viewInfoUQTN2.frame.origin.y + viewInfoUQTN2.frame.size.height + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImages.frame.origin.y + btUploadImages.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 40))
    }
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}
extension UploadUQTNViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
          //self.openCamera()
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
        
        // image is our desired image
        if (self.posImageUpload == 1){
            self.imageUQTN1(image: image)
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

