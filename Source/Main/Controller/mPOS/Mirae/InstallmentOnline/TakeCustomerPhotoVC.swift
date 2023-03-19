//
//  TakeCustomerPhotoVC.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 31/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TakeCustomerPhotoVC: BaseController {
    
    @IBOutlet weak var customerImage: UIImageView!
    @IBOutlet weak var imgView: UIView!
    var imagePicker = UIImagePickerController()
    
    var base64 = ""
    var detailOrder: InstallmentOrderData?
    var onUpdateSuccess: (() -> Void)?
    var isUploading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showActionSheet))
        customerImage.isUserInteractionEnabled = true
        customerImage.addGestureRecognizer(gesture)
        setupNav()
        
        NotificationCenter.default.addObserver(self, selector: #selector(backAction), name: NSNotification.Name("BackToPre"), object: nil)
    }
    
    private func setupNav() {
        self.title = "Chụp ảnh khách hàng"
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailOrderVC.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
    }
    
    
    
    @objc func actionBack() {
        if isUploading {return}
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showActionSheet(){
        if isUploading {return}
        let alrt  = UIAlertController(title: "Ảnh khách hàng", message: "", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.openCamera(islibrary: false)
        }
        let _ = UIAlertAction(title: "Thư viện", style: .default) { (action) in
            self.openCamera(islibrary: true)
        }
        let action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alrt.addAction(action)
        alrt.addAction(action3)
        self.present(alrt, animated: true, completion: nil)
    }
    
    
    func openCamera(islibrary: Bool) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = islibrary ? UIImagePickerController.SourceType.photoLibrary : UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onClickCheck() {
        if isUploading {return}
        if base64 == "" {
            self.showPopup(with: "Bạn vui lòng chụp ảnh khách hàng", completion: nil)
            return
        }
        var params: [String: Any] = [:]
        params["employeeCode"] = Cache.user!.UserName
        params["shopCode"] = Cache.user!.ShopCode
        params["nationalId"] = detailOrder?.customer.cMND
        params["realSelfie"] = base64
        params["applicationId"] = detailOrder?.otherInfos.applicationId
        params["docEntry"] = detailOrder?.otherInfos.docEntry
        
//        self.showLoading()
        isUploading = true
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang xác minh ảnh khách hàng...") {
            InstallmentApiManager.shared.checkInfordelivery(params: params) { [weak self] (response, error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self?.isUploading = false
                    guard let self = self else { return }
        //            self.stopLoading()
                    if error != "" {
                        self.showPopup(with: error, completion: nil)
                    } else {
                        if let res = response {
                            if res.isSuccess {
                                self.showPopup(with: res.message) {
                                    NotificationCenter.default.post(name: NSNotification.Name("BackToPre"), object: nil)
                                }
                            } else {
                                self.showPopup(with: res.message, completion: nil)
                            }
                        } else {
                            self.showPopup(with: "Pasre dữ liệu lỗi", completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    @objc func backAction() {
        if isUploading {return}
        navigationController?.popViewController(animated: true)
        if let succes = self.onUpdateSuccess {
            succes()
        }
    }
    
    
    func setImage(image:UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.7)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        return strBase64
    }
    
}

extension TakeCustomerPhotoVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
//        let imageData = image.jpegData(compressionQuality: 0.7)
//        if let dataImg = imageData {
            self.base64 = self.setImage(image: image)
//        }
        
        customerImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
