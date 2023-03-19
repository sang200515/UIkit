//
//  UploadImageVNPTViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/30/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftUI
import SkyFloatingLabelTextField
import PopupDialog
class UploadImageHistoryVNPTViewController:UIViewController,UITextFieldDelegate{
    
    
    var scrollView:UIScrollView!
    
    var imagePicker = UIImagePickerController()
    
    var posImageUpload:Int = -1
    
    var viewInfoCMNDTruoc:UIView!
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    var btUpload:UIButton!
    var tfPhoneNumber:SkyFloatingLabelTextFieldWithIcon!
    var tfUserName:SkyFloatingLabelTextFieldWithIcon!
    var tfCMND:SkyFloatingLabelTextFieldWithIcon!
    var url_hinh_kh:String = ""
    var docentry:String?
    var historyVNPT:HistoryVNPT?
    override func viewDidLoad() {
        
        self.title = "Upload hình ảnh KH"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(UploadImageHistoryVNPTViewController.backButton), for: UIControl.Event.touchUpInside)
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
        
        
        tfUserName.text = self.historyVNPT!.TenKH
        scrollView.addSubview(tfUserName)
       
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
        tfPhoneNumber.text = self.historyVNPT!.SDT
        
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
        
        
        viewInfoCMNDTruoc = UIView(frame: CGRect(x:0,y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDTruoc.clipsToBounds = true
        scrollView.addSubview(viewInfoCMNDTruoc)
        
        let lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDTruoc.textAlignment = .left
        lbTextCMNDTruoc.textColor = UIColor.black
        lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDTruoc.text = "Upload hình ảnh KH"
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
        
        let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowHinhKH))
        viewImageCMNDTruoc.isUserInteractionEnabled = true
        viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
        
        
        btUpload = UIButton()
        btUpload.frame = CGRect(x: Common.Size(s:15), y: viewInfoCMNDTruoc.frame.origin.y + viewInfoCMNDTruoc.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40) * 1.1)
        btUpload.backgroundColor = UIColor(netHex:0x00955E)
        btUpload.setTitle("Xác nhận", for: .normal)
        btUpload.addTarget(self, action: #selector(actionConfirm), for: .touchUpInside)
        btUpload.layer.borderWidth = 0.5
        btUpload.layer.borderColor = UIColor.white.cgColor
        btUpload.layer.cornerRadius = 5.0
        scrollView.addSubview(btUpload)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionConfirm(){
        if(self.url_hinh_kh == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng upload hình ảnh KH !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
        
        MPOSAPIManager.mpos_FRT_SP_VNPT_upload_anhKH(CMND:self.historyVNPT!.CMND,url_anhkh:self.url_hinh_kh,docentry:"\(self.historyVNPT!.Docentry)",sompos:"\(self.historyVNPT!.SOMPOS)") { (p_status,message,err) in
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
    func uploadImage(image:UIImage,type:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh, vui lòng chờ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageScanCMND) as NSData?{
            let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            MPOSAPIManager.mpos_FRT_Image_VNPT(CMND:"\(self.historyVNPT!.CMND)",IDMpos:"\(self.historyVNPT!.SOMPOS)",Base64:"\(strBase64)",Type:"4") { (result,err) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(err.count <= 0){
                        if (type == "4") {
                            self.url_hinh_kh = result
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
    @objc  func tapShowHinhKH(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
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
        
        
        
        btUpload.frame.origin.y = viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUpload.frame.origin.y + btUpload.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30) )
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImage(image: self.imgViewCMNDTruoc.image!,type:"4")
            
            
        }
        
        
    }
}
extension UploadImageHistoryVNPTViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
