//
//  UpdateInfoNopTienViewController.swift
//  fptshop
//
//  Created by Apple on 7/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class UpdateInfoNopTienViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var lbHinhAnhSelfie: UILabel!
    var lbHinhAnhBienNhan: UILabel!
    var lbNote: UILabel!
    var tvNoteText: UITextView!
    var btnConfirm: UIButton!
    
    var selfieView: UIView!
    var bienNhanView: UIView!
    var imgViewSelfie: UIImageView!
    var imgViewBienNhan: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var posImageUpload:Int = -1
    var paymentOfFundsInfo: PaymentOfFunds_New?
    
    var strBase64ImgSelfie = ""
    var strBase64ImgBienNhan = ""
    var urlStrImgSelfie = ""
    var urlStrImgBienNhan = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Nộp tiền ngân hàng"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.PaymentOfFunds_CallLogNopQuy(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        self.paymentOfFundsInfo = results[0]
                    } else {
//                        debugPrint("Không có data paymentOfFundsInfo")
                        let alertVC = UIAlertController(title: "Thông báo", message: "Không có dữ liệu nộp quỹ tại ngân hàng", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                            self.navigationController?.popViewController(animated: true)
                        })
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                    self.setUpView()
                }
            })
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func setUpView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let quyInfoView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s:40)))
        quyInfoView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(quyInfoView)
        
        let lbQuyInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: quyInfoView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        lbQuyInfo.text = "THÔNG TIN QUỸ"
        quyInfoView.addSubview(lbQuyInfo)
        
        let lbShop = UILabel(frame: CGRect(x: Common.Size(s:15), y: quyInfoView.frame.origin.y + quyInfoView.frame.height + Common.Size(s:15), width: scrollView.frame.width/3 - Common.Size(s:15), height: Common.Size(s:20)))
        lbShop.text = "Shop:"
        lbShop.font = UIFont.systemFont(ofSize: 14)
        lbShop.textColor = .lightGray
        scrollView.addSubview(lbShop)
        
        let lbShopName = UILabel(frame: CGRect(x: lbShop.frame.origin.x + lbShop.frame.width + Common.Size(s: 5), y: lbShop.frame.origin.y, width: scrollView.frame.width - (lbShop.frame.origin.x + lbShop.frame.width + Common.Size(s: 5)) - Common.Size(s: 15), height: Common.Size(s:20)))
        lbShopName.text = "\(self.paymentOfFundsInfo?.ShopName ?? "")"
        lbShopName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbShopName)
        
        let lbShopNameHeight = lbShopName.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbShopName.optimalHeight
        lbShopName.numberOfLines = 0
        
        lbShopName.frame = CGRect(x: lbShopName.frame.origin.x, y: lbShopName.frame.origin.y, width: lbShopName.frame.width, height: lbShopNameHeight)
        
        let lbNV = UILabel(frame: CGRect(x: lbShop.frame.origin.x, y: lbShopName.frame.origin.y + lbShopNameHeight + Common.Size(s: 5), width: lbShop.frame.width, height: Common.Size(s:20)))
        lbNV.text = "Nhân viên:"
        lbNV.font = UIFont.systemFont(ofSize: 14)
        lbNV.textColor = .lightGray
        scrollView.addSubview(lbNV)
        
        let lbNhanVienName = UILabel(frame: CGRect(x: lbShopName.frame.origin.x, y: lbNV.frame.origin.y, width: lbShopName.frame.width, height: Common.Size(s:20)))
        lbNhanVienName.text = "\(self.paymentOfFundsInfo?.EmployeeName ?? "")"
        lbNhanVienName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNhanVienName)
        
        let lbNhanVienNameHeight = lbNhanVienName.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbNhanVienName.optimalHeight
        lbNhanVienName.numberOfLines = 0
        
        lbNhanVienName.frame = CGRect(x: lbNhanVienName.frame.origin.x, y: lbNhanVienName.frame.origin.y, width: lbNhanVienName.frame.width, height: lbNhanVienNameHeight)
        
        let lbNgay = UILabel(frame: CGRect(x: lbShop.frame.origin.x, y: lbNhanVienName.frame.origin.y + lbNhanVienNameHeight + Common.Size(s:5), width: lbShop.frame.width, height: Common.Size(s:20)))
        lbNgay.text = "Ngày:"
        lbNgay.textColor = .lightGray
        lbNgay.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNgay)
        
        let lbNgayValue = UILabel(frame: CGRect(x: lbShopName.frame.origin.x, y: lbNgay.frame.origin.y, width: lbShopName.frame.width, height: Common.Size(s:20)))
        lbNgayValue.text = "\(self.paymentOfFundsInfo?.Date ?? "")"
        lbNgayValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNgayValue)
        
        let lbTienQuy = UILabel(frame: CGRect(x: lbShop.frame.origin.x, y: lbNgayValue.frame.origin.y + lbNgayValue.frame.height + Common.Size(s:5), width: lbShop.frame.width, height: Common.Size(s:20)))
        lbTienQuy.text = "Tiền quỹ:"
        lbTienQuy.textColor = .lightGray
        lbTienQuy.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTienQuy)
        
        let lbTienQuyValue = UILabel(frame: CGRect(x: lbShopName.frame.origin.x, y: lbTienQuy.frame.origin.y, width: lbShopName.frame.width, height: Common.Size(s:20)))
