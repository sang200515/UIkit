//
//  CMSNViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 07/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CMSNViewController: BaseController {

    @IBOutlet weak var preCMNDImg: UIImageView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var birthdayTxt: UITextField!
    @IBOutlet weak var cmndNumberTxt: UITextField!
    @IBOutlet weak var sdtTxt: UITextField!
    @IBOutlet weak var commitedImg: UIImageView!
    
//    var didScanComplete: ((String, String) -> Void)?
    var phone: String = ""
    var detectIDcard: DetectIDCard?
    var imagePicker = UIImagePickerController()
    var selectedType = 0
    var base64PreImg = ""
    var urlPreImg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SINH NHẬT KHÁCH HÀNG THÁNG 3"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let btLeftIcon = UIButton.init(type: .custom)
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backAction), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
        sdtTxt.isUserInteractionEnabled = false
        sdtTxt.text = phone
        
        // add gesture
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(showActionSheet1))
        preCMNDImg.isUserInteractionEnabled = true
        preCMNDImg.addGestureRecognizer(gesture1)
    }
    
    @objc func showActionSheet1() {
        openCamera(with: 1)
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func openCamera(with tag: Int){
        selectedType = tag
        let alrt  = UIAlertController(title: "Ảnh CMND/CCCD", message: "", preferredStyle: .actionSheet)
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
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = islibrary ? UIImagePickerController.SourceType.photoLibrary : UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setImage(image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.5)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        return strBase64
    }
    
    func isValidateOK() -> Bool{
        let isPreImgOK = self.base64PreImg != ""
        if !isPreImgOK {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải upload ảnh mặt trước CMND hoặc CCCD", titleButton: "Đồng ý")
            return false
        }
        
        guard let name = nameTxt.text, !name.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập tên khách hàng, hoặc scan CMND để có thông tin", titleButton: "Đồng ý")
            return false
        }
        
        guard let birth = birthdayTxt.text, !birth.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập ngày tháng năm sinh, hoặc scan CMND để có thông tin", titleButton: "Đồng ý")
            return false
        }
        
        guard let cmnds = cmndNumberTxt.text, !cmnds.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập số CMND/CCCD, hoặc scan CMND để có thông tin", titleButton: "Đồng ý")
            return false
        }
        
        guard let sdt = sdtTxt.text, !sdt.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập số điện thoại khách hàng", titleButton: "Đồng ý")
            return false
        }
        
        let iscommittedOK = commitedImg.image == UIImage(named: "mdi_check_circle_gr_2")
        if !iscommittedOK {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn chưa click chọn cam kết", titleButton: "Đồng ý")
            return false
        }
        
        return true
    }
    
    @IBAction func onCommitedAction(_ sender: Any) {
        if commitedImg.image == UIImage(named: "mdi_check_circle_gr_2") {
            commitedImg.image = UIImage(named: "mdi_check_circle_gr")
        } else {
            commitedImg.image = UIImage(named: "mdi_check_circle_gr_2")
        }
    }
    
    @IBAction func onConfirm(_ sender: Any) {
        if !isValidateOK() { return }
        
        let date = birthdayTxt.text&.toNewStrDate(withFormat: "dd/MM/yyyy", newFormat: "yyyy-MM-dd")
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.GenerateBirthdayOnMarchVoucher(idCard: self.cmndNumberTxt.text&, phone: self.phone, name: self.nameTxt.text&, birthday: date, base64: self.base64PreImg, handler: { [weak self] success, message in
                guard let self = self else { return }
                WaitingNetworkResponseAlert.DismissWaitingAlert()
                
                if success {
                    self.showAlertOneButton(title: "Thông báo", with: message, titleButton: "OK", handleOk: {
//                        self.didScanComplete?(self.nameTxt.text&, self.birthdayTxt.text&)
                        self.backAction()
                    })
                } else {
                    self.showAlertOneButton(title: "Thông báo", with: message, titleButton: "OK")
                }
            })
        }
    }
}

extension CMSNViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }

        urlPreImg = ""
        base64PreImg = self.setImage(image: image)
        preCMNDImg.image = image
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.GetinfoCustomerByImageIDCard(Image_CMND: "\(self.base64PreImg)", NhaMang: "unknown", Type: "1", handler: { [weak self] (results, err) in
                guard let self = self else { return }
                WaitingNetworkResponseAlert.DismissWaitingAlert()
                if (err.count <= 0) {
                    if (results.count > 0) {
                        let item = results[0]
                        
                        self.nameTxt.isUserInteractionEnabled = false
                        self.birthdayTxt.isUserInteractionEnabled = false
                        self.cmndNumberTxt.isUserInteractionEnabled = false
                       
                        self.nameTxt.text = item.FullName
                        self.birthdayTxt.text = item.Birthday
                        self.cmndNumberTxt.text = item.CMND
                        
//                        self.showAlert("Chúc mừng quý khách có sinh nhật trong tháng 3")
                    } else {
                        self.nameTxt.isUserInteractionEnabled = true
                        self.birthdayTxt.isUserInteractionEnabled = true
                        self.cmndNumberTxt.isUserInteractionEnabled = true
                        
                        self.showAlertOneButton(title: "Thông báo", with: "Vui lòng chụp rõ mặt trước CMND/CCCD", titleButton: "OK")
                    }
                } else {
                    self.nameTxt.isUserInteractionEnabled = true
                    self.birthdayTxt.isUserInteractionEnabled = true
                    self.cmndNumberTxt.isUserInteractionEnabled = true
                    
                    self.showAlertOneButton(title: "Thông báo", with: "Vui lòng chụp rõ mặt trước CMND/CCCD", titleButton: "OK")
                }
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
