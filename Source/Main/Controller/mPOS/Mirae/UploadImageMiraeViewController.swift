//
//  UploadImageMiraeViewController.swift
//  fptshop
//
//  Created by tan on 6/5/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import PopupDialog
protocol UploadImageMiraeViewControllerDelegate: NSObjectProtocol {
    
    func backSuccess()
    
}
class UploadImageMiraeViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,PopUpWarningUploadImageViewControllerDelegate {
    var delegate:UploadImageMiraeViewControllerDelegate?
    var getinfo_byContractNumber:Getinfo_byContractNumber?
     var historyMirae:HistoryOrderByID?
    var scrollView:UIScrollView!
    var tfPhoneNumber:UITextField!
    var tfCMND:UITextField!
    var tfDiaChi:UITextField!
    var tfUserName:UITextField!
    var imagePicker = UIImagePickerController()
     var viewUpload:UIView!
    var posImageUpload:Int = -1
    var heightUploadView:CGFloat = 0.0
    var btSave:UIButton!
   
    var viewInfoPDK:UIView!
    var viewImagePDK:UIView!
    var imgViewPDk: UIImageView!
    var viewPDK:UIView!
    //--
    //--
    var viewInfoPDK2:UIView!
    var viewImagePDK2:UIView!
    var imgViewPDk2: UIImageView!
    var viewPDK2:UIView!
    //--
    //--
    var viewInfoPDK3:UIView!
    var viewImagePDK3:UIView!
    var imgViewPDk3: UIImageView!
    var viewPDK3:UIView!
    //--
    //--
    var viewInfoPDK4:UIView!
    var viewImagePDK4:UIView!
    var imgViewPDk4: UIImageView!
    var viewPDK4:UIView!
    //--
    //--
    var viewInfoPDK5:UIView!
    var viewImagePDK5:UIView!
    var imgViewPDk5: UIImageView!
    var viewPDK5:UIView!
    //--
    //--
    var viewInfoPDK6:UIView!
    var viewImagePDK6:UIView!
    var imgViewPDk6: UIImageView!
    var viewPDK6:UIView!
      //--
    var viewInfoBienBanBanGiao:UIView!
    var viewImageBienBanBanGiao:UIView!
    var imgViewBienBanBanGiao: UIImageView!
    var viewBienBanBanGiao:UIView!
    //
    var viewInfoKHCamMay:UIView!
    var viewImageKHCamMay:UIView!
    var imgViewKHCamMay: UIImageView!
    var viewKHCamMay:UIView!
    //

    var fullFlagArr:[String] = []
    var listUploadImage:[UploadImageMirae] = []
    override func viewDidLoad() {
        self.title = "Upload PDK Biên Bản Bàn Giao"
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(UploadImageMiraeViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        if(self.getinfo_byContractNumber != nil){
            if(self.getinfo_byContractNumber!.Flag_Img_PDK_details != ""){
                self.fullFlagArr = self.getinfo_byContractNumber!.Flag_Img_PDK_details.components(separatedBy: ",")
            }
            
        }
        //---
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbUserInfo.textAlignment = .left
        lbUserInfo.textColor = UIColor(netHex:0x47B054)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbUserInfo.text = "THÔNG TIN KHÁCH HÀNG"
        scrollView.addSubview(lbUserInfo)
        
        
        let lbPhoneNumber = UILabel(frame: CGRect(x: Common.Size(s:20), y: lbUserInfo.frame.origin.y + lbUserInfo.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbPhoneNumber.textAlignment = .left
        lbPhoneNumber.textColor = UIColor.black
        lbPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPhoneNumber.text = "Số điện thoại"
        scrollView.addSubview(lbPhoneNumber)
        //input phone number
        tfPhoneNumber = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbPhoneNumber.frame.origin.y + lbPhoneNumber.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfPhoneNumber.placeholder = "Số điện thoại"
        tfPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneNumber.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneNumber.keyboardType = UIKeyboardType.numberPad
        tfPhoneNumber.returnKeyType = UIReturnKeyType.done
        tfPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhoneNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNumber.delegate = self
        scrollView.addSubview(tfPhoneNumber)
        tfPhoneNumber.isEnabled = false
        
        tfPhoneNumber.leftViewMode = UITextField.ViewMode.always
        let imagePhone = UIImageView(frame: CGRect(x: tfPhoneNumber.frame.size.height/4, y: tfPhoneNumber.frame.size.height/4, width: tfPhoneNumber.frame.size.height/2, height: tfPhoneNumber.frame.size.height/2))
        imagePhone.image = UIImage(named: "Phone-50")
        imagePhone.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewPhone = UIView()
        leftViewPhone.addSubview(imagePhone)
        leftViewPhone.frame = CGRect(x: 0, y: 0, width: tfPhoneNumber.frame.size.height, height: tfPhoneNumber.frame.size.height)
        tfPhoneNumber.leftView = leftViewPhone
        tfPhoneNumber.text = self.historyMirae!.PhoneNumber
        
        let lbCMND = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbCMND.textAlignment = .left
        lbCMND.textColor = UIColor.black
        lbCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMND.text = "CMND"
        scrollView.addSubview(lbCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:20), y: lbCMND.frame.origin.y + lbCMND.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfCMND.placeholder = "CMND"
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        
        scrollView.addSubview(tfCMND)
        tfCMND.isEnabled = false
        
        tfCMND.leftViewMode = UITextField.ViewMode.always
        let imageCMND = UIImageView(frame: CGRect(x: tfCMND.frame.size.height/4, y: tfCMND.frame.size.height/4, width: tfCMND.frame.size.height/2, height: tfCMND.frame.size.height/2))
        imageCMND.image = UIImage(named: "Phone-50")
        imageCMND.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewCMND = UIView()
        leftViewCMND.addSubview(imageCMND)
        leftViewCMND.frame = CGRect(x: 0, y: 0, width: tfCMND.frame.size.height, height: tfPhoneNumber.frame.size.height)
        tfCMND.leftView = leftViewCMND
        tfCMND.text = self.historyMirae!.IDCard
        
        
        let lbUserName = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbUserName.textAlignment = .left
        lbUserName.textColor = UIColor.black
        lbUserName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbUserName.text = "Tên khách hàng"
        scrollView.addSubview(lbUserName)
        
        //input name info
        tfUserName = UITextField(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: lbUserName.frame.origin.y + lbUserName.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ));
        tfUserName.placeholder = "Tên khách hàng"
        tfUserName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUserName.borderStyle = UITextField.BorderStyle.roundedRect
        tfUserName.autocorrectionType = UITextAutocorrectionType.no
        tfUserName.keyboardType = UIKeyboardType.default
        tfUserName.returnKeyType = UIReturnKeyType.done
        tfUserName.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfUserName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUserName.delegate = self
        
        scrollView.addSubview(tfUserName)
        tfUserName.isEnabled = false
        
        tfUserName.leftViewMode = UITextField.ViewMode.always
        let imageUser = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfPhoneNumber.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageUser.image = UIImage(named: "User-50")
        imageUser.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewUser = UIView()
        leftViewUser.addSubview(imageUser)
        leftViewUser.frame = CGRect(x: 0, y: 0, width: tfUserName.frame.size.height, height: tfUserName.frame.size.height)
        tfUserName.leftView = leftViewUser
        tfUserName.text = self.historyMirae!.FullName
        
        let lbDiaChi = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfUserName.frame.origin.y + tfUserName.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40), height: Common.Size(s:14)))
        lbDiaChi.textAlignment = .left
        lbDiaChi.textColor = UIColor.black
        lbDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbDiaChi.text = "Địa Chỉ"
        scrollView.addSubview(lbDiaChi)
        
