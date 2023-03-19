//
//  InstallLaptopViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 09/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
//import EPSignature
import AVFoundation
private let reuseIdentifier = "TermInstallLaptopCell"
class InstallAppleMobileViewController: UIViewController {
    var receiptID:Int = 0
    var checkButton = 0
    var cellHeigt:CGFloat = 600

    // MARK: - Properties
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        return scrollView
    }()
    private var viewTermInfo:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let titleInfoCustomer: UILabel = {
        let label = UILabel()
        label.text = "BÊN YÊU CẦU HỔ TRỢ(CUSTOMER)"
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        label.textColor = .mainGreen
        return label
    }()
    private let titleProductStatus: UILabel = {
        let label = UILabel()
        label.text = "SẢN PHẨM YÊU CẦU HỔ TRỢ(PRODUCT)"
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        label.textColor = .mainGreen
        return label
    }()
    private let titleStatusReport: UILabel = {
        let label = UILabel()
        label.text = "TÌNH TRẠNG SẢN PHẨM KHI BÊN YÊU CẦU HỔ TRỢ BÀN GIAO CHO BÊN NHẬN HỔ TRỢ"
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        label.textColor = .mainGreen
        label.numberOfLines = 2
        return label
    }()
	private let descriptionImeiLabel: UILabel = {
		let label = UILabel()
		label.text = "Bạn có thể cần thêm kí tự S trước Serial để tìm được thông tin mua hàng."
		label.font = UIFont.systemFont(ofSize: Common.Size(s: 11))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.sizeToFit()
		label.textColor = .red
		return label
	}()
    private let discriptionLabel2: UILabel = {
        let label = UILabel()
        label.text = "BÊN NHẬN YÊU CẦU HỔ TRỢ XÁC NHẬN VÀ ĐỒNG Ý VỚI CÁC NỘI DUNG DƯỚI ĐÂY(CUSTOMER HAS CONFIRMED AND AGREES TO THE TERMS BELLOW"
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        label.textColor = .mainGreen
        return label
    }()
    private let viewInfoCustomer:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let viewProductStatus: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let viewInfo: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let lbIMEI:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "IMEI/Serial")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfIMEI:UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        
        
        return tf
    }()
    private let lblSDT:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Số điện thoại(Phone no)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfSDT: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private let lblCustomerName:UILabel = {
        
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Họ và tên(Full name)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfCustomerName: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private let lblProduct:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Tên Sản phẩm(Name of Product)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfProduct: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private let lblColor:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Màu sắc(Color)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfColor: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private let lblAppearance:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Hình thức bên ngoài(Appearance)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    
    private var tfAppearance: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private let lblErrorReport:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Mô tả lỗi hiện tại(Describe the current status)")
        label.AutoScaleHeightForLabel()
        
        label.AutoScaleHeightForLabel()
        
        return label
    }()
    private var tfErrorReport: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    
    private let lblMemory:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Dung lượng bộ nhớ  (Internal Storage)")
        return label
    }()
    private var tfMemory: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private let lblMemoryCard:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Dung lượng thẻ nhớ (nếu có)(External Storage, if any")
        label.AutoScaleHeightForLabel()
        
        return label
    }()
    private let supportContentLabel:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Nội dung cần hỗ trợ")
        return label
    }()
    private var tfSupportContent: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private var tfMemoryCard: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private let lblMoreInfo:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Thông tin thêm nếu có")
        return label
    }()
    private var tfMoreInfo: UITextView = {
        let tv = UITextView(frame: CGRect(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight * 2))
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tv.layer.borderWidth = 0.5
        tv.layer.borderColor = borderColor.cgColor
        tv.layer.cornerRadius = 5.0
        return tv
    }()
    private let viewSign: UIView = {
        let viewImageSign = UIView(frame: CGRect(x:0, y: 0 , width: Common.standardWidth, height: Common.Size(s:150)))
        viewImageSign.layer.borderWidth = 0.5
        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSign.layer.cornerRadius = 3.0
        viewImageSign.backgroundColor = .white
        
        
        
        
        
        
        return viewImageSign
    }()
    
    private var viewSignButton: UIImageView!
    private lazy var btSave:UIButton = {
        let btInphieu = UIButton()
        btInphieu.backgroundColor = .mainGreen
        btInphieu.setTitle("LƯU", for: .normal)
        btInphieu.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        btInphieu.layer.borderWidth = 0.5
        btInphieu.layer.borderColor = UIColor.white.cgColor
        btInphieu.layer.cornerRadius = 3
        btInphieu.layer.cornerRadius = Common.standardHeight / 2
        
        btInphieu.clipsToBounds = true
        return btInphieu
    }()
    private lazy var btResendOTP:UIButton = {
        let btInphieu = UIButton()
        btInphieu.backgroundColor = .mainGreen
        btInphieu.setTitle("GỬI LẠI OTP", for: .normal)
        btInphieu.addTarget(self, action: #selector(handleResendOTP), for: .touchUpInside)
        btInphieu.layer.borderWidth = 0.5
        btInphieu.layer.borderColor = UIColor.white.cgColor
        btInphieu.layer.cornerRadius = Common.standardHeight / 2
        btInphieu.clipsToBounds = true
        
        return btInphieu
    }()
    private lazy var btConfirm:UIButton = {
        let btInphieu = UIButton()
        btInphieu.backgroundColor = .mainGreen
        btInphieu.setTitle("XÁC NHẬN", for: .normal)
        btInphieu.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
        btInphieu.layer.borderWidth = 0.5
        btInphieu.layer.borderColor = UIColor.white.cgColor
        btInphieu.layer.cornerRadius = Common.standardHeight / 2
        btInphieu.clipsToBounds = true
        return btInphieu
    }()
    private lazy var btDone:UIButton = {
        let btInphieu = UIButton()
        btInphieu.backgroundColor = .mainGreen
        btInphieu.setTitle("HOÀN TẤT", for: .normal)
        btInphieu.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        btInphieu.layer.borderWidth = 0.5
        btInphieu.layer.borderColor = UIColor.white.cgColor
        btInphieu.layer.cornerRadius = Common.standardHeight / 2
        btInphieu.clipsToBounds = true
        return btInphieu
    }()
    
    var masterDataInstallLaptop: MasterDataInstallLaptop?{
        didSet {
            configureViewModel()
        }
    }
    private var lstTerms = [ItemDataInstallLaptop](){
        didSet { viewTermInfo.reloadData() }
    }
    private var cellHeight:CGFloat = 0
    private var lstImei = [Checkimei_V2Result](){
        didSet { configureDataImei() }
    }
    private var viewModel:InstallRecordsViewModel!
    private var isSign:Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchReceiptMasterDataInstallLaptopAPI()
        
//
//                tfIMEI.text = "abc"
//                tfSDT.text = "0905100936"
//                tfCustomerName.text = "abc"
//                tfProduct.text = "abc"
//                tfColor.text = "red"
//                tfErrorReport.text = "abc"
//                tfMemory.text = "abc"
//                tfSupportContent.text = "abc"
//                tfMemoryCard.text = "abc"
//                tfAppearance.text = "abc"

        
    }
    
    // MARK: - API
    func sendOTPForCustomer(receiptID:Int,isShowError : Bool, completion: @escaping (() -> Void)) {
        //API guiwr OPT
        
        
        MPOSAPIMangerV2.shared.sendOTPForCustomer(receiptId: receiptID) {[weak self] result in
            guard let self = self else {return}
            
            
            switch result {
            case .success(let data):
                if isShowError {
                    self.showPopUp(data.Message, "Thông báo", buttonTitle: "OK")
                }
                if data.success {
                    let popup = PopupVC()
                    popup.onOKAction = {
                        completion()
//                        self.configureButtonConfirm()
                        self.viewSignButton.isUserInteractionEnabled = false
                    }
                    popup.onCloseAction = {
                        completion()
//                        self.configureButtonConfirm()
                    }
                    popup.dataPopup.content = "\(data.Message)"
                    popup.dataPopup.titleButton = "XÁC NHẬN"
                    popup.dataPopup.isShowClose = true
                    popup.modalPresentationStyle = .overCurrentContext
                    popup.modalTransitionStyle = .crossDissolve
                    self.present(popup, animated: true, completion: nil)
                    
                    if isShowError {
                        self.showPopUp(data.Message, "Thông báo", buttonTitle: "OK")
                    }
                    
                    
                }else {
                    self.showPopUp(data.Message, "Thông báo", buttonTitle: "OK")
                }
            case .failure(let error):
                self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                
            }
            
            
        }
        
    }
    func sendOTPForCustomer1(receiptID:Int) {
        //API guiwr OPT
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) { [self] in

        MPOSAPIMangerV2.shared.sendOTPForCustomer(receiptId: receiptID) {[weak self] result in
            guard let self = self else {return}
            WaitingNetworkResponseAlert.DismissWaitingAlert {

            switch result {
            case .success(let data):
                 if data.success {
                   
                    self.showPopUp(data.Message, "Thông báo", buttonTitle: "OK")
                }else {
                    self.showPopUp(data.Message, "Thông báo", buttonTitle: "OK")
                }
                
            case .failure(let error):
                self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                
            }
            }
        }
        
    }
    }
    func confirmOTPReceipt(receiptID:Int,customerOTP:String,completion: @escaping (() -> Void)) {
        if customerOTP == "" {
            self.showPopUp("Vui lòng nhập OTP", "Thông báo", buttonTitle: "OK")
            
        }else {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) { [self] in
                MPOSAPIMangerV2.shared.confirmOTPReceipt(receiptId: receiptID,customerOTP: customerOTP) {[weak self] result in
                    guard let self = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        
                        switch result {
                        case .success(let data):
                            if data.success {
                                print("thanhf co")
                                self.configureButtonDone1()
                                checkButton = 1
                                btSave.isHidden = true
                                btConfirm.isHidden = true
                                btResendOTP.isHidden = true
                                self.viewSignButton.isUserInteractionEnabled = true
                                

                            }
                            else {
                                self.showPopUp(data.Message, "Thông báo", buttonTitle: "OK")
                                
                            }
                            
                        case .failure(let error):
                            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                            
                        }
                    }
                }
            }
            
        }
    }
    
    func fetchCreateInstallationReceipt(){
        
        guard let imei = tfIMEI.text, !imei.isEmpty else {
            showPopUp("Vui lòng nhập IMEI !", "Thông báo", buttonTitle: "OK")
            return
            
        }
        guard let phone = tfSDT.text, !phone.isEmpty else {
            showPopUp("Vui lòng nhập SĐT", "Thông báo", buttonTitle: "OK")
            return
        }
        if (phone.count != 10) || (phone.hasPrefix("00")){
            showPopUp("Số điện thoại không hợp lệ", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let customerName = tfCustomerName.text, !customerName.isEmpty else {
            showPopUp("Vui lòng nhập tên KH", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let product = tfProduct.text, !product.isEmpty else {
            showPopUp("Vui lòng nhập tên sản phẩm", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let color = tfColor.text, !color.isEmpty else {
            showPopUp("Vui lòng nhập màu sản phẩm", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let memory = tfMemory.text, !memory.isEmpty else {
            showPopUp("Vui lòng chọn dung lượng bộ nhớ", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let supportContent = tfSupportContent.text, !supportContent.isEmpty && supportContent.count <= 45 else {
            showPopUp("Vui lòng nhập nội dung cần hổ trợ(tối đa 45 ký tự)", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let appearance = tfAppearance.text, !appearance.isEmpty else {
            showPopUp("Vui lòng chọn hình thức bên ngoài", "Thông báo", buttonTitle: "OK")
            return
        }
        
        guard let errorReport = tfErrorReport.text, !errorReport.isEmpty else {
            showPopUp("Vui lòng nhập mô tả lỗi hiện tại", "Thông báo", buttonTitle: "OK")
            return
        }
        
        guard let note = tfErrorReport  .text else {
            return
        }
        
        
        if isSign == false {
            
            self.showPopUp("Chưa có chữ ký khách hàng", "Thông báo", buttonTitle: "OK")
            return
        }
        
        let imageSign:UIImage = self.resizeImage(image: viewSignButton.image!,newHeight: 500)!
        if let imageDataChuKy:NSData = imageSign.pngData() as NSData?{
            let srtBase64ChuKy = imageDataChuKy.base64EncodedString(options: .endLineWithLineFeed)
            viewModel.getParamListData()
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) { [self] in
                
                MPOSAPIMangerV2.shared.createInstallationReceipt(Imei: imei,
                                                                 ItemName: product,
                                                                 DeviceColor: color,
                                                                 PhoneNumber: phone,
                                                                 CustFullname: customerName,
                                                                 Note: note,
                                                                 SignatureBase64: srtBase64ChuKy,
                                                                 ServiceType:1,
                                                                 MasterDataIdList: self.viewModel.lstParamChoose.joined(separator: ","),
                                                                 CurrentStatus:errorReport,
                                                                 BitLockerStatus: false,
                                                                 Problem: supportContent,   discriptionFail: ""
                                                                
                ) {[weak self] result in
                    guard let self = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        switch result {
                        case .success(let data):
                            if data.success == false || data.data.pStatus != 0{
                                self.showPopUp(data.data.pMessagess, "Thông báo", buttonTitle: "OK")
                            }
                            else if data.success == true && data.data.pStatus == 0 {
                                self.receiptID = data.data.receiptId!
                                sendOTPForCustomer(receiptID: receiptID, isShowError: false, completion: {

                                })
                                btSave.isHidden = true
                                configureButtonResendOTPandConfirm()
                                
                            }
                        case .failure(let error):
                            viewModel.lstParamChoose.removeAll()
                            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                            
                        }
                    }
                }
            }
            
        }
        
        
        
        
    }
    
    func fetchReceiptMasterDataInstallLaptopAPI(){
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            MPOSAPIMangerV2.shared.fetchReceiptMasterDataInstallLaptop(serviceType: 1) {[weak self] result in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    switch result {
                    case .success(let data):
                        if data.success {
                            self.masterDataInstallLaptop = data
                            
                            
                        }
                        
                    case .failure(let error):
                        self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                        
                    }
                }
            }
        }
    }
    
    func fetchIMEI(with imei: String){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Checkimei_V2(p_Imei: imei,p_BILL: "",p_SO_DocNum: "",p_PhoneNumber: "",p_Type: "0"){[weak self] (error: Error? , success: Bool,result: [Checkimei_V2Result]!,result2:Checkimei_V2_ImeiInfoServices_Result!,result3: [Checkimei_V2_LoadHTBH_Result]!) in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success{
                        if(result != nil && result.count > 0 ){
                            
                            self.lstImei = result
                            
                        }
                    }
                }
                
            }
        }
        
        
    }
    
    // MARK: - Selectors
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let imei = tfIMEI.text else {return}
        fetchIMEI(with: imei)
    }
    
    @objc func handleShowScanBarcode(){
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.fetchIMEI(with: code)
            self.tfIMEI.text = code
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    @objc func handleShowAppearance(){
        pushScreenItem(list: viewModel.lstAppearanceMobile,config: .appearancemobile)
    }
    
    @objc func handleShowMemory(){
        pushScreenItem(list: viewModel.lstMemory, config: .memory)
    }
    @objc func handleShowMemoryCard(){
        pushScreenItem(list: viewModel.lstMemoryCard, config: .memorycard)
    }
    
    
    @objc func tapShowSign(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
        
        self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    @objc func handleSave(){
        
        fetchCreateInstallationReceipt()
    }
    @objc func handleResendOTP(){
        sendOTPForCustomer1(receiptID:receiptID)
        
        
    }
    @objc func handleConfirm(){
        
        let popup = PopupInputOTP()
        popup.onOKAction = {
            self.confirmOTPReceipt(receiptID: self.receiptID, customerOTP: popup.inputTxt.text ?? "0", completion: {
            })
            
        }
        popup.onResendOTP =  {
            self.sendOTPForCustomer(receiptID: self.receiptID, isShowError: true, completion: {})
            
        }
        
        //        popup.dataPopup.content = "\(data.Message)"
        popup.modalPresentationStyle = .overCurrentContext
        
        popup.modalTransitionStyle = .crossDissolve
        self.present(popup, animated: true, completion: nil)
    }
    
    @objc func handleDone(){
        
        let imageSign:UIImage = self.resizeImage(image: viewSignButton.image!,newHeight: 500)!
        if let imageDataChuKy:NSData = imageSign.pngData() as NSData?{
            let srtBase64ChuKy = imageDataChuKy.base64EncodedString(options: .endLineWithLineFeed)
            let popup = PopUPDoneReceipt()
            
            popup.onOKAction = {
                
                WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) { [self] in
                    
                    MPOSAPIMangerV2.shared.returnDeviceReceipt(receiptId: self.receiptID,signatureBase64: srtBase64ChuKy) {[weak self] result in
                        guard let self = self else {return}
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            switch result {
                            case .success(let data):
                                if data.success {
                                    
                                    
                                    let alert = UIAlertController(title: "Thông báo", message: data.Message, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                        _ = self.navigationController?.popToRootViewController(animated: true)
                                        self.dismiss(animated: true, completion: nil)
                                        
                                    })
                                    self.present(alert, animated: true)
                                }else {
                                    self.showPopUp(data.Message, "Thông báo", buttonTitle: "OK")

                                }
                                
                            case .failure(let error):
                                self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                                
                            }
                        }
                    }
                    
                    
                }
            }
            popup.receiptID = receiptID
            self.navigationController?.pushViewController(popup, animated: true)
            
        }
    }
    // MARK: - Helpers
    
    func configureUI(){
        title = "Cài đặt Apple/Mobile"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.setDimensions(width: view.frame.size.width, height: view.frame.size.height)
        scrollView.addSubview(titleInfoCustomer)
        titleInfoCustomer.frame = CGRect(origin: CGPoint(x: Common.standardPaddingLeft, y: Common.Size(s: 5)), size: CGSize(width: Common.standardWidth, height: Common.Size(s: 35)))
        scrollView.addSubview(viewInfoCustomer)
        viewInfoCustomer.frame = CGRect(x: 0, y: titleInfoCustomer.frame.origin.y + titleInfoCustomer.frame.size.height , width: view.frame.size.width, height: 200)
        
        viewInfoCustomer.addSubview(lblCustomerName)
        lblCustomerName.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: Common.standardPaddingTop)
        viewInfoCustomer.addSubview(tfCustomerName)
        tfCustomerName.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblCustomerName.frame.size.height + lblCustomerName.frame.origin.y + Common.standardPaddingTop)
        //        ok
        viewInfoCustomer.addSubview(lblSDT)
        lblSDT.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfCustomerName.frame.size.height + tfCustomerName.frame.origin.y + Common.standardPaddingTop)
        viewInfoCustomer.addSubview(tfSDT)
        tfSDT.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblSDT.frame.size.height + lblSDT.frame.origin.y + Common.standardPaddingTop)
        scrollView.addSubview(titleProductStatus)
        titleProductStatus.frame = CGRect(x: Common.standardPaddingLeft, y: tfSDT.frame.size.height + tfSDT.frame.origin.y + Common.Size(s: 35) , width: Common.standardWidth, height: Common.Size(s: 35))
        
        //oke
        scrollView.addSubview(viewProductStatus)
        viewProductStatus.frame = CGRect(x: 0, y: titleProductStatus.frame.size.height + titleProductStatus.frame.origin.y , width: view.frame.size.width, height: 100
        )
        
        
        viewProductStatus.addSubview(lblProduct)
        lblProduct.frame.origin =   CGPoint(x: Common.standardPaddingLeft, y: Common.standardPaddingTop)
        
        viewProductStatus.addSubview(tfProduct)
        tfProduct.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblProduct.frame.size.height + lblProduct.frame.origin.y + Common.standardPaddingTop)
        
        viewProductStatus.addSubview(lblMemory)
        
        lblMemory.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfProduct.frame.size.height + tfProduct.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfMemory)
        tfMemory.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblMemory.frame.size.height + lblMemory.frame.origin.y + Common.standardPaddingTop)
        let viewFocusRam = UIView(frame: tfMemory.frame);
        viewProductStatus.addSubview(viewFocusRam)
        let gestureRam = UITapGestureRecognizer(target: self, action:  #selector(handleShowMemory))
        viewFocusRam.addGestureRecognizer(gestureRam)
        
        viewProductStatus.addSubview(lblMemoryCard)
        lblMemoryCard.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfMemory.frame.size.height + tfMemory.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfMemoryCard)
        tfMemoryCard.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblMemoryCard.frame.size.height + lblMemoryCard.frame.origin.y + Common.standardPaddingTop)
        let viewFocusStorage = UIView(frame: tfMemoryCard.frame);
        viewProductStatus.addSubview(viewFocusStorage)
        let gestureStorage = UITapGestureRecognizer(target: self, action:  #selector(handleShowMemoryCard))
        viewFocusStorage.addGestureRecognizer(gestureStorage)
        
        viewProductStatus.addSubview(lbIMEI)
        lbIMEI.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfMemoryCard.frame.size.height + tfMemoryCard.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfIMEI)
        tfIMEI.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lbIMEI.frame.size.height + lbIMEI.frame.origin.y + Common.standardPaddingTop)
        tfIMEI.rightViewMode = UITextField.ViewMode.always
        
        
        
        
        let imageImei = UIImageView(frame: CGRect(x: tfIMEI.frame.size.height/4, y: tfIMEI.frame.size.height/4, width: tfIMEI.frame.size.height/2, height: tfIMEI.frame.size.height/2))
        imageImei.image = #imageLiteral(resourceName: "barcode-1")
        imageImei.contentMode = UIView.ContentMode.scaleAspectFit
        let rightViewImei = UIView()
        rightViewImei.addSubview(imageImei)
        rightViewImei.frame = CGRect(x: 0, y: 0, width: tfIMEI.frame.size.height, height: tfIMEI.frame.size.height)
        tfIMEI.rightView = rightViewImei
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(handleShowScanBarcode))
        imageImei.isUserInteractionEnabled = true
        imageImei.addGestureRecognizer(tapScan)
        tfIMEI.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
		viewProductStatus.addSubview(descriptionImeiLabel)
		descriptionImeiLabel.frame = CGRect(x: Common.standardPaddingLeft, y: tfIMEI.frame.size.height + tfIMEI.frame.origin.y , width: Common.standardWidth, height: Common.Size(s: 35))

        viewProductStatus.addSubview(lblColor)
        lblColor.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: descriptionImeiLabel.frame.size.height + descriptionImeiLabel.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfColor)
        tfColor.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblColor.frame.size.height + lblColor.frame.origin.y + Common.standardPaddingTop)
        
        viewProductStatus.addSubview(supportContentLabel)
        supportContentLabel.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfColor.frame.size.height + tfColor.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfSupportContent)
        tfSupportContent.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: supportContentLabel.frame.size.height + supportContentLabel.frame.origin.y + Common.standardPaddingTop)
        
        
        viewProductStatus.addSubview(titleStatusReport)
        
        titleStatusReport.frame = CGRect(x: Common.standardPaddingLeft, y: tfSupportContent.frame.size.height + tfSupportContent.frame.origin.y + Common.Size(s: 5) , width: Common.standardWidth, height: Common.Size(s: 35))
        
        
        viewProductStatus.addSubview(lblAppearance)
        lblAppearance.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: titleStatusReport.frame.size.height + titleStatusReport.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfAppearance)
        tfAppearance.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblAppearance.frame.size.height + lblAppearance.frame.origin.y + Common.standardPaddingTop)
        let viewFocusAppearance = UIView(frame: tfAppearance.frame);
        viewProductStatus.addSubview(viewFocusAppearance)
        let gestureTransactionType = UITapGestureRecognizer(target: self, action:  #selector(self.handleShowAppearance))
        viewFocusAppearance.addGestureRecognizer(gestureTransactionType)
        viewProductStatus.addSubview(lblErrorReport)
        lblErrorReport.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfAppearance.frame.size.height + tfAppearance.frame.origin.y + Common.standardPaddingTop)
          viewProductStatus.addSubview(tfErrorReport)
        tfErrorReport.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblErrorReport.frame.size.height + lblErrorReport.frame.origin.y + Common.standardPaddingTop)
          viewProductStatus.addSubview(viewTermInfo)
        viewTermInfo.frame = CGRect(x: Common.standardPaddingLeft, y: tfErrorReport.frame.size.height + tfErrorReport.frame.origin.y + Common.standardPaddingTop, width: view.frame.size.width, height: 300)
        viewTermInfo.dataSource = self
        viewTermInfo.delegate = self
        viewTermInfo.register(TermInstallLaptopCell.self, forCellReuseIdentifier: reuseIdentifier)
        viewTermInfo.tableFooterView = UIView()
         viewProductStatus.addSubview(viewInfo)
        configureViewInfo()
        viewProductStatus.addSubview(viewSign)
        viewSign.frame = CGRect(x: Common.standardPaddingLeft, y: viewInfo.frame.origin.y + viewInfo.frame.size.height , width: Common.standardWidth, height: Common.Size(s:150))
        
        viewSignButton =  UIImageView(frame: CGRect(x:Common.Size(s: 15), y:  Common.Size(s:5), width: Common.standardWidth - Common.Size(s:30), height: (Common.standardWidth) / 2.6))
        viewSignButton.image = #imageLiteral(resourceName: "Chuky")
        viewSignButton.contentMode = .scaleAspectFit
        viewSignButton.tag = 1
        viewSign.addSubview(viewSignButton)
        let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(tapShowSign))
        viewSignButton.isUserInteractionEnabled = true
        viewSignButton.addGestureRecognizer(tapShowSignature)
        configureButtonView()
        
    }
    
    func configureButtonView(){
        viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop
        scrollView.addSubview(btSave)
        btSave.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btSave.frame.size.height + btSave.frame.origin.y + Common.Size(s: 100))
    }
    func configureButtonConfirm(){
        viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop
        scrollView.addSubview(btConfirm)
        btConfirm.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s: 100))
    }
    func configureButtonResendOTPandConfirm(){
        viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop
        scrollView.addSubview(btResendOTP)
        btResendOTP.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        scrollView.addSubview(btConfirm)

        btConfirm.frame = CGRect(x: Common.standardPaddingLeft, y: btResendOTP.frame.origin.y + btResendOTP.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s: 100))
    }
    func configureButtonDone(){
        viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop
        scrollView.addSubview(btDone)
        btDone.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btDone.frame.size.height + btDone.frame.origin.y + Common.Size(s: 100))
    }
    
    func configureButtonDone1(){
        viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop
        scrollView.addSubview(btDone)
        btDone.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btDone.frame.size.height + btDone.frame.origin.y + Common.Size(s: 100))
    }
    
    func configureViewInfo(){
        
        let widthInfo = Common.standardWidth
        let standardPaddingTopInfo = Common.Size(s: 5)
        viewInfo.frame = CGRect(x: Common.standardPaddingLeft, y: viewTermInfo.frame.size.height + viewTermInfo.frame.origin.y + Common.Size(s: 10), width: Common.standardWidth, height: 0)
        let imageCheck1 = UIImageView(frame: CGRect(x: Common.standardPaddingLeft - 15, y: 0, width: 20 , height: 20))
        imageCheck1.image = #imageLiteral(resourceName: "checked")
        imageCheck1.contentMode = UIView.ContentMode.scaleAspectFit
        viewInfo.addSubview(imageCheck1)
        
        let lbTitle1 = UILabel(frame: CGRect(x: imageCheck1.frame.origin.x + imageCheck1.frame.size.width + Common.standardPaddingLeft , y: standardPaddingTopInfo, width: widthInfo, height: Common.Size(s:14)))
        lbTitle1.textAlignment = .left
        lbTitle1.textColor = UIColor.black
        lbTitle1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitle1.text = "7Zip (Nén và giải nén)"
        lbTitle1.numberOfLines = 0
        lbTitle1.lineBreakMode = .byWordWrapping
        lbTitle1.sizeToFit()
        viewInfo.addSubview(lbTitle1)
        
        let imageCheck2 = UIImageView(frame: CGRect(x: Common.standardPaddingLeft - 15  , y: imageCheck1.frame.size.height+imageCheck1.frame.origin.y + Common.Size(s: 15), width: 20, height: 20))
        imageCheck2.image = #imageLiteral(resourceName: "checked")
        imageCheck2.contentMode = UIView.ContentMode.scaleAspectFit
        viewInfo.addSubview(imageCheck2)
        
        let lbTitle2 = UILabel(frame: CGRect(x: lbTitle1.frame.origin.x   , y: imageCheck1.frame.size.height+imageCheck1.frame.origin.y + Common.Size(s: 15), width: widthInfo - 40, height: Common.Size(s:14)))
        lbTitle2.textAlignment = .left
        lbTitle2.textColor = UIColor.black
        lbTitle2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitle2.text = "Foxit Reader (Đọc file PDF)"
        lbTitle2.AutoScaleHeightForLabel()
        viewInfo.addSubview(lbTitle2)
        let imageCheck3 = UIImageView(frame: CGRect(x: Common.standardPaddingLeft - 15  , y: lbTitle2.frame.size.height + lbTitle2.frame.origin.y + Common.Size(s: 15), width: 20, height: 20))
        imageCheck3.image = #imageLiteral(resourceName: "checked")
        imageCheck3.contentMode = UIView.ContentMode.scaleAspectFit
        viewInfo.addSubview(imageCheck3)
        
        let lbTitle3 =  UILabel(frame: CGRect(x: lbTitle2.frame.origin.x   , y: lbTitle2.frame.size.height+lbTitle2.frame.origin.y + Common.Size(s: 15), width: widthInfo - 40, height: Common.Size(s:14)))
        lbTitle3.textAlignment = .left
        lbTitle3.textColor = UIColor.black
        lbTitle3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitle3.text = "Ultraview (Phần mềm giúp Khách hàng sử dụng dịch vụ hổ trợ kỷ thuật từ xa của FPTSHOP)"
        lbTitle3.AutoScaleHeightForLabel()
        viewInfo.addSubview(lbTitle3)
        
        
        let imageCheck4 = UIImageView(frame: CGRect(x: Common.standardPaddingLeft - 15  , y: lbTitle3.frame.size.height + lbTitle3.frame.origin.y + Common.Size(s: 15), width: 20, height: 20))
        imageCheck4.image = #imageLiteral(resourceName: "checked")
        imageCheck4.contentMode = UIView.ContentMode.scaleAspectFit
        viewInfo.addSubview(imageCheck4)
        
        let lbTitle4 = UILabel(frame: CGRect(x: lbTitle3.frame.origin.x   , y: lbTitle3.frame.size.height+lbTitle3.frame.origin.y + Common.Size(s: 15), width: widthInfo - 40, height: Common.Size(s:14)))
        lbTitle4.textAlignment = .left
        lbTitle4.textColor = UIColor.black
        lbTitle4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitle4.text = "Google Chorme (Trình duyệt web)"
        lbTitle4.AutoScaleHeightForLabel()
        
        viewInfo.addSubview(lbTitle4)
        let imageCheck5 = UIImageView(frame: CGRect(x: Common.standardPaddingLeft - 15  , y: lbTitle4.frame.size.height + lbTitle4.frame.origin.y + Common.Size(s: 15), width: 20, height: 20))
        imageCheck5.image = #imageLiteral(resourceName: "checked")
        imageCheck5.contentMode = UIView.ContentMode.scaleAspectFit
        viewInfo.addSubview(imageCheck5)
        
        let lbTitle5 = UILabel(frame: CGRect(x: lbTitle4.frame.origin.x   , y: lbTitle4.frame.size.height+lbTitle4.frame.origin.y + Common.Size(s: 15), width: widthInfo - 40, height: Common.Size(s:14)))
        lbTitle5.textAlignment = .left
        lbTitle5.textColor = UIColor.black
        lbTitle5.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitle5.text = "Zalo/Viber (Phần mềm chat)"
        lbTitle5.AutoScaleHeightForLabel()
        
        viewInfo.addSubview(lbTitle5)
        
        
        let imageCheck6 = UIImageView(frame: CGRect(x: Common.standardPaddingLeft - 15  , y: lbTitle5.frame.size.height + lbTitle5.frame.origin.y + Common.Size(s: 15), width: 20, height: 20))
        imageCheck6.image = #imageLiteral(resourceName: "checked")
        imageCheck6.contentMode = UIView.ContentMode.scaleAspectFit
        viewInfo.addSubview(imageCheck6)
        
        let lbTitle6 = UILabel(frame: CGRect(x: lbTitle4.frame.origin.x   , y: lbTitle5.frame.size.height+lbTitle5.frame.origin.y + Common.Size(s: 15), width: widthInfo - 40, height: Common.Size(s:14)))
        lbTitle6.textAlignment = .left
        lbTitle6.textColor = UIColor.black
        lbTitle6.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitle6.text = "Font ABC (Phông chữ Tiếng Việt)"
        lbTitle6.AutoScaleHeightForLabel()
        
        viewInfo.addSubview(lbTitle6)
        
        let imageCheck7 = UIImageView(frame: CGRect(x: Common.standardPaddingLeft - 15  , y: lbTitle6.frame.size.height + lbTitle6.frame.origin.y + Common.Size(s: 15), width: 20, height: 20))
        imageCheck7.image = #imageLiteral(resourceName: "checked")
        imageCheck7.contentMode = UIView.ContentMode.scaleAspectFit
        viewInfo.addSubview(imageCheck7)
        
        let lbTitle7 = UILabel(frame: CGRect(x: lbTitle4.frame.origin.x   , y: lbTitle6.frame.size.height+lbTitle6.frame.origin.y + Common.Size(s: 15), width: widthInfo - 40, height: Common.Size(s:14)))
        lbTitle7.textAlignment = .left
        lbTitle7.textColor = UIColor.black
        lbTitle7.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitle7.text = "Unikey (Gõ Tiếng Việt)"
        lbTitle7.AutoScaleHeightForLabel()
        
        viewInfo.addSubview(lbTitle7)
        
        viewInfo.frame.size.height = lbTitle7.frame.size.height + lbTitle7.frame.origin.y + Common.Size(s: 10)
    }
    
    func configureDataImei(){
        if lstImei.count > 0 {
            //tfIMEI.text = lstImei[0].imei
            if lstImei[0].SoDienThoai != "" {
                tfSDT.text = lstImei[0].SoDienThoai
                tfCustomerName.text = lstImei[0].TenKH
                tfProduct.text = lstImei[0].TenSanPham
            }
         }
        
    }
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    func configureViewModel(){
        guard let masterDataInstallLaptop = masterDataInstallLaptop else {return}
        viewModel = InstallRecordsViewModel(masterData: masterDataInstallLaptop)
        self.lstTerms = viewModel!.lstTerm
    }
    
    func pushScreenItem(list:[ItemDataInstallLaptop],config: DataInstallLaptopConfiguration){
        let controller = ItemDataInstallLaptopMobileViewController(items: list, config: config)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true, completion: nil)
    }
    
    
    
}

