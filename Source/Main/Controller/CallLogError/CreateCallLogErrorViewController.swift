//
//  CreateCallLogErrorViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 5/15/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class CreateCallLogErrorViewController: UIViewController ,UITextFieldDelegate,UITextViewDelegate{
    var imagePicker = UIImagePickerController()
    var scrollView:UIScrollView!
    var taskNotes: UITextView!
    var placeholderLabel : UILabel!
    var imgViewPhoto: UIView!
    var imgPhoto: UIImageView!
    
    var btUploadImages:UIButton!
    var posImageUpload: Int = 0
    var indexBase: Int = 0
    var arrBase64:[String] = []
    var arrLink:[String] = []
    
    var msgAPI: String = ""
    var list_upload = ""
    var strBase64Image1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "GỬI CALLLOG"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(CreateCallLogErrorViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbNotes = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:16)))
        lbNotes.textAlignment = .left
        lbNotes.textColor = UIColor.black
        lbNotes.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbNotes.text = "Nội dung báo lỗi"
        scrollView.addSubview(lbNotes)
        
        taskNotes = UITextView(frame: CGRect(x: lbNotes.frame.origin.x , y: lbNotes.frame.origin.y  + lbNotes.frame.size.height + Common.Size(s:5), width: lbNotes.frame.size.width, height: Common.Size(s: 80)))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskNotes.layer.borderWidth = 0.5
        taskNotes.layer.borderColor = borderColor.cgColor
        taskNotes.layer.cornerRadius = 5.0
        taskNotes.delegate = self
        taskNotes.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        scrollView.addSubview(taskNotes)
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Ghi chú đơn hàng"
        placeholderLabel.font = UIFont.systemFont(ofSize: (taskNotes.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        taskNotes.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (taskNotes.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !taskNotes.text.isEmpty
        
        let lbTextImage1 = UILabel(frame: CGRect(x: Common.Size(s:15), y: taskNotes.frame.origin.y + taskNotes.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextImage1.textAlignment = .left
        lbTextImage1.textColor = UIColor.black
        lbTextImage1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextImage1.text = "Hình ảnh"
        scrollView.addSubview(lbTextImage1)
        
        imgViewPhoto = UIView(frame: CGRect(x: Common.Size(s:15), y: lbTextImage1.frame.origin.y + lbTextImage1.frame.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:150)))
        imgViewPhoto.backgroundColor = .white
        imgViewPhoto.layer.borderColor = UIColor.lightGray.cgColor
        imgViewPhoto.layer.borderWidth = 1
        scrollView.addSubview(imgViewPhoto)
        
        imgPhoto = UIImageView(frame: CGRect(x: 0, y: 0, width: imgViewPhoto.frame.width, height: imgViewPhoto.frame.height))
        imgPhoto.image = #imageLiteral(resourceName: "UploadImage")
        imgPhoto.contentMode = .scaleAspectFit
        imgViewPhoto.addSubview(imgPhoto)
        
        let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(tapShowImage1))
        imgViewPhoto.isUserInteractionEnabled = true
        imgViewPhoto.addGestureRecognizer(tapTakePhoto)
        
        btUploadImages = UIButton()
        btUploadImages.frame = CGRect(x: Common.Size(s:15), y: imgViewPhoto.frame.origin.y + imgViewPhoto.frame.size.height + Common.Size(s:30), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40) * 1.2)
        btUploadImages.backgroundColor = UIColor(netHex:0x04AB6E)
        btUploadImages.setTitle("Gửi báo lỗi", for: .normal)
        btUploadImages.addTarget(self, action: #selector(sendCallogErrorRequest), for: .touchUpInside)
        btUploadImages.layer.borderWidth = 0.5
        btUploadImages.layer.borderColor = UIColor.white.cgColor
        btUploadImages.layer.cornerRadius = 3
        scrollView.addSubview(btUploadImages)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImages.frame.origin.y + btUploadImages.frame.size.height + Common.Size(s: 20))
        self.hideKeyboardWhenTappedAround()
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func tapShowImage1(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func sendCallogErrorRequest() {
        guard let note = taskNotes.text, !note.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập nội dung báo lỗi!", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard self.strBase64Image1 != "" else {
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng cung cấp đủ hình ảnh!", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let listEmail = (Cache.user?.Email ?? "").components(separatedBy: "@")
        debugPrint("content: \(self.msgAPI)")
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            mCallLogApiManager.Calllog_FRTUService_Ticket_Create(email: listEmail[0], title: "Báo lỗi", list_upload: "\(self.list_upload)", content: "\(note)", note: "\(self.msgAPI)", sender: listEmail[0], informedUsers: listEmail[0]) { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            if rs?.p_status == 0 {
                                let alert = UIAlertController(title: "Thông báo", message: "\(rs?.p_messages ?? "Thành công!")", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    self.navigationController?.popToRootViewController(animated: true)
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                                
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "Error status \(rs?.p_status ?? 1): \(rs?.p_messages ?? "API Error!")", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "API Error!", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func uploadImgV2() {
        if (self.strBase64Image1 == "") {
            let alert = UIAlertController(title: "Thông báo", message: "Error endcode image!", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            debugPrint("strBase64:\(strBase64Image1)")
            debugPrint("fileName: img\(Date().millisecondsSince1970).jpg")
            let listEmail = (Cache.user?.Email ?? "").components(separatedBy: "@")
            
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                mCallLogApiManager.Calllog_FRTUService_AttachFile_Upload(email: listEmail[0], fileName: "img\(Date().millisecondsSince1970).jpg", extension_file: "jpg", stringBase64: self.strBase64Image1) { (rs, err) in
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if err.count <= 0 {
                            if rs != nil {
                                if rs?.p_status == 0 {
                                    self.list_upload = rs?.fileInfo_fileID ?? ""
                                } else {
                                    let alert = UIAlertController(title: "Thông báo", message: "Error status \(rs?.p_status ?? 1): \(rs?.p_messages ?? "API Error!")", preferredStyle: UIAlertController.Style.alert)
                                    let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                        self.strBase64Image1 = ""
                                        self.imgPhoto.image = #imageLiteral(resourceName: "UploadImage")
                                    }
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                }
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "API Error!", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    self.strBase64Image1 = ""
                                    self.imgPhoto.image = #imageLiteral(resourceName: "UploadImage")
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                self.strBase64Image1 = ""
                                self.imgPhoto.image = #imageLiteral(resourceName: "UploadImage")
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    func setImage(image:UIImage, viewContent: UIView) -> String {
        viewContent.subviews.forEach { $0.removeFromSuperview() }
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewContent.frame.width, height: viewContent.frame.height))
        imgView.contentMode = .scaleAspectFit
        imgView.image = image
        viewContent.addSubview(imgView)
        let imageData:NSData = image.jpegData(compressionQuality: 0.7)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        return strBase64
    }
}
extension CreateCallLogErrorViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        picker.dismiss(animated: true, completion: nil)
        
        self.strBase64Image1 = self.setImage(image: image, viewContent: self.imgViewPhoto)
        self.uploadImgV2()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
