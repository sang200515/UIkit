//
//  GHTNBacktoSchool.swift
//  fptshop
//
//  Created by Ngoc Bao on 6/21/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class GHTNBacktoSchool: UIViewController {
    
    @IBOutlet weak var preCMNDImg: UIImageView!
    @IBOutlet weak var backCMNDImg: UIImageView!
    @IBOutlet weak var cardStudentImg: UIImageView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var birthdayTxt: UITextField!
    @IBOutlet weak var cmndNumberTxt: UITextField!
    @IBOutlet weak var commitedImg: UIImageView!
    @IBOutlet weak var cmndView: UIView!
    @IBOutlet weak var paperRelateView: UIView!
    
    var selectedType = 0
    var base64PreImg = ""
    var urlPreImg = ""
    var base64BackImg = ""
    var urlBackImg = ""
    var base64OtherImg = ""
    var urlOtherImg = ""
    var btsID = 0
    var imagePicker = UIImagePickerController()
    let datePicker = UIDatePicker()
    var detectIDcard: DetectIDCard?
    var mObjectData:GetSOByUserResult?
    var onSuccess: (()->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        let btLeftIcon = UIButton.init(type: .custom)
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backAction), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        self.title = "CHỤP ẢNH BACK TO SCHOOL"
        // add gesture
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(showActionSheet1))
        preCMNDImg.isUserInteractionEnabled = true
        preCMNDImg.addGestureRecognizer(gesture1)
        
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(showActionSheet2))
        backCMNDImg.isUserInteractionEnabled = true
        backCMNDImg.addGestureRecognizer(gesture2)
        
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(showActionSheet3))
        cardStudentImg.isUserInteractionEnabled = true
        cardStudentImg.addGestureRecognizer(gesture3)
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        birthdayTxt.inputAccessoryView = toolbar
        birthdayTxt.inputView = datePicker
    }
    
    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }
    @objc func showActionSheet1(){
        openCamera(with: 1)
    }
    @objc func showActionSheet2(){
        openCamera(with: 2)
    }
    @objc func showActionSheet3(){
        openCamera(with: 3)
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
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        birthdayTxt.inputAccessoryView = toolbar
        birthdayTxt.inputView = datePicker
        
    }
    
    func setImage(image:UIImage) -> String {
        let imageData = NSData(data: image.jpegData(compressionQuality: 0.0001) ?? Data())
        let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        return strBase64
    }
    
    func isValidateOK() -> Bool{
            let isPreImgOK = self.base64PreImg != ""
            if !isPreImgOK {
                self.showAlertOneButton(title: "Thông báo", with: "Bạn phải upload ảnh mặt trước CMND hoặc CCCD", titleButton: "Đồng ý")
                return false
            }
            
            let isBackOK = self.base64BackImg != ""
            if !isBackOK {
                self.showAlertOneButton(title: "Thông báo", with: "Bạn phải upload ảnh mặt sau CMND hoặc CCCD", titleButton: "Đồng ý")
                return false
            }
            
            let isOtherOK = self.base64OtherImg != ""
            if !isOtherOK {
                self.showAlertOneButton(title: "Thông báo", with: "Bạn phải upload ảnh chụp giấy tờ liên quan", titleButton: "Đồng ý")
                return false
            }
        
        
        
        guard let name = nameTxt.text, !name.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập tên HS/SV", titleButton: "Đồng ý")
            return false
        }
        
        guard let birth = birthdayTxt.text, !birth.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập ngày tháng năm sinh", titleButton: "Đồng ý")
            return false
        }
        
        guard let cmnds = cmndNumberTxt.text, !cmnds.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập số CMND/CCCD", titleButton: "Đồng ý")
            return false
        }
        
        let iscommittedOK = commitedImg.image == UIImage(named: "mdi_check_circle_gr_2")
        if !iscommittedOK {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn chưa click chọn cam kết", titleButton: "Đồng ý")
            return false
        }
        
        return true
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func donedatePicker(){

      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM/yyyy"
      birthdayTxt.text = formatter.string(from: datePicker.date)
      self.view.endEditing(true)
    }
    
    @IBAction func onCommitedAction(_ sender: Any) {
        if commitedImg.image == UIImage(named: "mdi_check_circle_gr_2") {
            commitedImg.image = UIImage(named: "mdi_check_circle_gr")
        } else {
            commitedImg.image = UIImage(named: "mdi_check_circle_gr_2")
        }
    }
    
    @IBAction func onConfirm(_ sender: Any) {
        if isValidateOK() {
            WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: " ") {
                MPOSAPIManager.updateImageMdeli(ID_BackToSchool: self.btsID, Url_CMND_MT: self.urlPreImg, Url_CMND_MS: self.urlBackImg, Url_GiayBaoDuThi: self.urlOtherImg, CMND: self.cmndNumberTxt.text ?? "", Birthday: self.birthdayTxt.text ?? "") {[weak self] (result, error) in
                    guard let self = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if error != "" {
                            self.showAlertOneButton(title: "Thông báo", with: error, titleButton: "Đồng ý")
                        } else {
                            if result?.Success == "1" {
                                self.showPopUp(result?.Error ?? "", "Thông báo", buttonTitle: "Đồng ý") {
                                    if let success = self.onSuccess {
                                        success()
                                        self.navigationController?.popViewController(animated: true)
                                    }
                                }
                            } else {
                                self.showAlertOneButton(title: "Thông báo", with: result?.Error ?? "", titleButton: "Đồng ý")
                            }
                        }
                    }
                    
                }
            }
        }
    }

}


