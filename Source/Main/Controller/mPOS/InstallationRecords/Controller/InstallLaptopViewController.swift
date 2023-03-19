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
import DropDown
private let reuseIdentifier = "TermInstallLaptopCell"
class InstallLaptopViewController: UIViewController {
    let ServiceType = 0
    var checkButton = 0

    private var dropDown = DropDown()
    private var pickBitLocker:Bool? = nil
    private let dataSourceBitLockerStatus = ["Bật","Tắt"]
    var resultInstallation: ResultInstallationReceipt?
    var receiptID:Int = 0
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
    private let discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Mô tả tình trạng thành phần linh kiện máy(Describe components condition)"
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 11))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        label.textColor = .mainGreen
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
    //    private let TEXT1: UILabel = {
    //        let label = UILabel()
    //        label.text = "TÌNH TRẠNG SẢN PHẨM KHI BÊN YÊU CẦU HỔ TRỢ BÀN GIAO CHO BÊN NHẬN HỔ TRỢ"
    //        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
    //        label.textColor = .mainGreen
    //        return label
    //    }()
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
    private let viewProductReport: UIView = {
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
    private let lblContentSupport:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Nội dung cần hổ trợ(Problem need support)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfContentSupport: UITextField = {
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
    
    private let lblDisplay:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Màn hình(Monitor)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    
    private var tfDisplay: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    
    private let lblKeyboard:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Bàn phím(Keyboard)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    
    private var tfKeyboard: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
        
        
    }()
    
    
    private let lblCharge:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Sạc(Adaptor)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfCharge: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private let lblBattery:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Pin(Liền hay rời/Removable or not)")
        
        label.appendAttributedRedString(title: label.text!)
        
        return label
        
    }()
    private var tfBattery: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private let lblRam:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Dung lượng RAM(RAM Quantity/Capcity)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfRam: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private let lblStorage:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Dung lượng HDD/SSD(Drive Storage Capacity & type)")
        label.AutoScaleHeightForLabel()
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private let lblBitLocker:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Tình trạng BitLocker(BitLocker Status)")
        label.AutoScaleHeightForLabel()
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfStorage: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
    }()
    private var tfBitLocker:UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(chooseStatusBitLocker))
        return tf
    }()
    private let lblMoreInfo:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Thông tin thêm nếu có)")
        return label
    }()
    private let lblDiscriptStatus:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Mô tả lỗi hiện tại(Describe the current status)")
        label.AutoScaleHeightForLabel()
        
        return label
    }()
    private var tfDiscriptStatus: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        return tf
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
    private var lstTerms1 = [ItemDataInstallLaptop](){
        didSet { viewTermInfo.reloadData() }
    }
    private var lstTerms2 = [ItemDataInstallLaptop]()
    
    private var cellHeight:CGFloat = 0
    private var lstImei = [Checkimei_V2Result](){
        didSet { configureDataImei() }
    }
    private var isSign:Bool = false
    private var viewModel:InstallRecordsViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchReceiptMasterDataInstallLaptopAPI()
        loadDataDropdownBitLocker()
