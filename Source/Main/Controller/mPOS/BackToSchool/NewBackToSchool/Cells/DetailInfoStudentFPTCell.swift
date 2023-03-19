//
//  DetailInfoStudentFPTCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailInfoStudentFPTCell: BaseTableCell {

    private let widthConstant: CGFloat = 220
    private let heightConstant: CGFloat = 20

    let lbFirstAndLastName: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.text = "Họ tên:"
        return label
    }()
    
    let lbIdentity: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.text = "CMND/Căn cước:"
        return label
    }()
    
    let lbPhoneNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.text = "Số điện thoại:"
        return label
    }()
    
    let lbFirstAndLastNameValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.text = "Nguyễn Thành Nam"
        label.textAlignment = .right
        return label
    }()
    
    let lbIdentityValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.text = "1234567890"
        label.textAlignment = .right
        return label
    }()
    
    let lbPhoneNumberValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.text = "0909123456"
        label.textAlignment = .right
        return label
    }()
    
    override func setupCell() {
        super.setupCell()
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        
        let widthLabelName = lbFirstAndLastNameValue.widthAnchor.constraint(equalToConstant: widthConstant)
        lbFirstAndLastNameValue.addConstraints([widthLabelName])
        let stackViewName = UIStackView(arrangedSubviews: [lbFirstAndLastName, lbFirstAndLastNameValue])
        stackViewName.axis = .horizontal
        stackViewName.distribution = .fill
        stackViewName.spacing = 30
        
        let widthLabelIdentity = lbIdentityValue.widthAnchor.constraint(equalToConstant: widthConstant)
        lbIdentityValue.addConstraints([widthLabelIdentity])
        let stackViewIdentity = UIStackView(arrangedSubviews: [lbIdentity, lbIdentityValue])
        stackViewIdentity.axis = .horizontal
        stackViewIdentity.distribution = .fill
        stackViewIdentity.spacing = 30
        
        let widthLabelPhoneNumber = lbPhoneNumberValue.widthAnchor.constraint(equalToConstant: widthConstant)
        lbPhoneNumberValue.addConstraints([widthLabelPhoneNumber])
        let stackViewPhoneNumber = UIStackView(arrangedSubviews: [lbPhoneNumber, lbPhoneNumberValue])
        stackViewPhoneNumber.axis = .horizontal
        stackViewPhoneNumber.distribution = .fill
        stackViewPhoneNumber.spacing = 30
        
        let stackViewContainer = UIStackView(arrangedSubviews: [stackViewName, stackViewIdentity, stackViewPhoneNumber])
        stackViewContainer.axis = .vertical
        stackViewContainer.distribution = .fillEqually
        stackViewContainer.spacing = 4
        
        self.contentView.addSubview(stackViewContainer)
        stackViewContainer.myCustomAnchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, bottom: self.contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 8, trailingConstant: 8, bottomConstant: 8, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getDataDetailInfoStudent(_ name: String, _ identity: String, _ phoneNumber: String) {
        self.lbFirstAndLastNameValue.text = name
        self.lbIdentityValue.text = identity
        self.lbPhoneNumberValue.text = phoneNumber
    }

}
