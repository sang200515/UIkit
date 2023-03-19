//
//  VietjetPassengerTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum VietjetPassengerType {
    case adult
    case child
    case infant
    case contact
}

class VietjetPassengerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vBackground: UIStackView!
    @IBOutlet weak var cstHeaderView: NSLayoutConstraint!
    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var imgExpand: UIImageView!
    @IBOutlet weak var vExpand: UIView!
    @IBOutlet weak var vFirstName: UIStackView!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var vLastName: UIStackView!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var vDOB: UIStackView!
    @IBOutlet weak var tfDOB: UITextField!
    @IBOutlet weak var vGender: UIView!
    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var imgFemale: UIImageView!
    @IBOutlet weak var vCMND: UIStackView!
    @IBOutlet weak var tfCMND: UITextField!
    @IBOutlet weak var vAddress: UIStackView!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var vEmail: UIStackView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var vPhone: UIStackView!
    @IBOutlet weak var tfPhone: UITextField!
    
    var didExpand: (() -> Void)?
    private var isMale: Bool = true
    private var passengerIndex: Int = 0
    private var type: VietjetPassengerType = .adult
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tfFirstName.delegate = self
        tfLastName.delegate = self
        tfAddress.delegate = self
        tfEmail.delegate = self
        tfCMND.delegate = self
        tfPhone.delegate = self
        tfDOB.delegate = self
        
        tfFirstName.autocapitalizationType = .allCharacters
        tfLastName.autocapitalizationType = .allCharacters
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell(type: VietjetPassengerType, isExpand: Bool, index: Int = 0) {
        self.type = type
        
        switch type {
        case .adult:
            self.passengerIndex = index - 1
            
            vFirstName.isHidden = false
            vLastName.isHidden = false
            vDOB.isHidden = false
            vGender.isHidden = false
            vCMND.isHidden = false
            vAddress.isHidden = true
            vEmail.isHidden = true
            vPhone.isHidden = true
            
            if !VietjetDataManager.shared.passengers[index - 1].reservationProfile.firstName.isEmpty || !VietjetDataManager.shared.passengers[index - 1].reservationProfile.lastName.isEmpty {
                lbPhone.isHidden = false
                lbEmail.isHidden = true
                
                lbFullName.text = VietjetDataManager.shared.passengers[index - 1].reservationProfile.lastName + " " + VietjetDataManager.shared.passengers[index - 1].reservationProfile.firstName
                lbPhone.text = "Người lớn \(index)"
                lbFullName.textColor = UIColor(hexString: "10AF71")
            } else {
                lbPhone.isHidden = true
                lbEmail.isHidden = true
                
                lbFullName.text = "Người lớn \(index)"
                lbFullName.textColor = .black
            }
        case .child, .infant:
            vFirstName.isHidden = false
            vLastName.isHidden = false
            vDOB.isHidden = false
            vGender.isHidden = false
            vCMND.isHidden = true
            vAddress.isHidden = true
            vEmail.isHidden = true
            vPhone.isHidden = true
            
            if type == .child {
                self.passengerIndex = VietjetDataManager.shared.adultCount + index - 1
                if !VietjetDataManager.shared.passengers[VietjetDataManager.shared.adultCount + index - 1].reservationProfile.firstName.isEmpty || !VietjetDataManager.shared.passengers[VietjetDataManager.shared.adultCount + index - 1].reservationProfile.lastName.isEmpty {
                    lbPhone.isHidden = false
                    lbEmail.isHidden = true
                    lbFullName.textColor = UIColor(hexString: "10AF71")
                    
                    lbFullName.text = VietjetDataManager.shared.passengers[VietjetDataManager.shared.adultCount + index - 1].reservationProfile.lastName + " " + VietjetDataManager.shared.passengers[VietjetDataManager.shared.adultCount + index - 1].reservationProfile.firstName
                    lbPhone.text = "Trẻ em \(index) (Từ 2 đến 11 tuổi)"
                } else {
                    lbPhone.isHidden = true
                    lbEmail.isHidden = true
                    
                    lbFullName.text = "Trẻ em \(index) (Từ 2 đến 11 tuổi)"
                }
            } else if type == .infant {
                self.passengerIndex = index - 1
                if !VietjetDataManager.shared.passengers[index - 1].infantProfile!.firstName.isEmpty || !VietjetDataManager.shared.passengers[index - 1].infantProfile!.lastName.isEmpty {
                    lbPhone.isHidden = false
                    lbEmail.isHidden = true
                    lbFullName.textColor = UIColor(hexString: "10AF71")
                    
                    lbFullName.text = VietjetDataManager.shared.passengers[index - 1].infantProfile!.lastName + " " + VietjetDataManager.shared.passengers[index - 1].infantProfile!.firstName
                    lbPhone.text = "Em bé \(index) (Dưới 2 tuổi)"
                } else {
                    lbPhone.isHidden = true
                    lbEmail.isHidden = true
                    
                    lbFullName.text = "Em bé \(index) (Dưới 2 tuổi)"
                }
            }
        case .contact:
            vFirstName.isHidden = false
            vLastName.isHidden = false
            vDOB.isHidden = true
            vGender.isHidden = true
            vCMND.isHidden = true
            vAddress.isHidden = false
            vEmail.isHidden = false
            vPhone.isHidden = false
            
            if !VietjetDataManager.shared.contact.fullName.isEmpty {
                lbPhone.isHidden = false
                lbEmail.isHidden = false
                
                lbFullName.text = VietjetDataManager.shared.contact.fullName
                lbFullName.textColor = UIColor(hexString: "10AF71")
                lbPhone.text = VietjetDataManager.shared.contact.phoneNumber
                lbEmail.text = VietjetDataManager.shared.contact.email
            } else {
                lbPhone.isHidden = true
                lbEmail.isHidden = true
                
                lbFullName.text = "Thông tin liên hệ"
                lbFullName.textColor = .black
            }
        }
        
        vExpand.isHidden = !isExpand
        setRadioButton()
    }
    
    private func setupDatePickerToolbar(_ selector: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: selector)
        
        toolbar.setItems([spaceButton, doneButton], animated: false)
        return toolbar
    }
    
    @IBAction func expandButtonPressed(_ sender: Any) {
        self.didExpand?()
    }
    
    @IBAction func maleButtonPressed(_ sender: Any) {
        isMale = true
        setRadioButton()
    }
    
    @IBAction func femaleButtonPressed(_ sender: Any) {
        isMale = false
        setRadioButton()
    }
    
    private func setRadioButton() {
        let selectedImage = UIImage(named: "selected_radio_ic")!
        let unselectedImage = UIImage(named: "unselected_radio_ic")!
        
        if isMale {
            imgMale.image = selectedImage
            imgFemale.image = unselectedImage
        } else {
            imgMale.image = unselectedImage
            imgFemale.image = selectedImage
        }
        
        switch type {
        case .adult, .child:
            VietjetDataManager.shared.passengers[passengerIndex].reservationProfile.title = isMale ? "Mr" : "Ms"
            VietjetDataManager.shared.passengers[passengerIndex].reservationProfile.gender = isMale ? "Male" : "Female"
        case .infant:
            VietjetDataManager.shared.passengers[passengerIndex].infantProfile!.gender = isMale ? "Male" : "Female"
        default:
            break
        }
    }
}

