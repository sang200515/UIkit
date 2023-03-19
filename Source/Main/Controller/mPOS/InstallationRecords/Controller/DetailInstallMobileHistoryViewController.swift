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
private let reuseIdentifier = "TermInstallLaptopHistoryCell"
class DetailInstallMobileHistoryViewController: UIViewController {
    var receiptStatus = ""
    var receiptID = 0
    var isShowResendButton = false

    private var isSign:Bool = false

    // MARK: - Properties
    private var viewSignButton: UIImageView!

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
        tf.isUserInteractionEnabled = false

        return tf
    }()
    private let lblSDT:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Số điện thoại(Phone no)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfSDT: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        tf.isUserInteractionEnabled = false

        return tf
    }()
    private let lblCustomerName:UILabel = {
        
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Họ và tên(Full name)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfCustomerName: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        tf.isUserInteractionEnabled = false

        return tf
    }()
    private let lblProduct:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Tên Sản phẩm(Name of Product)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfProduct: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        tf.isUserInteractionEnabled = false

        return tf
    }()
    private let lblColor:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Màu sắc(Color)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    private var tfColor: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        tf.isUserInteractionEnabled = false

        return tf
    }()
    private let lblAppearance:UILabel = {
        let label = Common.tileLabel(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeightLabel, title: "Hình thức bên ngoài(Appearance)")
        label.appendAttributedRedString(title: label.text!)
        
        return label
    }()
    
    private var tfAppearance: UITextField = {
        let tf = Common.inputTextTextField(x: 0, y: 0, width: Common.standardWidth, height: Common.standardHeight, fontSize: Common.standardFontSize)
        tf.isUserInteractionEnabled = false

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
    
    private lazy var blankBt:UIButton = {
        let btInphieu = UIButton()
        btInphieu.backgroundColor = .white
        btInphieu.setTitle("", for: .normal)
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
    

    private var lstTerms = [MasterDatum](){
        didSet { viewTermInfo.reloadData() }
    }
    private var cellHeight:CGFloat = 0
    var item:DetailInstallationReceipt?{
        didSet { configureData() }
    }
    private var viewModel:InstallRecordsHistoryViewModel!
        //MARK: API
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
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        self.present(popup, animated: true, completion: nil)
    }
    @objc func handleDone(){
        let popup = PopUPDoneReceipt()
        
        popup.receiptID = receiptID
        self.navigationController?.pushViewController(popup, animated: true)
    }
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
                                self.btConfirm.isHidden = true
                                viewSign.isHidden = false
                                self.btResendOTP.isHidden = true

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
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        if isShowResendButton {
            configureButtonResendOTPandConfirm()
            
        }

    }
    init(item: DetailInstallationReceipt){
        super.init(nibName: nil, bundle:nil)
        self.item = item
        configureData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
        
        viewProductStatus.addSubview(lblMemoryCard)
        lblMemoryCard.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfMemory.frame.size.height + tfMemory.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfMemoryCard)
        tfMemoryCard.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblMemoryCard.frame.size.height + lblMemoryCard.frame.origin.y + Common.standardPaddingTop)
        
        
        viewProductStatus.addSubview(lbIMEI)
        lbIMEI.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfMemoryCard.frame.size.height + tfMemoryCard.frame.origin.y + Common.standardPaddingTop)
        viewProductStatus.addSubview(tfIMEI)
        tfIMEI.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lbIMEI.frame.size.height + lbIMEI.frame.origin.y + Common.standardPaddingTop)
        tfIMEI.rightViewMode = UITextField.ViewMode.always
        
        
       
        viewProductStatus.addSubview(lblColor)
        lblColor.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfIMEI.frame.size.height + tfIMEI.frame.origin.y + Common.standardPaddingTop)
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
        
        viewProductStatus.addSubview(lblErrorReport)
        lblErrorReport.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: tfAppearance.frame.size.height + tfAppearance.frame.origin.y + Common.standardPaddingTop)
          viewProductStatus.addSubview(tfErrorReport)
        tfErrorReport.frame.origin = CGPoint(x: Common.standardPaddingLeft, y: lblErrorReport.frame.size.height + lblErrorReport.frame.origin.y + Common.standardPaddingTop)
          viewProductStatus.addSubview(viewTermInfo)
        viewTermInfo.frame = CGRect(x: Common.standardPaddingLeft, y: tfErrorReport.frame.size.height + tfErrorReport.frame.origin.y + Common.standardPaddingTop, width: view.frame.size.width, height: 300)
        viewTermInfo.dataSource = self
        viewTermInfo.delegate = self
        viewTermInfo.register(TermInstallLaptopHistoryCell.self, forCellReuseIdentifier: reuseIdentifier)
        viewTermInfo.tableFooterView = UIView()
         viewProductStatus.addSubview(viewInfo)
        configureViewInfo()
       
        scrollView.addSubview(blankBt)

        if receiptStatus == "Tạo phiếu" {
            configureButtonView()
            viewSign.isHidden = true

        }
        else if receiptStatus == "Đang xử lý" {

            configureButtonDone1()

            viewSign.isHidden = true

       }else {
           configureBlankButton()
       }
       
  }
   func configureBlankButton(){
       viewProductStatus.frame.size.height = viewInfo.frame.size.height + viewInfo.frame.origin.y + Common.standardPaddingTop
       scrollView.addSubview(blankBt)
       blankBt.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: 0, height: 0)
       scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  blankBt.frame.size.height + blankBt.frame.origin.y + Common.Size(s: 100))

   }
   func configureButtonView(){
       viewProductStatus.frame.size.height = viewInfo.frame.size.height + viewInfo.frame.origin.y + Common.standardPaddingTop
       scrollView.addSubview(btConfirm)
       btConfirm.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
       
       
       scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s: 100))
   }
   func configureButtonDone(){
      
       
       scrollView.addSubview(btDone)

       viewProductStatus.frame.size.height = viewSign.frame.size.height + viewSign.frame.origin.y + Common.standardPaddingTop
       btDone.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
       
       
       scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btDone.frame.size.height + btDone.frame.origin.y + Common.Size(s: 100))
   }
    func configureButtonResendOTPandConfirm(){
        viewProductStatus.frame.size.height = viewInfo.frame.size.height + viewInfo.frame.origin.y + Common.standardPaddingTop
        scrollView.addSubview(btResendOTP)
        btResendOTP.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        scrollView.addSubview(btConfirm)
        btConfirm.frame = CGRect(x: Common.standardPaddingLeft, y: btResendOTP.frame.origin.y + btResendOTP.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btResendOTP.frame.size.height + btResendOTP.frame.origin.y + Common.Size(s: 140))
    }
    func configureButtonDone1(){
       

//        viewProductStatus.addSubview(viewSign)
//           viewSign.frame = CGRect(x: Common.standardPaddingLeft, y: viewInfo.frame.origin.y + viewInfo.frame.size.height , width: Common.standardWidth, height: Common.Size(s:150))
//
//           viewSignButton =  UIImageView(frame: CGRect(x:Common.Size(s: 15), y:  Common.Size(s:5), width: Common.standardWidth - Common.Size(s:30), height: (Common.standardWidth) / 2.6))
//           viewSignButton.image = #imageLiteral(resourceName: "Chuky")
//           viewSignButton.contentMode = .scaleAspectFit
//           viewSignButton.tag = 1
//           viewSign.addSubview(viewSignButton)
//   let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(tapShowSign))
//   viewSignButton.isUserInteractionEnabled = true
//   viewSignButton.addGestureRecognizer(tapShowSignature)
        scrollView.addSubview(btDone)

        viewProductStatus.frame.size.height = viewInfo.frame.size.height + viewInfo.frame.origin.y + Common.standardPaddingTop
        btDone.frame = CGRect(x: Common.standardPaddingLeft, y: viewProductStatus.frame.origin.y + viewProductStatus.frame.height + Common.Size(s: 15), width: Common.standardWidth, height: Common.standardHeight)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  btDone.frame.size.height + btDone.frame.origin.y + Common.Size(s: 100))
    }
    @objc func tapShowSign(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
        
        self.navigationController?.pushViewController(signatureVC, animated: true)
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
        viewInfo.frame.size.height = lbTitle7.frame.size.height + lbTitle7.frame.origin.y + Common.Size(s: 10)
    }
    func configureData(){
    
        guard let item = item else {return}
        viewModel = InstallRecordsHistoryViewModel(mastersData: item.data.masterData)
        tfIMEI.text = item.data.imei
        tfSDT.text = item.data.phoneNumber
        tfCustomerName.text = item.data.custFullname
        tfProduct.text = item.data.itemName
        tfColor.text = item.data.deviceColor
        tfErrorReport.text = item.data.problem
        lstTerms = viewModel.lstTerm
        
        let lstTitleAppearance = viewModel.lstAppearanceMobile.map{ $0.name }
        tfAppearance.text = lstTitleAppearance.joined(separator: ",")
        
  
        let lstMemory = viewModel.lstMemory.map{ $0.name }
        tfMemory.text = lstMemory.joined(separator: ",")
        
        let lstMemoryCard = viewModel.lstMemoryCard.map{ $0.name }
        tfMemoryCard.text = lstMemoryCard.joined(separator: ",")
        
        tfMoreInfo.text = item.data.note
        tfErrorReport.text = item.data.note
        tfSupportContent.text = item.data.problem
        if item.data.resendOTP{
            isShowResendButton = true
        }
    }
    


    

    

}
// MARK: - EPSignatureDelegate
extension DetailInstallMobileHistoryViewController:EPSignatureDelegate {
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

        configureButtonDone()
        
        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func reSignatureSignn(){
        
        let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(tapShowSign))
        viewSignButton.isUserInteractionEnabled = true
        viewSignButton.addGestureRecognizer(tapShowSignature)
    }
}
    // MARK: - UITableViewDataSource

extension DetailInstallMobileHistoryViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstTerms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TermInstallLaptopHistoryCell
        cell.itemDataInstallLaptop = lstTerms[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
   
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let item = lstTerms[indexPath.row]
//        if let row = lstTerms.firstIndex(where: {$0.id == item.id}) {
//            lstTerms[row].isSelected = lstTerms[row].isSelected == true ? false : true
//        }
//
//    }
    
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
         let heightcell = 0.01 * UIScreen.main.bounds.height
         
         if indexPath.row == 0 {
             return heightcell * 30
         }
         if indexPath.row == 1 {
             return heightcell * 32
         }
         
         if indexPath.row == 2{
             return heightcell * 16
         }
         
         if  indexPath.row == 3 {
             return heightcell * 19
         }
         if indexPath.row == 4{
             return heightcell * 19
         }
         if indexPath.row == 5{
             return heightcell * 16
         }else {
             return heightcell * 32
             
         }
    }
}