extension GHTNBacktoSchool: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        switch selectedType {
        case 1:
            self.urlPreImg = ""
            base64PreImg =  self.setImage(image: image)
            preCMNDImg.image = image
            let group = DispatchGroup()
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                group.enter()
                MPOSAPIManager.mpos_DetectIDCard(Image_CMND:"\(self.base64PreImg)") {[weak self] (result,err) in
                    group.leave()
                    guard let self = self else {return}
                    if(err.count <= 0){
                        
                        if(result != nil){
                            self.nameTxt.text = result?.FullName
                            self.birthdayTxt.text = result?.BirthDay
                            self.cmndNumberTxt.text = result?.IdCard
                            self.detectIDcard = result
                        }
                        self.nameTxt.isUserInteractionEnabled = self.nameTxt.text != "" ? false : true
                        self.birthdayTxt.isUserInteractionEnabled =  self.birthdayTxt.text != "" ? false : true
                        self.cmndNumberTxt.isUserInteractionEnabled = self.cmndNumberTxt.text != "" ? false : true
                    }
                }
                
                group.notify(queue: DispatchQueue.main) {
                    MPOSAPIManager.BackToSchool_UploadImage(base64: self.base64PreImg, cmnd: self.cmndNumberTxt.text ?? "" , type: "1", handler: {[weak self] (success, errorMsg, mData, err) in
                        WaitingNetworkResponseAlert.DismissWaitingAlert {}
                        if success == "1" {
                            self?.urlPreImg = mData
                        } else {
                            self?.urlPreImg = ""
                            self?.base64PreImg =  ""
                            self?.preCMNDImg.image = UIImage(named: "AddImage51")
                            self?.showAlertOneButton(title: "Thông báo", with: errorMsg != "" ? errorMsg : err, titleButton: "Đồng ý")
                        }
                    })
                }
                
            }
            
        case 2:
            self.urlBackImg = ""
            base64BackImg =  self.setImage(image: image)
            backCMNDImg.image = image
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.BackToSchool_UploadImage(base64: self.base64BackImg, cmnd: self.cmndNumberTxt.text ?? "" , type: "2", handler: {[weak self] (success, errorMsg, mData, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {}
                    if success == "1" {
                        self?.urlBackImg = mData
                    } else {
                        self?.urlBackImg = ""
                        self?.base64BackImg =  ""
                        self?.backCMNDImg.image = UIImage(named: "AddImage51")
                        self?.showAlertOneButton(title: "Thông báo", with: errorMsg != "" ? errorMsg : err, titleButton: "Đồng ý")
                    }
                    
                })
            }
        case 3:
            self.urlOtherImg = ""
            base64OtherImg =  self.setImage(image: image)
            cardStudentImg.image = image
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.BackToSchool_UploadImage(base64: self.base64OtherImg, cmnd: self.cmndNumberTxt.text ?? "" , type: "3", handler: { [weak self] (success, errorMsg, mData, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {}
                        if success == "1" {
                            self?.urlOtherImg = mData
                        } else {
                            self?.urlOtherImg = ""
                            self?.base64OtherImg =  ""
                            self?.cardStudentImg.image = UIImage(named: "AddImage51")
                            self?.showAlertOneButton(title: "Thông báo", with: errorMsg != "" ? errorMsg : err, titleButton: "Đồng ý")
                        }
                })
            }
        default:
            break
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
