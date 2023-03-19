//
//  CreateStudentInfoFPTCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol CreateStudentInfoFPTCellDelegate: AnyObject {
    func getFirstAndLastname(_ name: String)
    func getIdentity(_ identity: String)
    func getPhoneNumber(_ phoneNumber: String)
    func getTypeStudent(_ type: Int)
}

class CreateStudentInfoFPTCell: BaseTableCell {
    
    weak var createStudentInfoFPTCellDelegate: CreateStudentInfoFPTCellDelegate?

    private let widthConstant: CGFloat = 200
    private let heightConstant: CGFloat = 35
    private let spacingTextFieldAndTitle: CGFloat = 15
    var selectedType: Int = 0
    
    let btnChooseStudentFPT: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "uncheck"), for: .normal)
        return button
    }()
    
    let btnChooseStudentAdmission: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "uncheck"), for: .normal)
        return button
    }()
    
    let lbTitleStudentFPTCheck: UILabel = {
       let label = UILabel()
        label.text = " SV FPT"
        label.font = UIFont.mediumFont(size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lbTitleStudentAdmissionCheck: UILabel = {
       let label = UILabel()
        label.text = "SV xét TN/SV năm cũ/Giáo Viên/Giảng Viên"
        label.font = UIFont.mediumFont(size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    
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
        label.text = "CMND/Căn cước Học sinh/Sinh viên:"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let lbPhoneNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.black_main
        label.text = "Số điện thoại:"
        return label
    }()
    
    let tfName: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nhập tên sinh viên vào"
        tf.setBorder(color: Constants.COLORS.text_gray, borderWidth: 0.5, corner: 8)
        tf.font = UIFont.regularFontOfSize(ofSize: 13)
        return tf
    }()
    
    let tfIdentity: UITextField = {
        let tf = UITextField()
        tf.addPadding(.left(8))
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nhập số CMND/Căn cước"
        tf.setBorder(color: Constants.COLORS.text_gray, borderWidth: 0.5, corner: 8)
        tf.font = UIFont.regularFontOfSize(ofSize: 13)
        return tf
    }()
    
    let tfPhoneNumber: UITextField = {
        let tf = UITextField()
        tf.addPadding(.left(8))
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nhập số điện thoại"
        tf.setBorder(color: Constants.COLORS.text_gray, borderWidth: 0.5, corner: 8)
        tf.font = UIFont.regularFontOfSize(ofSize: 13)
        return tf
    }()
    
    override func setupCell() {
        super.setupCell()
        createStudentInfoFPTCellDelegate?.getTypeStudent(selectedType)
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        
        contentView.addSubview(btnChooseStudentFPT)
        btnChooseStudentFPT.myCustomAnchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        
        btnChooseStudentFPT.addTarget(self, action: #selector(chooseStudentFPT(_:)), for: .touchUpInside)
        btnChooseStudentFPT.isHidden = true
        
        contentView.addSubview(lbTitleStudentFPTCheck)
        lbTitleStudentFPTCheck.myCustomAnchor(top: nil, leading: btnChooseStudentFPT.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: btnChooseStudentFPT.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        lbTitleStudentFPTCheck.isHidden = true
        
        contentView.addSubview(btnChooseStudentAdmission)
        btnChooseStudentAdmission.myCustomAnchor(top: contentView.topAnchor, leading: lbTitleStudentFPTCheck.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        btnChooseStudentAdmission.isHidden = true
        btnChooseStudentAdmission.addTarget(self, action: #selector(chooseStudentAdmission(_:)), for: .touchUpInside)
        
        contentView.addSubview(lbTitleStudentAdmissionCheck)
        lbTitleStudentAdmissionCheck.myCustomAnchor(top: nil, leading: btnChooseStudentAdmission.trailingAnchor, trailing: self.contentView.trailingAnchor, bottom: nil, centerX: nil, centerY: btnChooseStudentAdmission.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 16, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 30)
        lbTitleStudentAdmissionCheck.isHidden = true
        
        let heightTfName = tfName.heightAnchor.constraint(equalToConstant: heightConstant)
        let widthTfname = tfName.widthAnchor.constraint(equalToConstant: widthConstant)
        tfName.addConstraints([heightTfName, widthTfname])
        tfName.delegate = self
        let stackViewName = UIStackView(arrangedSubviews: [lbFirstAndLastName, tfName])
        stackViewName.axis = .horizontal
        stackViewName.distribution = .fill
        stackViewName.spacing = spacingTextFieldAndTitle
        
        let heighTfIdentity = tfIdentity.heightAnchor.constraint(equalToConstant: heightConstant)
        let widthTfidentity = tfIdentity.widthAnchor.constraint(equalToConstant: widthConstant)
        tfIdentity.addConstraints([heighTfIdentity, widthTfidentity])
        tfIdentity.delegate = self
        let stackViewIdentity = UIStackView(arrangedSubviews: [lbIdentity, tfIdentity])
        stackViewIdentity.axis = .horizontal
        stackViewIdentity.distribution = .fill
        stackViewIdentity.spacing = spacingTextFieldAndTitle
        
        let heightTfPhoneNumber = tfPhoneNumber.heightAnchor.constraint(equalToConstant: heightConstant)
        let widthTfPhoneNumber = tfPhoneNumber.widthAnchor.constraint(equalToConstant: widthConstant)
        tfPhoneNumber.addConstraints([heightTfPhoneNumber, widthTfPhoneNumber])
        tfPhoneNumber.delegate = self
        let stackViewPhoneNumber = UIStackView(arrangedSubviews: [lbPhoneNumber, tfPhoneNumber])
        stackViewPhoneNumber.axis = .horizontal
        stackViewPhoneNumber.distribution = .fill
        stackViewPhoneNumber.spacing = spacingTextFieldAndTitle
        
        let stackViewContainer = UIStackView(arrangedSubviews: [stackViewName, stackViewIdentity, stackViewPhoneNumber])
        stackViewContainer.axis = .vertical
        stackViewContainer.distribution = .fillEqually
        stackViewContainer.spacing = 8
        
        self.contentView.addSubview(stackViewContainer)
        stackViewContainer.myCustomAnchor(top: self.btnChooseStudentFPT.bottomAnchor, leading: self.btnChooseStudentFPT.leadingAnchor, trailing: self.contentView.trailingAnchor, bottom: self.contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 16, leadingConstant: 0, trailingConstant: 8, bottomConstant: 8, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tfName.addTarget(self, action: #selector(typingName(textField:)), for: .editingChanged)
        tfName.addPadding(.left(8))
    }
    
    @objc private func typingName(textField: UITextField) {
        if let typeName = textField.text {
            createStudentInfoFPTCellDelegate?.getFirstAndLastname(typeName)
        }
    }
    
    @objc private func chooseStudentFPT(_ sender: UIButton?) {
        if let button = sender {
            btnChooseStudentFPT.isSelected = !button.isSelected
            btnChooseStudentAdmission.isSelected = false
            
            btnChooseStudentFPT.setImage(UIImage.init(named: "checkedBox"), for: .selected)
            if btnChooseStudentFPT.isSelected == true {
                selectedType = 1

            } else {
                selectedType = 0
            }
            createStudentInfoFPTCellDelegate?.getTypeStudent(selectedType)
        }
    }
    
    @objc private func chooseStudentAdmission(_ sender: UIButton?) {
        if let button = sender {
            btnChooseStudentAdmission.isSelected = !button.isSelected
            btnChooseStudentFPT.isSelected = false
            
            btnChooseStudentAdmission.setImage(UIImage.init(named: "checkedBox"), for: .selected)
            if btnChooseStudentAdmission.isSelected == true {
                selectedType = 2

            } else {
                selectedType = 0
            }
            createStudentInfoFPTCellDelegate?.getTypeStudent(selectedType)
        }
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension CreateStudentInfoFPTCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfPhoneNumber {
            let strNew = (textField.text as NSString?)!.replacingCharacters(in: range, with: string)
            createStudentInfoFPTCellDelegate?.getPhoneNumber(strNew)
        } else if textField == tfIdentity {
            let strNew = (textField.text as NSString?)!.replacingCharacters(in: range, with: string)
            createStudentInfoFPTCellDelegate?.getIdentity(strNew)
        }
        return true
    }
}


