//
//  DetailNopTienViewController.swift
//  fptshop
//
//  Created by Apple on 7/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailNopTienViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var imgViewBienNhan: UIImageView!
    var bienNhanView: UIView!
    var lbHinhAnhBienNhan: UILabel!
    var item:DetailsCallLogNopQuyItem?
    var urlStrImgBienNhan = ""
    var strBase64ImgBienNhan = ""
    var imagePicker = UIImagePickerController()
    var posImageUpload:Int = -1
    var btnConfirm: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Chi tiết"
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
        
        setUpView()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let calllogInfoView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s:40)))
        calllogInfoView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(calllogInfoView)
        
        let lbCalllogInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: calllogInfoView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        lbCalllogInfo.text = "THÔNG TIN CALLLOG"
        calllogInfoView.addSubview(lbCalllogInfo)
        
        let lbSoCalllog = UILabel(frame: CGRect(x: Common.Size(s:15), y: calllogInfoView.frame.origin.y + calllogInfoView.frame.height + Common.Size(s:15), width: scrollView.frame.width/3 - Common.Size(s:15), height: Common.Size(s:20)))
        lbSoCalllog.text = "Số Calllog:"
        lbSoCalllog.font = UIFont.systemFont(ofSize: 14)
        lbSoCalllog.textColor = .lightGray
        scrollView.addSubview(lbSoCalllog)
        
        let lbSoCalllogValue = UILabel(frame: CGRect(x: lbSoCalllog.frame.origin.x + lbSoCalllog.frame.width + Common.Size(s: 5), y: lbSoCalllog.frame.origin.y, width: scrollView.frame.width - (lbSoCalllog.frame.origin.x + lbSoCalllog.frame.width + Common.Size(s: 5)) - Common.Size(s: 15), height: Common.Size(s:20)))
        lbSoCalllogValue.text = "\(self.item?.RequestId ?? 0)"
        lbSoCalllogValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSoCalllogValue)
        
        let lbShop = UILabel(frame: CGRect(x: lbSoCalllog.frame.origin.x, y: lbSoCalllogValue.frame.origin.y + lbSoCalllogValue.frame.height + Common.Size(s:5), width: lbSoCalllog.frame.width, height: Common.Size(s:20)))
        lbShop.text = "Shop:"
        lbShop.font = UIFont.systemFont(ofSize: 14)
        lbShop.textColor = .lightGray
        scrollView.addSubview(lbShop)
        
        let lbShopName = UILabel(frame: CGRect(x: lbSoCalllogValue.frame.origin.x, y: lbShop.frame.origin.y, width: lbSoCalllogValue.frame.width, height: Common.Size(s:20)))
        lbShopName.text = "\(self.item?.ShopName ?? "")"
        lbShopName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbShopName)
        
        let lbShopNameHeight = lbShopName.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbShopName.optimalHeight
        lbShopName.numberOfLines = 0
        
        lbShopName.frame = CGRect(x: lbShopName.frame.origin.x, y: lbShopName.frame.origin.y, width: lbShopName.frame.width, height: lbShopNameHeight)
        
        let lbNV = UILabel(frame: CGRect(x: lbSoCalllog.frame.origin.x, y: lbShopName.frame.origin.y + lbShopNameHeight + Common.Size(s: 5), width: lbSoCalllog.frame.width, height: Common.Size(s:20)))
        lbNV.text = "Nhân viên:"
        lbNV.font = UIFont.systemFont(ofSize: 14)
        lbNV.textColor = .lightGray
        scrollView.addSubview(lbNV)
        
        let lbNhanVienName = UILabel(frame: CGRect(x: lbSoCalllogValue.frame.origin.x, y: lbNV.frame.origin.y, width: lbShopName.frame.width, height: Common.Size(s:20)))
        lbNhanVienName.text = "\(self.item?.EmployeeName ?? "")"
        lbNhanVienName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNhanVienName)
        
        let lbNhanVienNameHeight = lbNhanVienName.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbNhanVienName.optimalHeight
        lbNhanVienName.numberOfLines = 0
        
        lbNhanVienName.frame = CGRect(x: lbNhanVienName.frame.origin.x, y: lbNhanVienName.frame.origin.y, width: lbNhanVienName.frame.width, height: lbNhanVienNameHeight)
        
        let lbNgay = UILabel(frame: CGRect(x: lbSoCalllog.frame.origin.x, y: lbNhanVienName.frame.origin.y + lbNhanVienNameHeight + Common.Size(s:5), width: lbSoCalllog.frame.width, height: Common.Size(s:20)))
        lbNgay.text = "Ngày:"
        lbNgay.textColor = .lightGray
        lbNgay.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNgay)
        
        let lbNgayValue = UILabel(frame: CGRect(x: lbSoCalllogValue.frame.origin.x, y: lbNgay.frame.origin.y, width: lbShopName.frame.width, height: Common.Size(s:20)))
        lbNgayValue.text = "\(self.item?.Date ?? "")"
        lbNgayValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNgayValue)
        
        let lbTienQuy = UILabel(frame: CGRect(x: lbSoCalllog.frame.origin.x, y: lbNgayValue.frame.origin.y + lbNgayValue.frame.height + Common.Size(s:5), width: lbSoCalllog.frame.width, height: Common.Size(s:20)))
        lbTienQuy.text = "Tiền quỹ:"
        lbTienQuy.textColor = .lightGray
        lbTienQuy.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTienQuy)
        
        let lbTienQuyValue = UILabel(frame: CGRect(x: lbSoCalllogValue.frame.origin.x, y: lbTienQuy.frame.origin.y, width: lbShopName.frame.width, height: Common.Size(s:20)))
        lbTienQuyValue.text = "\(self.item?.Money ?? "")"
        lbTienQuyValue.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbTienQuyValue)
        
        let lbNgayNop = UILabel(frame: CGRect(x: lbSoCalllog.frame.origin.x, y: lbTienQuyValue.frame.origin.y + lbTienQuyValue.frame.height + Common.Size(s:5), width: lbSoCalllog.frame.width, height: Common.Size(s:20)))
        lbNgayNop.text = "Ngày nộp:"
        lbNgayNop.textColor = .lightGray
        lbNgayNop.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNgayNop)
        
        let lbNgayNopValue = UILabel(frame: CGRect(x: lbSoCalllogValue.frame.origin.x, y: lbNgayNop.frame.origin.y, width: lbShopName.frame.width, height: Common.Size(s:20)))
        lbNgayNopValue.text = "\(self.item?.UpdateDate ?? "")"
        lbNgayNopValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNgayNopValue)
        
        let lbGhiChu = UILabel(frame: CGRect(x: lbSoCalllog.frame.origin.x, y: lbNgayNopValue.frame.origin.y + lbNgayNopValue.frame.height + Common.Size(s:5), width: lbSoCalllog.frame.width, height: Common.Size(s:20)))
        lbGhiChu.text = "Ghi chú:"
        lbGhiChu.textColor = .lightGray
        lbGhiChu.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbGhiChu)
        
        let lbGhiChuValue = UILabel(frame: CGRect(x: lbSoCalllogValue.frame.origin.x, y: lbGhiChu.frame.origin.y, width: lbShopName.frame.width, height: Common.Size(s:20)))
        lbGhiChuValue.text = "\(self.item?.Note ?? "")"
        lbGhiChuValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbGhiChuValue)
        
        let lbGhiChuValueHeight = lbGhiChuValue.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbGhiChuValue.optimalHeight
        lbGhiChuValue.numberOfLines = 0
        
        lbGhiChuValue.frame = CGRect(x: lbGhiChuValue.frame.origin.x, y: lbGhiChuValue.frame.origin.y, width: lbGhiChuValue.frame.width, height: lbGhiChuValueHeight)
        
        let lbTinhTrang = UILabel(frame: CGRect(x: lbSoCalllog.frame.origin.x, y: lbGhiChuValue.frame.origin.y + lbGhiChuValueHeight + Common.Size(s:5), width: lbSoCalllog.frame.width, height: Common.Size(s:20)))
        lbTinhTrang.text = "Tình trạng:"
        lbTinhTrang.textColor = .lightGray
        lbTinhTrang.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTinhTrang)
        
        let lbTinhTrangValue = UILabel(frame: CGRect(x: lbSoCalllogValue.frame.origin.x, y: lbTinhTrang.frame.origin.y, width: lbShopName.frame.width, height: Common.Size(s:20)))
        lbTinhTrangValue.text = "\(self.item?.Status ?? "")"
        lbTinhTrangValue.font = UIFont.boldSystemFont(ofSize: 14)
        lbTinhTrangValue.textColor = UIColor(red: 192/255, green: 0/255, blue: 0/255, alpha: 1)
        scrollView.addSubview(lbTinhTrangValue)
        
        let hinhAnhView = UIView(frame: CGRect(x: 0, y: lbTinhTrangValue.frame.origin.y + lbTinhTrangValue.frame.height + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s:40)))
        hinhAnhView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(hinhAnhView)
        
        let lbHinhAnh = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: hinhAnhView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        lbHinhAnh.text = "HÌNH ẢNH"
        hinhAnhView.addSubview(lbHinhAnh)
        
        lbHinhAnhBienNhan = UILabel(frame: CGRect(x: Common.Size(s:15), y: hinhAnhView.frame.origin.y + hinhAnhView.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s:20)))
        lbHinhAnhBienNhan.text = "Hình ảnh biên nhận nộp tiền:"
        lbHinhAnhBienNhan.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbHinhAnhBienNhan)
        
        bienNhanView = UIView(frame: CGRect(x: Common.Size(s:15), y: lbHinhAnhBienNhan.frame.origin.y + lbHinhAnhBienNhan.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:150)))
        bienNhanView.layer.borderWidth = 1
        bienNhanView.layer.borderColor = UIColor.lightGray.cgColor
        scrollView.addSubview(bienNhanView)
        
        imgViewBienNhan = UIImageView(frame: CGRect(x: 0, y: 0, width: bienNhanView.frame.width, height: bienNhanView.frame.height))
        imgViewBienNhan.image = #imageLiteral(resourceName: "chupanhbienban")
        imgViewBienNhan.contentMode = .scaleAspectFit
        bienNhanView.addSubview(imgViewBienNhan)
        
        btnConfirm = UIButton(frame: CGRect(x: Common.Size(s:15), y: bienNhanView.frame.origin.y + bienNhanView.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:45)))
        btnConfirm.setTitle("XÁC NHẬN", for: .normal)
        btnConfirm.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btnConfirm.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnConfirm.addTarget(self, action: #selector(confirmInfoNopQuy), for: .touchUpInside)
        btnConfirm.layer.cornerRadius = 5
        scrollView.addSubview(btnConfirm)
        
        scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        if self.item?.Status == "Đã xác nhận" {
            btnConfirm.isHidden = true
            
            scrollViewHeight = bienNhanView.frame.origin.y + bienNhanView.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
            
            //set url Hình ảnh bien nhan
            guard let urlImgBienNhan = URL(string: "\(self.item?.ImageReceipt ?? "")") else {
                imgViewBienNhan.image = #imageLiteral(resourceName: "chupanhbienban")
                return
            }
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                let data2 = try? Data(contentsOf: urlImgBienNhan)
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if let imageDataBienNhan = data2 {
                        let imageBienNhan = UIImage(data: imageDataBienNhan)
                        self.imgViewBienNhan.image = imageBienNhan
                    }
                }
            }
        } else {
            imgViewBienNhan.image = #imageLiteral(resourceName: "chupanhbienban")
            btnConfirm.isHidden = false
            
            scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
            
            let tapShowImgBienNhan = UITapGestureRecognizer(target: self, action: #selector(takePhotoBienNhan))
            bienNhanView.isUserInteractionEnabled = true
            bienNhanView.addGestureRecognizer(tapShowImgBienNhan)
        }
    }
    
    @objc func takePhotoBienNhan() {
        self.openCamera()
    }
    
    @objc func confirmInfoNopQuy() {
            
            guard !self.urlStrImgBienNhan.isEmpty else {
                let alertVC = UIAlertController(title: "Thông báo", message: "Lỗi up hình ảnh biên nhận nộp tiền!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
                return
            }
            
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.PaymentOfFunds_Update(DocEntry: self.item?.DocEntry ?? 0, UrlImageSefie: "", UrlImageReceipt: self.urlStrImgBienNhan, Note: self.item?.Note ?? "", handler: { (results, err) in
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
                                let alertVC = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alertVC.addAction(action)
                                self.present(alertVC, animated: true, completion: nil)
                            }
                        }
                    }
                })
            }
        }
    
    func setImgBienNhan(image:UIImage) {
        let heightImage:CGFloat = Common.Size(s: 150)
        bienNhanView.subviews.forEach { $0.removeFromSuperview() }
        
        imgViewBienNhan = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewBienNhan.contentMode = .scaleAspectFit
        imgViewBienNhan.image = image
        bienNhanView.addSubview(imgViewBienNhan)
        
        bienNhanView.frame = CGRect(x: bienNhanView.frame.origin.x, y: lbHinhAnhBienNhan.frame.origin.y + lbHinhAnhBienNhan.frame.height + Common.Size(s: 5), width: bienNhanView.frame.width, height: heightImage)
        
        btnConfirm.frame = CGRect(x: btnConfirm.frame.origin.x, y: bienNhanView.frame.origin.y + bienNhanView.frame.height + Common.Size(s: 15), width: btnConfirm.frame.width, height: btnConfirm.frame.height)
        
        scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        let imageBienNhan:UIImage = self.resizeImageWidth(image: imgViewBienNhan.image!,newWidth: Common.resizeImageWith)!
        let imageBienNhanData:NSData = (imageBienNhan.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64ImgBienNhan = imageBienNhanData.base64EncodedString(options: .endLineWithLineFeed)
        debugPrint(self.strBase64ImgBienNhan)
        
        MPOSAPIManager.PaymentOfFunds_UploadImage(Base64String: self.strBase64ImgBienNhan, handler: { (resultCode, msg, urlData, err) in
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
}

extension DetailNopTienViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        self.setImgBienNhan(image: image)
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
