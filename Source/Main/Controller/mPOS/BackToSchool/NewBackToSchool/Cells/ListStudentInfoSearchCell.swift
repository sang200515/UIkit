//
//  ListStudentInfoSearchCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListStudentInfoSearchCell: BaseTableCell {

    let lbFirstAndLastName: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.text = "Họ tên KH:"
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lbTypeStudent: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.lineBreakMode = .byWordWrapping
        label.text = "Loại sinh viên:"
        return label
    }()
    
    let lbPhoneNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.lineBreakMode = .byWordWrapping
        label.text = "SĐT:"
        return label
    }()
    
    let lbNumberIdentity: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.lineBreakMode = .byCharWrapping
        label.text = "Số CMND/Căn cước:"
        return label
    }()
    
    let lbPercentDiscount: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.text = "Phần trăm giảm giá:"
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lbStatusVoucher: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.text = "Tình trạng:"
        return label
    }()
    
    let lbFirstAndLastNameValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        return label
    }()
    
    let lbIdentityValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.light_green
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        return label
    }()
    
    let lbPhoneNumberValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.light_green
        label.textAlignment = .right
        return label
    }()
    
    let lbValueTypeStudent: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        return label
    }()
    
    let lbValuePercentDiscount: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.main_red_my_info
        label.textAlignment = .right
        return label
    }()
    
    let lbValueStatusVoucher: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.main_red_my_info
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        return label
    }()
    
    let vLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        return view
    }()
    
    private let widthConstant: CGFloat = 220
    
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
        
        let widthLabelTypeStudent = lbValueTypeStudent.widthAnchor.constraint(equalToConstant: widthConstant)
        lbValueTypeStudent.addConstraints([widthLabelTypeStudent])
        let stackViewTypeStudent = UIStackView(arrangedSubviews: [lbTypeStudent, lbValueTypeStudent])
        stackViewName.axis = .horizontal
        stackViewName.distribution = .fill
        stackViewName.spacing = 30
        
        let widthLabelPercentDiscount = lbValuePercentDiscount.widthAnchor.constraint(equalToConstant: widthConstant)
        lbValuePercentDiscount.addConstraints([widthLabelPercentDiscount])
//        let stackViewPercentDiscount = UIStackView(arrangedSubviews: [lbPercentDiscount, lbValuePercentDiscount])
        stackViewName.axis = .horizontal
        stackViewName.distribution = .fill
        stackViewName.spacing = 30
        
        let widthStatusVoucher = lbValueStatusVoucher.widthAnchor.constraint(equalToConstant: widthConstant)
        lbValueStatusVoucher.addConstraints([widthStatusVoucher])
        let stackViewStatusVoucher = UIStackView(arrangedSubviews: [lbStatusVoucher, lbValueStatusVoucher])
        stackViewName.axis = .horizontal
        stackViewName.distribution = .fill
        stackViewName.spacing = 30
        
        let widthLabelValueIdentity = lbIdentityValue.widthAnchor.constraint(equalToConstant: widthConstant)
        let widthLabelIdentity = lbNumberIdentity.widthAnchor.constraint(equalToConstant: 150)
        lbNumberIdentity.addConstraints([widthLabelIdentity])
        lbIdentityValue.addConstraints([widthLabelValueIdentity])
        let stackViewIdentity = UIStackView(arrangedSubviews: [lbNumberIdentity, lbIdentityValue])
        stackViewIdentity.axis = .horizontal
        stackViewIdentity.distribution = .fill
        stackViewIdentity.spacing = 30
        
        let widthLabelPhoneNumber = lbPhoneNumberValue.widthAnchor.constraint(equalToConstant: widthConstant)
        lbPhoneNumberValue.addConstraints([widthLabelPhoneNumber])
        let stackViewPhoneNumber = UIStackView(arrangedSubviews: [lbPhoneNumber, lbPhoneNumberValue])
        stackViewPhoneNumber.axis = .horizontal
        stackViewPhoneNumber.distribution = .fill
        stackViewPhoneNumber.spacing = 30
        
        let stackViewContainer = UIStackView(arrangedSubviews: [stackViewName, stackViewTypeStudent, stackViewPhoneNumber, stackViewIdentity, stackViewStatusVoucher])
        stackViewContainer.axis = .vertical
        stackViewContainer.distribution = .fillEqually
        stackViewContainer.spacing = 4
        
        self.contentView.addSubview(vLine)
        vLine.myCustomAnchor(top: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, bottom: self.contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 1)
        
        self.contentView.addSubview(stackViewContainer)
        stackViewContainer.myCustomAnchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, bottom: self.vLine.topAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 8, trailingConstant: 8, bottomConstant: 8, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func getDataStudentInfo(_ name: String, typeStudent: String, phoneNumber: String, identity: String, percentDiscount: Double, statusVoucher: String) {
        lbFirstAndLastNameValue.text = name
        lbValueTypeStudent.text = typeStudent
        lbIdentityValue.text = identity
        lbPhoneNumberValue.text = phoneNumber
        lbValuePercentDiscount.text = "\(Int(percentDiscount))%"
        lbValueStatusVoucher.text = statusVoucher
        
    }
}
