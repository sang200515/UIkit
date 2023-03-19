//
//  UploadSignDocRightPhoneViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 3/23/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class UploadSignDocRightPhoneViewController: UIViewController {
    
    var scrollView:UIScrollView!
    
    //--
    var viewInfoSignDoc:UIView!
    var viewImageSignDoc:UIView!
    var imgViewSignDoc: UIImageView!
    var viewSignDoc:UIView!
    //
    var imagePicker = UIImagePickerController()
    var posImageUpload:Int = -1
    var itemRPOnProgress:ItemRPOnProgress?
    var detailRPRcheck:DetailRPRcheck?
    var urlFrontCMND:String = ""
    var urlBehindCMND:String = ""
    var urlLeft:String = ""
    var urlRight:String = ""
    var urlBroken:String = ""
    var urlSign:String = ""
    var urlAvarta:String = ""
    var urlNP:String = ""
    var btConfirm:UIButton!
    var btEmail:UIButton!
    override func viewDidLoad() {
        self.title = "Số MPOS: \(self.itemRPOnProgress!.docentry)"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(UploadSignDocRightPhoneViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label.text = "THÔNG TIN SẢN PHẨM"
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label)
        
        let viewProduct = UIView()
        viewProduct.frame = CGRect(x: 0, y: label.frame.size.height + label.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewProduct.backgroundColor = UIColor.white
        scrollView.addSubview(viewProduct)
        
        let lblMposNum = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMposNum.textAlignment = .left
        lblMposNum.textColor = UIColor.black
        lblMposNum.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lblMposNum.text = "Số Mpos: \(self.itemRPOnProgress?.docentry ?? 0)"
        viewProduct.addSubview(lblMposNum)
        
        let lblNameProduct = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblMposNum.frame.size.height + lblMposNum.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNameProduct.textAlignment = .left
        lblNameProduct.textColor = UIColor.black
        lblNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lblNameProduct.text = "Tên SP: \(self.detailRPRcheck!.ItemName)"
        viewProduct.addSubview(lblNameProduct)
        
        
        let lblImei = UILabel(frame: CGRect(x: Common.Size(s:10), y:lblNameProduct.frame.size.height + lblNameProduct.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblImei.textAlignment = .left
        lblImei.textColor = UIColor(netHex:0x00955E)
        lblImei.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        lblImei.text = "Imei: \(self.detailRPRcheck!.IMEI)"
        viewProduct.addSubview(lblImei)
        
        
        
        
        let lblColorProduct = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblImei.frame.size.height + lblImei.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblColorProduct.textAlignment = .left
        lblColorProduct.textColor = UIColor.black
        lblColorProduct.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblColorProduct.text = "Màu sắc: \(self.detailRPRcheck!.color)"
        viewProduct.addSubview(lblColorProduct)
        
        
        let lblBranch = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblImei.frame.size.height + lblImei.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBranch.textAlignment = .right
        lblBranch.textColor = UIColor.black
        lblBranch.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBranch.text = "Hãng: \(self.detailRPRcheck!.manufacturer)"
        viewProduct.addSubview(lblBranch)
        
        let lblMemory = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblColorProduct.frame.size.height + lblColorProduct.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMemory.textAlignment = .left
        lblMemory.textColor = UIColor.black
        lblMemory.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMemory.text = "Memory: \(self.detailRPRcheck!.memory)"
        viewProduct.addSubview(lblMemory)
        
        viewProduct.frame.size.height = lblMemory.frame.size.height + lblMemory.frame.origin.y + Common.Size(s: 10)
        
        //hinh anh bien ban ky
        viewInfoSignDoc = UIView(frame: CGRect(x:0,y:viewProduct.frame.size.height + viewProduct.frame.origin.y ,width:scrollView.frame.size.width, height: 100))
        viewInfoSignDoc.clipsToBounds = true
        viewInfoSignDoc.backgroundColor = .white
        scrollView.addSubview(viewInfoSignDoc)
        
        let lbTextSignDoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSignDoc.textAlignment = .left
        lbTextSignDoc.textColor = UIColor.black
        lbTextSignDoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSignDoc.text = "Ảnh ký biên bản"
        viewInfoSignDoc.addSubview(lbTextSignDoc)
        
        viewImageSignDoc = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSignDoc.frame.origin.y + lbTextSignDoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSignDoc.layer.borderWidth = 0.5
        viewImageSignDoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSignDoc.layer.cornerRadius = 3.0
        viewInfoSignDoc.addSubview(viewImageSignDoc)
        
        let viewSignDocButton = UIImageView(frame: CGRect(x: viewImageSignDoc.frame.size.width/2 - (viewImageSignDoc.frame.size.height * 2/3)/2, y: 0, width: viewImageSignDoc.frame.size.height * 2/3, height: viewImageSignDoc.frame.size.height * 2/3))
        viewSignDocButton.image = UIImage(named:"AddImage")
        viewSignDocButton.contentMode = .scaleAspectFit
        viewImageSignDoc.addSubview(viewSignDocButton)
        
        let lbSignDocButton = UILabel(frame: CGRect(x: 0, y: viewSignDocButton.frame.size.height + viewSignDocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSignDoc.frame.size.height/3))
        lbSignDocButton.textAlignment = .center
        lbSignDocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbSignDocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSignDocButton.text = "Thêm hình ảnh"
        viewImageSignDoc.addSubview(lbSignDocButton)
        viewInfoSignDoc.frame.size.height = viewImageSignDoc.frame.size.height + viewImageSignDoc.frame.origin.y
        
        let tapShowSignDoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSignDoc))
        viewImageSignDoc.isUserInteractionEnabled = true
        viewImageSignDoc.addGestureRecognizer(tapShowSignDoc)
        
      
        
        
        btConfirm = UIButton()
        btConfirm.frame = CGRect(x: Common.Size(s:10), y: viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:180), height: Common.Size(s:40))
        btConfirm.backgroundColor = UIColor(netHex:0x00955E)
        btConfirm.addTarget(self, action: #selector(actionComplete), for: .touchUpInside)
        btConfirm.layer.borderWidth = 0.5
        btConfirm.layer.borderColor = UIColor.white.cgColor
        btConfirm.layer.cornerRadius = 5.0
        btConfirm.clipsToBounds = true
        scrollView.addSubview(btConfirm)
        btConfirm.setTitle("Xác nhận", for: .normal)
        
        btEmail = UIButton()
        btEmail.frame = CGRect(x: btConfirm.frame.origin.x + btConfirm.frame.size.width + Common.Size(s:10), y: viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:180), height: Common.Size(s:40))
        btEmail.backgroundColor = UIColor(netHex:0x00955E)
        btEmail.addTarget(self, action: #selector(actionUpdateEmail), for: .touchUpInside)
        btEmail.layer.borderWidth = 0.5
        btEmail.layer.borderColor = UIColor.white.cgColor
        btEmail.layer.cornerRadius = 5.0
        btEmail.clipsToBounds = true
        scrollView.addSubview(btEmail)
        btEmail.setTitle("Cập nhật Email", for: .normal)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btConfirm.frame.origin.y + btConfirm.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        
    }
    
    @objc func backButton(){
        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionUpdateEmail(){
        showInputDialog(title: "Cập nhật Emai",
                            subtitle: "Vui lòng nhập email",
                            actionTitle: "Xác nhận",
                            cancelTitle: "Cancel",
                            inputPlaceholder: "email",
                            inputKeyboardType: UIKeyboardType.default, actionHandler:
                                { (input:String?) in
                                    print("The pass input is \(input ?? "")")
                                    // call api
                                    //self.checkAPIPassCode(pass: input!)
                                    if(input == ""){
                                        let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập email ", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                        })
                                        self.present(alert, animated: true)
                                        return
                                    }
                                    self.updateEmail(email: input!)
                                })
    }
    func updateEmail(email:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang cập nhật email ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.mpos_FRT_SP_SK_update_info(Docentry:"\(self.itemRPOnProgress!.docentry)",email:email) { (p_status,p_message, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(p_status == 1){
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                            
//                            _ = self.navigationController?.popToRootViewController(animated: true)
//                            self.dismiss(animated: true, completion: nil)
//                            let nc = NotificationCenter.default
//                            nc.post(name: Notification.Name("rightPhoneTabNotification"), object: nil)
                        })
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
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
    @objc func actionComplete(){
        if(self.urlSign == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Chưa upload hình ảnh biên bản thành công url = nil !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
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
        MPOSAPIManager.mpos_FRT_SP_SK_confirm_upanh_xacnhan(Docentry:"\(self.itemRPOnProgress!.docentry)",url_image:"\(self.urlSign)") { (p_status,p_message, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(p_status == 1){
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                            
                            _ = self.navigationController?.popToRootViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("rightPhoneTabNotification"), object: nil)
                        })
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
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
    
    
    @objc func tapShowSignDoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 6
        self.thisIsTheFunctionWeAreCalling()
    }
    func imageSignDoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSignDoc.frame.size.width / sca
        viewImageSignDoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewSignDoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSignDoc.frame.size.width, height: heightImage))
        imgViewSignDoc.contentMode = .scaleAspectFit
        imgViewSignDoc.image = image
        viewImageSignDoc.addSubview(imgViewSignDoc)
        viewImageSignDoc.frame.size.height = imgViewSignDoc.frame.size.height + imgViewSignDoc.frame.origin.y
        viewInfoSignDoc.frame.size.height = viewImageSignDoc.frame.size.height + viewImageSignDoc.frame.origin.y
        
        
        btConfirm.frame.origin.y = viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s:10)
        btEmail.frame.origin.y = viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btConfirm.frame.origin.y + btConfirm.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "7", image: self.imgViewSignDoc.image!)
            
        }
        
    }
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.isSecureTextEntry = false
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    func uploadImageV2(type:String,image:UIImage){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        
        let nc = NotificationCenter.default
        
        if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
            let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            
            MPOSAPIManager.mpos_FRT_Image_SKTelink(Base64:"\(strBase64)",docentry: self.itemRPOnProgress!.docentry,Type:"\(type)") { (result, err) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    
                    if(err.count <= 0){
                        
                        if(type == "7"){
                            self.urlSign = result
                        }
                        
                        
                        
                        
                        
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

extension UploadSignDocRightPhoneViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        
        if (self.posImageUpload == 6){
            self.imageSignDoc(image: image)
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