//        lbTienQuyValue.text = "\(Common.convertCurrency(value: self.paymentOfFundsInfo?.Money ?? 0))"
        lbTienQuyValue.font = UIFont.boldSystemFont(ofSize: 16)
        lbTienQuyValue.textColor = UIColor(red: 192/255, green: 0/255, blue: 0/255, alpha: 1)
        scrollView.addSubview(lbTienQuyValue)
        
        let moneyNum = Int(self.paymentOfFundsInfo?.Money ?? "")
        lbTienQuyValue.text = "\(Common.convertCurrency(value: moneyNum ?? 0))"
        
        let lbMaCalllog = UILabel(frame: CGRect(x: lbShop.frame.origin.x, y: lbTienQuyValue.frame.origin.y + lbTienQuyValue.frame.height + Common.Size(s:5), width: lbShop.frame.width, height: Common.Size(s:20)))
        lbMaCalllog.text = "Mã Calllog:"
        lbMaCalllog.textColor = .lightGray
        lbMaCalllog.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbMaCalllog)
        
        let lbMaCalllogValue = UILabel(frame: CGRect(x: lbShopName.frame.origin.x, y: lbMaCalllog.frame.origin.y, width: lbShopName.frame.width, height: Common.Size(s:20)))
        lbMaCalllogValue.text = "\(self.paymentOfFundsInfo?.RequestId ?? 0)"
        lbMaCalllogValue.font = UIFont.systemFont(ofSize: 16)
        scrollView.addSubview(lbMaCalllogValue)
        
        let bankInfoView = UIView(frame: CGRect(x: 0, y: lbMaCalllogValue.frame.origin.y + lbMaCalllogValue.frame.height + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s:40)))
        bankInfoView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(bankInfoView)
        
        let lbBankInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: bankInfoView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        lbBankInfo.text = "THÔNG TIN TẠI NGÂN HÀNG"
        bankInfoView.addSubview(lbBankInfo)
        
//        lbHinhAnhSelfie = UILabel(frame: CGRect(x: Common.Size(s:15), y: bankInfoView.frame.origin.y + bankInfoView.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:20)))
//        lbHinhAnhSelfie.text = "Hình ảnh selfie tại ngân hàng:"
//        lbHinhAnhSelfie.font = UIFont.systemFont(ofSize: 14)
//        scrollView.addSubview(lbHinhAnhSelfie)
//
//        selfieView = UIView(frame: CGRect(x: Common.Size(s:15), y: lbHinhAnhSelfie.frame.origin.y + lbHinhAnhSelfie.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:150)))
//        selfieView.layer.borderWidth = 1
//        selfieView.layer.borderColor = UIColor.lightGray.cgColor
//        scrollView.addSubview(selfieView)
//
//        imgViewSelfie = UIImageView(frame: CGRect(x: 0, y: 0, width: selfieView.frame.width, height: selfieView.frame.height))
//        imgViewSelfie.image = #imageLiteral(resourceName: "chupanhselfie")
//        imgViewSelfie.contentMode = .scaleAspectFit
//        selfieView.addSubview(imgViewSelfie)
//
//        let tapShowImgSelfie = UITapGestureRecognizer(target: self, action: #selector(takePhotoSelfie))
//        selfieView.isUserInteractionEnabled = true
//        selfieView.addGestureRecognizer(tapShowImgSelfie)
        