        //input name info
        tfDiaChi = UITextField(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: lbDiaChi.frame.origin.y + lbDiaChi.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ));
        tfDiaChi.placeholder = "Địa Chỉ"
        tfDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDiaChi.borderStyle = UITextField.BorderStyle.roundedRect
        tfDiaChi.autocorrectionType = UITextAutocorrectionType.no
        tfDiaChi.keyboardType = UIKeyboardType.default
        tfDiaChi.returnKeyType = UIReturnKeyType.done
        tfDiaChi.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfDiaChi.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDiaChi.delegate = self
        
        scrollView.addSubview(tfDiaChi)
        tfDiaChi.isEnabled = false
        
        tfDiaChi.leftViewMode = UITextField.ViewMode.always
        let imageDiaChi = UIImageView(frame: CGRect(x: tfDiaChi.frame.size.height/4, y: tfDiaChi.frame.size.height/4, width: tfDiaChi.frame.size.height/2, height: tfDiaChi.frame.size.height/2))
        imageDiaChi.image = UIImage(named: "User-50")
        imageDiaChi.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewDiaChi = UIView()
        leftViewDiaChi.addSubview(imageDiaChi)
        leftViewDiaChi.frame = CGRect(x: 0, y: 0, width: tfDiaChi.frame.size.height, height: tfDiaChi.frame.size.height)
        tfDiaChi.leftView = leftViewDiaChi
        tfDiaChi.text = self.historyMirae!.P_Address
        

        //
        viewPDK = UIView(frame: CGRect(x:0,y:tfDiaChi.frame.size.height + tfDiaChi.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewPDK.clipsToBounds = true
        scrollView.addSubview(viewPDK)
        
        let lbTextPDK = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPDK.textAlignment = .left
        lbTextPDK.textColor = UIColor.black
        lbTextPDK.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPDK.text = "Phiếu đăng ký mua hàng"
        viewPDK.addSubview(lbTextPDK)
        
        viewImagePDK = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextPDK.frame.origin.y + lbTextPDK.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImagePDK.layer.borderWidth = 0.5
        viewImagePDK.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePDK.layer.cornerRadius = 3.0
        viewPDK.addSubview(viewImagePDK)
        
        let viewPDKButton = UIImageView(frame: CGRect(x: viewImagePDK.frame.size.width/2 - (viewImagePDK.frame.size.height * 2/3)/2, y: 0, width: viewImagePDK.frame.size.height * 2/3, height: viewImagePDK.frame.size.height * 2/3))
        viewPDKButton.image = UIImage(named:"AddImage")
        viewPDKButton.contentMode = .scaleAspectFit
        viewImagePDK.addSubview(viewPDKButton)
        
        let lbPDKButton = UILabel(frame: CGRect(x: 0, y: viewPDKButton.frame.size.height + viewPDKButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImagePDK.frame.size.height/3))
        lbPDKButton.textAlignment = .center
        lbPDKButton.textColor = UIColor(netHex:0xc2c2c2)
        lbPDKButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDKButton.text = "Thêm hình ảnh"
        viewImagePDK.addSubview(lbPDKButton)
        viewPDK.frame.size.height = viewImagePDK.frame.size.height + viewImagePDK.frame.origin.y
        
        let tapShowPDK = UITapGestureRecognizer(target: self, action: #selector(self.tapShowPDKMuaHang))
        viewImagePDK.isUserInteractionEnabled = true
        viewImagePDK.addGestureRecognizer(tapShowPDK)
        
        if(fullFlagArr[0] != "1"){
            viewPDK.frame.size.height = 0
            lbTextPDK.frame.size.height = 0
            viewImagePDK.frame.size.height = 0
            viewPDKButton.frame.size.height = 0
            lbPDKButton.frame.size.height = 0
            
        }

        //
        //
        viewPDK2 = UIView(frame: CGRect(x:0,y:viewPDK.frame.size.height + viewPDK.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewPDK2.clipsToBounds = true
        scrollView.addSubview(viewPDK2)
        
        let lbTextPDK2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPDK2.textAlignment = .left
        lbTextPDK2.textColor = UIColor.black
        lbTextPDK2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPDK2.text = "Phiếu đăng ký mua hàng trang 2"
        viewPDK2.addSubview(lbTextPDK2)
        
        viewImagePDK2 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextPDK2.frame.origin.y + lbTextPDK2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImagePDK2.layer.borderWidth = 0.5
        viewImagePDK2.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePDK2.layer.cornerRadius = 3.0
        viewPDK2.addSubview(viewImagePDK2)
        
        let viewPDK2Button = UIImageView(frame: CGRect(x: viewImagePDK2.frame.size.width/2 - (viewImagePDK2.frame.size.height * 2/3)/2, y: 0, width: viewImagePDK2.frame.size.height * 2/3, height: viewImagePDK2.frame.size.height * 2/3))
        viewPDK2Button.image = UIImage(named:"AddImage")
        viewPDK2Button.contentMode = .scaleAspectFit
        viewImagePDK2.addSubview(viewPDK2Button)
        
        let lbPDK2Button = UILabel(frame: CGRect(x: 0, y: viewPDK2Button.frame.size.height + viewPDK2Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImagePDK2.frame.size.height/3))
        lbPDK2Button.textAlignment = .center
        lbPDK2Button.textColor = UIColor(netHex:0xc2c2c2)
        lbPDK2Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDK2Button.text = "Thêm hình ảnh"
        viewImagePDK2.addSubview(lbPDK2Button)
        viewPDK2.frame.size.height = viewImagePDK2.frame.size.height + viewImagePDK2.frame.origin.y
        
        let tapShowPDK2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowPDK2MuaHang))
        viewImagePDK2.isUserInteractionEnabled = true
        viewImagePDK2.addGestureRecognizer(tapShowPDK2)
        
        if(fullFlagArr[1] != "1"){
            viewPDK2.frame.size.height = 0
            lbTextPDK2.frame.size.height = 0
            viewImagePDK2.frame.size.height = 0
            viewPDK2Button.frame.size.height = 0
            lbPDK2Button.frame.size.height = 0
            
        }
        //
        
        //
        viewPDK3 = UIView(frame: CGRect(x:0,y:viewPDK2.frame.size.height + viewPDK2.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewPDK3.clipsToBounds = true
        scrollView.addSubview(viewPDK3)
        
        let lbTextPDK3 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPDK3.textAlignment = .left
        lbTextPDK3.textColor = UIColor.black
        lbTextPDK3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPDK3.text = "Phiếu đăng ký mua hàng trang 3"
        viewPDK3.addSubview(lbTextPDK3)
        
        viewImagePDK3 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextPDK3.frame.origin.y + lbTextPDK3.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImagePDK3.layer.borderWidth = 0.5
        viewImagePDK3.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePDK3.layer.cornerRadius = 3.0
        viewPDK3.addSubview(viewImagePDK3)
        
        let viewPDK3Button = UIImageView(frame: CGRect(x: viewImagePDK3.frame.size.width/2 - (viewImagePDK3.frame.size.height * 2/3)/2, y: 0, width: viewImagePDK3.frame.size.height * 2/3, height: viewImagePDK3.frame.size.height * 2/3))
        viewPDK3Button.image = UIImage(named:"AddImage")
        viewPDK3Button.contentMode = .scaleAspectFit
        viewImagePDK3.addSubview(viewPDK3Button)
        
        let lbPDK3Button = UILabel(frame: CGRect(x: 0, y: viewPDK3Button.frame.size.height + viewPDK2Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImagePDK3.frame.size.height/3))
        lbPDK3Button.textAlignment = .center
        lbPDK3Button.textColor = UIColor(netHex:0xc2c2c2)
        lbPDK3Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDK3Button.text = "Thêm hình ảnh"
        viewImagePDK3.addSubview(lbPDK3Button)
        viewPDK3.frame.size.height = viewImagePDK3.frame.size.height + viewImagePDK3.frame.origin.y
        
        let tapShowPDK3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowPDK3MuaHang))
        viewImagePDK3.isUserInteractionEnabled = true
        viewImagePDK3.addGestureRecognizer(tapShowPDK3)
        
        if(fullFlagArr[2] != "1"){
            viewPDK3.frame.size.height = 0
            lbTextPDK3.frame.size.height = 0
            viewImagePDK3.frame.size.height = 0
            viewPDK3Button.frame.size.height = 0
            lbPDK3Button.frame.size.height = 0
            
        }
        //
        //
        viewPDK4 = UIView(frame: CGRect(x:0,y:viewPDK3.frame.size.height + viewPDK3.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewPDK4.clipsToBounds = true
        scrollView.addSubview(viewPDK4)
        
        let lbTextPDK4 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPDK4.textAlignment = .left
        lbTextPDK4.textColor = UIColor.black
        lbTextPDK4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPDK4.text = "Phiếu đăng ký mua hàng trang 4"
        viewPDK4.addSubview(lbTextPDK4)
        
        viewImagePDK4 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextPDK4.frame.origin.y + lbTextPDK4.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImagePDK4.layer.borderWidth = 0.5
        viewImagePDK4.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePDK4.layer.cornerRadius = 3.0
        viewPDK4.addSubview(viewImagePDK4)
        
        let viewPDK4Button = UIImageView(frame: CGRect(x: viewImagePDK4.frame.size.width/2 - (viewImagePDK4.frame.size.height * 2/3)/2, y: 0, width: viewImagePDK4.frame.size.height * 2/3, height: viewImagePDK4.frame.size.height * 2/3))
        viewPDK4Button.image = UIImage(named:"AddImage")
        viewPDK4Button.contentMode = .scaleAspectFit
        viewImagePDK4.addSubview(viewPDK4Button)
        
        let lbPDK4Button = UILabel(frame: CGRect(x: 0, y: viewPDK4Button.frame.size.height + viewPDK4Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImagePDK4.frame.size.height/3))
        lbPDK4Button.textAlignment = .center
        lbPDK4Button.textColor = UIColor(netHex:0xc2c2c2)
        lbPDK4Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDK4Button.text = "Thêm hình ảnh"
        viewImagePDK4.addSubview(lbPDK4Button)
        viewPDK4.frame.size.height = viewImagePDK4.frame.size.height + viewImagePDK4.frame.origin.y
        
        let tapShowPDK4 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowPDK4MuaHang))
        viewImagePDK4.isUserInteractionEnabled = true
        viewImagePDK4.addGestureRecognizer(tapShowPDK4)
        
        if(fullFlagArr[4] != "1"){
            viewPDK4.frame.size.height = 0
            lbTextPDK4.frame.size.height = 0
            viewImagePDK4.frame.size.height = 0
            viewPDK4Button.frame.size.height = 0
            lbPDK4Button.frame.size.height = 0
            
        }
        //
        viewPDK5 = UIView(frame: CGRect(x:0,y:viewPDK4.frame.size.height + viewPDK4.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewPDK5.clipsToBounds = true
        scrollView.addSubview(viewPDK5)
        
        let lbTextPDK5 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPDK5.textAlignment = .left
        lbTextPDK5.textColor = UIColor.black
        lbTextPDK5.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPDK5.text = "Phiếu đăng ký mua hàng trang 5"
        viewPDK5.addSubview(lbTextPDK5)
        
        viewImagePDK5 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextPDK5.frame.origin.y + lbTextPDK5.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImagePDK5.layer.borderWidth = 0.5
        viewImagePDK5.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePDK5.layer.cornerRadius = 3.0
        viewPDK5.addSubview(viewImagePDK5)
        
        let viewPDK5Button = UIImageView(frame: CGRect(x: viewImagePDK5.frame.size.width/2 - (viewImagePDK5.frame.size.height * 2/3)/2, y: 0, width: viewImagePDK5.frame.size.height * 2/3, height: viewImagePDK5.frame.size.height * 2/3))
        viewPDK5Button.image = UIImage(named:"AddImage")
        viewPDK5Button.contentMode = .scaleAspectFit
        viewImagePDK5.addSubview(viewPDK5Button)
        
        let lbPDK5Button = UILabel(frame: CGRect(x: 0, y: viewPDK5Button.frame.size.height + viewPDK5Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImagePDK5.frame.size.height/3))
        lbPDK5Button.textAlignment = .center
        lbPDK5Button.textColor = UIColor(netHex:0xc2c2c2)
        lbPDK5Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDK5Button.text = "Thêm hình ảnh"
        viewImagePDK5.addSubview(lbPDK5Button)
        viewPDK5.frame.size.height = viewImagePDK5.frame.size.height + viewImagePDK5.frame.origin.y
        
        let tapShowPDK5 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowPDK5MuaHang))
        viewImagePDK5.isUserInteractionEnabled = true
        viewImagePDK5.addGestureRecognizer(tapShowPDK5)
        
        if(fullFlagArr[5] != "1"){
            viewPDK5.frame.size.height = 0
            lbTextPDK5.frame.size.height = 0
            viewImagePDK5.frame.size.height = 0
            viewPDK5Button.frame.size.height = 0
            lbPDK5Button.frame.size.height = 0
            
        }
        //
        //
        viewPDK6 = UIView(frame: CGRect(x:0,y:viewPDK5.frame.size.height + viewPDK5.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewPDK6.clipsToBounds = true
        scrollView.addSubview(viewPDK6)
        
        let lbTextPDK6 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPDK6.textAlignment = .left
        lbTextPDK6.textColor = UIColor.black
        lbTextPDK6.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPDK6.text = "Phiếu đăng ký mua hàng trang 6"
        viewPDK6.addSubview(lbTextPDK6)
        
        viewImagePDK6 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextPDK6.frame.origin.y + lbTextPDK6.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImagePDK6.layer.borderWidth = 0.5
        viewImagePDK6.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePDK6.layer.cornerRadius = 3.0
        viewPDK6.addSubview(viewImagePDK6)
        
        let viewPDK6Button = UIImageView(frame: CGRect(x: viewImagePDK6.frame.size.width/2 - (viewImagePDK6.frame.size.height * 2/3)/2, y: 0, width: viewImagePDK6.frame.size.height * 2/3, height: viewImagePDK6.frame.size.height * 2/3))
        viewPDK6Button.image = UIImage(named:"AddImage")
        viewPDK6Button.contentMode = .scaleAspectFit
        viewImagePDK6.addSubview(viewPDK6Button)
        
        let lbPDK6Button = UILabel(frame: CGRect(x: 0, y: viewPDK6Button.frame.size.height + viewPDK6Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImagePDK6.frame.size.height/3))
        lbPDK6Button.textAlignment = .center
        lbPDK6Button.textColor = UIColor(netHex:0xc2c2c2)
        lbPDK6Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPDK6Button.text = "Thêm hình ảnh"
        viewImagePDK6.addSubview(lbPDK6Button)
        viewPDK6.frame.size.height = viewImagePDK6.frame.size.height + viewImagePDK6.frame.origin.y
        
        let tapShowPDK6 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowPDK6MuaHang))
        viewImagePDK6.isUserInteractionEnabled = true
        viewImagePDK6.addGestureRecognizer(tapShowPDK6)
        
        if(fullFlagArr[6] != "1"){
            viewPDK6.frame.size.height = 0
            lbTextPDK6.frame.size.height = 0
            viewImagePDK6.frame.size.height = 0
            viewPDK6Button.frame.size.height = 0
            lbPDK6Button.frame.size.height = 0
            
        }
            //
        viewBienBanBanGiao = UIView(frame: CGRect(x:0,y:viewPDK6.frame.size.height + viewPDK6.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewBienBanBanGiao.clipsToBounds = true
        scrollView.addSubview(viewBienBanBanGiao)
        
        let lbTextBienBanBanGiao = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBienBanBanGiao.textAlignment = .left
        lbTextBienBanBanGiao.textColor = UIColor.black
        lbTextBienBanBanGiao.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBienBanBanGiao.text = "Biên bản xác nhận"
        viewBienBanBanGiao.addSubview(lbTextBienBanBanGiao)
        
        viewImageBienBanBanGiao = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextBienBanBanGiao.frame.origin.y + lbTextBienBanBanGiao.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageBienBanBanGiao.layer.borderWidth = 0.5
        viewImageBienBanBanGiao.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageBienBanBanGiao.layer.cornerRadius = 3.0
        viewBienBanBanGiao.addSubview(viewImageBienBanBanGiao)
        
        let viewBienBanBanGiaoButton = UIImageView(frame: CGRect(x: viewImageBienBanBanGiao.frame.size.width/2 - (viewImageBienBanBanGiao.frame.size.height * 2/3)/2, y: 0, width: viewImageBienBanBanGiao.frame.size.height * 2/3, height: viewImageBienBanBanGiao.frame.size.height * 2/3))
        viewBienBanBanGiaoButton.image = UIImage(named:"AddImage")
        viewBienBanBanGiaoButton.contentMode = .scaleAspectFit
        viewImageBienBanBanGiao.addSubview(viewBienBanBanGiaoButton)
        
        let lbBienBanBanGiaoButton = UILabel(frame: CGRect(x: 0, y: viewBienBanBanGiaoButton.frame.size.height + viewBienBanBanGiaoButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageBienBanBanGiao.frame.size.height/3))
        lbBienBanBanGiaoButton.textAlignment = .center
        lbBienBanBanGiaoButton.textColor = UIColor(netHex:0xc2c2c2)
        lbBienBanBanGiaoButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbBienBanBanGiaoButton.text = "Thêm hình ảnh"
        viewImageBienBanBanGiao.addSubview(lbBienBanBanGiaoButton)
        viewBienBanBanGiao.frame.size.height = viewImageBienBanBanGiao.frame.size.height + viewImageBienBanBanGiao.frame.origin.y
        
        let tapShowBienBanBanGiao = UITapGestureRecognizer(target: self, action: #selector(self.tapShowBienBanBanGiao))
        viewImageBienBanBanGiao.isUserInteractionEnabled = true
        viewImageBienBanBanGiao.addGestureRecognizer(tapShowBienBanBanGiao)
        
        if(fullFlagArr[3] != "1"){
            viewBienBanBanGiao.frame.size.height = 0
            lbTextBienBanBanGiao.frame.size.height = 0
            viewImageBienBanBanGiao.frame.size.height = 0
            viewBienBanBanGiaoButton.frame.size.height = 0
            lbBienBanBanGiaoButton.frame.size.height = 0
            
        }
        //
        viewKHCamMay = UIView(frame: CGRect(x:0,y:viewBienBanBanGiao.frame.size.height + viewBienBanBanGiao.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewKHCamMay.clipsToBounds = true
        scrollView.addSubview(viewKHCamMay)
        
        let lbTextKHCamMay = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextKHCamMay.textAlignment = .left
        lbTextKHCamMay.textColor = UIColor.black
        lbTextKHCamMay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextKHCamMay.text = "Ảnh khách hàng cầm máy"
        viewKHCamMay.addSubview(lbTextKHCamMay)
        
        viewImageKHCamMay = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextKHCamMay.frame.origin.y + lbTextKHCamMay.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageKHCamMay.layer.borderWidth = 0.5
        viewImageKHCamMay.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageKHCamMay.layer.cornerRadius = 3.0
        viewKHCamMay.addSubview(viewImageKHCamMay)
        
        let viewKHCamMayButton = UIImageView(frame: CGRect(x: viewImageKHCamMay.frame.size.width/2 - (viewImageKHCamMay.frame.size.height * 2/3)/2, y: 0, width: viewImageKHCamMay.frame.size.height * 2/3, height: viewImageKHCamMay.frame.size.height * 2/3))
        viewKHCamMayButton.image = UIImage(named:"AddImage")
        viewKHCamMayButton.contentMode = .scaleAspectFit
        viewImageKHCamMay.addSubview(viewKHCamMayButton)
        
        let lbKHCamMayButton = UILabel(frame: CGRect(x: 0, y: viewBienBanBanGiaoButton.frame.size.height + viewBienBanBanGiaoButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageBienBanBanGiao.frame.size.height/3))
        lbKHCamMayButton.textAlignment = .center
        lbKHCamMayButton.textColor = UIColor(netHex:0xc2c2c2)
        lbKHCamMayButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbKHCamMayButton.text = "Thêm hình ảnh"
        viewImageKHCamMay.addSubview(lbBienBanBanGiaoButton)
        viewKHCamMay.frame.size.height = viewImageKHCamMay.frame.size.height + viewImageKHCamMay.frame.origin.y
        
        let tapShowKHCamMay = UITapGestureRecognizer(target: self, action: #selector(self.tapShowKHCamMay))
        viewImageKHCamMay.isUserInteractionEnabled = true
        viewImageKHCamMay.addGestureRecognizer(tapShowKHCamMay)
        
        if(fullFlagArr[7] != "1"){
            viewKHCamMay.frame.size.height = 0
            lbTextKHCamMay.frame.size.height = 0
            viewImageKHCamMay.frame.size.height = 0
            viewKHCamMayButton.frame.size.height = 0
            lbKHCamMayButton.frame.size.height = 0
            
        }
        //

        
        btSave = UIButton()
        btSave.frame = CGRect(x: Common.Size(s:10), y:viewKHCamMay.frame.size.height + viewKHCamMay.frame.origin.y + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:20), height: tfPhoneNumber.frame.size.height * 1.2)
        btSave.backgroundColor = UIColor(netHex:0x00955E)
        btSave.setTitle("Lưu", for: .normal)
        btSave.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
        btSave.layer.borderWidth = 0.5
        btSave.layer.borderColor = UIColor.white.cgColor
        btSave.layer.cornerRadius = 3
        scrollView.addSubview(btSave)
      
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSave.frame.origin.y + btSave.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
    }
//    @objc func actionSave(){
//
//        if(viewPDK.frame.size.height > 0){
//            if (imgViewPDk == nil){
//
//                let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh phiếu đăng ký trang 1", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                })
//                self.present(alert, animated: true)
//                return
//            }
//        }
//
//        if(viewPDK2.frame.size.height > 0){
//            if (imgViewPDk2 == nil){
//
//                let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh phiếu đăng ký trang 2", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                })
//                self.present(alert, animated: true)
//                return
//            }
//        }
//
//        if(viewPDK3.frame.size.height > 0){
//            if (imgViewPDk3 == nil){
//
//                let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh phiếu đăng ký trang 3", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                })
//                self.present(alert, animated: true)
//                return
//            }
//        }
//
//        if(viewPDK4.frame.size.height > 0){
//            if (imgViewPDk4 == nil){
//
//                let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh phiếu đăng ký trang 4", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                })
//                self.present(alert, animated: true)
//                return
//            }
//        }
//        if(viewPDK5.frame.size.height > 0){
//            if (imgViewPDk5 == nil){
//
//                let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh phiếu đăng ký trang 5", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                })
//                self.present(alert, animated: true)
//                return
//            }
//        }
//
//        if(viewBienBanBanGiao.frame.size.height > 0){
//            if(imgViewBienBanBanGiao == nil){
//
//                let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh biên bản bàn giao", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                })
//                self.present(alert, animated: true)
//                return
//            }
//        }
//
//        let newViewController = LoadingViewController()
//        newViewController.content = "Đang lưu thông tin ..."
//        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.navigationController?.present(newViewController, animated: true, completion: nil)
//        let nc = NotificationCenter.default
//
//
//        MPOSAPIManager.mpos_FRT_SP_Mirae_Insert_image_contract(base64Xmlimage:self.parseXMLURL().toBase64(),Docentry: "\(self.historyMirae!.Docentry)",processId:"\(self.historyMirae!.processId_Mirae)",IsUpdate:"2") { (results, err) in
//            let when = DispatchTime.now() + 0.5
//            DispatchQueue.main.asyncAfter(deadline: when) {
//                //nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                if(err.count <= 0){
//                    if(results[0].p_status == 0){
//                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                        let alert = UIAlertController(title: "Thông báo", message: results[0].p_messagess, preferredStyle: .alert)
//
//                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                        })
//                        self.present(alert, animated: true)
//                        return
//                    }
//
//
//                    //
//                    MPOSAPIManager.mpos_ConfirmUploadComplete(activityId:self.historyMirae!.activityId_Mirae) { (message, err) in
//                        let when = DispatchTime.now() + 0.5
//                        DispatchQueue.main.asyncAfter(deadline: when) {
//                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                            if(err.count <= 0){
//
//                                let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
//
//                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//                                        self.navigationController?.popViewController(animated: true)
//                                    self.delegate?.backSuccess()
//                                })
//                                self.present(alert, animated: true)
//
//
//
//                            }else{
//                                let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
//
//                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                                })
//                                self.present(alert, animated: true)
//                            }
//                        }
//                    }
//                    //
//
//
//
//
//                }else{
//                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
//
//                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                    })
//                    self.present(alert, animated: true)
//                }
//            }
//        }
//    }
    
     @objc func actionSave(){
         
//         if(viewPDK.frame.size.height > 0){
//             if (imgViewPDk == nil){
//
//                 let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh phiếu đăng ký trang 1", preferredStyle: .alert)
//
//                 alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                 })
//                 self.present(alert, animated: true)
//                 return
//             }
//         }
//
//         if(viewPDK2.frame.size.height > 0){
//             if (imgViewPDk2 == nil){
//
//                 let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh phiếu đăng ký trang 2", preferredStyle: .alert)
//
//                 alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                 })
//                 self.present(alert, animated: true)
//                 return
//             }
//         }
//
//         if(viewPDK3.frame.size.height > 0){
//             if (imgViewPDk3 == nil){
//
//                 let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh phiếu đăng ký trang 3", preferredStyle: .alert)
//
//                 alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                 })
//                 self.present(alert, animated: true)
//                 return
//             }
//         }
//
//         if(viewPDK4.frame.size.height > 0){
//             if (imgViewPDk4 == nil){
//
//                 let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh phiếu đăng ký trang 4", preferredStyle: .alert)
//
//                 alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                 })
//                 self.present(alert, animated: true)
//                 return
//             }
//         }
//         if(viewPDK5.frame.size.height > 0){
//             if (imgViewPDk5 == nil){
//
//                 let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh phiếu đăng ký trang 5", preferredStyle: .alert)
//
//                 alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                 })
//                 self.present(alert, animated: true)
//                 return
//             }
//         }
//
//         if(viewBienBanBanGiao.frame.size.height > 0){
//             if(imgViewBienBanBanGiao == nil){
//
//                 let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh biên bản bàn giao", preferredStyle: .alert)
//
//                 alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                 })
//                 self.present(alert, animated: true)
//                 return
//             }
//         }
     
         let newViewController = LoadingViewController()
         newViewController.content = "Đang lưu thông tin ..."
         newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
         newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
         self.navigationController?.present(newViewController, animated: true, completion: nil)
         let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_Mirae_NotiAfterUploadImageComplete(DocEntry: "\(self.historyMirae!.Docentry)",processId:"\(self.historyMirae!.processId_Mirae)") { (p_status,message,err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    if (p_status == 1) {
                        let myVC = PopUpWarningUploadImageViewController()
                        myVC.delegate = self
                        myVC.warning = message
                        myVC.base64URL = self.parseXMLURL().toBase64()
                        myVC.historyMirae = self.historyMirae!
                        let navController = UINavigationController(rootViewController: myVC)
                        self.navigationController?.present(navController, animated:false, completion: nil)
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
    
    func returnUpload(){
//        self.navigationController?.popViewController(animated: true)
        //        self.delegate?.backSuccess()
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("SearchCMNDMiraeHistory"), object: nil)
        
    }
    
    

    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
   
    @objc  func tapShowPDKMuaHang(sender:UITapGestureRecognizer) {
        self.posImageUpload = 13
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowPDK2MuaHang(sender:UITapGestureRecognizer) {
        self.posImageUpload = 14
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc  func tapShowPDK3MuaHang(sender:UITapGestureRecognizer) {
        self.posImageUpload = 15
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc  func tapShowPDK4MuaHang(sender:UITapGestureRecognizer) {
        self.posImageUpload = 16
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowPDK5MuaHang(sender:UITapGestureRecognizer) {
        self.posImageUpload = 17
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowPDK6MuaHang(sender:UITapGestureRecognizer) {
        self.posImageUpload = 18
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc  func tapShowBienBanBanGiao(sender:UITapGestureRecognizer) {
        self.posImageUpload = 19
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowKHCamMay(sender:UITapGestureRecognizer) {
          self.posImageUpload = 20
          self.thisIsTheFunctionWeAreCalling()
      }

    func imagePDKMuaHang(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImagePDK.frame.size.width / sca
        viewImagePDK.subviews.forEach { $0.removeFromSuperview() }
        imgViewPDk  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImagePDK.frame.size.width, height: heightImage))
        imgViewPDk.contentMode = .scaleAspectFit
        imgViewPDk.image = image
        viewImagePDK.addSubview(imgViewPDk)
        viewImagePDK.frame.size.height = imgViewPDk.frame.size.height + imgViewPDk.frame.origin.y
        viewPDK.frame.size.height = viewImagePDK.frame.size.height + viewImagePDK.frame.origin.y
        
        viewPDK2.frame.origin.y =  viewPDK.frame.size.height + viewPDK.frame.origin.y + Common.Size(s: 10)
        
        viewPDK3.frame.origin.y =  viewPDK2.frame.size.height + viewPDK2.frame.origin.y + Common.Size(s: 10)
      viewPDK4.frame.origin.y =  viewPDK3.frame.size.height + viewPDK3.frame.origin.y + Common.Size(s: 10)
          viewPDK5.frame.origin.y =  viewPDK4.frame.size.height + viewPDK4.frame.origin.y + Common.Size(s: 10)
        viewPDK6.frame.origin.y =  viewPDK5.frame.size.height + viewPDK5.frame.origin.y + Common.Size(s: 10)
        viewBienBanBanGiao.frame.origin.y =  viewPDK6.frame.size.height + viewPDK6.frame.origin.y + Common.Size(s: 10)
        viewKHCamMay.frame.origin.y =  viewBienBanBanGiao.frame.size.height + viewBienBanBanGiao.frame.origin.y + Common.Size(s: 10)
        
        btSave.frame.origin.y = viewKHCamMay.frame.size.height + viewKHCamMay.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSave.frame.origin.y + btSave.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "13", image: self.imgViewPDk.image!)
            
        }
        
       
    }
    func imagePDK2MuaHang(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImagePDK2.frame.size.width / sca
        viewImagePDK2.subviews.forEach { $0.removeFromSuperview() }
        imgViewPDk2  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImagePDK2.frame.size.width, height: heightImage))
        imgViewPDk2.contentMode = .scaleAspectFit
        imgViewPDk2.image = image
        viewImagePDK2.addSubview(imgViewPDk2)
        viewImagePDK2.frame.size.height = imgViewPDk2.frame.size.height + imgViewPDk2.frame.origin.y
        viewPDK2.frame.size.height = viewImagePDK2.frame.size.height + viewImagePDK2.frame.origin.y
        
        viewPDK3.frame.origin.y =  viewPDK2.frame.size.height + viewPDK2.frame.origin.y + Common.Size(s: 10)
        viewPDK4.frame.origin.y =  viewPDK3.frame.size.height + viewPDK3.frame.origin.y + Common.Size(s: 10)
        viewPDK5.frame.origin.y =  viewPDK4.frame.size.height + viewPDK4.frame.origin.y + Common.Size(s: 10)
          viewPDK6.frame.origin.y =  viewPDK5.frame.size.height + viewPDK5.frame.origin.y + Common.Size(s: 10)
        viewBienBanBanGiao.frame.origin.y =  viewPDK6.frame.size.height + viewPDK6.frame.origin.y
        
        viewKHCamMay.frame.origin.y =  viewBienBanBanGiao.frame.size.height + viewBienBanBanGiao.frame.origin.y + Common.Size(s: 10)
         
         btSave.frame.origin.y = viewKHCamMay.frame.size.height + viewKHCamMay.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSave.frame.origin.y + btSave.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "14", image: self.imgViewPDk2.image!)
            
        }
        
        
    }
    func imagePDK3MuaHang(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImagePDK3.frame.size.width / sca
        viewImagePDK3.subviews.forEach { $0.removeFromSuperview() }
        imgViewPDk3  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImagePDK3.frame.size.width, height: heightImage))
        imgViewPDk3.contentMode = .scaleAspectFit
        imgViewPDk3.image = image
        viewImagePDK3.addSubview(imgViewPDk3)
        viewImagePDK3.frame.size.height = imgViewPDk3.frame.size.height + imgViewPDk3.frame.origin.y
        viewPDK3.frame.size.height = viewImagePDK3.frame.size.height + viewImagePDK3.frame.origin.y
        viewPDK4.frame.origin.y =  viewPDK3.frame.size.height + viewPDK3.frame.origin.y + Common.Size(s: 10)
        viewPDK5.frame.origin.y =  viewPDK4.frame.size.height + viewPDK4.frame.origin.y + Common.Size(s: 10)
        viewPDK6.frame.origin.y =  viewPDK5.frame.size.height + viewPDK5.frame.origin.y + Common.Size(s: 10)
        
        viewBienBanBanGiao.frame.origin.y =  viewPDK6.frame.size.height + viewPDK6.frame.origin.y + Common.Size(s: 10)
        
               viewKHCamMay.frame.origin.y =  viewBienBanBanGiao.frame.size.height + viewBienBanBanGiao.frame.origin.y + Common.Size(s: 10)
         
         btSave.frame.origin.y = viewKHCamMay.frame.size.height + viewKHCamMay.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSave.frame.origin.y + btSave.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "15", image: self.imgViewPDk3.image!)
            
        }
        
        
    }
    
    func imagePDK4MuaHang(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImagePDK4.frame.size.width / sca
        viewImagePDK4.subviews.forEach { $0.removeFromSuperview() }
        imgViewPDk4  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImagePDK4.frame.size.width, height: heightImage))
        imgViewPDk4.contentMode = .scaleAspectFit
        imgViewPDk4.image = image
        viewImagePDK4.addSubview(imgViewPDk4)
        viewImagePDK4.frame.size.height = imgViewPDk4.frame.size.height + imgViewPDk4.frame.origin.y
        viewPDK4.frame.size.height = viewImagePDK4.frame.size.height + viewImagePDK4.frame.origin.y
        
        
        viewPDK5.frame.origin.y =  viewPDK4.frame.size.height + viewPDK4.frame.origin.y + Common.Size(s: 10)
        viewPDK6.frame.origin.y =  viewPDK5.frame.size.height + viewPDK5.frame.origin.y + Common.Size(s: 10)
        viewBienBanBanGiao.frame.origin.y =  viewPDK6.frame.size.height + viewPDK6.frame.origin.y + Common.Size(s: 10)
        
               viewKHCamMay.frame.origin.y =  viewBienBanBanGiao.frame.size.height + viewBienBanBanGiao.frame.origin.y + Common.Size(s: 10)
         
         btSave.frame.origin.y = viewKHCamMay.frame.size.height + viewKHCamMay.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSave.frame.origin.y + btSave.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "19", image: self.imgViewPDk4.image!)
            
        }
        
        
    }
    func imagePDK5MuaHang(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImagePDK4.frame.size.width / sca
        viewImagePDK5.subviews.forEach { $0.removeFromSuperview() }
        imgViewPDk5  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImagePDK5.frame.size.width, height: heightImage))
        imgViewPDk5.contentMode = .scaleAspectFit
        imgViewPDk5.image = image
        viewImagePDK5.addSubview(imgViewPDk5)
        viewImagePDK5.frame.size.height = imgViewPDk5.frame.size.height + imgViewPDk5.frame.origin.y
        viewPDK5.frame.size.height = viewImagePDK5.frame.size.height + viewImagePDK5.frame.origin.y
        
        
        viewPDK6.frame.origin.y =  viewPDK5.frame.size.height + viewPDK5.frame.origin.y + Common.Size(s: 10)
        
        viewBienBanBanGiao.frame.origin.y =  viewPDK6.frame.size.height + viewPDK6.frame.origin.y + Common.Size(s: 10)
        
            viewKHCamMay.frame.origin.y =  viewBienBanBanGiao.frame.size.height + viewBienBanBanGiao.frame.origin.y + Common.Size(s: 10)
         
         btSave.frame.origin.y = viewKHCamMay.frame.size.height + viewKHCamMay.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSave.frame.origin.y + btSave.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "20", image: self.imgViewPDk5.image!)
            
        }
        
        
    }
    func imagePDK6MuaHang(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImagePDK6.frame.size.width / sca
        viewImagePDK6.subviews.forEach { $0.removeFromSuperview() }
        imgViewPDk6  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImagePDK6.frame.size.width, height: heightImage))
        imgViewPDk6.contentMode = .scaleAspectFit
        imgViewPDk6.image = image
        viewImagePDK6.addSubview(imgViewPDk6)
        viewImagePDK6.frame.size.height = imgViewPDk6.frame.size.height + imgViewPDk6.frame.origin.y
        viewPDK6.frame.size.height = viewImagePDK6.frame.size.height + viewImagePDK6.frame.origin.y
        
        
        
        viewBienBanBanGiao.frame.origin.y =  viewPDK6.frame.size.height + viewPDK6.frame.origin.y + Common.Size(s: 10)
        
               viewKHCamMay.frame.origin.y =  viewBienBanBanGiao.frame.size.height + viewBienBanBanGiao.frame.origin.y + Common.Size(s: 10)
         
         btSave.frame.origin.y = viewKHCamMay.frame.size.height + viewKHCamMay.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSave.frame.origin.y + btSave.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "21", image: self.imgViewPDk6.image!)
            
        }
        
        
    }
    func imageBienBanBanGiao(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageBienBanBanGiao.frame.size.width / sca
        viewImageBienBanBanGiao.subviews.forEach { $0.removeFromSuperview() }
        imgViewBienBanBanGiao  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageBienBanBanGiao.frame.size.width, height: heightImage))
        imgViewBienBanBanGiao.contentMode = .scaleAspectFit
        imgViewBienBanBanGiao.image = image
        viewImageBienBanBanGiao.addSubview(imgViewBienBanBanGiao)
        viewImageBienBanBanGiao.frame.size.height = imgViewBienBanBanGiao.frame.size.height + imgViewBienBanBanGiao.frame.origin.y
        viewBienBanBanGiao.frame.size.height = viewImageBienBanBanGiao.frame.size.height + viewImageBienBanBanGiao.frame.origin.y
        
        
        
               viewKHCamMay.frame.origin.y =  viewBienBanBanGiao.frame.size.height + viewBienBanBanGiao.frame.origin.y + Common.Size(s: 10)
         
         btSave.frame.origin.y = viewKHCamMay.frame.size.height + viewKHCamMay.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSave.frame.origin.y + btSave.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30))
        
     
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
          self.uploadImageV2(type: "16", image: self.imgViewBienBanBanGiao.image!)
            
        }
    }
    func imageKHCamMay(image:UIImage){
           let sca:CGFloat = image.size.width / image.size.height
           let heightImage:CGFloat = viewImageKHCamMay.frame.size.width / sca
           viewImageKHCamMay.subviews.forEach { $0.removeFromSuperview() }
           imgViewKHCamMay  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageKHCamMay.frame.size.width, height: heightImage))
           imgViewKHCamMay.contentMode = .scaleAspectFit
           imgViewKHCamMay.image = image
           viewImageKHCamMay.addSubview(imgViewKHCamMay)
           viewImageKHCamMay.frame.size.height = imgViewKHCamMay.frame.size.height + imgViewKHCamMay.frame.origin.y
           viewKHCamMay.frame.size.height = viewImageKHCamMay.frame.size.height + viewImageKHCamMay.frame.origin.y
           

            
            btSave.frame.origin.y = viewKHCamMay.frame.size.height + viewKHCamMay.frame.origin.y + Common.Size(s:20)
           scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSave.frame.origin.y + btSave.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30))
           
        
           let when = DispatchTime.now() + 0.3
           DispatchQueue.main.asyncAfter(deadline: when) {
             self.uploadImageV2(type: "22", image: self.imgViewKHCamMay.image!)
               
           }
       }
    
    func parseXMLURL()->String{
        var rs:String = "<Data>"
        for item in self.listUploadImage {
            var name = item.url
            name = name.replace(target: "&", withString:"&#38;")
            name = name.replace(target: "<", withString:"&#60;")
            name = name.replace(target: ">", withString:"&#62;")
            name = name.replace(target: "\"", withString:"&#34;")
            name = name.replace(target: "'", withString:"&#39;")
            
            
            item.url =  item.url.replace(target: "&", withString:"&#38;")
            item.url =  item.url.replace(target: "<", withString:"&#60;")
            item.url =  item.url.replace(target: ">", withString:"&#62;")
            item.url =  item.url.replace(target: "\"", withString:"&#34;")
            item.url =  item.url.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item urlimage=\"\(item.url)\" contentType=\"\(item.type)\"/>"
        }
        rs = rs + "</Data>"
        print(rs)
        return rs
    }
    func uploadImageV2(type:String,image:UIImage){
        var DirectoryMirae:String = ""
        if(type == "13"){
            // pdk
            DirectoryMirae = self.getinfo_byContractNumber!.ftpPathContract_Mirae
        }
        if(type == "14"){
            // pdk
            DirectoryMirae = self.getinfo_byContractNumber!.ftpPathContract_Mirae
        }
        if(type == "15"){
            // pdk
            DirectoryMirae = self.getinfo_byContractNumber!.ftpPathContract_Mirae
        }
        if(type == "19"){
            // pdk
            DirectoryMirae = self.getinfo_byContractNumber!.ftpPathContract_Mirae
        }
        if(type == "20"){
            // pdk
            DirectoryMirae = self.getinfo_byContractNumber!.ftpPathContract_Mirae
        }
        if(type == "21"){
            // pdk
            DirectoryMirae = self.getinfo_byContractNumber!.ftpPathContract_Mirae
        }
        if(type == "16"){
            //bien ban ban giao
            DirectoryMirae = self.getinfo_byContractNumber!.ftpPath3Party_Mirae
        }
        if(type == "22"){
            // pdk
            DirectoryMirae = self.getinfo_byContractNumber!.ftpPathContract_Mirae
        }
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
            let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            if(strBase64 == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Lỗi convert Base64!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            MPOSAPIManager.UploadImage_Mirae(base64:"\(strBase64)",processId:"\(self.historyMirae!.processId_Mirae)",IdCardNo:"\(self.historyMirae!.IDCard)",contentType:"\(type)",DirectoryMirae:"\(DirectoryMirae)") { (result, err) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(err.count <= 0){
                        let uploadImage = UploadImageMirae(url:result
                            , type:type)
                        
                        if(self.listUploadImage.count > 0){
                            let obj =  self.listUploadImage.filter{ $0.type == "\(uploadImage.type)" }.first
                            
                            if(obj != nil){
                                if let index = self.listUploadImage.firstIndex(of: obj!) {
                                    self.listUploadImage.remove(at: index)
                                }
                            }
                        
                        }
                     
                        
                        
                        self.listUploadImage.append(uploadImage)
      
                        
                        
                    }else{
                        let title = "THÔNG BÁO(1)"
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
extension UploadImageMiraeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        if (self.posImageUpload == 13){
            self.imagePDKMuaHang(image: image)
        }else if (self.posImageUpload == 14){
            self.imagePDK2MuaHang(image: image)
        }else if (self.posImageUpload == 15){
            self.imagePDK3MuaHang(image: image)
        }else if (self.posImageUpload == 16){
            self.imagePDK4MuaHang(image: image)
        }else if (self.posImageUpload == 17){
            self.imagePDK5MuaHang(image: image)
        }else if (self.posImageUpload == 18){
            self.imagePDK6MuaHang(image: image)
        }else if (self.posImageUpload == 19){
            self.imageBienBanBanGiao(image: image)
        }else if (self.posImageUpload == 20){
            self.imageKHCamMay(image: image)
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