//        tfIMEI.text = "abc”"
//        tfSDT.text = "0905100935"
//        tfCustomerName.text = "abc”"
//        tfProduct.text = "abc”"
//        tfContentSupport.text = "abc”"
//        tfAppearance.text = "abc"
//        tfDisplay.text = "abc”"
//        tfKeyboard.text = "abc"
//        tfCharge.text = "abc"
//        tfBattery.text = "abc”"
//        tfRam.text = "abc"
//        tfStorage.text = "abc"
////        tfBitLocker.text = "Bật"
//        tfDiscriptStatus.text = "moo ta"
//        tfColor.text = "abc"
//        tfContentSupport.text = "ho tro"

        
        
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
                        self.viewSignButton.isUserInteractionEnabled = false

                    }
                    popup.onCloseAction = {
                        completion()
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
        guard let contentSupport = tfContentSupport.text, !contentSupport.isEmpty else {
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
        guard let appearance = tfAppearance.text, !appearance.isEmpty else {
            showPopUp("Vui lòng chọn hình thức bên ngoài", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let display = tfDisplay.text , !display.isEmpty else {
            showPopUp("Vui lòng chọn đúng tình trạng màn hình", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let keyboard = tfKeyboard.text, !keyboard.isEmpty else {
            showPopUp("Vui lòng chọn tình trạng bàn phím", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let charge = tfCharge.text, !charge.isEmpty else {
            showPopUp("Vui lòng chọn tình trạng sạc", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let battery = tfBattery.text, !battery.isEmpty else {
            showPopUp("Vui lòng chọn tình trạng pin", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let ram = tfRam.text, !ram.isEmpty else {
            showPopUp("Vui lòng chọn dung lượng ram", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let storage = tfStorage.text, !storage.isEmpty else {
            showPopUp("Vui lòng chọn dung lượng HDD/SSD", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let bitLocker = tfBitLocker.text, !bitLocker.isEmpty else {
            showPopUp("Vui lòng chọn bitLocker", "Thông báo", buttonTitle: "OK")
            return
        }
        guard let note = tfDiscriptStatus.text else {
            return
        }
        
        
        if isSign == false{
            
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
                                                                 ServiceType:ServiceType,
                                                                 MasterDataIdList: self.viewModel.lstParamChoose.joined(separator: ","),
                                                                 CurrentStatus:"",
                                                                 BitLockerStatus: pickBitLocker!,
                                                                 Problem: contentSupport,
                                                                 discriptionFail: ""
                    ) {[weak self] result in
                    guard let self = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        switch result {
                        case .success(let data):
                            if data.success == false || data.data.pStatus != 0{
                                self.showPopUp(data.data.pMessagess, "Thông báo", buttonTitle: "OK")
                            }else if data.success == true && data.data.pStatus == 0 {
                                self.receiptID = data.data.receiptId!
                                sendOTPForCustomer(receiptID: receiptID, isShowError: false, completion: {

                                })
                                btSave.isHidden = true
                                configureButtonResendOTPandConfirm()
                                
                            }
                        case .failure(let error):
                            viewModel.lstParamChoose.removeAll()
                            self.showPopUp(error.localizedDescription, "Thông báo", buttonTitle: "OK")
                            
                        }
                    }
                }
            }
            
        }
      }
    
    func fetchReceiptMasterDataInstallLaptopAPI(){
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            MPOSAPIMangerV2.shared.fetchReceiptMasterDataInstallLaptop(serviceType: 0) {[weak self] result in
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
        viewController.scanSuccess = { text in
            self.fetchIMEI(with: text)
            self.tfIMEI.text = text
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    @objc func handleShowAppearance(){
        pushScreenItem(list: viewModel.lstAppearance,config: .appearance)
    }
    @objc func handleShowDisplay(){
        pushScreenItem(list: viewModel.lstDisplay,config: .display)
    }
    
    @objc func handleShowKeyboard(){
        pushScreenItem(list: viewModel.lstKeyboard,config: .keyboard)
    }
    @objc func handleShowCharge(){
        pushScreenItem(list: viewModel.lstCharge,config: .charge)
    }
    
    @objc func handleShowBattery(){
        pushScreenItem(list: viewModel.lstBattery,config: .battery)
    }
    
    @objc func handleShowRam(){
        pushScreenItem(list: viewModel.lstRam,config: .ram)
    }
    
    @objc func handleShowStorage(){
        pushScreenItem(list: viewModel.lstStorage,config: .storage)
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
        sendOTPForCustomer1(receiptID: receiptID)
        
        
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
                                if data.success{
                                    
                                    
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
    
    private func loadDataDropdownBitLocker(){
        dropDown.dataSource = dataSourceBitLockerStatus
        dropDown.anchorView = tfBitLocker
    }
    @objc func chooseStatusBitLocker() {
        dropDown.show()
        
        dropDown.direction = .bottom
        DropDown.startListeningToKeyboard()
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfBitLocker.text = dataSourceBitLockerStatus[index]
            if index ==  0 {
                pickBitLocker = true
            }else {
                pickBitLocker = false
            }
        }
    }
    // MARK: - Helpers
    
    func configureUI(){
        title = "Cài đặt Laptop"
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
        
        //oke
        
        viewProductStatus.addSubview(lbIMEI)
        lbIMEI.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfProduct.frame.size.height + tfProduct.frame.origin.y + Common.standardPaddingTop)
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
        
        
        viewProductStatus.addSubview(lblContentSupport)
        lblContentSupport.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfColor.frame.size.height + tfColor.frame.origin.y + Common.standardPaddingTop)
        
        viewProductStatus.addSubview(tfContentSupport)
        tfContentSupport.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblContentSupport.frame.size.height + lblContentSupport.frame.origin.y + Common.standardPaddingTop)
        //oke
        
        viewProductStatus.addSubview(titleStatusReport)
        
        titleStatusReport.frame = CGRect(x: Common.standardPaddingLeft, y: tfContentSupport.frame.size.height + tfContentSupport.frame.origin.y , width: Common.standardWidth, height: Common.Size(s: 35))
        
        
        viewProductStatus.addSubview(lblAppearance)
        
        lblAppearance.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: titleStatusReport.frame.size.height + titleStatusReport.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfAppearance)
        tfAppearance.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblAppearance.frame.size.height + lblAppearance.frame.origin.y + Common.standardPaddingTop)
        let viewFocusAppearance = UIView(frame: tfAppearance.frame);
        viewProductStatus.addSubview(viewFocusAppearance)
        let gestureTransactionType = UITapGestureRecognizer(target: self, action:  #selector(self.handleShowAppearance))
        viewFocusAppearance.addGestureRecognizer(gestureTransactionType)
        
        
        
        
        viewProductStatus.addSubview(discriptionLabel)
        
        discriptionLabel.frame = CGRect(x: Common.standardPaddingLeft, y: tfAppearance.frame.size.height + tfAppearance.frame.origin.y , width: Common.standardWidth, height: Common.Size(s: 35))
        
        viewProductStatus.addSubview(lblDisplay)
        
        lblDisplay.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: discriptionLabel.frame.size.height + discriptionLabel.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfDisplay)
        tfDisplay.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblDisplay.frame.size.height + lblDisplay.frame.origin.y + Common.standardPaddingTop)
        let viewFocusDisplay = UIView(frame: tfDisplay.frame);
        viewProductStatus.addSubview(viewFocusDisplay)
        let gestureDisplay = UITapGestureRecognizer(target: self, action:  #selector(handleShowDisplay))
        viewFocusDisplay.addGestureRecognizer(gestureDisplay)
        
        
        viewProductStatus.addSubview(lblKeyboard)
        
        lblKeyboard.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfDisplay.frame.size.height + tfDisplay.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfKeyboard)
        
        tfKeyboard.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblKeyboard.frame.size.height + lblKeyboard.frame.origin.y + Common.standardPaddingTop)
        let viewFocusKeyboard = UIView(frame: tfKeyboard.frame);
        viewProductStatus.addSubview(viewFocusKeyboard)
        let gestureKeyboard = UITapGestureRecognizer(target: self, action:  #selector(handleShowKeyboard))
        viewFocusKeyboard.addGestureRecognizer(gestureKeyboard)
        
        
        
        viewProductStatus.addSubview(lblCharge)
        
        lblCharge.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfKeyboard.frame.size.height + tfKeyboard.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfCharge)
        tfCharge.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblCharge.frame.size.height + lblCharge.frame.origin.y + Common.standardPaddingTop)
        let viewFocusCharge = UIView(frame: tfCharge.frame);
        viewProductStatus.addSubview(viewFocusCharge)
        let gestureCharge = UITapGestureRecognizer(target: self, action:  #selector(handleShowCharge))
        viewFocusCharge.addGestureRecognizer(gestureCharge)
        
        viewProductStatus.addSubview(lblBattery)
        
        lblBattery.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfCharge.frame.size.height + tfCharge.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfBattery)
        tfBattery.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblBattery.frame.size.height + lblBattery.frame.origin.y + Common.standardPaddingTop)
        let viewFocusBattery = UIView(frame: tfBattery.frame);
        viewProductStatus.addSubview(viewFocusBattery)
        let gestureBattery = UITapGestureRecognizer(target: self, action:  #selector(handleShowBattery))
        viewFocusBattery.addGestureRecognizer(gestureBattery)
        
        
        viewProductStatus.addSubview(lblRam)
        
        lblRam.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfBattery.frame.size.height + tfBattery.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfRam)
        tfRam.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblRam.frame.size.height + lblRam.frame.origin.y + Common.standardPaddingTop)
        let viewFocusRam = UIView(frame: tfRam.frame);
        viewProductStatus.addSubview(viewFocusRam)
        let gestureRam = UITapGestureRecognizer(target: self, action:  #selector(handleShowRam))
        viewFocusRam.addGestureRecognizer(gestureRam)
        
        viewProductStatus.addSubview(lblStorage)
        
        lblStorage.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfRam.frame.size.height + tfRam.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfStorage)
        tfStorage.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblStorage.frame.size.height + lblStorage.frame.origin.y + Common.standardPaddingTop)
        let viewFocusStorage = UIView(frame: tfStorage.frame);
        viewProductStatus.addSubview(viewFocusStorage)
        let gestureStorage = UITapGestureRecognizer(target: self, action:  #selector(handleShowStorage))
        viewFocusStorage.addGestureRecognizer(gestureStorage)
        
        viewProductStatus.addSubview(lblBitLocker)
        lblBitLocker.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfStorage.frame.size.height + tfStorage.frame.origin.y + Common.standardPaddingTop)
        
        viewProductStatus.addSubview(tfBitLocker)
        tfBitLocker.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblBitLocker.frame.size.height + lblBitLocker.frame.origin.y + Common.standardPaddingTop)
        let tapBitLocker = UITapGestureRecognizer(target: self, action: #selector(chooseStatusBitLocker))
        tfBitLocker.isUserInteractionEnabled = true
        tfBitLocker.addGestureRecognizer(tapBitLocker)
        
        
        viewProductStatus.addSubview(lblDiscriptStatus)
        
        lblDiscriptStatus.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfBitLocker.frame.size.height + tfBitLocker.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfDiscriptStatus)
        tfDiscriptStatus.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblDiscriptStatus.frame.size.height + lblDiscriptStatus.frame.origin.y + Common.standardPaddingTop)
        
        viewProductStatus.addSubview(discriptionLabel2)
        
        
        discriptionLabel2.frame = CGRect(x: Common.standardPaddingLeft, y: tfDiscriptStatus.frame.size.height + tfDiscriptStatus.frame.origin.y , width: Common.standardWidth, height: Common.Size(s: 52))
        
        
        viewProductStatus.addSubview(viewTermInfo)
        viewTermInfo.frame = CGRect(x: Common.standardPaddingLeft, y: discriptionLabel2.frame.size.height + discriptionLabel2.frame.origin.y + Common.standardPaddingTop, width: view.frame.size.width, height: 300)
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
    func setButtonWithStatus(status:String) {
        
    }
    func configureButtonView(){
        viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop
        scrollView.addSubview(btSave)
        btSave.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btSave.frame.size.height + btSave.frame.origin.y + Common.Size(s: 100))
    }
    func configureButtonResendOTPandConfirm(){
        viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop
        scrollView.addSubview(btResendOTP)
        btResendOTP.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        scrollView.addSubview(btConfirm)

        btConfirm.frame = CGRect(x: Common.standardPaddingLeft, y: btResendOTP.frame.origin.y + btResendOTP.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s: 100))
    }
    func configureButtonConfirm(){
        viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop
        scrollView.addSubview(btConfirm)
        btConfirm.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s: 100))
    }

    func configureButtonDone(){
        viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop
        scrollView.addSubview(btDone)
        btDone.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btDone.frame.size.height + btDone.frame.origin.y + Common.Size(s: 100))
    }
    func configureButtonDone1(){
        viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop + 20
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
        //        titleInfoCustomer.frame = CGRect(origin: CGPoint(x: Common.standardPaddingLeft, y: Common.Size(s: 5)), size: CGSize(width: Common.standardWidth, height: Common.Size(s: 35)))
        
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
        self.lstTerms = viewModel!.lstInfo
        self.lstTerms1 = viewModel!.lstTerm
   //        self.lstTerms1 = viewModel!.lstConfirm

    }
    
    func pushScreenItem(list:[ItemDataInstallLaptop],config: DataInstallLaptopConfiguration){
        let controller = ItemDataInstallLaptopMobileViewController(items: list, config: config)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true, completion: nil)
    }
    
    
    var contentHeights : [CGFloat] = [0.0, 0.0]
    
}