//        lbHinhAnhBienNhan = UILabel(frame: CGRect(x: Common.Size(s:15), y: selfieView.frame.origin.y + selfieView.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s:20)))
        
        lbHinhAnhBienNhan = UILabel(frame: CGRect(x: Common.Size(s:15), y: bankInfoView.frame.origin.y + bankInfoView.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s:20)))
        lbHinhAnhBienNhan.text = "Hình ảnh biên nhận nộp tiền:"
        lbHinhAnhBienNhan.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbHinhAnhBienNhan)
        
        bienNhanView = UIView(frame: CGRect(x: Common.Size(s:15), y: lbHinhAnhBienNhan.frame.origin.y + lbHinhAnhBienNhan.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:150)))
        bienNhanView.layer.borderWidth = 1
        bienNhanView.layer.borderColor = UIColor.lightGray.cgColor
        scrollView.addSubview(bienNhanView)
        
        imgViewBienNhan = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width - Common.Size(s:30), height: bienNhanView.frame.height))
        imgViewBienNhan.image = #imageLiteral(resourceName: "chupanhbienban")
        imgViewBienNhan.contentMode = .scaleAspectFit
        bienNhanView.addSubview(imgViewBienNhan)
        
        let tapShowImgBienNhan = UITapGestureRecognizer(target: self, action: #selector(takePhotoBienNhan))
        bienNhanView.isUserInteractionEnabled = true
        bienNhanView.addGestureRecognizer(tapShowImgBienNhan)
        
        lbNote = UILabel(frame: CGRect(x: Common.Size(s:15), y: bienNhanView.frame.origin.y + bienNhanView.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s:20)))
        lbNote.text = "Ghi chú:"
        lbNote.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNote)
        
        tvNoteText = UITextView(frame: CGRect(x: Common.Size(s:15), y: lbNote.frame.origin.y + lbNote.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:70)))
        tvNoteText.layer.cornerRadius = 5
        tvNoteText.layer.borderColor = UIColor.lightGray.cgColor
        tvNoteText.layer.borderWidth = 1
        tvNoteText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(tvNoteText)
        
        btnConfirm = UIButton(frame: CGRect(x: Common.Size(s:15), y: tvNoteText.frame.origin.y + tvNoteText.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:45)))
        btnConfirm.setTitle("XÁC NHẬN", for: .normal)
        btnConfirm.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btnConfirm.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnConfirm.addTarget(self, action: #selector(confirmInfoNopQuy), for: .touchUpInside)
        btnConfirm.layer.cornerRadius = 5
        scrollView.addSubview(btnConfirm)
        
        scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + (navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
    }
    
    @objc func takePhotoSelfie() {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func takePhotoBienNhan() {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    
    func setImgSelfie(image:UIImage){
        let heightImage:CGFloat = Common.Size(s: 150)
        selfieView.subviews.forEach { $0.removeFromSuperview() }
        imgViewSelfie = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewSelfie.contentMode = .scaleAspectFit
        imgViewSelfie.image = image
        selfieView.addSubview(imgViewSelfie)
        
        selfieView.frame = CGRect(x: selfieView.frame.origin.x, y: lbHinhAnhSelfie.frame.origin.y + lbHinhAnhSelfie.frame.height + Common.Size(s: 5), width: selfieView.frame.width, height: heightImage)
        
        lbHinhAnhBienNhan.frame = CGRect(x: lbHinhAnhBienNhan.frame.origin.x, y: selfieView.frame.origin.y + selfieView.frame.height + Common.Size(s: 15), width: lbHinhAnhBienNhan.frame.width, height: lbHinhAnhBienNhan.frame.height)
        
        bienNhanView.frame = CGRect(x: bienNhanView.frame.origin.x, y: lbHinhAnhBienNhan.frame.origin.y + lbHinhAnhBienNhan.frame.height + Common.Size(s: 5), width: bienNhanView.frame.width, height: bienNhanView.frame.height)
        
        lbNote.frame = CGRect(x: lbNote.frame.origin.x, y: bienNhanView.frame.origin.y + bienNhanView.frame.height + Common.Size(s: 15), width: lbNote.frame.width, height: lbNote.frame.height)
        
        tvNoteText.frame = CGRect(x: tvNoteText.frame.origin.x, y: lbNote.frame.origin.y + lbNote.frame.height + Common.Size(s: 5), width: tvNoteText.frame.width, height: tvNoteText.frame.height)
        
        btnConfirm.frame = CGRect(x: btnConfirm.frame.origin.x, y: tvNoteText.frame.origin.y + tvNoteText.frame.height + Common.Size(s: 15), width: btnConfirm.frame.width, height: btnConfirm.frame.height)
        
        scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        let imageSelfie:UIImage = self.resizeImageWidth(image: imgViewSelfie.image!,newWidth: Common.resizeImageWith)!
        let imageSelfieData:NSData = (imageSelfie.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64ImgSelfie = imageSelfieData.base64EncodedString(options: .endLineWithLineFeed)
        
        debugPrint(self.strBase64ImgSelfie)
        
//        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
//
//        }
        MPOSAPIManager.PaymentOfFunds_UploadImage(Base64String: self.strBase64ImgSelfie, handler: { (resultCode, msg, urlData, err) in
//            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if resultCode == 1 {
                    if !urlData.isEmpty {
                        self.urlStrImgSelfie = urlData
                    } else {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                            self.urlStrImgSelfie = ""
                            self.strBase64ImgSelfie = ""
                            self.imgViewSelfie.image = #imageLiteral(resourceName: "chupanhselfie")
                        })
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                } else {
                    let alertVC = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                        self.urlStrImgSelfie = ""
                        self.strBase64ImgSelfie = ""
                        self.imgViewSelfie.image = #imageLiteral(resourceName: "chupanhselfie")
                    })
                    alertVC.addAction(action)
                    self.present(alertVC, animated: true, completion: nil)
                }
//            }
        })

    }
    
    func setImgBienNhan(image:UIImage){
        let heightImage:CGFloat = Common.Size(s: 150)
        bienNhanView.subviews.forEach { $0.removeFromSuperview() }
        
        imgViewBienNhan = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewBienNhan.contentMode = .scaleAspectFit
        imgViewBienNhan.image = image
        bienNhanView.addSubview(imgViewBienNhan)
        
        bienNhanView.frame = CGRect(x: bienNhanView.frame.origin.x, y: lbHinhAnhBienNhan.frame.origin.y + lbHinhAnhBienNhan.frame.height + Common.Size(s: 5), width: bienNhanView.frame.width, height: heightImage)
        
        lbNote.frame = CGRect(x: lbNote.frame.origin.x, y: bienNhanView.frame.origin.y + bienNhanView.frame.height + Common.Size(s: 15), width: lbNote.frame.width, height: lbNote.frame.height)
        
        tvNoteText.frame = CGRect(x: tvNoteText.frame.origin.x, y: lbNote.frame.origin.y + lbNote.frame.height + Common.Size(s: 5), width: tvNoteText.frame.width, height: tvNoteText.frame.height)
        
        btnConfirm.frame = CGRect(x: btnConfirm.frame.origin.x, y: tvNoteText.frame.origin.y + tvNoteText.frame.height + Common.Size(s: 15), width: btnConfirm.frame.width, height: btnConfirm.frame.height)
        
        scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        let imageBienNhan:UIImage = self.resizeImageWidth(image: imgViewBienNhan.image!,newWidth: Common.resizeImageWith)!
        let imageBienNhanData:NSData = (imageBienNhan.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64ImgBienNhan = imageBienNhanData.base64EncodedString(options: .endLineWithLineFeed)
        debugPrint(self.strBase64ImgBienNhan)
        
//        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
//
//        }
        MPOSAPIManager.PaymentOfFunds_UploadImage(Base64String: self.strBase64ImgBienNhan, handler: { (resultCode, msg, urlData, err) in
//            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if resultCode == 1 {
                    if !urlData.isEmpty {
                        self.urlStrImgBienNhan = urlData
                    } else {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                            self.urlStrImgBienNhan = ""
                            self.strBase64ImgBienNhan = ""
                            self.imgViewBienNhan.image = #imageLiteral(resourceName: "chupanhbienban")
                        })
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                } else {
                    let alertVC = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                        self.urlStrImgBienNhan = ""
                        self.strBase64ImgBienNhan = ""
                        self.imgViewBienNhan.image = #imageLiteral(resourceName: "chupanhbienban")
                    })
                    alertVC.addAction(action)
                    self.present(alertVC, animated: true, completion: nil)
                }
