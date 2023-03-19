//
//  UploadChungTuDoiTraViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import PopupDialog
class UploadChungTuDoiTraViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var scrollView:UIScrollView!
    
    var viewImageUQTN1:UIView!
    var imgViewUQTN1: UIImageView!
    var viewUQTN1:UIView!
    
    var IDFinal:String!
    var btUploadImages:UIButton!
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Upload chứng từ đổi trả"
        
        viewImageUQTN1 = UIView(frame: CGRect(x:Common.Size(s:15), y:Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
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
        
        let tapShowUQTN1 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowUQTN1))
        viewImageUQTN1.isUserInteractionEnabled = true
        viewImageUQTN1.addGestureRecognizer(tapShowUQTN1)
        
        btUploadImages = UIButton()
        btUploadImages.frame = CGRect(x: Common.Size(s:15), y: viewImageUQTN1.frame.origin.y + viewImageUQTN1.frame.size.height + Common.Size(s:20), width: UIScreen.main.bounds.size.width - Common.Size(s:30), height: Common.Size(s: 40) * 1.2)
        btUploadImages.backgroundColor = UIColor(netHex:0xEF4A40)
        btUploadImages.setTitle("Lưu hình ảnh", for: .normal)
        btUploadImages.addTarget(self, action: #selector(actionUpload), for: .touchUpInside)
        btUploadImages.layer.borderWidth = 0.5
        btUploadImages.layer.borderColor = UIColor.white.cgColor
        btUploadImages.layer.cornerRadius = 3
        
        scrollView.addSubview(btUploadImages)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImages.frame.origin.y + btUploadImages.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
    }
    @objc func tapShowUQTN1(sender:UITapGestureRecognizer) {
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func actionUpload(){
        if(imgViewUQTN1 != nil){
            let newViewController = LoadingViewController()
            newViewController.content = "Đang upload chứng từ..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            if let imageDataUQTN:NSData = imgViewUQTN1.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
                let strBase64UQTN1 = imageDataUQTN.base64EncodedString(options: .endLineWithLineFeed)
                MPOSAPIManager.mpos_sp_SaveImageFriend_ChungTuDoiTra(insideCode: "\(Cache.user!.UserName)", idFinal: "\(IDFinal!)", base64_ChungTuDoiTra: strBase64UQTN1, handler: { (success, error) in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        if(error.count <= 0){
                            let title = "THÔNG BÁO"
                            let popup = PopupDialog(title: title, message: success, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                _ = self.navigationController?.popToRootViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }else{
                            let title = "THÔNG BÁO"
                            let popup = PopupDialog(title: title, message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
        }else{
 
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa chụp ảnh chứng từ!", preferredStyle: .alert)
            
        
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
        }
    }
    
}
extension UploadChungTuDoiTraViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageUQTN1.frame.size.width / sca
        viewImageUQTN1.subviews.forEach { $0.removeFromSuperview() }
        imgViewUQTN1  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageUQTN1.frame.size.width, height: heightImage))
        imgViewUQTN1.contentMode = .scaleAspectFit
        imgViewUQTN1.image = image
        
        viewImageUQTN1.addSubview(imgViewUQTN1)
        viewImageUQTN1.frame.size.height = imgViewUQTN1.frame.origin.y + imgViewUQTN1.frame.size.height
        btUploadImages.frame.origin.y = viewImageUQTN1.frame.origin.y + viewImageUQTN1.frame.size.height + Common.Size(s:20)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btUploadImages.frame.origin.y + btUploadImages.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 40))
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