// MARK: - UITableViewDataSource

extension InstallAppleMobileViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstTerms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TermInstallLaptopCell
        cell.itemDataInstallLaptop = lstTerms[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightcell = 0.01 * UIScreen.main.bounds.height
        if indexPath.row == 0 {
            return heightcell * 30
        }
        if indexPath.row == 1 {
            return heightcell * 32
        }
        if indexPath.row == 2{
            return heightcell *  14
        }
       
        if indexPath.row == 3{
            return heightcell * 20
        }
        if indexPath.row == 4{
            return heightcell * 19
        }
        if indexPath.row == 5{
            return heightcell * 16
        }
        else {
            return heightcell * 32
            
        }

    }
   
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        let item = lstTerms[indexPath.row]
    //        if let row = lstTerms.firstIndex(where: {$0.id == item.id}) {
    //            lstTerms[row].isSelected = lstTerms[row].isSelected == true ? false : true
    //        }
    //
    //    }
    
}
// MARK: - EPSignatureDelegate
extension InstallAppleMobileViewController:EPSignatureDelegate {
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        
        let width = viewSign.frame.size.width - Common.Size(s:10)
        isSign = true
        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        let heightImage:CGFloat = width / sca
        
        viewSign.subviews.forEach { $0.removeFromSuperview() }
        viewSignButton  = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: width, height: heightImage))
        //        imgViewSignature.backgroundColor = .red
        viewSignButton.contentMode = .scaleAspectFit
        viewSign.addSubview(viewSignButton)
        viewSignButton.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        viewSign.frame.size.height = viewSignButton.frame.size.height + viewSignButton.frame.origin.y + Common.Size(s:5)
        reSignatureSignn()
        configureButtonView()
        if checkButton == 1 {
            configureButtonDone()
            btSave.isHidden = true
        }
        

        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func reSignatureSignn(){
        
        let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(tapShowSign))
        viewSignButton.isUserInteractionEnabled = true
        viewSignButton.addGestureRecognizer(tapShowSignature)
    }
}
// MARK: - ItemDataInstallLaptopMobileDelegate
extension InstallAppleMobileViewController: ItemDataInstallLaptopMobileDelegate{
    func handleChooseItem(_ config: DataInstallLaptopConfiguration, _ itemsDataInstallLaptop: [ItemDataInstallLaptop]) {
        let itemsDataFilter = itemsDataInstallLaptop.filter {  item in
            return item.isSelected == true
        }
        let lstTitle = itemsDataFilter.map {
            $0.name
        }
        //        itemsDataInstallLaptop.forEach { item in
        //            viewModel.lstParamChoose.append("\(item.id)")
        //        }
        switch config {
            
        case .appearance:
            
            break
        case .charge:
            break
        case .battery:
            break
        case .ram:
            break
            
        case .storage:
            
            break
        case .display:
            break
        case .memory:
            tfMemory.text = lstTitle.joined(separator: ",")
            viewModel.lstMemory.removeAll()
            viewModel.lstMemory = itemsDataInstallLaptop
        case .memorycard:
            
            tfMemoryCard.text = lstTitle.joined(separator: ",")
            viewModel.lstMemoryCard.removeAll()
            viewModel.lstMemoryCard = itemsDataInstallLaptop
        case .info:
            break
            
        case .term:
            break
        case .confirm:
            break
        case .confirmMobile:
            break
        case .term:
            break
        case .appearancemobile:
            tfAppearance.text = lstTitle.joined(separator: ",")
            viewModel.lstAppearanceMobile.removeAll()
            viewModel.lstAppearanceMobile = itemsDataInstallLaptop
        case .keyboard:
            break
            
            
        }
    }
    
    
}