//            }
        })
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
    
    @objc func confirmInfoNopQuy() {
        
//        guard !self.urlStrImgSelfie.isEmpty else {
//            self.showAlert(title: "Thông báo", message: "Lỗi up hình ảnh selfie tại ngân hàng!")
//            return
//        }
        
        guard !self.urlStrImgBienNhan.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Lỗi up hình ảnh biên nhận nộp tiền!")
            return
        }
//        let newVC = DetailNopTienViewController()
//        self.navigationController?.pushViewController(newVC, animated: true)
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.PaymentOfFunds_Update(DocEntry: self.paymentOfFundsInfo?.DocEntry ?? 0, UrlImageSefie: self.urlStrImgSelfie, UrlImageReceipt: self.urlStrImgBienNhan, Note: self.tvNoteText.text, handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(results[0].Message)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                            self.navigationController?.popViewController(animated: true)
                        })
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    } else {
                        debugPrint("xác nhận thất bại!")
                        if err.count > 0 {
                            self.showAlert(title: "Thông báo", message: err)
                        }
                    }
                }
            })
        }
    }
}

extension UpdateInfoNopTienViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        
        // image is our desired image
        if (self.posImageUpload == 1){
            self.setImgSelfie(image: image)
        }else if (self.posImageUpload == 2){
            self.setImgBienNhan(image: image)
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