extension VietjetPassengerTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfPhone {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            let shouldChange = range.location < 11 && allowedCharacters.isSuperset(of: characterSet)
            
            if shouldChange {
                switch type {
                case .contact:
                    let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    VietjetDataManager.shared.contact.phoneNumber = text
                default:
                    break
                }
            }
            
            return shouldChange
        } else if textField == tfFirstName {
            textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
            
            switch type {
            case .adult, .child:
                VietjetDataManager.shared.passengers[passengerIndex].reservationProfile.firstName = textField.text&
            case .infant:
                VietjetDataManager.shared.passengers[passengerIndex].infantProfile!.firstName = textField.text&
            case .contact:
                VietjetDataManager.shared.contact.fullName = tfLastName.text& + " " + textField.text&
            }
            
            return false
        } else if textField == tfLastName {
            textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
            
            switch type {
            case .adult, .child:
                VietjetDataManager.shared.passengers[passengerIndex].reservationProfile.lastName = textField.text&
            case .infant:
                VietjetDataManager.shared.passengers[passengerIndex].infantProfile!.lastName = textField.text&
            case .contact:
                VietjetDataManager.shared.contact.fullName = textField.text& + " " + tfFirstName.text&
            }
            
            return false
        } else if textField == tfEmail {
            switch type {
            case .contact:
                var text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                if string.count > 1 {
                    text = string
                }
                
                VietjetDataManager.shared.contact.email = text.trimmingCharacters(in: .whitespaces)
            default:
                break
            }
        } else if textField == tfCMND {
            switch type {
            case .adult:
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                VietjetDataManager.shared.passengers[passengerIndex].reservationProfile.idcard = text
            default:
                break
            }
        } else if textField == tfAddress {
            switch type {
            case .contact:
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                VietjetDataManager.shared.contact.address = text
            default:
                break
            }
        } else if textField == tfDOB {
            if tfDOB.text?.count == 2 || tfDOB.text?.count == 5 {
                if !string.isEmpty {
                    tfDOB.text = tfDOB.text! + "/"
                }
            }
            
            let shouldChange = !(textField.text!.count > 9 && (string.count) > range.length)
            
            if shouldChange {
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                switch type {
                case .adult, .child:
                    VietjetDataManager.shared.passengers[passengerIndex].reservationProfile.birthDate = text
                case .infant:
                    VietjetDataManager.shared.passengers[passengerIndex].infantProfile!.birthDate = text
                default:
                    break
                }
            }
            
            return shouldChange
        }
        
        return true
    }
}
