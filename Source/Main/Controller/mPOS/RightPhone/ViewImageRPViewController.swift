//
//  ViewImageRPViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class ViewImageRPViewController: UIViewController {
    var scrollView:UIScrollView!
    var rsImage:UrlImageRP?
    var rsDescription:DescriptionRightPhone?
    var imageViewFrontCMND: UIImageView!
    var imageViewBehindCMND: UIImageView!
    var imageViewLeft:UIImageView!
    var imageViewRight:UIImageView!
    var imageViewBroken:UIImageView!
    var imageViewSign:UIImageView!
    var imageAvarta:UIImageView!
    var imageViewNP: UIImageView!
    override func viewDidLoad() {
        self.title = "Thông tin chi tiết"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(ViewImageRPViewController.backButton), for: UIControl.Event.touchUpInside)
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
        
        let lblCMND = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCMND.textAlignment = .left
        lblCMND.textColor = UIColor.black
        lblCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCMND.text = "CMND"
        viewProduct.addSubview(lblCMND)
        
        let lblCMNDValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblCMND.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:14)))
        lblCMNDValue.textAlignment = .right
        lblCMNDValue.textColor = UIColor.black
        lblCMNDValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCMNDValue.text = "\(self.rsDescription!.CMND)"
        viewProduct.addSubview(lblCMNDValue)
        
        let lblDateCMND = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblCMND.frame.size.height + lblCMND.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblDateCMND.textAlignment = .left
        lblDateCMND.textColor = UIColor.black
        lblDateCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateCMND.text = "Ngày cấp CMND"
        viewProduct.addSubview(lblDateCMND)
        
        let lblDateCMNDValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblDateCMND.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:14)))
        lblDateCMNDValue.textAlignment = .right
        lblDateCMNDValue.textColor = UIColor.black
        lblDateCMNDValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateCMNDValue.text = "\(self.rsDescription!.NgayCapCMND)"
        viewProduct.addSubview(lblDateCMNDValue)
        
        let lblPlaceCMND = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblDateCMND.frame.size.height + lblDateCMND.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPlaceCMND.textAlignment = .left
        lblPlaceCMND.textColor = UIColor.black
        lblPlaceCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPlaceCMND.text = "Nơi cấp CMND"
        viewProduct.addSubview(lblPlaceCMND)
        
        let lblPlaceCMNDValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblPlaceCMND.frame.origin.y , width: lblPlaceCMND.frame.size.width  , height: Common.Size(s:14)))
        lblPlaceCMNDValue.textAlignment = .right
        lblPlaceCMNDValue.textColor = UIColor.black
        lblPlaceCMNDValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPlaceCMNDValue.text = "\(self.rsDescription!.NoiCapCMND)"
        viewProduct.addSubview(lblPlaceCMNDValue)
        
        let lblAddressCMND = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblPlaceCMND.frame.size.height + lblPlaceCMND.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblAddressCMND.textAlignment = .left
        lblAddressCMND.textColor = UIColor.black
        lblAddressCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblAddressCMND.text = "Địa chỉ thường trú"
        viewProduct.addSubview(lblAddressCMND)
        
        let lblAddressCMNDValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblAddressCMND.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:14)))
        lblAddressCMNDValue.textAlignment = .right
        lblAddressCMNDValue.textColor = UIColor.black
        lblAddressCMNDValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblAddressCMNDValue.text = "\(self.rsDescription!.DiaChiThuongTru)"
        viewProduct.addSubview(lblAddressCMNDValue)
        
        
        let lblAddressTemp = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblAddressCMND.frame.size.height + lblAddressCMND.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblAddressTemp.textAlignment = .left
        lblAddressTemp.textColor = UIColor.black
        lblAddressTemp.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblAddressTemp.text = "Địa chỉ tạm trú"
        viewProduct.addSubview(lblAddressTemp)
        
        let lblAddressTempValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblAddressTemp.frame.origin.y , width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:14)))
        lblAddressTempValue.textAlignment = .right
        lblAddressTempValue.textColor = UIColor.black
        lblAddressTempValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblAddressTempValue.text = "\(self.rsDescription!.DiaChiHienTai)"
        viewProduct.addSubview(lblAddressTempValue)
        
        
        let lblPhoneHome = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblAddressTemp.frame.size.height + lblAddressTemp.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPhoneHome.textAlignment = .left
        lblPhoneHome.textColor = UIColor.black
        lblPhoneHome.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhoneHome.text = "Số điện thoại nhà"
        viewProduct.addSubview(lblPhoneHome)
        
        let lblPhoneHomeValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblPhoneHome.frame.origin.y , width: lblAddressCMND.frame.size.width , height: Common.Size(s:14)))
        lblPhoneHomeValue.textAlignment = .right
        lblPhoneHomeValue.textColor = UIColor.black
        lblPhoneHomeValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhoneHomeValue.text = "\(self.rsDescription!.SDT_home)"
        viewProduct.addSubview(lblPhoneHomeValue)
        
        
        let lblScreenDescription = UILabel(frame: CGRect(x: Common.Size(s: 10), y:lblPhoneHome.frame.size.height + lblPhoneHome.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lblScreenDescription.text = "Mô tả tình trạng máy"
        lblScreenDescription.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewProduct.addSubview(lblScreenDescription)
        
        let lblScreenDescriptionValue = UILabel(frame: CGRect(x:lblScreenDescription.frame.origin.x, y: lblScreenDescription.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        
        lblScreenDescriptionValue.textAlignment = .right
        
        lblScreenDescriptionValue.textColor = .black
        lblScreenDescriptionValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lblScreenDescriptionValue.text = self.rsDescription!.mota_DienThoai
        viewProduct.addSubview(lblScreenDescriptionValue)
        
        let lblScreenDescriptionValueHeight:CGFloat = lblScreenDescriptionValue.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lblScreenDescriptionValue.optimalHeight
        lblScreenDescriptionValue.numberOfLines = 0
        lblScreenDescriptionValue.frame = CGRect(x: lblScreenDescriptionValue.frame.origin.x, y: lblScreenDescriptionValue.frame.origin.y, width: lblScreenDescriptionValue.frame.width, height: lblScreenDescriptionValueHeight)
        //
        
        //
        let lblAccessoriesDescription = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblScreenDescription.frame.size.height + lblScreenDescription.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lblAccessoriesDescription.text = "Mô tả phụ kiện"
        lblAccessoriesDescription.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewProduct.addSubview(lblAccessoriesDescription)
        
        let lblAccessoriesDescriptionValue = UILabel(frame: CGRect(x: lblAccessoriesDescription.frame.origin.x, y: lblAccessoriesDescription.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        
        lblAccessoriesDescriptionValue.textAlignment = .right
        
        lblAccessoriesDescriptionValue.textColor = .black
        lblAccessoriesDescriptionValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lblAccessoriesDescriptionValue.text = self.rsDescription!.mota_phukien
        viewProduct.addSubview(lblAccessoriesDescriptionValue)
        
        let lblAccessoriesDescriptionValueHeight:CGFloat = lblAccessoriesDescriptionValue.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lblAccessoriesDescriptionValue.optimalHeight
        lblAccessoriesDescriptionValue.numberOfLines = 0
        lblAccessoriesDescriptionValue.frame = CGRect(x: lblAccessoriesDescriptionValue.frame.origin.x, y: lblAccessoriesDescriptionValue.frame.origin.y, width: lblAccessoriesDescriptionValue.frame.width, height: lblAccessoriesDescriptionValueHeight)
        //
        
        
        viewProduct.frame.size.height = lblAccessoriesDescriptionValue.frame.size.height + lblAccessoriesDescriptionValue.frame.origin.y
        
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 10), y: viewProduct.frame.size.height + viewProduct.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "HÌNH ẢNH"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        let viewImage = UIView()
        viewImage.frame = CGRect(x: 0, y: label2.frame.size.height + label2.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewImage.backgroundColor = UIColor.white
        scrollView.addSubview(viewImage)
        
        let lblFrontImage = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblFrontImage.textAlignment = .left
        lblFrontImage.textColor = UIColor.black
        lblFrontImage.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblFrontImage.text = "Ảnh ĐT mặt trước CMND"
        viewImage.addSubview(lblFrontImage)
        
        imageViewFrontCMND = UIImageView(frame: CGRect(x: Common.Size(s:10), y: lblFrontImage.frame.size.height + lblFrontImage.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:300)))
        viewImage.addSubview(imageViewFrontCMND)
        
        let lblBehindImage = UILabel(frame: CGRect(x: Common.Size(s:10), y:imageViewFrontCMND.frame.size.height + imageViewFrontCMND.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblBehindImage.textAlignment = .left
        lblBehindImage.textColor = UIColor.black
        lblBehindImage.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBehindImage.text = "Ảnh ĐT mặt sau CMND"
        viewImage.addSubview(lblBehindImage)
        
        imageViewBehindCMND = UIImageView(frame: CGRect(x: Common.Size(s:10), y: lblBehindImage.frame.size.height + lblBehindImage.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:300)))
        viewImage.addSubview(imageViewBehindCMND)
        
        
        let lblLeftImage = UILabel(frame: CGRect(x: Common.Size(s:10), y:imageViewBehindCMND.frame.size.height + imageViewBehindCMND.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblLeftImage.textAlignment = .left
        lblLeftImage.textColor = UIColor.black
        lblLeftImage.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblLeftImage.text = "Ảnh sườn trái máy"
        viewImage.addSubview(lblLeftImage)
        
        imageViewLeft = UIImageView(frame: CGRect(x: Common.Size(s:10), y: lblLeftImage.frame.size.height + lblLeftImage.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:300)))
        viewImage.addSubview(imageViewLeft)
        
        let lblRightImage = UILabel(frame: CGRect(x: Common.Size(s:10), y:imageViewLeft.frame.size.height + imageViewLeft.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblRightImage.textAlignment = .left
        lblRightImage.textColor = UIColor.black
        lblRightImage.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblRightImage.text = "Ảnh sườn phải"
        viewImage.addSubview(lblRightImage)
        
        imageViewRight = UIImageView(frame: CGRect(x: Common.Size(s:10), y: lblRightImage.frame.size.height + lblRightImage.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:300)))
        viewImage.addSubview(imageViewRight)
        
        let lblBrokenImage = UILabel(frame: CGRect(x: Common.Size(s:10), y:imageViewRight.frame.size.height + imageViewRight.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblBrokenImage.textAlignment = .left
        lblBrokenImage.textColor = UIColor.black
        lblBrokenImage.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBrokenImage.text = "Ảnh vị trí trầy xước"
        viewImage.addSubview(lblBrokenImage)
        
        imageViewBroken = UIImageView(frame: CGRect(x: Common.Size(s:10), y: lblBrokenImage.frame.size.height + lblBrokenImage.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:300)))
        viewImage.addSubview(imageViewBroken)
        
        
        let lblSignImage = UILabel(frame: CGRect(x: Common.Size(s:10), y:imageViewBroken.frame.size.height + imageViewBroken.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblSignImage.textAlignment = .left
        lblSignImage.textColor = UIColor.black
        lblSignImage.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSignImage.text = "Ảnh ký biên bản"
        viewImage.addSubview(lblSignImage)
        
        imageViewSign = UIImageView(frame: CGRect(x: Common.Size(s:10), y: lblSignImage.frame.size.height + lblSignImage.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:300)))
        viewImage.addSubview(imageViewSign)
        
        let lblAvartaImage = UILabel(frame: CGRect(x: Common.Size(s:10), y:imageViewSign.frame.size.height + imageViewSign.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblAvartaImage.textAlignment = .left
        lblAvartaImage.textColor = UIColor.black
        lblAvartaImage.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblAvartaImage.text = "Ảnh chân dung KH"
        viewImage.addSubview(lblAvartaImage)
        
        imageAvarta = UIImageView(frame: CGRect(x: Common.Size(s:10), y: lblAvartaImage.frame.size.height + lblAvartaImage.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:300)))
        viewImage.addSubview(imageAvarta)
        
        let lblNPImage = UILabel(frame: CGRect(x: Common.Size(s:10), y:imageAvarta.frame.size.height + imageAvarta.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblNPImage.textAlignment = .left
        lblNPImage.textColor = UIColor.black
        lblNPImage.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNPImage.text = "Ảnh niêm phong"
        viewImage.addSubview(lblNPImage)
        
        imageViewNP = UIImageView(frame: CGRect(x: Common.Size(s:10), y: lblNPImage.frame.size.height + lblNPImage.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:250)))
        viewImage.addSubview(imageViewNP)
        
        viewImage.frame.size.height = imageViewNP.frame.size.height + imageViewNP.frame.origin.y
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewImage.frame.origin.y + viewImage.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        if(rsImage != nil){
            if(rsImage!.CMND_mattruoc != ""){
                self.setImageFront(from: rsImage!.CMND_mattruoc)
            }else{
                
                imageViewFrontCMND.image = #imageLiteral(resourceName: "image_not_found")
            }
            
            if(rsImage!.CMND_matsau != ""){
                self.setImageBehind(from: rsImage!.CMND_matsau)
            }else{
                imageViewBehindCMND.image = #imageLiteral(resourceName: "image_not_found")
            }
            
            if(rsImage!.anh_trai_dt != ""){
                self.setImageLeft(from: rsImage!.anh_trai_dt)
            }else{
                imageViewLeft.image = #imageLiteral(resourceName: "image_not_found")
            }
            
            if(rsImage!.anh_phai_dt != ""){
                self.setImageRight(from: rsImage!.anh_phai_dt)
            }else{
                imageViewRight.image = #imageLiteral(resourceName: "image_not_found")
            }
            
            if(rsImage!.anh_tray_xuoc != ""){
                self.setImageBroken(from: rsImage!.anh_tray_xuoc)
            }else{
                imageViewBroken.image = #imageLiteral(resourceName: "image_not_found")
            }
            
            if(rsImage!.anh_bien_ban != ""){
                self.setImageSign(from: rsImage!.anh_bien_ban)
            }else{
                imageViewSign.image = #imageLiteral(resourceName: "image_not_found")
            }
            
            if(rsImage!.anh_chan_dung != ""){
                self.setImageAvarta(from: rsImage!.anh_chan_dung)
            }else{
                imageAvarta.image = #imageLiteral(resourceName: "image_not_found")
            }
            
            if(rsImage!.anh_niem_phong != ""){
                self.setImageNP(from: rsImage!.anh_niem_phong)
            }else{
                imageViewNP.image = #imageLiteral(resourceName: "image_not_found")
            }
            
        }
        
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setImageFront(from url: String){
        guard let imageURL = URL(string: url) else {  return  }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageViewFrontCMND.image = image
            }
        }
        
    }
    
    func setImageBehind(from url: String){
        guard let imageURL = URL(string: url) else {  return  }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageViewBehindCMND.image = image
            }
        }
        
    }
    func setImageLeft(from url: String){
        guard let imageURL = URL(string: url) else {  return  }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageViewLeft.image = image
            }
        }
        
    }
    func setImageRight(from url: String){
        guard let imageURL = URL(string: url) else {  return  }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageViewRight.image = image
            }
        }
        
    }
    func setImageBroken(from url: String){
        guard let imageURL = URL(string: url) else {  return  }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageViewBroken.image = image
            }
        }
        
    }
    func setImageSign(from url: String){
        guard let imageURL = URL(string: url) else {  return  }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageViewSign.image = image
            }
        }
        
    }
    func setImageAvarta(from url: String){
        guard let imageURL = URL(string: url) else {  return  }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageAvarta.image = image
            }
        }
        
    }
    func setImageNP(from url: String){
        guard let imageURL = URL(string: url) else {  return  }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageViewNP.image = image
            }
        }
        
    }
}
