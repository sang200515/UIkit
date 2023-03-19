//
//  InfoCustomerFollowZaloScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class InfoCustomerFollowZaloScreen: BaseController {
    
    let vNameCustomer: InputTextFieldView = {
        let view = InputTextFieldView()
        return view
    }()
    
    let vPhoneNumberCustomer: InputTextFieldView = {
        let view = InputTextFieldView()
        return view
    }()
    
    lazy var imgAvatar: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let lbNameCustomer: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.bold_green
        label.font = UIFont.mediumCustomFont(ofSize: Common.Size(s: 13))
        label.text = "Nguyen Viet Minh Khanh"
        return label
    }()
    
    let lbTitleFollowDate: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.text_gray
        label.font = UIFont.mediumCustomFont(ofSize: Common.Size(s: 12))
        label.text = "Ngày follow: "
        return label
    }()
    
    let lbDateDescription: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.mediumCustomFont(ofSize: Common.Size(s: 12))
        return label
    }()
    
    let lbGender: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.text_gray
        label.font = UIFont.mediumCustomFont(ofSize: Common.Size(s: 13))
        label.text = "Giới tính: "
        return label
    }()
    
    let lbGenderFemale: UILabel = {
        let label = UILabel()
        label.text = "Nữ"
        label.textColor = .black
        label.font = UIFont.regularFontOfSize(ofSize: Common.Size(s: 13))
        return label
    }()
    
    let lbGenderMale: UILabel = {
        let label = UILabel()
        label.text = "Nam"
        label.textColor = .black
        label.font = UIFont.regularFontOfSize(ofSize: Common.Size(s: 13))
        return label
    }()
    
    let btnMale: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "uncheck"), for: .normal)
        return button
    }()
    
    let btnFemale: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "uncheck"), for: .normal)
        return button
    }()
    
    let btnSaveInfo: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.COLORS.bold_green
        button.makeCorner(corner: 8)
        button.setTitle("LƯU", for: .normal)
        return button
    }()
    
    private var validInputData: Bool = false {
        didSet {
            if oldValue != validInputData {
                updateStateButton(validInputData)
            }
        }
    }
    
    private var didCheckBoxGenderFemale: Bool = false {
        didSet {
            if oldValue != didCheckBoxGenderFemale {
                checkBoxGenderFemale(didCheckBoxGenderFemale)
            }
        }
    }
    
    private var didCheckBoxGenderMale: Bool = false {
        didSet {
            if oldValue != didCheckBoxGenderMale {
                checkBoxGenderMale(didCheckBoxGenderMale)
            }
        }
    }
    
    private var senderId: String?
    
    private var gender: String = ""
    private var phoneNumber: String?
    
    override func setupViews() {
        super.setupViews()
        self.title = "Thông tin khách hàng"
        
        imgAvatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imgAvatar.layer.masksToBounds = false
        imgAvatar.layer.cornerRadius = imgAvatar.frame.size.height/2
        imgAvatar.layer.borderWidth = 0
        imgAvatar.clipsToBounds = true
        
        view.addSubview(imgAvatar)
        imgAvatar.myAnchorWithUIEdgeInsets(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 0), size: CGSize(width: 60, height: 60))
        
        view.addSubview(lbNameCustomer)
        lbNameCustomer.myAnchorWithUIEdgeInsets(top: view.topAnchor, leading: imgAvatar.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 4, bottom: 0, right: 16), size: CGSize(width: 0, height: 0))
        
        view.addSubview(lbTitleFollowDate)
        lbTitleFollowDate.myAnchorWithUIEdgeInsets(top: lbNameCustomer.bottomAnchor, leading: lbNameCustomer.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0), size: .zero)
        
        view.addSubview(lbDateDescription)
        lbDateDescription.myAnchorWithUIEdgeInsets(top: lbNameCustomer.bottomAnchor, leading: lbTitleFollowDate.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 16), size: .zero)
        
        view.addSubview(vNameCustomer)
        vNameCustomer.myAnchorWithUIEdgeInsets(top: imgAvatar.bottomAnchor, leading: imgAvatar.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 16), size: .zero)
        
        vNameCustomer.loadNameCustomerFollowZalo()
        
        view.addSubview(vPhoneNumberCustomer)
        vPhoneNumberCustomer.myAnchorWithUIEdgeInsets(top: vNameCustomer.bottomAnchor, leading: vNameCustomer.leadingAnchor, bottom: nil, trailing: vNameCustomer.trailingAnchor, padding: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0), size: .zero)
        
        vPhoneNumberCustomer.loadPhoneNumberCustomerFollowZalo()
        vPhoneNumberCustomer.inputTextFieldViewDelegate = self
        
        view.addSubview(lbGender)
        lbGender.myAnchorWithUIEdgeInsets(top: vPhoneNumberCustomer.bottomAnchor, leading: vPhoneNumberCustomer.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0), size: .zero)
        
        view.addSubview(btnMale)
        btnMale.myCustomAnchor(top: nil, leading: lbGender.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: lbGender.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 24, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 30, heightConstant: 30)
        
        btnMale.addTarget(self, action: #selector(chooseMaleTapped(_:)), for: .touchUpInside)
        
        view.addSubview(lbGenderMale)
        lbGenderMale.myCustomAnchor(top: nil, leading: btnMale.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: lbGender.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(btnFemale)
        btnFemale.myCustomAnchor(top: nil, leading: lbGenderMale.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: lbGender.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 24, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 30, heightConstant: 30)
        
        btnFemale.addTarget(self, action: #selector(chooseFemaleTapped(_:)), for: .touchUpInside)
        
        view.addSubview(lbGenderFemale)
        lbGenderFemale.myCustomAnchor(top: nil, leading: btnFemale.trailingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: lbGender.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 60, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(btnSaveInfo)
        btnSaveInfo.myAnchorWithUIEdgeInsets(top: lbGender.bottomAnchor, leading: imgAvatar.leadingAnchor, bottom: nil, trailing: vNameCustomer.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 40))
        btnSaveInfo.addTarget(self, action: #selector(saveInfo(_:)), for: .touchUpInside)
        
    }
    
    func getNameCustomer(_ name: String) {
        lbNameCustomer.text = name
    }
    
    func getSenderID(_ id: String) {
        self.senderId = id
    }
    
    func getPhoneNumber(_ phoneNumber: String) {
        vPhoneNumberCustomer.tfInput.text = phoneNumber
    }
    
    func getNameInput(_ nameInput: String) {
        vNameCustomer.tfInput.text = nameInput
    }
    
    func getPhoneNumberInput(_ phoneNumber: String) {
        vPhoneNumberCustomer.tfInput.text = phoneNumber
        validDateInputPhoneNumber(phoneNumber)
    }
    
    private func validDateInputPhoneNumber(_ phoneNumberInput: String) {
        if phoneNumberInput.isValidPhoneNumber() {
            updateStateButton(true)
        } else {
            updateStateButton(false)
        }
        phoneNumber = phoneNumberInput
    }
    
    private func updateStateButton(_ state: Bool) {
        btnSaveInfo.isEnabled = state
        btnSaveInfo.backgroundColor = state ? Constants.COLORS.bold_green : Constants.COLORS.text_gray
    }
    
    func loadImgAvatar(_ url: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            getImageWithURL(urlImage: url, placeholderImage: UIImage.init(named: "ic_zalo"), imgView: self.imgAvatar, shouldCache: false, contentMode: .scaleAspectFit)
        }
    }
    
    func getCreateDate(_ date: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let dateConvert = Common.convertDateToStringWith(dateString: date, formatIn: "yyyy-MM-dd'T'HH:mm:ss.SS", formatOut: "dd/MM/yyyy HH:mm:ss")
            self.lbDateDescription.text = dateConvert
        }
        
    }
    
    @objc private func chooseMaleTapped(_ sender: UIButton?) {
        if let button = sender {
            btnMale.isSelected = !button.isSelected
            btnFemale.isSelected = false
            
            btnMale.setImage(UIImage.init(named: "checkedBox"), for: .selected)
            if btnMale.isSelected == true {
                gender = "Anh"
            } else {
                gender = ""
            }
        }
    }
    
    func getGender(_ gender: String) {
        self.gender = gender
        if gender == "Anh" {
            didCheckBoxGenderMale = true
        } else if gender == "Chị" {
            didCheckBoxGenderFemale = true
        } else {
            didCheckBoxGenderMale = false
            didCheckBoxGenderFemale = false
        }
    }
    
    private func checkBoxGenderFemale(_ state: Bool) {
        if state {
            btnFemale.isSelected = true
            btnFemale.setImage(UIImage.init(named: "checkedBox"), for: .selected)
        } else {
            btnFemale.isSelected = false
            btnFemale.setImage(UIImage.init(named: "uncheck"), for: .selected)
        }
    }
    
    private func checkBoxGenderMale(_ state: Bool) {
        if state {
            btnMale.isSelected = true
            btnMale.setImage(UIImage.init(named: "checkedBox"), for: .selected)
        } else {
            btnMale.isSelected = false
            btnMale.setImage(UIImage.init(named: "uncheck"), for: .selected)
        }
    }
    
    @objc private func chooseFemaleTapped(_ sender: UIButton?) {
        if let button = sender {
            btnFemale.isSelected = !button.isSelected
            btnMale.isSelected = false
            
            btnFemale.setImage(UIImage.init(named: "checkedBox"), for: .selected)
            if btnFemale.isSelected == true {
                gender = "Chị"
                
            } else {
                gender = ""
            }
        }
    }
    
    @objc private func saveInfo(_ sender: UIButton) {
        guard vNameCustomer.tfInput.text != "" else {
            showAlertOneButton(title: "Thông tin khách hàng", with: "Vui lòng nhập vào tên khách hàng", titleButton: "Đồng ý")
            return
        }
        
        guard gender != "" else {
            showAlertOneButton(title: "Thông tin khách hàng", with: "Vui lòng chọn giới tính", titleButton: "Đồng ý")
            return
        }
        
        guard senderId != "" else {
            showAlertOneButton(title: "Thông tin khách hàng", with: "Không có sender ID, vui lòng kiểm tra lại", titleButton: "Đồng ý")
            return
        }
        
        let params: [String:Any] = [
            "sender_id": senderId ?? "",
            "fullname": vNameCustomer.tfInput.text ?? "",
            "phonenumber": phoneNumber ?? "",
            "gender": gender
        ]
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            FollowZaloShopAPIManager.shared.update_info_customer_follow_zalo_shop(params, completion: {[weak self] (result) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if let response = result {
                        strongSelf.showAlertOneButton(title: "Thông báo thông tin khách hàng", with: response.messages, titleButton: "Đồng ý") {
                            for controller in (self?.navigationController!.viewControllers)! as Array {
                                if controller.isKind(of: ListCustomerFollowZaloShopScreen.self) {
                                    _ = strongSelf.navigationController?.popToViewController(controller, animated: true)
                                }
                            }
                            
                        }
                    }
                }
            }) { (error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.showAlertOneButton(title: "Thông báo thông tin khách hàng", with: error ?? "", titleButton: "Đồng ý", handleOk: nil)
                }
            }
        }
    }
    
}

extension InfoCustomerFollowZaloScreen: InputTextFieldViewDelegate {
    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == vPhoneNumberCustomer.tfInput {
            let strNew = (textField.text as NSString?)!.replacingCharacters(in: range, with: string).trimAllSpace()
            validDateInputPhoneNumber(strNew)
        }
        return true
    }
    
}
