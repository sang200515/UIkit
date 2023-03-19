//
//  UploadStudentImageViewController.swift
//  fptshop
//
//  Created by Apple on 7/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class UploadStudentImageViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var lbImgCmndTruoc: UILabel!
    var lbImgGiayBaoThi: UILabel!
    var btnUpLoadImg: UIButton!
    
    var cmndTruocView: UIView!
    var cmndSauView: UIView!
    var giayBaoThiView :UIView!
    
    var imgCMNDTruoc: UIImageView!
    var imgCMNDSau: UIImageView!
    var imgGiayBaoThi: UIImageView!
    
    var camKetView: UIView!
    var imgCheckCamKet: UIImageView!
    var isCheck : Bool = false
    
    var imagePicker = UIImagePickerController()
    var posImageUpload:Int = -1
    var strBase64CMNDTruoc = ""
    var strBase64CMNDSau = ""
    var strBase64GiayBaoThi = ""
    
    var urlCMNDTruoc = ""
    var urlCMNDSau = ""
    var urlGiayBaoThi = ""
    var studentInfoItem:StudentBTSInfo?
    var isNewStudentInfo = false
    var numberIdentity: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "UPLOAD HÌNH ẢNH"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        lbImgCmndTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbImgCmndTruoc.text = "Hình ảnh CMND"
        lbImgCmndTruoc.textColor = UIColor.black
        lbImgCmndTruoc.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbImgCmndTruoc)
        
        //cmnd truoc
        cmndTruocView = UIView(frame: CGRect(x: Common.Size(s:15), y: lbImgCmndTruoc.frame.origin.y + lbImgCmndTruoc.frame.height, width: lbImgCmndTruoc.frame.width, height: Common.Size(s:150)))
        cmndTruocView.layer.borderWidth = 0.5
        cmndTruocView.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        cmndTruocView.layer.cornerRadius = 3.0
        scrollView.addSubview(cmndTruocView)
        
        imgCMNDTruoc = UIImageView(frame: CGRect(x: 0, y: 0, width: cmndTruocView.frame.width, height: cmndTruocView.frame.height))
        imgCMNDTruoc.image = #imageLiteral(resourceName: "CMNDmattrc")
        imgCMNDTruoc.contentMode = .scaleAspectFit
        cmndTruocView.addSubview(imgCMNDTruoc)
        
        let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(takePhotoCMNDTruoc))
        cmndTruocView.isUserInteractionEnabled = true
        cmndTruocView.addGestureRecognizer(tapShowCMNDTruoc)
        
        //cmnd sau
        cmndSauView = UIView(frame: CGRect(x: Common.Size(s:15), y: cmndTruocView.frame.origin.y + cmndTruocView.frame.height + Common.Size(s:10), width: cmndTruocView.frame.width, height: cmndTruocView.frame.height))
        cmndSauView.layer.borderWidth = 0.5
        cmndSauView.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        cmndSauView.layer.cornerRadius = 3.0
        scrollView.addSubview(cmndSauView)
        
        imgCMNDSau = UIImageView(frame: CGRect(x: 0, y: 0, width: cmndSauView.frame.width, height: cmndSauView.frame.height))
        imgCMNDSau.image = #imageLiteral(resourceName: "CMNDmatsau")
        imgCMNDSau.contentMode = .scaleAspectFit
        cmndSauView.addSubview(imgCMNDSau)
        
        let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(takePhotoCMNDSau))
        cmndSauView.isUserInteractionEnabled = true
        cmndSauView.addGestureRecognizer(tapShowCMNDSau)
        
        //img giay bao thi
        lbImgGiayBaoThi = UILabel(frame: CGRect(x: Common.Size(s:15), y: cmndSauView.frame.origin.y + cmndSauView.frame.height + Common.Size(s:15), width: lbImgCmndTruoc.frame.width, height: Common.Size(s:20)))
        lbImgGiayBaoThi.text = "Hình ảnh GBDT/CNTNTT/BTN/GBNH"
        lbImgGiayBaoThi.textColor = UIColor.black
        lbImgGiayBaoThi.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbImgGiayBaoThi)
        
        giayBaoThiView = UIView(frame: CGRect(x: Common.Size(s:15), y: lbImgGiayBaoThi.frame.origin.y + lbImgGiayBaoThi.frame.height + Common.Size(s:5), width: cmndTruocView.frame.width, height: cmndTruocView.frame.height))
        giayBaoThiView.layer.borderWidth = 0.5
        giayBaoThiView.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        giayBaoThiView.layer.cornerRadius = 3.0
        scrollView.addSubview(giayBaoThiView)
        
        imgGiayBaoThi = UIImageView(frame: CGRect(x: 0, y: 0, width: giayBaoThiView.frame.width, height: giayBaoThiView.frame.height))
        imgGiayBaoThi.image = UIImage.init(named: "img_entrance_examination_update")
        imgGiayBaoThi.contentMode = .scaleAspectFit
        giayBaoThiView.addSubview(imgGiayBaoThi)
        
        let tapShowGiayBaoThi = UITapGestureRecognizer(target: self, action: #selector(takePhotoGiayBaoThi))
        giayBaoThiView.isUserInteractionEnabled = true
        giayBaoThiView.addGestureRecognizer(tapShowGiayBaoThi)
        
        //----cam ket view
        camKetView = UIView(frame: CGRect(x: Common.Size(s:15), y: giayBaoThiView.frame.origin.y + giayBaoThiView.frame.height + Common.Size(s:15), width: giayBaoThiView.frame.width, height: Common.Size(s:35)))
        scrollView.addSubview(camKetView)
        
        let lbCamKet = UILabel(frame: CGRect(x: Common.Size(s:50), y: 0, width: camKetView.frame.width - Common.Size(s:50) - Common.Size(s:15), height: camKetView.frame.height))
        lbCamKet.text = "Shop cam kết thông tin thí sinh hoàn toàn chính xác và chính chủ"
        lbCamKet.font = UIFont(name:"Trebuchet MS",size:17)
        camKetView.addSubview(lbCamKet)
        
        let lbcamKetHeight = lbCamKet.optimalHeight > Common.Size(s:35) ? lbCamKet.optimalHeight : Common.Size(s:35)
        lbCamKet.numberOfLines = 0
        
        camKetView.frame = CGRect(x: camKetView.frame.origin.x, y: camKetView.frame.origin.y, width: camKetView.frame.width, height: lbcamKetHeight)
        
        imgCheckCamKet = UIImageView(frame: CGRect(x: 0, y: camKetView.frame.height/2 - Common.Size(s:15), width: Common.Size(s:30), height: Common.Size(s:30)))
        imgCheckCamKet.image = UIImage(named: "uncheck")
        camKetView.addSubview(imgCheckCamKet)
        
        let tapCheckCamKet = UITapGestureRecognizer(target: self, action: #selector(checkCamKet))
        imgCheckCamKet.isUserInteractionEnabled = true
        imgCheckCamKet.addGestureRecognizer(tapCheckCamKet)
        
        //------
        btnUpLoadImg = UIButton(frame: CGRect(x: Common.Size(s:15), y: camKetView.frame.origin.y + camKetView.frame.height + Common.Size(s: 20), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        btnUpLoadImg.setTitle("UPLOAD", for: .normal)
        btnUpLoadImg.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnUpLoadImg.addTarget(self, action: #selector(uploadImg), for: .touchUpInside)
        btnUpLoadImg.layer.cornerRadius = 5
        scrollView.addSubview(btnUpLoadImg)
        
        scrollViewHeight = btnUpLoadImg.frame.origin.y + btnUpLoadImg.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func checkCamKet() {
        isCheck = !isCheck
        imgCheckCamKet.image = UIImage(named: isCheck ? "checkedBox" : "uncheck")
    }
    
    @objc func uploadImg() {
        
        guard !self.urlCMNDTruoc.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Lỗi up hình CMND mặt trước!")
            return
        }
        
        guard !self.urlCMNDSau.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Lỗi up hình CMND mặt sau!")
            return
        }
        
        guard !self.urlGiayBaoThi.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Lỗi up hình giấy báo thi!")
            return
        }
        
        if isCheck == false {
            self.showAlert(title: "Thông báo", message: "Phải nhấn chọn ô cam kết trước khi Upload hình ảnh!")
        } else {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.BackToSchool_UpdateHinhAnh(ID_BackToSchool: self.studentInfoItem?.ID_BackToSchool ?? 0, SBD: self.studentInfoItem?.SoBaoDanh ?? "", Url_CMND_MT: self.urlCMNDTruoc, Url_CMND_MS: self.urlCMNDSau, Url_GiayBaoDuThi: self.urlGiayBaoThi, handler: { (success, errorMsg, mData, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if success == "1" {
                            
                            let alertVC = UIAlertController(title: "Thông báo", message: errorMsg, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                
                                if self.isNewStudentInfo {
                                    for controller in self.navigationController!.viewControllers as Array {
                                        if controller.isKind(of: HomeBackToSchoolScreen.self) {
                                            _ = self.navigationController?.popToViewController(controller, animated: true)
                                        }
                                    }
                                } else {
                                    for controller in self.navigationController!.viewControllers as Array {
                                        if controller.isKind(of: HomeBackToSchoolScreen.self) {
                                            _ = self.navigationController?.popToViewController(controller, animated: true)
                                        }
                                    }
                                }
                                
                            })
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        } else {
                            self.showAlert(title: "Thông báo", message: errorMsg)
                        }
                    }
                })
            }
        }
        
    }
    
    @objc func takePhotoCMNDTruoc() {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func takePhotoCMNDSau() {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func takePhotoGiayBaoThi() {
        self.posImageUpload = 3
        self.thisIsTheFunctionWeAreCalling()
    }
    
    func setImageCMNDTruoc(image:UIImage){
        let heightImage:CGFloat = Common.Size(s: 150)
        cmndTruocView.subviews.forEach { $0.removeFromSuperview() }
        imgCMNDTruoc = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgCMNDTruoc.contentMode = .scaleAspectFit
        imgCMNDTruoc.image = image
        cmndTruocView.addSubview(imgCMNDTruoc)
        
        cmndTruocView.frame = CGRect(x: cmndTruocView.frame.origin.x, y: cmndTruocView.frame.origin.y, width: cmndTruocView.frame.width, height: Common.Size(s: 150))
        
        cmndSauView.frame = CGRect(x: cmndSauView.frame.origin.x, y: cmndTruocView.frame.origin.y + cmndTruocView.frame.height + Common.Size(s: 10), width: cmndSauView.frame.width, height:cmndSauView.frame.height)
        
        lbImgGiayBaoThi.frame = CGRect(x: lbImgGiayBaoThi.frame.origin.x, y: cmndSauView.frame.origin.y + cmndSauView.frame.height + Common.Size(s: 10), width: lbImgGiayBaoThi.frame.width, height:lbImgGiayBaoThi.frame.height)
        
        giayBaoThiView.frame = CGRect(x: giayBaoThiView.frame.origin.x, y: lbImgGiayBaoThi.frame.origin.y + lbImgGiayBaoThi.frame.height + Common.Size(s: 5), width: giayBaoThiView.frame.width, height:giayBaoThiView.frame.height)
        
        camKetView.frame = CGRect(x: camKetView.frame.origin.x, y: giayBaoThiView.frame.origin.y + giayBaoThiView.frame.height + Common.Size(s: 15), width: camKetView.frame.width, height:camKetView.frame.height)
        
        btnUpLoadImg.frame = CGRect(x: btnUpLoadImg.frame.origin.x, y: camKetView.frame.origin.y + camKetView.frame.height + Common.Size(s: 20), width: btnUpLoadImg.frame.width, height:btnUpLoadImg.frame.height)
        
        scrollViewHeight = btnUpLoadImg.frame.origin.y + btnUpLoadImg.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        let imageCMNDTruocResize:UIImage = self.resizeImageWidth(image: imgCMNDTruoc.image!,newWidth: Common.resizeImageWith)!
        let imageDataCMNDTruoc:NSData = (imageCMNDTruocResize.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64CMNDTruoc = imageDataCMNDTruoc.base64EncodedString(options: .endLineWithLineFeed)
        
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if self.studentInfoItem?.CMND != "" {
                self.numberIdentity = self.studentInfoItem?.CMND
            }
            MPOSAPIManager.BackToSchool_UploadImage(base64: self.strBase64CMNDTruoc, cmnd: self.numberIdentity ?? "", type: "1", handler: { (success, errorMsg, mData, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success == "1" {
                        self.urlCMNDTruoc = mData
                    } else {
                        let alertVC = UIAlertController(title: "Thông báo", message: errorMsg, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            self.strBase64CMNDTruoc = ""
                            self.urlCMNDTruoc = ""
                            self.imgCMNDTruoc.image = #imageLiteral(resourceName: "CMNDmattrc")
                        })
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    func setImageCMNDSau(image:UIImage){
        let heightImage:CGFloat = Common.Size(s: 150)
        cmndSauView.subviews.forEach { $0.removeFromSuperview() }
        imgCMNDSau = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgCMNDSau.contentMode = .scaleAspectFit
        imgCMNDSau.image = image
        cmndSauView.addSubview(imgCMNDSau)
        
        cmndSauView.frame = CGRect(x: cmndSauView.frame.origin.x, y: cmndTruocView.frame.origin.y + cmndTruocView.frame.height + Common.Size(s: 10), width: cmndSauView.frame.width, height: heightImage)
        
        lbImgGiayBaoThi.frame = CGRect(x: lbImgGiayBaoThi.frame.origin.x, y: cmndSauView.frame.origin.y + cmndSauView.frame.height + Common.Size(s: 10), width: lbImgGiayBaoThi.frame.width, height:lbImgGiayBaoThi.frame.height)
        
        giayBaoThiView.frame = CGRect(x: giayBaoThiView.frame.origin.x, y: lbImgGiayBaoThi.frame.origin.y + lbImgGiayBaoThi.frame.height + Common.Size(s: 5), width: giayBaoThiView.frame.width, height:giayBaoThiView.frame.height)
        
        camKetView.frame = CGRect(x: camKetView.frame.origin.x, y: giayBaoThiView.frame.origin.y + giayBaoThiView.frame.height + Common.Size(s: 15), width: camKetView.frame.width, height:camKetView.frame.height)
        
        btnUpLoadImg.frame = CGRect(x: btnUpLoadImg.frame.origin.x, y: camKetView.frame.origin.y + camKetView.frame.height + Common.Size(s: 20), width: btnUpLoadImg.frame.width, height:btnUpLoadImg.frame.height)
        
        scrollViewHeight = btnUpLoadImg.frame.origin.y + btnUpLoadImg.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        let imageCMNDSauResize:UIImage = self.resizeImageWidth(image: imgCMNDSau.image!,newWidth: Common.resizeImageWith)!
        let imageDataCMNDSau:NSData = (imageCMNDSauResize.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64CMNDSau = imageDataCMNDSau.base64EncodedString(options: .endLineWithLineFeed)
        
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if self.studentInfoItem?.CMND != "" {
                self.numberIdentity = self.studentInfoItem?.CMND
            }
            MPOSAPIManager.BackToSchool_UploadImage(base64: self.strBase64CMNDSau, cmnd: self.numberIdentity ?? "" , type: "2", handler: { (success, errorMsg, mData, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success == "1" {
                        self.urlCMNDSau = mData
                    } else {
                        let alertVC = UIAlertController(title: "Thông báo", message: errorMsg, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            self.strBase64CMNDSau = ""
                            self.urlCMNDSau = ""
                            self.imgCMNDSau.image = #imageLiteral(resourceName: "CMNDmatsau")
                        })
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                        
                    }
                }
            })
        }
    }
    
    func setImageGiayBaoThi(image:UIImage){
        let heightImage:CGFloat = Common.Size(s: 150)
        giayBaoThiView.subviews.forEach { $0.removeFromSuperview() }
        imgGiayBaoThi = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgGiayBaoThi.contentMode = .scaleAspectFit
        imgGiayBaoThi.image = image
        giayBaoThiView.addSubview(imgGiayBaoThi)
        
        lbImgGiayBaoThi.frame = CGRect(x: lbImgGiayBaoThi.frame.origin.x, y: cmndSauView.frame.origin.y + cmndSauView.frame.height + Common.Size(s: 10), width: lbImgGiayBaoThi.frame.width, height:lbImgGiayBaoThi.frame.height)
        
        giayBaoThiView.frame = CGRect(x: giayBaoThiView.frame.origin.x, y: lbImgGiayBaoThi.frame.origin.y + lbImgGiayBaoThi.frame.height + Common.Size(s: 5), width: giayBaoThiView.frame.width, height:giayBaoThiView.frame.height)
        
        camKetView.frame = CGRect(x: camKetView.frame.origin.x, y: giayBaoThiView.frame.origin.y + giayBaoThiView.frame.height + Common.Size(s: 15), width: camKetView.frame.width, height:camKetView.frame.height)
        
        btnUpLoadImg.frame = CGRect(x: btnUpLoadImg.frame.origin.x, y: camKetView.frame.origin.y + camKetView.frame.height + Common.Size(s: 20), width: btnUpLoadImg.frame.width, height:btnUpLoadImg.frame.height)
        
        scrollViewHeight = btnUpLoadImg.frame.origin.y + btnUpLoadImg.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        let imageGiayBaoThiResize:UIImage = self.resizeImageWidth(image: imgGiayBaoThi.image!,newWidth: Common.resizeImageWith)!
        let imageDataGiayBaoThi:NSData = (imageGiayBaoThiResize.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64GiayBaoThi = imageDataGiayBaoThi.base64EncodedString(options: .endLineWithLineFeed)
        
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if self.studentInfoItem?.CMND != "" {
                self.numberIdentity = self.studentInfoItem?.CMND
            }
            MPOSAPIManager.BackToSchool_UploadImage(base64: self.strBase64GiayBaoThi, cmnd: self.numberIdentity ?? "" , type: "3", handler: { (success, errorMsg, mData, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success == "1" {
                        self.urlGiayBaoThi = mData
                    } else {
                        let alertVC = UIAlertController(title: "Thông báo", message: errorMsg, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            self.strBase64GiayBaoThi = ""
                            self.urlGiayBaoThi = ""
                            self.imgGiayBaoThi.image = #imageLiteral(resourceName: "giaybao")
                        })
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                        
                    }
                }
            })
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
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension UploadStudentImageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        //        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
        //            self.openGallary()
        //        }))
        
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
            self.setImageCMNDTruoc(image: image)
        } else if (self.posImageUpload == 2 ){
            self.setImageCMNDSau(image: image)
        } else if (self.posImageUpload == 3){
            self.setImageGiayBaoThi(image: image)
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
        imagePicker.navigationBar.barTintColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}
