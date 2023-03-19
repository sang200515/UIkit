//
//  ListCustomerFollowZaloTableViewCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol ListCustomerFollowZalotableViewCellDelegate: AnyObject {
    func selecteScanQRCode(cell: ListCustomerFollowZaloTableViewCell)
    func selecteEditProfile(cell: ListCustomerFollowZaloTableViewCell)
}

class ListCustomerFollowZaloTableViewCell: BaseTableCell {
    
    weak var listCustomerFollowZaloCellDelegate: ListCustomerFollowZalotableViewCellDelegate?
    
    let vCorner: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
        view.makeCorner(corner: 8)
        return view
    }()
    
    let vMain: UIView = {
        let view = UIView()
        view.myCustomDropShadow()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var imgAvatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.makeCircle()
        return imageView
    }()
    
    let imgQRCode: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ic_zalo_qr")
        return imageView
    }()
    
    let imgEditProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ic_edit")
        return imageView
    }()
    
    
    let lbUserName: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.bold_green
        return label
    }()
    
    let lbTitleDateFollow: UILabel = {
        let label = UILabel()
        label.text = "Ngày follow: "
        label.font = UIFont.mediumCustomFont(ofSize: 11)
        label.textColor = Constants.COLORS.text_gray
        return label
    }()
    
    let lbDateDescription: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.mediumCustomFont(ofSize: 11)
        return label
    }()
    
    let btnQRCode: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let btnEdit: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let vContainerQR: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let vContainerEdit: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setupCell() {
        super.setupCell()
        self.contentView.addSubview(vMain)
        vMain.fill(left: 16, top: 16, right: -16, bottom: 0)
        
        vMain.addSubview(vCorner)
        vCorner.fill()
        
        imgAvatarView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imgAvatarView.layer.masksToBounds = false
        imgAvatarView.layer.cornerRadius = imgAvatarView.frame.size.height/2
        imgAvatarView.layer.borderWidth = 0
        imgAvatarView.clipsToBounds = true
        
        vCorner.addSubview(imgAvatarView)
        imgAvatarView.myCustomAnchor(top: nil, leading: vCorner.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vCorner.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 16, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 40, heightConstant: 40)
        
        vCorner.addSubview(lbUserName)
        lbUserName.myAnchorWithUIEdgeInsets(top: vCorner.topAnchor, leading: imgAvatarView.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        vCorner.addSubview(lbTitleDateFollow)
        lbTitleDateFollow.myAnchorWithUIEdgeInsets(top: lbUserName.bottomAnchor, leading: lbUserName.leadingAnchor, bottom: vCorner.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 4, left: 0, bottom: 16, right: 0), size: CGSize(width: 0, height: 0))
        
        vCorner.addSubview(lbDateDescription)
        lbDateDescription.myCustomAnchor(top: nil, leading: lbTitleDateFollow.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: lbTitleDateFollow.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vCorner.addSubview(vContainerQR)
        vContainerQR.myCustomAnchor(top: nil, leading: lbUserName.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vCorner.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 16, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 35, heightConstant: 35)
        
        vContainerQR.addSubview(imgQRCode)
        imgQRCode.myAnchorWithUIEdgeInsets(top: vContainerQR.topAnchor, leading: vContainerQR.leadingAnchor, bottom: vContainerQR.bottomAnchor, trailing: vContainerQR.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), size: CGSize(width: 0, height: 0))
        
        vContainerQR.addSubview(btnQRCode)
        btnQRCode.fill()
        
        btnQRCode.addTarget(self, action: #selector(selectScanQRCodeTapped(_:)), for: .touchUpInside)
        
        vCorner.addSubview(vContainerEdit)
        vContainerEdit.myCustomAnchor(top: nil, leading: vContainerQR.trailingAnchor, trailing: vCorner.trailingAnchor, bottom: nil, centerX: nil, centerY: vCorner.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 2, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 35, heightConstant: 35)
        
        vContainerEdit.addSubview(imgEditProfile)
        imgEditProfile.myAnchorWithUIEdgeInsets(top: vContainerEdit.topAnchor, leading: vContainerEdit.leadingAnchor, bottom: vContainerEdit.bottomAnchor, trailing: vContainerEdit.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), size: CGSize(width: 0, height: 0))
        
        vContainerEdit.addSubview(btnEdit)
        btnEdit.fill()
        
        btnEdit.addTarget(self, action: #selector(selectEditProdilfeTapped(_:)), for: .touchUpInside)
        
    }
    
    @objc private func selectScanQRCodeTapped(_ button: UIButton) {
        listCustomerFollowZaloCellDelegate?.selecteScanQRCode(cell: self)
    }
    
    @objc private func selectEditProdilfeTapped(_ button: UIButton) {
        listCustomerFollowZaloCellDelegate?.selecteEditProfile(cell: self)
    }
    
    func convertToString(dateString: String, formatIn : String, formatOut : String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = formatIn
        guard let date = dateFormater.date(from: dateString) else {return ""}
        
        dateFormater.dateFormat = formatOut
        let timeStr = dateFormater.string(from: date)
        return timeStr
    }
    
    func setupCellGetData(_ name: String, iamgeURL: String, createDate: String) {
        getImageWithURL(urlImage: iamgeURL, placeholderImage: UIImage.init(named: "ic_zalo"), imgView: imgAvatarView, shouldCache: false, contentMode: .scaleAspectFit)
        lbUserName.text = name
        let dateConvert = convertToString(dateString: createDate, formatIn: "yyyy-MM-dd'T'HH:mm:ss.SS", formatOut: "dd/MM/yyyy HH:mm:ss")
        lbDateDescription.text = dateConvert
        
    }
    
    func setupForUser() {
        imgAvatarView.image = nil
        lbUserName.text = nil
        lbDateDescription.text = nil
    }
}
