//
//  UploadImagesCreditNoCardViewControllerV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import ActionSheetPicker_3_0
class UploadImagesCreditNoCardViewControllerV2: UIViewController,UITextFieldDelegate {
      var imagePicker = UIImagePickerController()
    var scrollView:UIScrollView!
    var tfName, tfCMND:UITextField!
    var name:String = ""
    var cmnd:String = ""
    var isUpdate:Bool = false
    var linkCMNDMT:String = ""
    var linkCMNDMS:String = ""
    
    var nameProduct:String = ""
    var idCardCode:String = ""
    var companyButton: SearchTextField!
    var listBank:[BankFFriend] = []
    var selectBank:String = ""
    var viewUpload:UIView!
    var btUpload:UIButton!
    
    var ocfdFFriend: OCRDFFriend?
    
    //--
    var viewInfoCMNDTruoc:UIView!
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    var viewCMNDTruoc:UIView!
    //--
    
    //--
    var viewInfoCMNDSau:UIView!
    var viewImageCMNDSau:UIView!
    var imgViewCMNDSau: UIImageView!
    var viewCMNDSau:UIView!
    //--
    
    //--
    var viewInfoAvatar:UIView!
    var viewImageAvatar:UIView!
    var imgVieAvatar: UIImageView!
    var viewAvatar:UIView!
    //--
    //--
    var viewInfoAvatarSign:UIView!
    var viewImageAvatarSign:UIView!
    var imgVieAvatarSign: UIImageView!
    var viewAvatarSign:UIView!
    //--
    //--
    var viewInfoGPLXTruoc:UIView!
    var viewImageGPLXTruoc:UIView!
    var imgViewGPLXTruoc: UIImageView!
    var viewGPLXTruoc:UIView!
    //--
    
    //--
    var viewInfoGPLXSau:UIView!
    var viewImageGPLXSau:UIView!
    var imgViewGPLXSau: UIImageView!
    var viewGPLXSau:UIView!
    //--
    //--
    var viewInfoFormRegister:UIView!
    var viewImageFormRegister:UIView!
    var imgViewFormRegister: UIImageView!
    var viewFormRegister:UIView!
    //--
    //--
    var viewInfoTrichNoTD:UIView!
    var viewImageTrichNoTD:UIView!
    var imgViewTrichNoTD: UIImageView!
    var viewTrichNoTD:UIView!
    //--
    //--
    var viewInfoTrichNoTDTrang2:UIView!
    var viewImageTrichNoTDTrang2:UIView!
    var imgViewTrichNoTDTrang2: UIImageView!
    var viewTrichNoTDTrang2:UIView!
    //--
    //--
    var viewInfoSoHK:UIView!
    var viewImageSoHK:UIView!
    var imgViewSoHK: UIImageView!
    var viewSoHK:UIView!
    //--
    
    var lbInfoUploadMore:UILabel!
    
    //---
    var viewUploadMore:UIView!
    
    //--
    var viewInfoSoHKTrang2:UIView!
    var viewImageSoHKTrang2:UIView!
    var imgViewSoHKTrang2: UIImageView!
    var viewSoHKTrang2:UIView!
    //--
    //--
    var viewInfoSoHKTrang3:UIView!
    var viewImageSoHKTrang3:UIView!
    var imgViewSoHKTrang3: UIImageView!
    var viewSoHKTrang3:UIView!
    //--
    //--
    var viewInfoSoHKTrang4:UIView!
    var viewImageSoHKTrang4:UIView!
    var imgViewSoHKTrang4: UIImageView!
    var viewSoHKTrang4:UIView!
    //--
    //--
    var viewInfoSoHKTrang5:UIView!
    var viewImageSoHKTrang5:UIView!
    var imgViewSoHKTrang5: UIImageView!
    var viewSoHKTrang5:UIView!
    //--
    //--
    var viewInfoSoHKTrang6:UIView!
    var viewImageSoHKTrang6:UIView!
    var imgViewSoHKTrang6: UIImageView!
    var viewSoHKTrang6:UIView!
    //--
    //--
    var viewInfoSoHKTrang7:UIView!
    var viewImageSoHKTrang7:UIView!
    var imgViewSoHKTrang7: UIImageView!
    var viewSoHKTrang7:UIView!
    //--
    //--
    var viewInfoSoHKTrang8:UIView!
    var viewImageSoHKTrang8:UIView!
    var imgViewSoHKTrang8: UIImageView!
    var viewSoHKTrang8:UIView!
    //--
    
    var heightUploadView:CGFloat = 0.0
    
    var posImageUpload:Int = -1
    
    
    var imagesUpload: [String:UIImageView] = [:]
    var nameimagesUpload: [String:String] = [:]
    var fullFlagArr:[String] = []
    
