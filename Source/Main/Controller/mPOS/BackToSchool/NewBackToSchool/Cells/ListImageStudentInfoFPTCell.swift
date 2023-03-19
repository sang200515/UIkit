//
//  ListImageStudentInfoFPT.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListImageStudentInfoFPTCell: BaseTableCell {
    
    private var widthContantsImageView: CGFloat = 300
    private var heightContantsImageView: CGFloat = 200
    
    let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
    
    let vImageIdentityFront: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let vImageIdentityBackSide: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let vImageEntranceExaminationPage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let vContainerIdentityFront: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let vContainerIdentitBackSide: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let vContainerEntranceExaminationPage: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func setupCell() {
        super.setupCell()
        setupStackView()
    }
    
    fileprivate func setupStackView() {
       vContainerIdentityFront.layer.borderWidth = 0.5
       vContainerIdentityFront.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
       vContainerIdentityFront.layer.cornerRadius = 3.0
       
       vContainerIdentitBackSide.layer.borderWidth = 0.5
       vContainerIdentitBackSide.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
       vContainerIdentitBackSide.layer.cornerRadius = 3.0
       
       vContainerEntranceExaminationPage.layer.borderWidth = 0.5
       vContainerEntranceExaminationPage.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
       vContainerEntranceExaminationPage.layer.cornerRadius = 3.0
        
        vContainerIdentityFront.addSubview(vImageIdentityFront)
        vImageIdentityFront.myCustomAnchor(top: vContainerIdentityFront.topAnchor, leading: nil, trailing: nil, bottom: vContainerIdentityFront.bottomAnchor, centerX: vContainerIdentityFront.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: widthContantsImageView, heightConstant: 0)
        
        vContainerIdentitBackSide.addSubview(vImageIdentityBackSide)
        vImageIdentityBackSide.myCustomAnchor(top: vContainerIdentitBackSide.topAnchor, leading: nil, trailing: nil, bottom: vContainerIdentitBackSide.bottomAnchor, centerX: vContainerIdentitBackSide.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: widthContantsImageView, heightConstant: 0)
        
        vContainerEntranceExaminationPage.addSubview(vImageEntranceExaminationPage)
        vImageEntranceExaminationPage.myCustomAnchor(top: vContainerEntranceExaminationPage.topAnchor, leading: nil, trailing: nil, bottom: vContainerEntranceExaminationPage.bottomAnchor, centerX: vContainerEntranceExaminationPage.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: widthContantsImageView, heightConstant: 0)
        
        let stackView = UIStackView(arrangedSubviews: [vContainerIdentityFront, vContainerIdentitBackSide, vContainerEntranceExaminationPage])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        contentView.addSubview(stackView)
        stackView.myCustomAnchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 16, leadingConstant: 8, trailingConstant: 8, bottomConstant: 30, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 600)
        
    }
    
    func getImageIdentityFront(_ url: String) {
        printLog(function: #function, json: url)
        getImageWithURL(urlImage: "\(url)", placeholderImage: UIImage.init(named: "img_identity_front"), imgView: vImageIdentityFront, shouldCache: true, contentMode: .scaleToFill)
    }
    
    func getImageIdentityBackSide(_ url: String) {
        printLog(function: #function, json: url)
        getImageWithURL(urlImage: "\(url)", placeholderImage: UIImage.init(named: "img_identity_backSide"), imgView: vImageIdentityBackSide, shouldCache: true, contentMode: .scaleToFill)
    }
    
    func getImageEntranceExamination(_ url: String) {
        printLog(function: #function, json: url)
        getImageWithURL(urlImage: "\(url)", placeholderImage: UIImage.init(named: "img_entrance_examination_update"), imgView: vImageEntranceExaminationPage, shouldCache: true, contentMode: .scaleToFill)
    }
    
}
