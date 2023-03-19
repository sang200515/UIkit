//
//  File.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class UploadImageStudentFPTInfoScreen: BaseController {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let lbTitleImageIdentity: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 14)
        label.textColor = .black
        label.text = "Hình ảnh CMND/Căn cước"
        return label
    }()
    
    let lbTitleEntranceExaminationPaper: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 14)
        label.textColor = .black
        label.text = "Hình ảnh GBDT/CNTNTT/BTN/GBNH"
        return label
    }()
    
    let lbDescriptionIdentityFront: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textColor = Constants.COLORS.text_gray
        label.text = "Nhấn vào đây để chụp ảnh CMND/Căn cuóc mặt trước"
        return label
    }()
    
    let lbDescriptionIdentityBackSide: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textColor = Constants.COLORS.text_gray
        label.text = "Nhấn vào đây để chụp ảnh CMND/Căn cuóc mặt sau"
        return label
    }()
    
    let lbDescriptionEntranceExaminationPaper: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textColor = Constants.COLORS.text_gray
        label.text = "Nhấn vào đây để chụp ảnh giấy báo dự thi"
        return label
    }()
    
    let vMainContainerIdentity: UIView = {
        let view = UIView()
        return view
    }()
    
    let vMainContainerEntranceExaminationPaper: UIView = {
        let view = UIView()
        return view
    }()
    
    let vContainerIdentityFront: UIView = {
        let view = UIView()
        return view
    }()
    
    let vContainerIdentityBackSide: UIView = {
        let view = UIView()
        return view
    }()
    
    let vContainerEntranceExaminationPaper: UIView = {
        let view = UIView()
        return view
    }()
    
    let vImgIdentityFront: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let vImgIdentityBackSide: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let vImageEntranceExaminationPaper: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let btnChooseImgIdentityFront: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        return button
    }()
    
    let btnChooseImgIdentityBackSide: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        return button
    }()
    
    let btnChooseEntranceExaminationPaper: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        return button
    }()
    
    let btnUploadImage: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Constants.COLORS.bold_green
        button.setTitle("UPLOAD", for: .normal)
        button.setTitleColor(Constants.COLORS.main_color_white, for: .normal)
        return button
    }()
    
    let vImgCheck: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let imgPicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()
    
    private var posImageUpload: Int = -1
    private var strBase64IdentityFront = ""
    private var strBase64IdentityBackSide = ""
    private var strBase64IdentityEntranceExaminationPaper = ""
    
    private var urlIdentityFront = ""
    private var urlIdentityBackSide = ""
    private var urlEntranceExaminationPaper = ""
    private var isCheck = false
    private var isNewStudentFPTInfo = false
    
    private var scrollViewHeight: CGFloat = 0
    
    override func setupViews() {
        super.setupViews()
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
    }
    
    func setupContainers() {
        vMainContainerIdentity.addSubview(lbTitleImageIdentity)
        lbTitleImageIdentity.myCustomAnchor(top: vMainContainerIdentity.topAnchor, leading: vMainContainerIdentity.leadingAnchor, trailing: vMainContainerIdentity.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerIdentityFront.addSubview(vImgIdentityFront)
        vImgIdentityFront.myCustomAnchor(top: vContainerIdentityFront.topAnchor, leading: vContainerIdentityFront.leadingAnchor, trailing: vContainerIdentityFront.trailingAnchor, bottom: vContainerIdentityFront.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerIdentityFront.addSubview(lbDescriptionIdentityFront)
        lbDescriptionIdentityFront.myCustomAnchor(top: nil, leading: nil, trailing: nil, bottom: vContainerIdentityFront.bottomAnchor, centerX: vContainerIdentityFront.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 16, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerIdentityFront.addSubview(btnChooseImgIdentityFront)
        btnChooseImgIdentityFront.fill()
        
        vContainerIdentityBackSide.addSubview(vImgIdentityBackSide)
        vImgIdentityBackSide.myCustomAnchor(top: vContainerIdentityBackSide.topAnchor, leading: vContainerIdentityBackSide.leadingAnchor, trailing: vContainerIdentityBackSide.trailingAnchor, bottom: vContainerIdentityBackSide.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerIdentityBackSide.addSubview(btnChooseImgIdentityBackSide)
        btnChooseImgIdentityBackSide.fill()

        let stackViewContainerIdentity = UIStackView(arrangedSubviews: [vContainerIdentityFront, vContainerIdentityBackSide])
        stackViewContainerIdentity.axis = .vertical
        stackViewContainerIdentity.distribution = .fillEqually
        stackViewContainerIdentity.spacing = 8
        
        vMainContainerIdentity.addSubview(stackViewContainerIdentity)
        stackViewContainerIdentity.myCustomAnchor(top: lbTitleImageIdentity.bottomAnchor, leading: vMainContainerIdentity.leadingAnchor, trailing: vMainContainerIdentity.trailingAnchor, bottom: vMainContainerIdentity.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vMainContainerEntranceExaminationPaper.addSubview(lbTitleEntranceExaminationPaper)
        lbTitleEntranceExaminationPaper.myCustomAnchor(top: vMainContainerEntranceExaminationPaper.topAnchor, leading: vMainContainerEntranceExaminationPaper.leadingAnchor, trailing: vMainContainerEntranceExaminationPaper.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 4, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerEntranceExaminationPaper.addSubview(vImageEntranceExaminationPaper)
        vImageEntranceExaminationPaper.fill()
        
        vContainerEntranceExaminationPaper.addSubview(lbDescriptionEntranceExaminationPaper)
        lbDescriptionEntranceExaminationPaper.myCustomAnchor(top: nil, leading: nil, trailing: nil, bottom: vContainerEntranceExaminationPaper.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 16, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    fileprivate func setupStackViewContainer() {
        
        
        
        _ = UIStackView(arrangedSubviews: [vContainerIdentityFront, vContainerIdentityBackSide, vContainerEntranceExaminationPaper])
    }
    
}