    var isChooseCMNDMT: Bool = false
    var isChooseCMNDMS: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        isChooseCMNDMT = false
        isChooseCMNDMS = false
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Upload xác nhận đăng ký Credit"
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin CMND..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        self.nameimagesUpload.removeAll()
        MPOSAPIManager.mpos_sp_GetLink_CMND_UQTN_Credit(CMND: cmnd) { (cmndmt, cmndms, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                self.linkCMNDMT = cmndmt
                self.linkCMNDMS = cmndms
                self.loadUI()
            }
        }
    }
    func loadUI(){
        if(self.ocfdFFriend != nil){
            fullFlagArr = self.ocfdFFriend!.Flag_Credit.components(separatedBy: ",")
        }
        let lbTextName = UILabel(frame: CGRect(x: Common.Size(s:15), y:Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextName.textAlignment = .left
        lbTextName.textColor = UIColor.black
        lbTextName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextName.text = "Tên khách hàng (*)"
        scrollView.addSubview(lbTextName)
        
        tfName = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextName.frame.size.height + lbTextName.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfName.borderStyle = UITextField.BorderStyle.roundedRect
        tfName.autocorrectionType = UITextAutocorrectionType.no
        tfName.keyboardType = UIKeyboardType.default
        tfName.returnKeyType = UIReturnKeyType.done
        tfName.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfName.delegate = self
        tfName.placeholder = "Ghi đầy đủ họ tên bằng Tiếng Việt có dấu"
        scrollView.addSubview(tfName)
        tfName.text = "\(name)"
        tfName.isEnabled = false
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfName.frame.size.height + tfName.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "CMND (*)"
        scrollView.addSubview(lbTextCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.size.height + lbTextCMND.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.default
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        tfCMND.placeholder = "Ghi đầy đủ số CMND khách hàng"
        scrollView.addSubview(tfCMND)
        tfCMND.text = "\(cmnd)"
        tfCMND.isEnabled = false
        
        let lbTextBank = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBank.textAlignment = .left
        lbTextBank.textColor = UIColor.black
        lbTextBank.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbTextBank.text = "Tên ngân hàng"
        scrollView.addSubview(lbTextBank)
        
        companyButton = SearchTextField(frame: CGRect(x: lbTextBank.frame.origin.x, y: lbTextBank.frame.origin.y + lbTextBank.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        companyButton.placeholder = "Chọn tên ngân hàng"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        companyButton.delegate = self
        scrollView.addSubview(companyButton)
        
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
        companyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        viewUpload = UIView(frame: CGRect(x: 0, y: companyButton.frame.origin.y + companyButton.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: Common.Size(s:100) ))
        //        viewUpload.backgroundColor = .red
        scrollView.addSubview(viewUpload)
        
        //---CMND TRUOC
        viewInfoCMNDTruoc = UIView(frame: CGRect(x:0,y:0,width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDTruoc.clipsToBounds = true
        viewUpload.addSubview(viewInfoCMNDTruoc)
        
        let lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
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
        
        
        let lbCMNDTruocButton = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDTruoc.frame.size.height/3))
        lbCMNDTruocButton.textAlignment = .center
        lbCMNDTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton.text = "Thêm hình ảnh"
        viewImageCMNDTruoc.addSubview(lbCMNDTruocButton)
        viewInfoCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        
        //        let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
        //        viewImageCMNDTruoc.isUserInteractionEnabled = true
        //        viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
        
        
        
        
        //---------
        
        //---CMND SAU
        viewInfoCMNDSau = UIView(frame: CGRect(x:0,y:viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDSau.clipsToBounds = true
        viewUpload.addSubview(viewInfoCMNDSau)
        
        let lbTextCMNDSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
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
        
        let lbCMNDSauButton = UILabel(frame: CGRect(x: 0, y: viewCMNDSauButton.frame.size.height + viewCMNDSauButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDSau.frame.size.height/3))
        lbCMNDSauButton.textAlignment = .center
        lbCMNDSauButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDSauButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDSauButton.text = "Thêm hình ảnh"
        viewImageCMNDSau.addSubview(lbCMNDSauButton)
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        
        //        let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
        //        viewImageCMNDSau.isUserInteractionEnabled = true
        //        viewImageCMNDSau.addGestureRecognizer(tapShowCMNDSau)
        
        //---CMND Avatar
        viewInfoAvatar = UIView(frame: CGRect(x:0,y:viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoAvatar.clipsToBounds = true
        viewUpload.addSubview(viewInfoAvatar)
        
        let lbTextAvatar = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextAvatar.textAlignment = .left
        lbTextAvatar.textColor = UIColor.black
        lbTextAvatar.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextAvatar.text = "Chân dung KH cầm CMND (*)"
        viewInfoAvatar.addSubview(lbTextAvatar)
        
        let  lbInfoCheckAvatar = UILabel(frame: CGRect(x:scrollView.frame.size.width/2, y: lbTextAvatar.frame.origin.y, width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbInfoCheckAvatar.textAlignment = .right
        lbInfoCheckAvatar.textColor = UIColor(netHex:0x47B054)
        lbInfoCheckAvatar.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttributeAvatar = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedStringAvatar = NSAttributedString(string: "Ảnh mẫu", attributes: underlineAttributeAvatar)
        lbInfoCheckAvatar.attributedText = underlineAttributedStringAvatar
        viewInfoAvatar.addSubview(lbInfoCheckAvatar)
        let tapShowCheckAvatar = UITapGestureRecognizer(target: self, action: #selector(UploadImagesCreditNoCardViewControllerV2.tapShowCheckAvatar))
        lbInfoCheckAvatar.isUserInteractionEnabled = true
        lbInfoCheckAvatar.addGestureRecognizer(tapShowCheckAvatar)
        
        
        viewImageAvatar = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextAvatar.frame.origin.y + lbTextAvatar.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageAvatar.layer.borderWidth = 0.5
        viewImageAvatar.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageAvatar.layer.cornerRadius = 3.0
        viewInfoAvatar.addSubview(viewImageAvatar)
        
        let viewAvatarButton = UIImageView(frame: CGRect(x: viewImageAvatar.frame.size.width/2 - (viewImageAvatar.frame.size.height * 2/3)/2, y: 0, width: viewImageAvatar.frame.size.height * 2/3, height: viewImageAvatar.frame.size.height * 2/3))
        viewAvatarButton.image = UIImage(named:"AddImage")
        viewAvatarButton.contentMode = .scaleAspectFit
        viewImageAvatar.addSubview(viewAvatarButton)
        
        let lbAvatarButton = UILabel(frame: CGRect(x: 0, y: viewAvatarButton.frame.size.height + viewAvatarButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbAvatarButton.textAlignment = .center
        lbAvatarButton.textColor = UIColor(netHex:0xc2c2c2)
        lbAvatarButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbAvatarButton.text = "Thêm hình ảnh"
        viewImageAvatar.addSubview(lbAvatarButton)
        viewInfoAvatar.frame.size.height = viewImageAvatar.frame.size.height + viewImageAvatar.frame.origin.y
        //        let tapShowAvatar = UITapGestureRecognizer(target: self, action: #selector(self.tapShowAvatar))
        //        viewImageAvatar.isUserInteractionEnabled = true
        //        viewImageAvatar.addGestureRecognizer(tapShowAvatar)
        
        //---CMND Avatar Sign
        viewInfoAvatarSign = UIView(frame: CGRect(x:0,y:viewInfoAvatar.frame.size.height + viewInfoAvatar.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoAvatarSign.clipsToBounds = true
        viewUpload.addSubview(viewInfoAvatarSign)
        
        let lbTextAvatarSign = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextAvatarSign.textAlignment = .left
        lbTextAvatarSign.textColor = UIColor.black
        lbTextAvatarSign.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextAvatarSign.text = "Chân dung KH đang ký form mở thẻ (*)"
        viewInfoAvatarSign.addSubview(lbTextAvatarSign)
        
        let  lbInfoCheckAvatarSign = UILabel(frame: CGRect(x:scrollView.frame.size.width/2, y: lbTextAvatar.frame.origin.y, width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbInfoCheckAvatarSign.textAlignment = .right
        lbInfoCheckAvatarSign.textColor = UIColor(netHex:0x47B054)
        lbInfoCheckAvatarSign.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttributeAvatarSign = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedStringAvatarSign = NSAttributedString(string: "Ảnh mẫu", attributes: underlineAttributeAvatarSign)
        lbInfoCheckAvatarSign.attributedText = underlineAttributedStringAvatarSign
        viewInfoAvatarSign.addSubview(lbInfoCheckAvatarSign)
        let tapShowCheckAvatarSign = UITapGestureRecognizer(target: self, action: #selector(UploadImagesCreditNoCardViewControllerV2.tapShowCheckAvatarForm))
        lbInfoCheckAvatarSign.isUserInteractionEnabled = true
        lbInfoCheckAvatarSign.addGestureRecognizer(tapShowCheckAvatarSign)
        
        viewImageAvatarSign = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextAvatarSign.frame.origin.y + lbTextAvatarSign.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageAvatarSign.layer.borderWidth = 0.5
        viewImageAvatarSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageAvatarSign.layer.cornerRadius = 3.0
        viewInfoAvatarSign.addSubview(viewImageAvatarSign)
        
        let viewAvatarButtonSign = UIImageView(frame: CGRect(x: viewImageAvatarSign.frame.size.width/2 - (viewImageAvatarSign.frame.size.height * 2/3)/2, y: 0, width: viewImageAvatarSign.frame.size.height * 2/3, height: viewImageAvatarSign.frame.size.height * 2/3))
        viewAvatarButtonSign.image = UIImage(named:"AddImage")
        viewAvatarButtonSign.contentMode = .scaleAspectFit
        viewImageAvatarSign.addSubview(viewAvatarButtonSign)
        
        let lbAvatarButtonSign = UILabel(frame: CGRect(x: 0, y: viewAvatarButtonSign.frame.size.height + viewAvatarButtonSign.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatarSign.frame.size.height/3))
        lbAvatarButtonSign.textAlignment = .center
        lbAvatarButtonSign.textColor = UIColor(netHex:0xc2c2c2)
        lbAvatarButtonSign.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbAvatarButtonSign.text = "Thêm hình ảnh"
        viewImageAvatarSign.addSubview(lbAvatarButtonSign)
        viewInfoAvatarSign.frame.size.height = viewImageAvatarSign.frame.size.height + viewImageAvatarSign.frame.origin.y
        
        //        let tapShowAvatar = UITapGestureRecognizer(target: self, action: #selector(self.tapShowAvatar))
        //        viewImageAvatar.isUserInteractionEnabled = true
        //        viewImageAvatar.addGestureRecognizer(tapShowAvatar)
        
        //---GPLX TRUOC
        viewInfoGPLXTruoc = UIView(frame: CGRect(x:0,y:viewInfoAvatarSign.frame.size.height + viewInfoAvatarSign.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoGPLXTruoc.clipsToBounds = true
        viewUpload.addSubview(viewInfoGPLXTruoc)
        
        let lbTextGPLXTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextGPLXTruoc.textAlignment = .left
        lbTextGPLXTruoc.textColor = UIColor.black
        lbTextGPLXTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextGPLXTruoc.text = "Giấy phép lái xe (mặt trước)"
        viewInfoGPLXTruoc.addSubview(lbTextGPLXTruoc)
        
        viewImageGPLXTruoc = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextGPLXTruoc.frame.origin.y + lbTextGPLXTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageGPLXTruoc.layer.borderWidth = 0.5
        viewImageGPLXTruoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageGPLXTruoc.layer.cornerRadius = 3.0
        viewInfoGPLXTruoc.addSubview(viewImageGPLXTruoc)
        
        let viewGPLXTruocButton = UIImageView(frame: CGRect(x: viewImageGPLXTruoc.frame.size.width/2 - (viewImageGPLXTruoc.frame.size.height * 2/3)/2, y: 0, width: viewImageGPLXTruoc.frame.size.height * 2/3, height: viewImageGPLXTruoc.frame.size.height * 2/3))
        viewGPLXTruocButton.image = UIImage(named:"AddImage")
        viewGPLXTruocButton.contentMode = .scaleAspectFit
        viewImageGPLXTruoc.addSubview(viewGPLXTruocButton)
        
        let lbGPLXTruocButton = UILabel(frame: CGRect(x: 0, y: viewGPLXTruocButton.frame.size.height + viewGPLXTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbGPLXTruocButton.textAlignment = .center
        lbGPLXTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbGPLXTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGPLXTruocButton.text = "Thêm hình ảnh"
        viewImageGPLXTruoc.addSubview(lbGPLXTruocButton)
        viewInfoGPLXTruoc.frame.size.height = viewImageAvatar.frame.size.height + viewImageAvatar.frame.origin.y
        
        //        let tapShowGPLXTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowGPLXTruoc))
        //        viewImageGPLXTruoc.isUserInteractionEnabled = true
        //        viewImageGPLXTruoc.addGestureRecognizer(tapShowGPLXTruoc)
        
        //---GPLX Sau
        viewInfoGPLXSau = UIView(frame: CGRect(x:0,y:viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoGPLXSau.clipsToBounds = true
        viewUpload.addSubview(viewInfoGPLXSau)
        
        let lbTextGPLXSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextGPLXSau.textAlignment = .left
        lbTextGPLXSau.textColor = UIColor.black
        lbTextGPLXSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextGPLXSau.text = "Giấy phép lái xe (mặt sau)"
        viewInfoGPLXSau.addSubview(lbTextGPLXSau)
        
        viewImageGPLXSau = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextGPLXSau.frame.origin.y + lbTextGPLXSau.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageGPLXSau.layer.borderWidth = 0.5
        viewImageGPLXSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageGPLXSau.layer.cornerRadius = 3.0
        viewInfoGPLXSau.addSubview(viewImageGPLXSau)
        
        let viewGPLXSauButton = UIImageView(frame: CGRect(x: viewImageGPLXSau.frame.size.width/2 - (viewImageGPLXSau.frame.size.height * 2/3)/2, y: 0, width: viewImageGPLXSau.frame.size.height * 2/3, height: viewImageGPLXSau.frame.size.height * 2/3))
        viewGPLXSauButton.image = UIImage(named:"AddImage")
        viewGPLXSauButton.contentMode = .scaleAspectFit
        viewImageGPLXSau.addSubview(viewGPLXSauButton)
        
        let lbGPLXSauButton = UILabel(frame: CGRect(x: 0, y: viewGPLXSauButton.frame.size.height + viewGPLXSauButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbGPLXSauButton.textAlignment = .center
        lbGPLXSauButton.textColor = UIColor(netHex:0xc2c2c2)
        lbGPLXSauButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGPLXSauButton.text = "Thêm hình ảnh"
        viewImageGPLXSau.addSubview(lbGPLXSauButton)
        viewInfoGPLXSau.frame.size.height = viewImageAvatar.frame.size.height + viewImageAvatar.frame.origin.y
        
        //        let tapShowGPLXSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowGPLXSau))
        //        viewImageGPLXSau.isUserInteractionEnabled = true
        //        viewImageGPLXSau.addGestureRecognizer(tapShowGPLXSau)
        
        //---Form register
        viewInfoFormRegister = UIView(frame: CGRect(x:0,y:viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoFormRegister.clipsToBounds = true
        viewUpload.addSubview(viewInfoFormRegister)
        
        let lbTextFormRegister = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextFormRegister.textAlignment = .left
        lbTextFormRegister.textColor = UIColor.black
        lbTextFormRegister.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextFormRegister.text = "Tờ số 7/8 form mở thẻ có chữ ký của KH"
        viewInfoFormRegister.addSubview(lbTextFormRegister)
        
        let  lbInfoCheckForm = UILabel(frame: CGRect(x:scrollView.frame.size.width/2, y: lbTextAvatar.frame.origin.y, width: scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
        lbInfoCheckForm.textAlignment = .right
        lbInfoCheckForm.textColor = UIColor(netHex:0x47B054)
        lbInfoCheckForm.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        lbInfoCheckForm.attributedText = underlineAttributedStringAvatarSign
        viewInfoFormRegister.addSubview(lbInfoCheckForm)
        let tapShowCheckForm = UITapGestureRecognizer(target: self, action: #selector(UploadImagesCreditNoCardViewControllerV2.tapShowCheckForm))
        lbInfoCheckForm.isUserInteractionEnabled = true
        lbInfoCheckForm.addGestureRecognizer(tapShowCheckForm)
        
        
        viewImageFormRegister = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextFormRegister.frame.origin.y + lbTextFormRegister.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageFormRegister.layer.borderWidth = 0.5
        viewImageFormRegister.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageFormRegister.layer.cornerRadius = 3.0
        viewInfoFormRegister.addSubview(viewImageFormRegister)
        
        let viewFormRegisterButton = UIImageView(frame: CGRect(x: viewImageFormRegister.frame.size.width/2 - (viewImageFormRegister.frame.size.height * 2/3)/2, y: 0, width: viewImageFormRegister.frame.size.height * 2/3, height: viewImageFormRegister.frame.size.height * 2/3))
        viewFormRegisterButton.image = UIImage(named:"AddImage")
        viewFormRegisterButton.contentMode = .scaleAspectFit
        viewImageFormRegister.addSubview(viewFormRegisterButton)
        
        let lbFormRegisterButton = UILabel(frame: CGRect(x: 0, y: viewFormRegisterButton.frame.size.height + viewFormRegisterButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbFormRegisterButton.textAlignment = .center
        lbFormRegisterButton.textColor = UIColor(netHex:0xc2c2c2)
        lbFormRegisterButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbFormRegisterButton.text = "Thêm hình ảnh"
        viewImageFormRegister.addSubview(lbFormRegisterButton)
        viewInfoFormRegister.frame.size.height = viewImageAvatar.frame.size.height + viewImageAvatar.frame.origin.y
        
        //        let tapShowFormRegister = UITapGestureRecognizer(target: self, action: #selector(self.tapShowFormRegister))
        //        viewImageFormRegister.isUserInteractionEnabled = true
        //        viewImageFormRegister.addGestureRecognizer(tapShowFormRegister)
        
        //---Form TRICH NO TINH DUNG
        viewInfoTrichNoTD = UIView(frame: CGRect(x:0,y:viewInfoFormRegister.frame.size.height + viewInfoFormRegister.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoTrichNoTD.clipsToBounds = true
        viewUpload.addSubview(viewInfoTrichNoTD)
        
        let lbTextTrichNoTD = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTrichNoTD.textAlignment = .left
        lbTextTrichNoTD.textColor = UIColor.black
        lbTextTrichNoTD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTrichNoTD.text = "Đề xuất trích nợ trang 1"
        viewInfoTrichNoTD.addSubview(lbTextTrichNoTD)
        
        viewImageTrichNoTD = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextTrichNoTD.frame.origin.y + lbTextTrichNoTD.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageTrichNoTD.layer.borderWidth = 0.5
        viewImageTrichNoTD.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageTrichNoTD.layer.cornerRadius = 3.0
        viewInfoTrichNoTD.addSubview(viewImageTrichNoTD)
        
        let viewTrichNoTDButton = UIImageView(frame: CGRect(x: viewImageTrichNoTD.frame.size.width/2 - (viewImageTrichNoTD.frame.size.height * 2/3)/2, y: 0, width: viewImageTrichNoTD.frame.size.height * 2/3, height: viewImageTrichNoTD.frame.size.height * 2/3))
        viewTrichNoTDButton.image = UIImage(named:"AddImage")
        viewTrichNoTDButton.contentMode = .scaleAspectFit
        viewImageTrichNoTD.addSubview(viewTrichNoTDButton)
        
        let lbTrichNoTDButton = UILabel(frame: CGRect(x: 0, y: viewTrichNoTDButton.frame.size.height + viewTrichNoTDButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbTrichNoTDButton.textAlignment = .center
        lbTrichNoTDButton.textColor = UIColor(netHex:0xc2c2c2)
        lbTrichNoTDButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTrichNoTDButton.text = "Thêm hình ảnh"
        viewImageTrichNoTD.addSubview(lbTrichNoTDButton)
        viewInfoTrichNoTD.frame.size.height = viewImageTrichNoTD.frame.size.height + viewImageTrichNoTD.frame.origin.y
        
        //        let tapShowTrichNoTD = UITapGestureRecognizer(target: self, action: #selector(self.tapShowTrichNoTD))
        //        viewImageTrichNoTD.isUserInteractionEnabled = true
        //        viewImageTrichNoTD.addGestureRecognizer(tapShowTrichNoTD)
        
        
        //---Form TRICH NO TINH DUNG Trang 2
        viewInfoTrichNoTDTrang2 = UIView(frame: CGRect(x:0,y:viewInfoTrichNoTD.frame.size.height + viewInfoTrichNoTD.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoTrichNoTDTrang2.clipsToBounds = true
        viewUpload.addSubview(viewInfoTrichNoTDTrang2)
        
        let lbTextTrichNoTDTrang2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTrichNoTDTrang2.textAlignment = .left
        lbTextTrichNoTDTrang2.textColor = UIColor.black
        lbTextTrichNoTDTrang2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTrichNoTDTrang2.text = "Đề xuất trích nợ trang 2"
        viewInfoTrichNoTDTrang2.addSubview(lbTextTrichNoTDTrang2)
        
        viewImageTrichNoTDTrang2 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextTrichNoTDTrang2.frame.origin.y + lbTextTrichNoTDTrang2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageTrichNoTDTrang2.layer.borderWidth = 0.5
        viewImageTrichNoTDTrang2.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageTrichNoTDTrang2.layer.cornerRadius = 3.0
        viewInfoTrichNoTDTrang2.addSubview(viewImageTrichNoTDTrang2)
        
        let viewTrichNoTDButtonTrang2 = UIImageView(frame: CGRect(x: viewImageTrichNoTDTrang2.frame.size.width/2 - (viewImageTrichNoTDTrang2.frame.size.height * 2/3)/2, y: 0, width: viewImageTrichNoTDTrang2.frame.size.height * 2/3, height: viewImageTrichNoTDTrang2.frame.size.height * 2/3))
        viewTrichNoTDButtonTrang2.image = UIImage(named:"AddImage")
        viewTrichNoTDButtonTrang2.contentMode = .scaleAspectFit
        viewImageTrichNoTDTrang2.addSubview(viewTrichNoTDButtonTrang2)
        
        let lbTrichNoTDButtonTrang2 = UILabel(frame: CGRect(x: 0, y: viewTrichNoTDButtonTrang2.frame.size.height + viewTrichNoTDButtonTrang2.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbTrichNoTDButtonTrang2.textAlignment = .center
        lbTrichNoTDButtonTrang2.textColor = UIColor(netHex:0xc2c2c2)
        lbTrichNoTDButtonTrang2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTrichNoTDButtonTrang2.text = "Thêm hình ảnh"
        viewImageTrichNoTDTrang2.addSubview(lbTrichNoTDButtonTrang2)
        viewInfoTrichNoTDTrang2.frame.size.height = viewImageTrichNoTDTrang2.frame.size.height + viewImageTrichNoTDTrang2.frame.origin.y
        
        //        let tapShowTrichNoTD = UITapGestureRecognizer(target: self, action: #selector(self.tapShowTrichNoTD))
        //        viewImageTrichNoTD.isUserInteractionEnabled = true
        //        viewImageTrichNoTD.addGestureRecognizer(tapShowTrichNoTD)
        
        //---SO HO KHAU
        viewInfoSoHK = UIView(frame: CGRect(x:0,y:viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHK.clipsToBounds = true
        viewUpload.addSubview(viewInfoSoHK)
        
        let lbTextSoHK = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHK.textAlignment = .left
        lbTextSoHK.textColor = UIColor.black
        lbTextSoHK.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHK.text = "Sổ hộ khẩu (Trang 1)"
        viewInfoSoHK.addSubview(lbTextSoHK)
        
        viewImageSoHK = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHK.frame.origin.y + lbTextSoHK.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHK.layer.borderWidth = 0.5
        viewImageSoHK.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHK.layer.cornerRadius = 3.0
        viewInfoSoHK.addSubview(viewImageSoHK)
        
        let viewSoHKButton = UIImageView(frame: CGRect(x: viewImageSoHK.frame.size.width/2 - (viewImageSoHK.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHK.frame.size.height * 2/3, height: viewImageSoHK.frame.size.height * 2/3))
        viewSoHKButton.image = UIImage(named:"AddImage")
        viewSoHKButton.contentMode = .scaleAspectFit
        viewImageSoHK.addSubview(viewSoHKButton)
        
        let lbSoHKButton = UILabel(frame: CGRect(x: 0, y: viewSoHKButton.frame.size.height + viewSoHKButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbSoHKButton.textAlignment = .center
        lbSoHKButton.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKButton.text = "Thêm hình ảnh"
        viewImageSoHK.addSubview(lbSoHKButton)
        viewInfoSoHK.frame.size.height = viewImageSoHK.frame.size.height + viewImageSoHK.frame.origin.y
        //        let tapShowSoHK = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK))
        //        viewImageSoHK.isUserInteractionEnabled = true
        //        viewImageSoHK.addGestureRecognizer(tapShowSoHK)
        
        //---
        
        lbInfoUploadMore = UILabel(frame: CGRect(x:tfCMND.frame.origin.x, y: viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 14)))
        lbInfoUploadMore.textAlignment = .right
        lbInfoUploadMore.textColor = UIColor(netHex:0x47B054)
        lbInfoUploadMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString1 = NSAttributedString(string: "Upload thêm hình", attributes: underlineAttribute1)
        lbInfoUploadMore.attributedText = underlineAttributedString1
        viewUpload.addSubview(lbInfoUploadMore)
        let tapShowUploadMore = UITapGestureRecognizer(target: self, action: #selector(UploadImagesCreditNoCardViewControllerV2.tapShowUploadMore))
        lbInfoUploadMore.isUserInteractionEnabled = true
        lbInfoUploadMore.addGestureRecognizer(tapShowUploadMore)
        
        viewUploadMore = UIView(frame: CGRect(x: 0, y: lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: Common.Size(s:100) ))
        viewUploadMore.clipsToBounds = true
        //                viewUploadMore.backgroundColor = .red
        viewUpload.addSubview(viewUploadMore)
        
        
        
        //---SO HO KHAU Trang 2
        viewInfoSoHKTrang2 = UIView(frame: CGRect(x:0,y: 0,width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang2.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang2)
        
        let lbTextSoHKTrang2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang2.textAlignment = .left
        lbTextSoHKTrang2.textColor = UIColor.black
        lbTextSoHKTrang2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang2.text = "Sổ hộ khẩu (Trang 2)"
        viewInfoSoHKTrang2.addSubview(lbTextSoHKTrang2)
        
        viewImageSoHKTrang2 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang2.frame.origin.y + lbTextSoHKTrang2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang2.layer.borderWidth = 0.5
        viewImageSoHKTrang2.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang2.layer.cornerRadius = 3.0
        viewInfoSoHKTrang2.addSubview(viewImageSoHKTrang2)
        
        let viewSoHKTrang2Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang2.frame.size.width/2 - (viewImageSoHKTrang2.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang2.frame.size.height * 2/3, height: viewImageSoHKTrang2.frame.size.height * 2/3))
        viewSoHKTrang2Button.image = UIImage(named:"AddImage")
        viewSoHKTrang2Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang2.addSubview(viewSoHKTrang2Button)
        
        let lbSoHKTrang2Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang2Button.frame.size.height + viewSoHKTrang2Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbSoHKTrang2Button.textAlignment = .center
        lbSoHKTrang2Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang2Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang2Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang2.addSubview(lbSoHKTrang2Button)
        viewInfoSoHKTrang2.frame.size.height = viewImageSoHKTrang2.frame.size.height + viewImageSoHKTrang2.frame.origin.y
        
        //        let tapShowSoHK2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK2))
        //        viewImageSoHKTrang2.isUserInteractionEnabled = true
        //        viewImageSoHKTrang2.addGestureRecognizer(tapShowSoHK2)
        
        
        //---SO HO KHAU Trang 3
        viewInfoSoHKTrang3 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang2.frame.origin.y + viewInfoSoHKTrang2.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang3.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang3)
        
        let lbTextSoHKTrang3 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang3.textAlignment = .left
        lbTextSoHKTrang3.textColor = UIColor.black
        lbTextSoHKTrang3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang3.text = "Sổ hộ khẩu (Trang 3)"
        viewInfoSoHKTrang3.addSubview(lbTextSoHKTrang3)
        
        viewImageSoHKTrang3 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang3.frame.origin.y + lbTextSoHKTrang3.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang3.layer.borderWidth = 0.5
        viewImageSoHKTrang3.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang3.layer.cornerRadius = 3.0
        viewInfoSoHKTrang3.addSubview(viewImageSoHKTrang3)
        
        let viewSoHKTrang3Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang3.frame.size.width/2 - (viewImageSoHKTrang3.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang3.frame.size.height * 2/3, height: viewImageSoHKTrang3.frame.size.height * 2/3))
        viewSoHKTrang3Button.image = UIImage(named:"AddImage")
        viewSoHKTrang3Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang3.addSubview(viewSoHKTrang3Button)
        
        let lbSoHKTrang3Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang3Button.frame.size.height + viewSoHKTrang3Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbSoHKTrang3Button.textAlignment = .center
        lbSoHKTrang3Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang3Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang3Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang3.addSubview(lbSoHKTrang3Button)
        viewInfoSoHKTrang3.frame.size.height = viewImageSoHKTrang3.frame.size.height + viewImageSoHKTrang3.frame.origin.y
        let tapShowSoHK3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK3))
        viewImageSoHKTrang3.isUserInteractionEnabled = true
        viewImageSoHKTrang3.addGestureRecognizer(tapShowSoHK3)
        //---SO HO KHAU Trang 4
        viewInfoSoHKTrang4 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang3.frame.origin.y + viewInfoSoHKTrang3.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang4.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang4)
        
        let lbTextSoHKTrang4 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang4.textAlignment = .left
        lbTextSoHKTrang4.textColor = UIColor.black
        lbTextSoHKTrang4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang4.text = "Sổ hộ khẩu (Trang 4)"
        viewInfoSoHKTrang4.addSubview(lbTextSoHKTrang4)
        
        viewImageSoHKTrang4 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang4.frame.origin.y + lbTextSoHKTrang4.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang4.layer.borderWidth = 0.5
        viewImageSoHKTrang4.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang4.layer.cornerRadius = 3.0
        viewInfoSoHKTrang4.addSubview(viewImageSoHKTrang4)
        
        let viewSoHKTrang4Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang4.frame.size.width/2 - (viewImageSoHKTrang4.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang4.frame.size.height * 2/3, height: viewImageSoHKTrang4.frame.size.height * 2/3))
        viewSoHKTrang4Button.image = UIImage(named:"AddImage")
        viewSoHKTrang4Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang4.addSubview(viewSoHKTrang4Button)
        
        let lbSoHKTrang4Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang4Button.frame.size.height + viewSoHKTrang4Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbSoHKTrang4Button.textAlignment = .center
        lbSoHKTrang4Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang4Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang4Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang4.addSubview(lbSoHKTrang4Button)
        viewInfoSoHKTrang4.frame.size.height = viewImageSoHKTrang4.frame.size.height + viewImageSoHKTrang4.frame.origin.y
        let tapShowSoHK4 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK4))
        viewImageSoHKTrang4.isUserInteractionEnabled = true
        viewImageSoHKTrang4.addGestureRecognizer(tapShowSoHK4)
        //---SO HO KHAU Trang 5
        viewInfoSoHKTrang5 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang5.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang5)
        
        let lbTextSoHKTrang5 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang5.textAlignment = .left
        lbTextSoHKTrang5.textColor = UIColor.black
        lbTextSoHKTrang5.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang5.text = "Sổ hộ khẩu (Trang 5)"
        viewInfoSoHKTrang5.addSubview(lbTextSoHKTrang5)
        
        viewImageSoHKTrang5 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang5.frame.origin.y + lbTextSoHKTrang5.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang5.layer.borderWidth = 0.5
        viewImageSoHKTrang5.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang5.layer.cornerRadius = 3.0
        viewInfoSoHKTrang5.addSubview(viewImageSoHKTrang5)
        
        let viewSoHKTrang5Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang5.frame.size.width/2 - (viewImageSoHKTrang5.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang5.frame.size.height * 2/3, height: viewImageSoHKTrang5.frame.size.height * 2/3))
        viewSoHKTrang5Button.image = UIImage(named:"AddImage")
        viewSoHKTrang5Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang5.addSubview(viewSoHKTrang5Button)
        
        let lbSoHKTrang5Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang5Button.frame.size.height + viewSoHKTrang5Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbSoHKTrang5Button.textAlignment = .center
        lbSoHKTrang5Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang5Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang5Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang5.addSubview(lbSoHKTrang5Button)
        viewInfoSoHKTrang5.frame.size.height = viewImageSoHKTrang5.frame.size.height + viewImageSoHKTrang5.frame.origin.y
        let tapShowSoHK5 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK5))
        viewImageSoHKTrang5.isUserInteractionEnabled = true
        viewImageSoHKTrang5.addGestureRecognizer(tapShowSoHK5)
        //---SO HO KHAU Trang 6
        viewInfoSoHKTrang6 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang6.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang6)
        
        let lbTextSoHKTrang6 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang6.textAlignment = .left
        lbTextSoHKTrang6.textColor = UIColor.black
        lbTextSoHKTrang6.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang6.text = "Sổ hộ khẩu (Trang 6)"
        viewInfoSoHKTrang6.addSubview(lbTextSoHKTrang6)
        
        viewImageSoHKTrang6 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang6.frame.origin.y + lbTextSoHKTrang6.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang6.layer.borderWidth = 0.5
        viewImageSoHKTrang6.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang6.layer.cornerRadius = 3.0
        viewInfoSoHKTrang6.addSubview(viewImageSoHKTrang6)
        
        let viewSoHKTrang6Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang6.frame.size.width/2 - (viewImageSoHKTrang6.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang6.frame.size.height * 2/3, height: viewImageSoHKTrang6.frame.size.height * 2/3))
        viewSoHKTrang6Button.image = UIImage(named:"AddImage")
        viewSoHKTrang6Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang6.addSubview(viewSoHKTrang6Button)
        
        let lbSoHKTrang6Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang6Button.frame.size.height + viewSoHKTrang6Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbSoHKTrang6Button.textAlignment = .center
        lbSoHKTrang6Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang6Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang6Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang6.addSubview(lbSoHKTrang6Button)
        viewInfoSoHKTrang6.frame.size.height = viewImageSoHKTrang6.frame.size.height + viewImageSoHKTrang6.frame.origin.y
        let tapShowSoHK6 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK6))
        viewImageSoHKTrang6.isUserInteractionEnabled = true
        viewImageSoHKTrang6.addGestureRecognizer(tapShowSoHK6)
        //---SO HO KHAU Trang 7
        viewInfoSoHKTrang7 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang7.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang7)
        
        let lbTextSoHKTrang7 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang7.textAlignment = .left
        lbTextSoHKTrang7.textColor = UIColor.black
        lbTextSoHKTrang7.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang7.text = "Sổ hộ khẩu (Trang 7)"
        viewInfoSoHKTrang7.addSubview(lbTextSoHKTrang7)
        
        viewImageSoHKTrang7 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang7.frame.origin.y + lbTextSoHKTrang7.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang7.layer.borderWidth = 0.5
        viewImageSoHKTrang7.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang7.layer.cornerRadius = 3.0
        viewInfoSoHKTrang7.addSubview(viewImageSoHKTrang7)
        
        let viewSoHKTrang7Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang7.frame.size.width/2 - (viewImageSoHKTrang7.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang7.frame.size.height * 2/3, height: viewImageSoHKTrang7.frame.size.height * 2/3))
        viewSoHKTrang7Button.image = UIImage(named:"AddImage")
        viewSoHKTrang7Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang7.addSubview(viewSoHKTrang7Button)
        
        let lbSoHKTrang7Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang7Button.frame.size.height + viewSoHKTrang7Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbSoHKTrang7Button.textAlignment = .center
        lbSoHKTrang7Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang7Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang7Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang7.addSubview(lbSoHKTrang7Button)
        viewInfoSoHKTrang7.frame.size.height = viewImageSoHKTrang7.frame.size.height + viewImageSoHKTrang7.frame.origin.y
        let tapShowSoHK7 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK7))
        viewImageSoHKTrang7.isUserInteractionEnabled = true
        viewImageSoHKTrang7.addGestureRecognizer(tapShowSoHK7)
        //---SO HO KHAU Trang 8
        viewInfoSoHKTrang8 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang8.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang8)
        
        let lbTextSoHKTrang8 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang8.textAlignment = .left
        lbTextSoHKTrang8.textColor = UIColor.black
        lbTextSoHKTrang8.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang8.text = "Sổ hộ khẩu (Trang 8)"
        viewInfoSoHKTrang8.addSubview(lbTextSoHKTrang8)
        
        viewImageSoHKTrang8 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang8.frame.origin.y + lbTextSoHKTrang8.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang8.layer.borderWidth = 0.5
        viewImageSoHKTrang8.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang8.layer.cornerRadius = 3.0
        viewInfoSoHKTrang8.addSubview(viewImageSoHKTrang8)
        
        let viewSoHKTrang8Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang8.frame.size.width/2 - (viewImageSoHKTrang8.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang8.frame.size.height * 2/3, height: viewImageSoHKTrang8.frame.size.height * 2/3))
        viewSoHKTrang8Button.image = UIImage(named:"AddImage")
        viewSoHKTrang8Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang8.addSubview(viewSoHKTrang8Button)
        
        let lbSoHKTrang8Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang8Button.frame.size.height + viewSoHKTrang8Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageAvatar.frame.size.height/3))
        lbSoHKTrang8Button.textAlignment = .center
        lbSoHKTrang8Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang8Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang8Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang8.addSubview(lbSoHKTrang8Button)
        viewInfoSoHKTrang8.frame.size.height = viewImageSoHKTrang8.frame.size.height + viewImageSoHKTrang8.frame.origin.y
        let tapShowSoHK8 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK8))
        viewImageSoHKTrang8.isUserInteractionEnabled = true
        viewImageSoHKTrang8.addGestureRecognizer(tapShowSoHK8)
        //---------
        viewUploadMore.frame.size.height = viewInfoSoHKTrang8.frame.size.height + viewInfoSoHKTrang8.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        viewUploadMore.frame.size.height = 0
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        //---------
        btUpload = UIButton()
        btUpload.frame = CGRect(x: tfCMND.frame.origin.x, y:viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20), width: tfName.frame.size.width, height: tfCMND.frame.size.height * 1.2)
        btUpload.backgroundColor = UIColor(netHex:0xEF4A40)
        btUpload.setTitle("Lưu hình ảnh", for: .normal)
        btUpload.addTarget(self, action: #selector(actionUpload), for: .touchUpInside)
        btUpload.layer.borderWidth = 0.5
        btUpload.layer.borderColor = UIColor.white.cgColor
        btUpload.layer.cornerRadius = 3
        scrollView.addSubview(btUpload)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin ngân hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_sp_GetBank_CreditNoCard{ (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count<=0){
                    var listCom: [String] = []
                    self.listBank = results
                    for item in results {
                        listCom.append("\(item.BankName)")
                        //VPBank
                        if(item.ID == "12"){
                            self.companyButton.text = "\(item.BankName)"
                            self.selectBank = item.ID
                            self.companyButton.isEnabled = false
                        }
                    }
                    self.companyButton.filterStrings(listCom)
                }
            }
        }
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        if(linkCMNDMT.count > 0 && fullFlagArr[0] == "1"){
            if let escapedString = linkCMNDMT.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                let url = URL(string: "\(escapedString)")!
                viewCMNDTruocButton.kf.setImage(with: url,
                                                placeholder: nil,
                                                options: nil,
                                                progressBlock: nil,
                                                completionHandler: {
                                                    result in
                                                    if(viewCMNDTruocButton.image != nil){
                                                        let when = DispatchTime.now() + 1
                                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                                            self.imageCMNDTruoc(image: viewCMNDTruocButton.image!)
                                                        }
                                                        
                                                    }
                })
                
            }
        }
        if(linkCMNDMS.count > 0 && fullFlagArr[1] == "1"){
            if let escapedString = linkCMNDMS.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                let url = URL(string: "\(escapedString)")!
                viewCMNDSauButton.kf.setImage(with: url,
                                              placeholder: nil,
                                              options: nil,
                                              progressBlock: nil,
                                              completionHandler: {
                                                result in
                                                if(viewCMNDSauButton.image != nil){
                                                    
                                                    let when = DispatchTime.now() + 1
                                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                                        self.imageCMNDSau(image: viewCMNDSauButton.image!)
                                                    }
                                                }
                })
                
            }
        }
        
        if(self.ocfdFFriend != nil){
            // cmnd mat truoc
            if(fullFlagArr[0] != "0"){
                let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
                viewImageCMNDTruoc.isUserInteractionEnabled = true
                viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
            }else {
                let lbStatusUploadCMNDMT = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageCMNDTruoc.frame.size.width,height:self.viewImageCMNDTruoc.frame.size.height))
                lbStatusUploadCMNDMT.textColor = UIColor.white
                lbStatusUploadCMNDMT.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUploadCMNDMT.textAlignment = .center
                lbStatusUploadCMNDMT.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageCMNDTruoc.addSubview(lbStatusUploadCMNDMT)
                lbStatusUploadCMNDMT.text = "Đã duyệt CMND (Mặt trước)"
                
                linkCMNDMT = ""
            }
            
            // cmnd mat sau
            if(fullFlagArr[1] != "0"){
                let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
                viewImageCMNDSau.isUserInteractionEnabled = true
                viewImageCMNDSau.addGestureRecognizer(tapShowCMNDSau)
            }else{
                let lbStatusUploadCMNDMS = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageCMNDSau.frame.size.width,height:self.viewImageCMNDSau.frame.size.height))
                lbStatusUploadCMNDMS.textColor = UIColor.white
                lbStatusUploadCMNDMS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUploadCMNDMS.textAlignment = .center
                lbStatusUploadCMNDMS.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageCMNDSau.addSubview(lbStatusUploadCMNDMS)
                lbStatusUploadCMNDMS.text = "Đã duyệt CMND (Mặt sau)"
                
                linkCMNDMS = ""
            }
            
            // cmnd chan dung
            if(fullFlagArr[2] != "0"){
                let tapShowAvatar = UITapGestureRecognizer(target: self, action: #selector(self.tapShowAvatar))
                viewImageAvatar.isUserInteractionEnabled = true
                viewImageAvatar.addGestureRecognizer(tapShowAvatar)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageAvatar.frame.size.width,height:self.viewImageAvatar.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageAvatar.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt chân dung KH"
            }
            
            // cmnd gplx truoc
            if(fullFlagArr[3] != "0"){
                let tapShowGPLXTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowGPLXTruoc))
                viewImageGPLXTruoc.isUserInteractionEnabled = true
                viewImageGPLXTruoc.addGestureRecognizer(tapShowGPLXTruoc)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageGPLXTruoc.frame.size.width,height:self.viewImageGPLXTruoc.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageGPLXTruoc.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt GPLX (Mặt trước)"
            }
            // cmnd gplx sau
            if(fullFlagArr[4] != "0"){
                let tapShowGPLXSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowGPLXSau))
                viewImageGPLXSau.isUserInteractionEnabled = true
                viewImageGPLXSau.addGestureRecognizer(tapShowGPLXSau)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageGPLXSau.frame.size.width,height:self.viewImageGPLXSau.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageGPLXSau.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt GPLX (Mặt sau)"
            }
            // form mo the
            if(fullFlagArr[5] != "0"){
                let tapShowFormRegister = UITapGestureRecognizer(target: self, action: #selector(self.tapShowFormRegister))
                viewImageFormRegister.isUserInteractionEnabled = true
                viewImageFormRegister.addGestureRecognizer(tapShowFormRegister)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageFormRegister.frame.size.width,height:self.viewImageFormRegister.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageFormRegister.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt form mở thẻ"
            }
            // trich no tin dung
            if(fullFlagArr[6] != "0"){
                let tapShowTrichNoTD = UITapGestureRecognizer(target: self, action: #selector(self.tapShowTrichNoTD))
                viewImageTrichNoTD.isUserInteractionEnabled = true
                viewImageTrichNoTD.addGestureRecognizer(tapShowTrichNoTD)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageTrichNoTD.frame.size.width,height:self.viewImageTrichNoTD.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageTrichNoTD.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt ảnh trích nợ (T.1)"
            }
            
            // so ho khau trang 1
            if(fullFlagArr[7] != "0"){
                let tapShowSoHK = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK))
                viewImageSoHK.isUserInteractionEnabled = true
                viewImageSoHK.addGestureRecognizer(tapShowSoHK)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageSoHK.frame.size.width,height:self.viewImageSoHK.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageSoHK.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt Sổ hộ khẩu (T.1)"
            }
            // so ho khau trang 2
            if(fullFlagArr[8] != "0"){
                let tapShowSoHK2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK2))
                viewImageSoHKTrang2.isUserInteractionEnabled = true
                viewImageSoHKTrang2.addGestureRecognizer(tapShowSoHK2)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageSoHKTrang2.frame.size.width,height:self.viewImageSoHKTrang2.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageSoHKTrang2.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt Sổ hộ khẩu (T.2)"
            }
            // so ho khau trang 3
            if(fullFlagArr[9] != "0"){
                let tapShowSoHK3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK3))
                viewImageSoHKTrang3.isUserInteractionEnabled = true
                viewImageSoHKTrang3.addGestureRecognizer(tapShowSoHK3)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageSoHKTrang3.frame.size.width,height:self.viewImageSoHKTrang3.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageSoHKTrang3.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt Sổ hộ khẩu (T.3)"
            }
            // so ho khau trang 4
            if(fullFlagArr[10] != "0"){
                let tapShowSoHK4 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK4))
                viewImageSoHKTrang4.isUserInteractionEnabled = true
                viewImageSoHKTrang4.addGestureRecognizer(tapShowSoHK4)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageSoHKTrang4.frame.size.width,height:self.viewImageSoHKTrang4.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageSoHKTrang4.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt Sổ hộ khẩu (T.4)"
            }
            // so ho khau trang 5
            if(fullFlagArr[11] != "0"){
                let tapShowSoHK5 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK5))
                viewImageSoHKTrang5.isUserInteractionEnabled = true
                viewImageSoHKTrang5.addGestureRecognizer(tapShowSoHK5)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageSoHKTrang5.frame.size.width,height:self.viewImageSoHKTrang5.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageSoHKTrang5.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt Sổ hộ khẩu (T.5)"
            }
            // so ho khau trang 6
            if(fullFlagArr[12] != "0"){
                let tapShowSoHK6 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK6))
                viewImageSoHKTrang6.isUserInteractionEnabled = true
                viewImageSoHKTrang6.addGestureRecognizer(tapShowSoHK6)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageSoHKTrang6.frame.size.width,height:self.viewImageSoHKTrang6.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageSoHKTrang6.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt Sổ hộ khẩu (T.6)"
            }
            // so ho khau trang 7
            if(fullFlagArr[13] != "0"){
                let tapShowSoHK7 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK7))
                viewImageSoHKTrang7.isUserInteractionEnabled = true
                viewImageSoHKTrang7.addGestureRecognizer(tapShowSoHK7)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width: self.viewImageSoHKTrang7.frame.size.width,height:self.viewImageSoHKTrang7.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageSoHKTrang7.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt Sổ hộ khẩu (T.7)"
            }
            // so ho khau trang 8
            if(fullFlagArr[14] != "0"){
                let tapShowSoHK8 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK8))
                viewImageSoHKTrang8.isUserInteractionEnabled = true
                viewImageSoHKTrang8.addGestureRecognizer(tapShowSoHK8)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageSoHKTrang8.frame.size.width,height:self.viewImageSoHKTrang8.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageSoHKTrang8.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt Sổ hộ khẩu (T.8)"
            }
            if(fullFlagArr[15] != "0"){
                let tapImageAvatarSign = UITapGestureRecognizer(target: self, action: #selector(self.tapTrichNoTDTrang2))
                viewImageTrichNoTDTrang2.isUserInteractionEnabled = true
                viewImageTrichNoTDTrang2.addGestureRecognizer(tapImageAvatarSign)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageTrichNoTDTrang2.frame.size.width,height:self.viewImageTrichNoTDTrang2.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageTrichNoTDTrang2.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt ảnh trích nợ (T.2)"
            }
            if(fullFlagArr[16] != "0"){
                let tapImageAvatarSign = UITapGestureRecognizer(target: self, action: #selector(self.tapImageAvatarSign))
                viewImageAvatarSign.isUserInteractionEnabled = true
                viewImageAvatarSign.addGestureRecognizer(tapImageAvatarSign)
            }else {
                let lbStatusUpload = UILabel(frame: CGRect(x:0,y:0,width:self.viewImageAvatarSign.frame.size.width,height:self.viewImageAvatarSign.frame.size.height))
                lbStatusUpload.textColor = UIColor.white
                lbStatusUpload.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbStatusUpload.textAlignment = .center
                lbStatusUpload.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.viewImageAvatarSign.addSubview(lbStatusUpload)
                lbStatusUpload.text = "Đã duyệt ảnh KH"
            }
            
            
            
        }else{
            let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
            viewImageCMNDTruoc.isUserInteractionEnabled = true
            viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
            
            let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
            viewImageCMNDSau.isUserInteractionEnabled = true
            viewImageCMNDSau.addGestureRecognizer(tapShowCMNDSau)
            
            let tapShowAvatar = UITapGestureRecognizer(target: self, action: #selector(self.tapShowAvatar))
            viewImageAvatar.isUserInteractionEnabled = true
            viewImageAvatar.addGestureRecognizer(tapShowAvatar)
            
            let tapShowGPLXTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowGPLXTruoc))
            viewImageGPLXTruoc.isUserInteractionEnabled = true
            viewImageGPLXTruoc.addGestureRecognizer(tapShowGPLXTruoc)
            
            let tapShowGPLXSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowGPLXSau))
            viewImageGPLXSau.isUserInteractionEnabled = true
            viewImageGPLXSau.addGestureRecognizer(tapShowGPLXSau)
            
            let tapShowFormRegister = UITapGestureRecognizer(target: self, action: #selector(self.tapShowFormRegister))
            viewImageFormRegister.isUserInteractionEnabled = true
            viewImageFormRegister.addGestureRecognizer(tapShowFormRegister)
            
            let tapShowTrichNoTD = UITapGestureRecognizer(target: self, action: #selector(self.tapShowTrichNoTD))
            viewImageTrichNoTD.isUserInteractionEnabled = true
            viewImageTrichNoTD.addGestureRecognizer(tapShowTrichNoTD)
            
            let tapShowSoHK = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK))
            viewImageSoHK.isUserInteractionEnabled = true
            viewImageSoHK.addGestureRecognizer(tapShowSoHK)
            
            let tapShowSoHK2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK2))
            viewImageSoHKTrang2.isUserInteractionEnabled = true
            viewImageSoHKTrang2.addGestureRecognizer(tapShowSoHK2)
            
            let tapShowSoHK3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK3))
            viewImageSoHKTrang3.isUserInteractionEnabled = true
            viewImageSoHKTrang3.addGestureRecognizer(tapShowSoHK3)
            
            let tapShowSoHK4 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK4))
            viewImageSoHKTrang4.isUserInteractionEnabled = true
            viewImageSoHKTrang4.addGestureRecognizer(tapShowSoHK4)
            
            let tapShowSoHK5 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK5))
            viewImageSoHKTrang5.isUserInteractionEnabled = true
            viewImageSoHKTrang5.addGestureRecognizer(tapShowSoHK5)
            
            let tapShowSoHK6 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK6))
            viewImageSoHKTrang6.isUserInteractionEnabled = true
            viewImageSoHKTrang6.addGestureRecognizer(tapShowSoHK6)
            
            let tapShowSoHK7 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK7))
            viewImageSoHKTrang7.isUserInteractionEnabled = true
            viewImageSoHKTrang7.addGestureRecognizer(tapShowSoHK7)
            
            let tapShowSoHK8 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK8))
            viewImageSoHKTrang8.isUserInteractionEnabled = true
            viewImageSoHKTrang8.addGestureRecognizer(tapShowSoHK8)
            
            let tapImageAvatarSign = UITapGestureRecognizer(target: self, action: #selector(self.tapImageAvatarSign))
            viewImageAvatarSign.isUserInteractionEnabled = true
            viewImageAvatarSign.addGestureRecognizer(tapImageAvatarSign)
            
            let tapTrichNoTDTrang2 = UITapGestureRecognizer(target: self, action: #selector(self.tapTrichNoTDTrang2))
            viewImageTrichNoTDTrang2.isUserInteractionEnabled = true
            viewImageTrichNoTDTrang2.addGestureRecognizer(tapTrichNoTDTrang2)
            
        }
        
        
    }
    @objc func tapShowCheckAvatar(sender:UITapGestureRecognizer) {
        let viewController = ViewImageViewController()
        viewController.pos = 1
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func tapShowCheckAvatarForm(sender:UITapGestureRecognizer) {
        let viewController = ViewImageViewController()
        viewController.pos = 2
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func tapShowCheckForm(sender:UITapGestureRecognizer) {
        let viewController = ViewImageViewController()
        viewController.pos = 3
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func tapShowUploadMore(sender:UITapGestureRecognizer) {
        if(viewUploadMore.frame.size.height != 0){
            viewUploadMore.frame.size.height = 0
        }else{
            viewUploadMore.frame.size.height = heightUploadView
        }
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    @objc func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowAvatar(sender:UITapGestureRecognizer) {
        self.posImageUpload = 3
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowGPLXTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 4
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowGPLXSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 5
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowFormRegister(sender:UITapGestureRecognizer) {
        self.posImageUpload = 6
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowTrichNoTD(sender:UITapGestureRecognizer) {
        self.posImageUpload = 7
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK(sender:UITapGestureRecognizer) {
        self.posImageUpload = 8
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK2(sender:UITapGestureRecognizer) {
        self.posImageUpload = 9
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK3(sender:UITapGestureRecognizer) {
        self.posImageUpload = 10
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK4(sender:UITapGestureRecognizer) {
        self.posImageUpload = 11
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK5(sender:UITapGestureRecognizer) {
        self.posImageUpload = 12
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK6(sender:UITapGestureRecognizer) {
        self.posImageUpload = 13
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK7(sender:UITapGestureRecognizer) {
        self.posImageUpload = 14
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK8(sender:UITapGestureRecognizer) {
        self.posImageUpload = 15
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapImageAvatarSign(sender:UITapGestureRecognizer) {
        self.posImageUpload = 16
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapTrichNoTDTrang2(sender:UITapGestureRecognizer) {
        self.posImageUpload = 17
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
        viewInfoCMNDSau.frame.origin.y = viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10)
        viewInfoAvatar.frame.origin.y = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
        viewInfoAvatarSign.frame.origin.y = viewInfoAvatar.frame.size.height + viewInfoAvatar.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXTruoc.frame.origin.y = viewInfoAvatarSign.frame.size.height + viewInfoAvatarSign.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        viewInfoFormRegister.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTD.frame.origin.y = viewInfoFormRegister.frame.size.height + viewInfoFormRegister.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoTrichNoTD.frame.size.height + viewInfoTrichNoTD.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
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
        viewInfoAvatar.frame.origin.y = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
        viewInfoAvatarSign.frame.origin.y = viewInfoAvatar.frame.size.height + viewInfoAvatar.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXTruoc.frame.origin.y = viewInfoAvatarSign.frame.size.height + viewInfoAvatarSign.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        viewInfoFormRegister.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTD.frame.origin.y = viewInfoFormRegister.frame.size.height + viewInfoFormRegister.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoTrichNoTD.frame.size.height + viewInfoTrichNoTD.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageAvatar(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageAvatar.frame.size.width / sca
        viewImageAvatar.subviews.forEach { $0.removeFromSuperview() }
        imgVieAvatar  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageAvatar.frame.size.width, height: heightImage))
        imgVieAvatar.contentMode = .scaleAspectFit
        imgVieAvatar.image = image
        viewImageAvatar.addSubview(imgVieAvatar)
        viewImageAvatar.frame.size.height = imgVieAvatar.frame.size.height + imgVieAvatar.frame.origin.y
        viewInfoAvatar.frame.size.height = viewImageAvatar.frame.size.height + viewImageAvatar.frame.origin.y
        viewInfoAvatarSign.frame.origin.y = viewInfoAvatar.frame.size.height + viewInfoAvatar.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXTruoc.frame.origin.y = viewInfoAvatarSign.frame.size.height + viewInfoAvatarSign.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        viewInfoFormRegister.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTD.frame.origin.y = viewInfoFormRegister.frame.size.height + viewInfoFormRegister.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoTrichNoTD.frame.size.height + viewInfoTrichNoTD.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageAvatarSign(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageAvatarSign.frame.size.width / sca
        viewImageAvatarSign.subviews.forEach { $0.removeFromSuperview() }
        imgVieAvatarSign  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageAvatarSign.frame.size.width, height: heightImage))
        imgVieAvatarSign.contentMode = .scaleAspectFit
        imgVieAvatarSign.image = image
        viewImageAvatarSign.addSubview(imgVieAvatarSign)
        viewImageAvatarSign.frame.size.height = imgVieAvatarSign.frame.size.height + imgVieAvatarSign.frame.origin.y
        viewInfoAvatarSign.frame.size.height = viewImageAvatarSign.frame.size.height + viewImageAvatarSign.frame.origin.y
        viewInfoGPLXTruoc.frame.origin.y = viewInfoAvatarSign.frame.size.height + viewInfoAvatarSign.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        viewInfoFormRegister.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTD.frame.origin.y = viewInfoFormRegister.frame.size.height + viewInfoFormRegister.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoTrichNoTD.frame.size.height + viewInfoTrichNoTD.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    
    func imageGPLXTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageGPLXTruoc.frame.size.width / sca
        viewImageGPLXTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewGPLXTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageGPLXTruoc.frame.size.width, height: heightImage))
        imgViewGPLXTruoc.contentMode = .scaleAspectFit
        imgViewGPLXTruoc.image = image
        viewImageGPLXTruoc.addSubview(imgViewGPLXTruoc)
        viewImageGPLXTruoc.frame.size.height = imgViewGPLXTruoc.frame.size.height + imgViewGPLXTruoc.frame.origin.y
        viewInfoGPLXTruoc.frame.size.height = viewImageGPLXTruoc.frame.size.height + viewImageGPLXTruoc.frame.origin.y
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        viewInfoFormRegister.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTD.frame.origin.y = viewInfoFormRegister.frame.size.height + viewInfoFormRegister.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoTrichNoTD.frame.size.height + viewInfoTrichNoTD.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    
    func imageGPLXSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageGPLXSau.frame.size.width / sca
        viewImageGPLXSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewGPLXSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageGPLXSau.frame.size.width, height: heightImage))
        imgViewGPLXSau.contentMode = .scaleAspectFit
        imgViewGPLXSau.image = image
        viewImageGPLXSau.addSubview(imgViewGPLXSau)
        viewImageGPLXSau.frame.size.height = imgViewGPLXSau.frame.size.height + imgViewGPLXSau.frame.origin.y
        viewInfoGPLXSau.frame.size.height = viewImageGPLXSau.frame.size.height + viewImageGPLXSau.frame.origin.y
        viewInfoFormRegister.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTD.frame.origin.y = viewInfoFormRegister.frame.size.height + viewInfoFormRegister.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoTrichNoTD.frame.size.height + viewInfoTrichNoTD.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageFormRegister(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageFormRegister.frame.size.width / sca
        viewImageFormRegister.subviews.forEach { $0.removeFromSuperview() }
        imgViewFormRegister  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageFormRegister.frame.size.width, height: heightImage))
        imgViewFormRegister.contentMode = .scaleAspectFit
        imgViewFormRegister.image = image
        viewImageFormRegister.addSubview(imgViewFormRegister)
        viewImageFormRegister.frame.size.height = imgViewFormRegister.frame.size.height + imgViewFormRegister.frame.origin.y
        viewInfoFormRegister.frame.size.height = viewImageFormRegister.frame.size.height + viewImageFormRegister.frame.origin.y
        viewInfoTrichNoTD.frame.origin.y = viewInfoFormRegister.frame.size.height + viewInfoFormRegister.frame.origin.y + Common.Size(s:10)
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoTrichNoTD.frame.size.height + viewInfoTrichNoTD.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageTrichNoTD(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageTrichNoTD.frame.size.width / sca
        viewImageTrichNoTD.subviews.forEach { $0.removeFromSuperview() }
        imgViewTrichNoTD  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageTrichNoTD.frame.size.width, height: heightImage))
        imgViewTrichNoTD.contentMode = .scaleAspectFit
        imgViewTrichNoTD.image = image
        viewImageTrichNoTD.addSubview(imgViewTrichNoTD)
        viewImageTrichNoTD.frame.size.height = imgViewTrichNoTD.frame.size.height + imgViewTrichNoTD.frame.origin.y
        viewInfoTrichNoTD.frame.size.height = viewImageTrichNoTD.frame.size.height + viewImageTrichNoTD.frame.origin.y
        viewInfoTrichNoTDTrang2.frame.origin.y = viewInfoTrichNoTD.frame.size.height + viewInfoTrichNoTD.frame.origin.y + Common.Size(s:10)
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageTrichNoTDTrang2(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageTrichNoTDTrang2.frame.size.width / sca
        viewImageTrichNoTDTrang2.subviews.forEach { $0.removeFromSuperview() }
        imgViewTrichNoTDTrang2  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageTrichNoTDTrang2.frame.size.width, height: heightImage))
        imgViewTrichNoTDTrang2.contentMode = .scaleAspectFit
        imgViewTrichNoTDTrang2.image = image
        viewImageTrichNoTDTrang2.addSubview(imgViewTrichNoTDTrang2)
        viewImageTrichNoTDTrang2.frame.size.height = imgViewTrichNoTDTrang2.frame.size.height + imgViewTrichNoTDTrang2.frame.origin.y
        viewInfoTrichNoTDTrang2.frame.size.height = viewImageTrichNoTDTrang2.frame.size.height + viewImageTrichNoTDTrang2.frame.origin.y
        viewInfoSoHK.frame.origin.y = viewInfoTrichNoTDTrang2.frame.size.height + viewInfoTrichNoTDTrang2.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSoHK(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHK.frame.size.width / sca
        viewImageSoHK.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHK  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHK.frame.size.width, height: heightImage))
        imgViewSoHK.contentMode = .scaleAspectFit
        imgViewSoHK.image = image
        viewImageSoHK.addSubview(imgViewSoHK)
        viewImageSoHK.frame.size.height = imgViewSoHK.frame.size.height + imgViewSoHK.frame.origin.y
        viewInfoSoHK.frame.size.height = viewImageSoHK.frame.size.height + viewImageSoHK.frame.origin.y
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSoHK2(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang2.frame.size.width / sca
        viewImageSoHKTrang2.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang2  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang2.frame.size.width, height: heightImage))
        imgViewSoHKTrang2.contentMode = .scaleAspectFit
        imgViewSoHKTrang2.image = image
        viewImageSoHKTrang2.addSubview(imgViewSoHKTrang2)
        viewImageSoHKTrang2.frame.size.height = imgViewSoHKTrang2.frame.size.height + imgViewSoHKTrang2.frame.origin.y
        viewInfoSoHKTrang2.frame.size.height = viewImageSoHKTrang2.frame.size.height + viewImageSoHKTrang2.frame.origin.y
        
        viewInfoSoHKTrang3.frame.origin.y = viewInfoSoHKTrang2.frame.origin.y + viewInfoSoHKTrang2.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang4.frame.origin.y = viewInfoSoHKTrang3.frame.origin.y + viewInfoSoHKTrang3.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang5.frame.origin.y = viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewUploadMore.frame.size.height = viewInfoSoHKTrang8.frame.size.height + viewInfoSoHKTrang8.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    
    func imageSoHK3(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang3.frame.size.width / sca
        viewImageSoHKTrang3.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang3  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang3.frame.size.width, height: heightImage))
        imgViewSoHKTrang3.contentMode = .scaleAspectFit
        imgViewSoHKTrang3.image = image
        viewImageSoHKTrang3.addSubview(imgViewSoHKTrang3)
        viewImageSoHKTrang3.frame.size.height = imgViewSoHKTrang3.frame.size.height + imgViewSoHKTrang3.frame.origin.y
        viewInfoSoHKTrang3.frame.size.height = viewImageSoHKTrang3.frame.size.height + viewImageSoHKTrang3.frame.origin.y
        viewInfoSoHKTrang4.frame.origin.y = viewInfoSoHKTrang3.frame.origin.y + viewInfoSoHKTrang3.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang5.frame.origin.y = viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewUploadMore.frame.size.height = viewInfoSoHKTrang8.frame.size.height + viewInfoSoHKTrang8.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSoHK4(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang4.frame.size.width / sca
        viewImageSoHKTrang4.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang4  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang4.frame.size.width, height: heightImage))
        imgViewSoHKTrang4.contentMode = .scaleAspectFit
        imgViewSoHKTrang4.image = image
        viewImageSoHKTrang4.addSubview(imgViewSoHKTrang4)
        viewImageSoHKTrang4.frame.size.height = imgViewSoHKTrang4.frame.size.height + imgViewSoHKTrang4.frame.origin.y
        viewInfoSoHKTrang4.frame.size.height = viewImageSoHKTrang4.frame.size.height + viewImageSoHKTrang4.frame.origin.y
        viewInfoSoHKTrang5.frame.origin.y = viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewUploadMore.frame.size.height = viewInfoSoHKTrang8.frame.size.height + viewInfoSoHKTrang8.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSoHK5(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang5.frame.size.width / sca
        viewImageSoHKTrang5.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang5  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang5.frame.size.width, height: heightImage))
        imgViewSoHKTrang5.contentMode = .scaleAspectFit
        imgViewSoHKTrang5.image = image
        viewImageSoHKTrang5.addSubview(imgViewSoHKTrang5)
        viewImageSoHKTrang5.frame.size.height = imgViewSoHKTrang5.frame.size.height + imgViewSoHKTrang5.frame.origin.y
        viewInfoSoHKTrang5.frame.size.height = viewImageSoHKTrang5.frame.size.height + viewImageSoHKTrang5.frame.origin.y
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewUploadMore.frame.size.height = viewInfoSoHKTrang8.frame.size.height + viewInfoSoHKTrang8.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSoHK6(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang6.frame.size.width / sca
        viewImageSoHKTrang6.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang6  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang6.frame.size.width, height: heightImage))
        imgViewSoHKTrang6.contentMode = .scaleAspectFit
        imgViewSoHKTrang6.image = image
        viewImageSoHKTrang6.addSubview(imgViewSoHKTrang6)
        viewImageSoHKTrang6.frame.size.height = imgViewSoHKTrang6.frame.size.height + imgViewSoHKTrang6.frame.origin.y
        viewInfoSoHKTrang6.frame.size.height = viewImageSoHKTrang6.frame.size.height + viewImageSoHKTrang6.frame.origin.y
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewUploadMore.frame.size.height = viewInfoSoHKTrang8.frame.size.height + viewInfoSoHKTrang8.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSoHK7(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang7.frame.size.width / sca
        viewImageSoHKTrang7.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang7  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang7.frame.size.width, height: heightImage))
        imgViewSoHKTrang7.contentMode = .scaleAspectFit
        imgViewSoHKTrang7.image = image
        viewImageSoHKTrang7.addSubview(imgViewSoHKTrang7)
        viewImageSoHKTrang7.frame.size.height = imgViewSoHKTrang7.frame.size.height + imgViewSoHKTrang7.frame.origin.y
        viewInfoSoHKTrang7.frame.size.height = viewImageSoHKTrang7.frame.size.height + viewImageSoHKTrang7.frame.origin.y
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewUploadMore.frame.size.height = viewInfoSoHKTrang8.frame.size.height + viewInfoSoHKTrang8.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    func imageSoHK8(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang8.frame.size.width / sca
        viewImageSoHKTrang8.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang8  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang8.frame.size.width, height: heightImage))
        imgViewSoHKTrang8.contentMode = .scaleAspectFit
        imgViewSoHKTrang8.image = image
        viewImageSoHKTrang8.addSubview(imgViewSoHKTrang8)
        viewImageSoHKTrang8.frame.size.height = imgViewSoHKTrang8.frame.size.height + imgViewSoHKTrang8.frame.origin.y
        viewInfoSoHKTrang8.frame.size.height = viewImageSoHKTrang8.frame.size.height + viewImageSoHKTrang8.frame.origin.y
        viewUploadMore.frame.size.height = viewInfoSoHKTrang8.frame.size.height + viewInfoSoHKTrang8.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btUpload.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    /* ACTION UPLOAD */
    @objc func actionUpload(){
        imagesUpload.removeAll()
        if(self.ocfdFFriend == nil){
            if(imgViewCMNDTruoc == nil){
                self.showDialog(message: "Chưa có ảnh CMND mặt trước!")
                return
            }else{
                imagesUpload.updateValue(imgViewCMNDTruoc, forKey: "1")
            }
            if(imgViewCMNDSau == nil){
                self.showDialog(message: "Chưa có ảnh CMND mặt sau!")
                return
            }else{
                imagesUpload.updateValue(imgViewCMNDSau, forKey: "2")
            }
            if(imgVieAvatar == nil){
                self.showDialog(message: "Chưa có ảnh KH cầm CMND!")
                return
            }else{
                imagesUpload.updateValue(imgVieAvatar, forKey: "3")
            }
            if(imgVieAvatarSign == nil){
                self.showDialog(message: "Chưa có ảnh KH đang ký form mở thẻ!")
                return
            }else{
                imagesUpload.updateValue(imgVieAvatarSign, forKey: "17")
            }
            if(imgViewFormRegister == nil){
                self.showDialog(message: "Chưa có ảnh tờ 7/8 form mở thẻ!")
                return
            }else{
                imagesUpload.updateValue(imgViewFormRegister, forKey: "6")
            }
            if(nameProduct.count > 0){
                if(imgViewTrichNoTD == nil){
                    self.showDialog(message: "Chưa có ảnh đề xuất trích nợ tín dụng (Trang 1)!")
                    return
                }else{
                    imagesUpload.updateValue(imgViewTrichNoTD, forKey: "7")
                }
                if(imgViewTrichNoTDTrang2 == nil){
                    self.showDialog(message: "Chưa có ảnh đề xuất trích nợ tín dụng (Trang 2)!")
                    return
                }else{
                    imagesUpload.updateValue(imgViewTrichNoTDTrang2, forKey: "16")
                }
            }else{
                if(imgViewTrichNoTD != nil){
                    imagesUpload.updateValue(imgViewTrichNoTD, forKey: "7")
                }
                if(imgViewTrichNoTDTrang2 != nil){
                    imagesUpload.updateValue(imgViewTrichNoTDTrang2, forKey: "16")
                }
            }
            if(imgViewGPLXTruoc == nil || imgViewGPLXSau == nil){
                if(imgViewGPLXTruoc == nil && imgViewGPLXSau == nil){
                    if(imgViewSoHK == nil && imgViewSoHKTrang2 == nil && imgViewSoHKTrang3 == nil && imgViewSoHKTrang4 == nil && imgViewSoHKTrang5 == nil && imgViewSoHKTrang6 == nil && imgViewSoHKTrang7 == nil && imgViewSoHKTrang8 == nil){
                        self.showDialog(message: "Bạn chưa có ảnh Sổ hộ khẩu!")
                        return
                    }else{
                        if(imgViewSoHK != nil){
                            imagesUpload.updateValue(imgViewSoHK, forKey: "8")
                        }
                        if(imgViewSoHKTrang2 != nil){
                            imagesUpload.updateValue(imgViewSoHKTrang2, forKey: "9")
                        }
                        if(imgViewSoHKTrang3 != nil){
                            imagesUpload.updateValue(imgViewSoHKTrang3, forKey: "10")
                        }
                        if(imgViewSoHKTrang4 != nil){
                            imagesUpload.updateValue(imgViewSoHKTrang4, forKey: "11")
                        }
                        if(imgViewSoHKTrang5 != nil){
                            imagesUpload.updateValue(imgViewSoHKTrang5, forKey: "12")
                        }
                        if(imgViewSoHKTrang6 != nil){
                            imagesUpload.updateValue(imgViewSoHKTrang6, forKey: "13")
                        }
                        if(imgViewSoHKTrang7 != nil){
                            imagesUpload.updateValue(imgViewSoHKTrang7, forKey: "14")
                        }
                        if(imgViewSoHKTrang8 != nil){
                            imagesUpload.updateValue(imgViewSoHKTrang8, forKey: "15")
                        }
                    }
                }else{
                    self.showDialog(message: "Bạn chưa đầy đủ ảnh Giấy phép lái xe!")
                    return
                }
            }else{
                // upload gplx
                imagesUpload.updateValue(imgViewGPLXTruoc, forKey: "4")
                imagesUpload.updateValue(imgViewGPLXSau, forKey: "5")
            }
        }else{
            for i in 0..<fullFlagArr.count {
                let item = fullFlagArr[i]
                if(item != "0"){
                    let type:String = "\(i + 1)"
                    if (type == "1") {
                        if((imgViewCMNDTruoc == nil && item == "2") || (imgViewCMNDTruoc == nil && item == "1")){
                            self.showDialog(message: "Chưa có ảnh CMND mặt trước!")
                            return
                        }else{
                            if(imgViewCMNDTruoc != nil){
                                imagesUpload.updateValue(imgViewCMNDTruoc, forKey: "1")
                            }
                        }
                    }
                    if (type == "2"){
                        if((imgViewCMNDSau == nil && item == "2") || (imgViewCMNDSau == nil && item == "1")){
                            self.showDialog(message: "Chưa có ảnh CMND mặt sau!")
                            return
                        }else{
                            
                            if(imgViewCMNDSau != nil){
                                imagesUpload.updateValue(imgViewCMNDSau, forKey: "2")
                            }
                        }
                    }
                    if (type == "3"){
                        if((imgVieAvatar == nil && item == "2") || (imgVieAvatar == nil && item == "1")){
                            self.showDialog(message: "Chưa có ảnh KH cầm CMND!")
                            return
                        }else{
                            
                            if(imgVieAvatar != nil){
                                imagesUpload.updateValue(imgVieAvatar, forKey: "3")
                            }
                        }
                    }
                    if (type == "17"){
                        if((imgVieAvatarSign == nil && item == "2") || (imgVieAvatarSign == nil && item == "1")){
                            self.showDialog(message: "Chưa có ảnh KH đang ký form mở thẻ!")
                            return
                        }else{
                            
                            if(imgVieAvatarSign != nil){
                                imagesUpload.updateValue(imgVieAvatarSign, forKey: "17")
                            }
                        }
                    }
                    if (type == "4"){
                        if((imgViewGPLXTruoc == nil && item == "2") || (imgViewGPLXTruoc == nil && item == "1" && !checkImage())){
                            self.showDialog(message: "Chưa có GPLX mặt trước!")
                            return
                        }else{
                            if(imgViewGPLXTruoc != nil){
                                imagesUpload.updateValue(imgViewGPLXTruoc, forKey: "4")
                            }
                        }
                    }
                    if (type == "5"){
                        if((imgViewGPLXSau == nil && item == "2") || (imgViewGPLXSau == nil && item == "1" && !checkImage())){
                            self.showDialog(message: "Chưa có GPLX mặt sau!")
                            return
                        }else{
                            
                            if(imgViewGPLXSau != nil){
                                imagesUpload.updateValue(imgViewGPLXSau, forKey: "5")
                            }
                        }
                    }
                    if (type == "6"){
                        if((imgViewFormRegister == nil && item == "2") || (imgViewFormRegister == nil && item == "1")){
                            self.showDialog(message: "Chưa có ảnh tờ 7/8 form mở thẻ!")
                            return
                        }else{
                            
                            if(imgViewFormRegister != nil){
                                imagesUpload.updateValue(imgViewFormRegister, forKey: "6")
                            }
                        }
                    }
                    if (type == "7"){
                        if(self.ocfdFFriend!.TenSPThamDinh.count > 0){
                            if((imgViewTrichNoTD == nil && item == "2") || (imgViewTrichNoTD == nil && item == "1")){
                                self.showDialog(message: "Chưa có ảnh đề xuất trích nợ tín dụng (Trang 1)!")
                                return
                            }else{
                                if(imgViewTrichNoTD != nil){
                                    imagesUpload.updateValue(imgViewTrichNoTD, forKey: "7")
                                }
                            }
                        }else{
                            if(imgViewTrichNoTD != nil){
                                imagesUpload.updateValue(imgViewTrichNoTD, forKey: "7")
                            }
                        }
                    }
                    if (type == "16"){
                        if(self.ocfdFFriend!.TenSPThamDinh.count > 0){
                            if((imgViewTrichNoTDTrang2 == nil && item == "2") || (imgViewTrichNoTDTrang2 == nil && item == "1")){
                                self.showDialog(message: "Chưa có ảnh đề xuất trích nợ tín dụng (Trang 2)!")
                                return
                            }else{
                                if(imgViewTrichNoTDTrang2 != nil){
                                    imagesUpload.updateValue(imgViewTrichNoTDTrang2, forKey: "16")
                                }
                            }
                        }else{
                            if(imgViewTrichNoTDTrang2 != nil){
                                imagesUpload.updateValue(imgViewTrichNoTDTrang2, forKey: "16")
                            }
                        }
                    }
                    if (type == "8"){
                        if((imgViewSoHK == nil && item == "2") || (imgViewSoHK == nil && imgViewGPLXTruoc == nil && item == "1" && !checkImage())){
                            self.showDialog(message: "Chưa có ảnh Sổ hộ khẩu (T.1)!")
                            return
                        }else{
                            
                            if(imgViewSoHK != nil){
                                imagesUpload.updateValue(imgViewSoHK, forKey: "8")
                            }
                        }
                    }
                    if (type == "9"){
                        if((imgViewSoHKTrang2 == nil && item == "2") || (imgViewSoHKTrang2 == nil && imgViewGPLXTruoc == nil && item == "1" && !checkImage())){
                            self.showDialog(message: "Chưa có ảnh Sổ hộ khẩu (T.2)!")
                            return
                        }else{
                            
                            if(imgViewSoHKTrang2 != nil){
                                imagesUpload.updateValue(imgViewSoHKTrang2, forKey: "9")
                            }
                        }
                    }
                    if (type == "10"){
                        if((imgViewSoHKTrang3 == nil && item == "2") || (imgViewSoHKTrang3 == nil && imgViewGPLXTruoc == nil && item == "1" && !checkImage())){
                            self.showDialog(message: "Chưa có ảnh Sổ hộ khẩu (T.3)!")
                            return
                        }else{
                            
                            if(imgViewSoHKTrang3 != nil){
                                imagesUpload.updateValue(imgViewSoHKTrang3, forKey: "10")
                            }
                        }
                    }
                    if (type == "11"){
                        if((imgViewSoHKTrang4 == nil && item == "2") || (imgViewSoHKTrang4 == nil && imgViewGPLXTruoc == nil && item == "1" && !checkImage())){
                            self.showDialog(message: "Chưa có ảnh Sổ hộ khẩu (T.4)!")
                            return
                        }else{
                            
                            if(imgViewSoHKTrang4 != nil){
                                imagesUpload.updateValue(imgViewSoHKTrang4, forKey: "11")
                            }
                        }
                    }
                    if (type == "12"){
                        if((imgViewSoHKTrang5 == nil && item == "2") || (imgViewSoHKTrang5 == nil && imgViewGPLXTruoc == nil && item == "1" && !checkImage())){
                            self.showDialog(message: "Chưa có ảnh Sổ hộ khẩu (T.5)!")
                            return
                        }else{
                            
                            if(imgViewSoHKTrang5 != nil){
                                imagesUpload.updateValue(imgViewSoHKTrang5, forKey: "12")
                            }
                        }
                    }
                    if (type == "13"){
                        if((imgViewSoHKTrang6 == nil && item == "2") || (imgViewSoHKTrang6 == nil && imgViewGPLXTruoc == nil && item == "1" && !checkImage())){
                            self.showDialog(message: "Chưa có ảnh Sổ hộ khẩu (T.6)!")
                            return
                        }else{
                            
                            if(imgViewSoHKTrang6 != nil){
                                imagesUpload.updateValue(imgViewSoHKTrang6, forKey: "13")
                            }
                        }
                    }
                    if (type == "14"){
                        if((imgViewSoHKTrang7 == nil && item == "2") || (imgViewSoHKTrang7 == nil && imgViewGPLXTruoc == nil && item == "1" && !checkImage())){
                            self.showDialog(message: "Chưa có ảnh Sổ hộ khẩu (T.7)!")
                            return
                        }else{
                            if(imgViewSoHKTrang7 != nil){
                                imagesUpload.updateValue(imgViewSoHKTrang7, forKey: "14")
                            }
                            
                        }
                    }
                    if (type == "15"){
                        if((imgViewSoHKTrang8 == nil && item == "2") || (imgViewSoHKTrang8 == nil && imgViewGPLXTruoc == nil && item == "1" && !checkImage())){
                            self.showDialog(message: "Chưa có ảnh Sổ hộ khẩu (T.8)!")
                            return
                        }else{
                            if(imgViewSoHKTrang8 != nil){
                                imagesUpload.updateValue(imgViewSoHKTrang8, forKey: "15")
                            }
                            
                        }
                    }
                }
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
    func checkImage() -> Bool{
        for i in 7..<fullFlagArr.count {
            let item = fullFlagArr[i]
            if(item == "0"){
                return true
            }
        }
        
        if(imgViewSoHK == nil && imgViewSoHKTrang2 == nil && imgViewSoHKTrang3 == nil && imgViewSoHKTrang4 == nil && imgViewSoHKTrang5 == nil && imgViewSoHKTrang6 == nil && imgViewSoHKTrang7 == nil && imgViewSoHKTrang8 == nil ){
            return false
        }else{
            return true
        }
    }
    func uploadImage(loading:LoadingViewController){
        let nc = NotificationCenter.default
        if(imagesUpload.count > 0){
            let item = imagesUpload.popFirst()
            if let imageData:NSData = (item?.value.image!)!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
                MPOSAPIManager.UploadImage_CreditNoCard(IdCardCode: self.idCardCode, base64: strBase64, Type: "\((item?.key)!)") { (result, err) in
                    if(err.count <= 0){
                        self.nameimagesUpload.updateValue("\(result)", forKey: "\((item?.key)!)")
                        print("NAME \(result)")
                        self.uploadImage(loading: loading)
                    }else{
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
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
        }else{
            var CRD_MT_CMND:String = ""
            var CRD_MS_CMND:String = ""
            var CRD_KH_CMND:String = ""
            var CRD_KH_FORM:String = ""
            var CRD_GPLX_MT:String = ""
            var CRD_GPLX_MS:String = ""
            var CRD_MoThe:String = ""
            var CRD_DXTNTD:String = ""
            var CRD_DXTNTDTrang2:String = ""
            var CRD_SHK_1:String = ""
            var CRD_SHK_2:String = ""
            var CRD_SHK_3:String = ""
            var CRD_SHK_4:String = ""
            var CRD_SHK_5:String = ""
            var CRD_SHK_6:String = ""
            var CRD_SHK_7:String = ""
            var CRD_SHK_8:String = ""
            
            var Link_CRD_MT_CMND:String = linkCMNDMT
            var Link_CRD_MS_CMND:String = linkCMNDMS
            if(isChooseCMNDMT){
                Link_CRD_MT_CMND = ""
            }
            if(isChooseCMNDMS){
                Link_CRD_MS_CMND = ""
            }
            for item in self.nameimagesUpload {
                let type:String = item.key
                if (type == "1") {
                    CRD_MT_CMND = item.value
                }
                if (type == "2"){
                    CRD_MS_CMND = item.value
                }
                if (type == "3"){
                    CRD_KH_CMND = item.value
                }
                if (type == "4"){
                    CRD_GPLX_MT = item.value
                }
                if (type == "5"){
                    CRD_GPLX_MS = item.value
                }
                if (type == "6"){
                    CRD_MoThe = item.value
                }
                if (type == "7"){
                    CRD_DXTNTD = item.value
                }
                if (type == "8"){
                    CRD_SHK_1 = item.value
                }
                if (type == "9"){
                    CRD_SHK_2 = item.value
                }
                if (type == "10"){
                    CRD_SHK_3 = item.value
                }
                if (type == "11"){
                    CRD_SHK_4 = item.value
                }
                if (type == "12"){
                    CRD_SHK_5 = item.value
                }
                if (type == "13"){
                    CRD_SHK_6 = item.value
                }
                if (type == "14"){
                    CRD_SHK_7 = item.value
                }
                if (type == "15"){
                    CRD_SHK_8 = item.value
                }
                if (type == "16"){
                    CRD_DXTNTDTrang2 = item.value
                }
                if (type == "17"){
                    CRD_KH_FORM = item.value
                }
            }
            MPOSAPIManager.sp_CreditNoneCard_UploadImage_RequestV2(InsideCode: "\(Cache.user!.UserName)", IdCardCode: "\(idCardCode)", CRD_MT_CMND: CRD_MT_CMND, CRD_MS_CMND: CRD_MS_CMND, CRD_KH_CMND: CRD_KH_CMND, CRD_GPLX_MT: CRD_GPLX_MT, CRD_GPLX_MS: CRD_GPLX_MS, CRD_MoThe: CRD_MoThe, CRD_DXTNTD: CRD_DXTNTD, CRD_SHK_1: CRD_SHK_1, CRD_SHK_2: CRD_SHK_2, CRD_SHK_3: CRD_SHK_3, CRD_SHK_4: CRD_SHK_4, CRD_SHK_5: CRD_SHK_5, CRD_SHK_6: CRD_SHK_6, CRD_SHK_7: CRD_SHK_7, CRD_SHK_8: CRD_SHK_8, Link_CRD_MT_CMND: Link_CRD_MT_CMND, Link_CRD_MS_CMND: Link_CRD_MS_CMND, CRD_DXTNTD_M2: CRD_DXTNTDTrang2, CRD_CD_DKMoThe: CRD_KH_FORM, handler: { (result, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: result, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            _ = self.navigationController?.popToRootViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                            let myDict = ["CMND": "\(self.cmnd)"]
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("AutoLoadCMND"), object: myDict)
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }else{
                        let title = "THÔNG BÁO"
                        let popup = PopupDialog(title: title, message: result, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}
extension UploadImagesCreditNoCardViewControllerV2: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
            isChooseCMNDMT = true
            self.imageCMNDTruoc(image: image)
        }else if (self.posImageUpload == 2){
            isChooseCMNDMS = true
            self.imageCMNDSau(image: image)
        }else if (self.posImageUpload == 3){
            self.imageAvatar(image: image)
        }else if (self.posImageUpload == 4){
            self.imageGPLXTruoc(image: image)
        }else if (self.posImageUpload == 5){
            self.imageGPLXSau(image: image)
        }else if (self.posImageUpload == 6){
            self.imageFormRegister(image: image)
        }else if (self.posImageUpload == 7){
            self.imageTrichNoTD(image: image)
        }else if (self.posImageUpload == 8){
            self.imageSoHK(image: image)
        }else if (self.posImageUpload == 9){
            self.imageSoHK2(image: image)
        }else if (self.posImageUpload == 10){
            self.imageSoHK3(image: image)
        }else if (self.posImageUpload == 11){
            self.imageSoHK4(image: image)
        }else if (self.posImageUpload == 12){
            self.imageSoHK5(image: image)
        }else if (self.posImageUpload == 13){
            self.imageSoHK6(image: image)
        }else if (self.posImageUpload == 14){
            self.imageSoHK7(image: image)
        }else if (self.posImageUpload == 15){
            self.imageSoHK8(image: image)
        }else if (self.posImageUpload == 16){
            self.imageAvatarSign(image: image)
        }else if (self.posImageUpload == 17){
            self.imageTrichNoTDTrang2(image: image)
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


