//
//  CreateAddIPScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/8/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CreateAddIPScreen: BaseController {
    
    private var placeholderLabel: UILabel!
    
    let lblTitleInsertIP: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_14)
        label.text = "Nhập IP 3G:"
        return label
    }()
    
    let textFieldInsertIP: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.setBorder(color: Constants.COLORS.bg_gray_popup, borderWidth: 0.3, corner: 8)
        return textField
    }()
    
    let lblTitleDescribeTheRequest: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_14)
        label.text = "Mô tả yêu cầu:"
        return label
    }()
    
    let textViewDescribeTheRequest: UITextView = {
        let textView = UITextView()
        textView.setBorder(color: Constants.COLORS.bg_gray_popup, borderWidth: 0.3, corner: 8)
        return textView
    }()
    
    let btnSendRequest: UIButton = {
        let button = UIButton()
        button.setTitle("GỬI YÊU CẦU", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.COLORS.bold_green
        button.layer.cornerRadius = 8
        return button
    }()
    
    let lbInstructionGetIP: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        return label
    }()
    
    var iPValue: String?
    var contentResponse: String?
    
    override func setupViews() {
        super.setupViews()
        self.title = "TẠO YÊU CẦU ADD IP 3G"
        setupStackView()
        createPlaceholderForTextView()
    }
    
    fileprivate func setupStackView() {
        let heightTFInsertIP = textFieldInsertIP.heightAnchor.constraint(equalToConstant: 40)
        textFieldInsertIP.addConstraint(heightTFInsertIP)
        
        let stackViewInsertIP = UIStackView(arrangedSubviews: [lblTitleInsertIP, textFieldInsertIP])
        stackViewInsertIP.axis = .vertical
        stackViewInsertIP.alignment = .fill
        stackViewInsertIP.distribution = .fill
        stackViewInsertIP.spacing = 4
        
        textFieldInsertIP.delegate = self
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        textFieldInsertIP.leftView = paddingView
        textFieldInsertIP.leftViewMode = .always
        
        let heightTextViewDescribe = textViewDescribeTheRequest.heightAnchor.constraint(equalToConstant: 100)
        textViewDescribeTheRequest.addConstraint(heightTextViewDescribe)
        let stackViewDescribeTheRequest = UIStackView(arrangedSubviews: [lblTitleDescribeTheRequest, textViewDescribeTheRequest])
        stackViewDescribeTheRequest.axis = .vertical
        stackViewDescribeTheRequest.alignment = .fill
        stackViewDescribeTheRequest.distribution = .fill
        stackViewDescribeTheRequest.spacing = 4
        
        textViewDescribeTheRequest.delegate = self
        
        let mainStackViewContainer = UIStackView(arrangedSubviews: [stackViewInsertIP, stackViewDescribeTheRequest])
        mainStackViewContainer.axis = .vertical
        mainStackViewContainer.distribution = .fill
        mainStackViewContainer.spacing = 4
        
        self.view.addSubview(mainStackViewContainer)
        mainStackViewContainer.myCustomAnchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 8, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.view.addSubview(btnSendRequest)
        btnSendRequest.myCustomAnchor(top: mainStackViewContainer.bottomAnchor, leading: mainStackViewContainer.leadingAnchor, trailing: mainStackViewContainer.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 16, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 50)
        
        setupButtonEnable(false)
        
        setupNoted()
        
        btnSendRequest.addTarget(self, action: #selector(tapRequest(_:)), for: .touchUpInside)
        self.textFieldInsertIP.addTarget(self, action: #selector(typingIP(textField:)), for: .editingChanged)
    }
    
    private func setupNoted() {
        self.view.addSubview(lbInstructionGetIP)
        lbInstructionGetIP.myAnchorWithUIEdgeInsets(top: btnSendRequest.bottomAnchor, leading: btnSendRequest.leadingAnchor, bottom: nil, trailing: btnSendRequest.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        let tapLabelLink = UITapGestureRecognizer(target: self, action: #selector(CreateAddIPScreen.tapToLink(sender:)))
        
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)]
        
        let plainAttributedStringOne = NSMutableAttributedString(string: "* Hướng dẫn lấy IP: \n Anh/chị vui lòng kết nối wifi 3G mới của shop sau đó click vào link này: ", attributes: nil)
        let plainAttributedStringTwo = NSMutableAttributedString(string: "để lấy số IP public chính xác !!! \n", attributes: nil)
        let plainAttributedNoted = NSMutableAttributedString(string: "Lưu ý: ", attributes: boldAttribute)
        let plainAttributedNotedContent = NSMutableAttributedString(string: "nên dùng 3G Mobi - Vina - Viettel, không nên dùng Vietnammobile vì IP nhà mạng này nhảy liên tục phải add nhiều lần làm chậm quá trình xử lý công việc.", attributes: nil)
        let string = "https://www.whatismyip.com "
        let attributedLinkString = NSMutableAttributedString(string: string, attributes:[NSAttributedString.Key.link: URL(string: "https://www.whatismyip.com")!])
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedStringOne)
        fullAttributedString.append(attributedLinkString)
        fullAttributedString.append(plainAttributedStringTwo)
        fullAttributedString.append(plainAttributedNoted)
        fullAttributedString.append(plainAttributedNotedContent)
        
        lbInstructionGetIP.isUserInteractionEnabled = true
        lbInstructionGetIP.attributedText = fullAttributedString
        lbInstructionGetIP.addGestureRecognizer(tapLabelLink)
    }
    
    @objc private func tapRequest(_ button: UIButton) {
        guard iPValue != nil else {
            showPopUp("Bạn vui lòng nhập thông tin IPSHOP. ", "Thông báo", buttonTitle: "Đồng ý")
            return
        }
        
        let validateIP = verifyWholeIP(test: iPValue ?? "")
        if validateIP == false {
            showAlertOneButton(title: "Kiểm tra đúng định dạng IP mới cho tạo ticket", with: "Bạn vui lòng kiểm tra lại định dạng IP, IP đúng sẽ có định dạng ._._.!", titleButton: "Đồng ý")
            return
        }
        
        if iPValue == "0.0.0.0" {
            showAlertOneButton(title: "Kiểm tra đúng định dạng IP mới cho tạo ticket", with: "Không được nhập IP có định dạng 0.0.0.0, bạn vui lòng kiểm tra lại.", titleButton: "Đồng ý")
        }
        
        guard contentResponse != nil else {
            showPopUp("Bạn vui lòng nhập Mô tả lý do add IP.", "Thông báo", buttonTitle: "Đồng ý")
            return
            
        }
        createTicket()
    }
    
    @objc private func tapToLink(sender: UITapGestureRecognizer) {
        let urlString = URL(string: "https://www.whatismyip.com")!
        UIApplication.shared.open(urlString)
    }
    
    func createTicket() {
        let user = Cache.user
        guard let email = user?.Email else {return}
        //        guard let shopName = user?.ShopName else {return}
        guard let token = UserDefaults.standard.getMyInfoToken() else {return}
        //        guard let shopOfficeUservice = user?.shopOfficeUservice else {return}
        let emailAfterPlist = email.split{$0 == "@"}.map(String.init)
        let name = emailAfterPlist[0]
        let params: [String:Any] = [            
            "email": name,
            "token": token,
            "processKey": "AddIP3G",
            "title": "ADD IP 3G",
            "locationId": 5,
            "ticketOwner": name,
            "informedUsers": name,
            "values": "<item><line Name=\"NguoiYeuCau\" Value=\"\(name)\" /><line Name=\"NhapIP3G\" Value=\"\(iPValue ?? "")\" /><line Name=\"MoTaYeuCau\" Value=\"\(contentResponse ?? "")\" /></item>",
            "fromSystem": "mPOS"
        ]
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            UserviceAPIManager.shared.createTicketIPItem(params: params, completion: {[weak self] (msg) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    strongSelf.showPopUpCustom(title: "Thông báo", titleButtonOk: "Ok", titleButtonCancel: nil, message: msg, actionButtonOk: {
                        strongSelf.navigationController?.popViewController(animated: true)
                    }, actionButtonCancel: nil, isHideButtonOk: false, isHideButtonCancel: true)                }
            }) { [weak self](err) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    strongSelf.showAlertOneButton(title: "Thông báo", with: err, titleButton: "Đồng ý")
                }
            }
        }
        
    }
    
    @objc private func typingIP(textField: UITextField) {
        if let typeIP = textField.text {
            setupButtonEnable(!typeIP.isEmpty)
            self.iPValue = typeIP
            if iPValue?.count ?? 0 > 0 && contentResponse?.count ?? 0 > 0 {
                setupButtonEnable(true)
            } else {
                setupButtonEnable(false)
            }
        }
    }
    
    private func createPlaceholderForTextView() {
        placeholderLabel = UILabel()
        placeholderLabel.text = "Nhập mô tả"
        placeholderLabel.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_13)
        placeholderLabel.sizeToFit()
        textViewDescribeTheRequest.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 8, y: textViewDescribeTheRequest.font?.pointSize ?? 0 / 4)
        placeholderLabel.textColor = Constants.COLORS.text_gray
        placeholderLabel.isHidden = !textViewDescribeTheRequest.text.isEmpty
    }
    
    private func setupButtonEnable(_ state: Bool) {
        btnSendRequest.isEnabled = state
        btnSendRequest.backgroundColor = state ? Constants.COLORS.bold_green : Constants.COLORS.text_gray
    }
    
    func verifyWhileTyping(test: String) -> Bool {
        let pattern_1 = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])[.]){0,3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])?$"
        let regexText_1 = NSPredicate(format: "SELF MATCHES %@", pattern_1)
        let result_1 = regexText_1.evaluate(with: test)
        return result_1
    }
    
    func verifyWholeIP(test: String) -> Bool {
        let pattern_2 = "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})"
        let regexText_2 = NSPredicate(format: "SELF MATCHES %@", pattern_2)
        let result_2 = regexText_2.evaluate(with: test)
        return result_2
    }
    
}

extension CreateAddIPScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "," {
            textField.text = textField.text! + "."
            return false
        }
        return true
    }
    
}

extension CreateAddIPScreen: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        self.contentResponse = textView.text
        if iPValue?.count ?? 0 > 0 && contentResponse?.count ?? 0 > 0 {
            setupButtonEnable(true)
        } else {
            setupButtonEnable(false)
        }
    }
}

extension CreateAddIPScreen: PopAlerCreateIPScreenDelegate {
    func tappedOk() {
        self.navigationController?.popViewController(animated: true)
    }
}