// MARK: - UITableViewDataSource

extension InstallLaptopViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstTerms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TermInstallLaptopCell
        cell.itemDataInstallLaptop = lstTerms[indexPath.row]
        cell.selectionStyle = .none
        //        self.cellHeight = cell.estimateCellHeight
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightcell = 0.01 * UIScreen.main.bounds.height
        
        if indexPath.row == 0 {
            return heightcell * 29
        }
        if indexPath.row == 1 {
            return heightcell * 16
        }
        
        if indexPath.row == 2{
            return heightcell * 19
        }
        
        if  indexPath.row == 3 {
            return heightcell * 16
        }
        if indexPath.row == 4{
            return heightcell * 32
        }
        if indexPath.row == 5{
            return heightcell * 14
        }else {
            return heightcell * 20
            
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
extension InstallLaptopViewController:EPSignatureDelegate {
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
extension InstallLaptopViewController: ItemDataInstallLaptopMobileDelegate{
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
            
            tfAppearance.text = lstTitle.joined(separator: ",")
            viewModel.lstAppearance.removeAll()
            viewModel.lstAppearance = itemsDataInstallLaptop
        case .charge:
            tfCharge.text = lstTitle.joined(separator: ",")
            viewModel.lstCharge.removeAll()
            viewModel.lstCharge = itemsDataInstallLaptop
        case .battery:
            tfBattery.text = lstTitle.joined(separator: ",")
            viewModel.lstBattery.removeAll()
            viewModel.lstBattery = itemsDataInstallLaptop
        case .ram:
            tfRam.text = lstTitle.joined(separator: ",")
            viewModel.lstRam.removeAll()
            viewModel.lstRam = itemsDataInstallLaptop
        case .storage:
            tfStorage.text = lstTitle.joined(separator: ",")
            viewModel.lstStorage.removeAll()
            viewModel.lstStorage = itemsDataInstallLaptop
        case .display:
            tfDisplay.text = lstTitle.joined(separator: ",")
            viewModel.lstDisplay.removeAll()
            viewModel.lstDisplay = itemsDataInstallLaptop
        case .memory:
            break
        case .memorycard:
            break
        case .term:
            break
        case .confirm:
            break
        case .confirmMobile:
            break
        case .info:
            break
        case .appearancemobile:
            break
        case .keyboard:
            tfKeyboard.text = lstTitle.joined(separator: ",")
            viewModel.lstKeyboard.removeAll()
            viewModel.lstKeyboard = itemsDataInstallLaptop
            
            
        }
    }
    
    
}
