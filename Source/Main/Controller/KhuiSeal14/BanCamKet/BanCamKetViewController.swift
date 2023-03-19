//
//  BanCamKetViewController.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import Kingfisher


class BanCamKetViewController : BaseVC<BanCamKetView> {
    
    private var viewModel:BanCamKetViewModel!
    private var datePicker:UIDatePicker!
    private let sign = BehaviorSubject<String>(value: "")
    private let otp = PublishSubject<String>()
    private let id = BehaviorRelay<Int>(value: 0)
    private let resent = PublishSubject<Void>()
    private let isHistory = BehaviorRelay<Bool>(value: false)
    
    
    init(id: Int = 0, isHistory:Bool = false) {
        self.viewModel = BanCamKetViewModel()
        self.id.accept(id)
        self.isHistory.accept(isHistory)
        self.viewModel.isHistory = isHistory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.view.backgroundColor = Common.Colors.CamKet.background
        self.configureNavigation()
        self.configureDatePicker()
    }
    
    private func configureDatePicker(){
        let view = self.mainView
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        datePicker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerChanged))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        view.ngayCapCMNDTextField.textField.inputAccessoryView = toolbar
        view.ngayCapCMNDTextField.textField.inputView = datePicker
    }
    
    @objc func datePickerChanged() {
        let view = self.mainView
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        view.ngayCapCMNDTextField.text = formatter.string(from: self.datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    deinit {
        print("deinit called")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateHeightScrollView()
    }
    
    private func configureNavigation(){
        self.title = "Bản Cam Kết"
    }
    
    private func configureButton(){
        let view = self.mainView
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTouchSignature))
        view.signView.addGestureRecognizer(tap)
    }
    
    private func bind(){
        let view = self.mainView
        let bag = self.viewModel.bag
 
        let parameters = Driver.combineLatest(
            view.nameCustomerTextField.textField.rx.text.asDriver(),
            view.cmndTextField.textField.rx.text.asDriver(),
            view.noiCapCMNDTextField.textField.rx.text.asDriver(),
            view.ngayCapCMNDTextField.textField.rx.text.asDriver(),
            view.phoneCustomerTextField.textField.rx.text.asDriver(),
            view.sanPhamTextField.textField.rx.text.asDriver()
        ).map { name,cmnd,noiCap,ngayCap,phone,sanPham -> BanCamKetKhuiSealModel in
                let model = BanCamKetKhuiSealModel()
                model.nameCustomer = name
                model.cmnd = cmnd
                model.noiCap = noiCap
                model.ngayCap = ngayCap
                model.phone = phone
                model.sanPham = sanPham
                return model
        }
 
        let viewDidLoad = BehaviorRelay<Void>(value: ())
        
        let input = BanCamKetViewModel.Input(
            paramester: parameters,
            getOTP: view.optButton.rx.tap.asDriver(),
            finalCommit: view.finalButton.rx.tap.asDriver(),
            id: self.id.asDriver(onErrorJustReturn: 0),
            otp: self.otp.asDriver(onErrorJustReturn: ""),
            sign: self.sign.asDriver(onErrorJustReturn: ""),
            viewDidLoad: viewDidLoad,
            resent:self.resent.asDriver(onErrorJustReturn: ())
        )
        
        let output = self.viewModel.transform(input)
        
        output.response
            .map { $0.sanPham ?? "" }
            .distinctUntilChanged()
            .drive(view.sanPhamTextField.textField.rx.text)
            .disposed(by: bag)
        
        output.response
            .map { $0.nameCustomer ?? "" }
            .distinctUntilChanged()
            .drive( view.nameCustomerTextField.textField.rx.text)
            .disposed(by: bag)
        
        output.response
            .map { $0.cmnd ?? "" }
            .distinctUntilChanged()
            .drive( view.cmndTextField.textField.rx.text)
            .disposed(by: bag)
        
        output.response
            .map { $0.noiCap ?? "" }
            .distinctUntilChanged()
            .drive( view.noiCapCMNDTextField.textField.rx.text)
            .disposed(by: bag)
        
        output.response
            .map { $0.ngayCap ?? "" }
            .distinctUntilChanged()
            .drive( view.ngayCapCMNDTextField.textField.rx.text)
            .disposed(by: bag)
        
        output.response
            .map { $0.phone ?? "" }
            .distinctUntilChanged()
            .drive( view.phoneCustomerTextField.textField.rx.text)
            .disposed(by: bag)
        
        output.response
            .map { $0.sanPham ?? "" }
            .distinctUntilChanged()
            .drive( view.sanPhamTextField.textField.rx.text)
            .disposed(by: bag)
        
        output.response
            .map { !($0.buttonOTP?.value ?? false) }
            .drive( view.optButton.rx.isHidden)
            .disposed(by: bag)
        
        output.response
            .map {!($0.buttonHoanTatBienBan?.value ?? false) }
            .drive( view.finalButton.rx.isHidden)
            .disposed(by: bag)
        
        output.response
            .map {!($0.buttonKhachHangKhuiSeal?.value ?? false) }
            .drive( view.sealButton.rx.isHidden)
            .disposed(by: bag)
        
        output.response
            .map { $0.noiDungCamKet?.htmlToAttributedString }
            .drive( view.contentLabel.rx.attributedText)
            .disposed(by: bag)
        
        output.response
            .map { $0.buttonOTP?.text ?? "" }
            .drive( view.optButton.rx.title())
            .disposed(by: bag)
        
        output.response
            .map { $0.buttonHoanTatBienBan?.text ?? "" }
            .drive( view.finalButton.rx.title())
            .disposed(by: bag)
        
        output.response
            .map { $0.buttonKhachHangKhuiSeal?.text ?? "" }
            .drive( view.sealButton.rx.title())
            .disposed(by: bag)
        
        output.response
            .map { URL(string: $0.urlChuKyKhachHang ?? "")}
            .drive { url in
                if url != nil {
                    KF.url(url)
                        .set(to: view.signView.imageSign)
                }
            }
            .disposed(by: bag)
        
        output.responseFinal
            .drive {[weak self]  model in
                if model.status == 1 {
                    self?.showAlert(
                        message: model.mess ?? "",
                        isBack: true,
                        color: Common.Colors.CamKet.green,
                        reload: nil)
                }else {
                    self?.showAlert(
                        message: model.mess ?? "",
                        color: .red,
                        reload: viewDidLoad,
                        isReload:true)
                }
            }.disposed(by: bag)
        
        output.responseVerifyOTP
            .drive { [weak self] model in
                if model.status == 1 {
                    view.nameCustomerTextField.isDisableField = true
                    view.cmndTextField.isDisableField = true
                    view.ngayCapCMNDTextField.isDisableField = true
                    view.noiCapCMNDTextField.isDisableField = true
                    view.phoneCustomerTextField.isDisableField = true
                    view.signView.isUserInteractionEnabled = false
                    self?.showAlert(
                        message: model.mess ?? "",
                        color: Common.Colors.CamKet.green,
                        reload: viewDidLoad,
                        isReload:true)
                }else {
                    self?.showAlert(
                        message: model.mess ?? "",
                        isShow: true, color: .red,
                        reload: nil)
                }
            }.disposed(by: bag)
        
        output.responseGetOTP
            .drive { [weak self] model in
                if model.status == 1 {
                    self?.showAlert(
                        message: model.mess ?? "",
                        isShow: true,
                        color: Common.Colors.CamKet.green,
                        reload: nil)
                }else {
                    self?.showAlert(
                        message: "Đã có lỗi xảy ra.\(model.mess ?? "")",
                        color: .red,
                        reload: nil)
                }
            }.disposed(by: bag)

        self.isHistory
            .asDriver()
            .drive { [weak self] history in
                if history == false {
                    self?.configureButton()
                }
                view.nameCustomerTextField.isDisableField = history
                view.cmndTextField.isDisableField = history
                view.ngayCapCMNDTextField.isDisableField = history
                view.noiCapCMNDTextField.isDisableField = history
                view.phoneCustomerTextField.isDisableField = history
            }.disposed(by: bag)
        
        output.fetching
            .drive { [weak self] value in
            value ? self?.startLoading(message: "Đang tải dữ liệu") : self?.stopLoading()
        }.disposed(by: bag)
        
        output.error
            .drive { [weak self] error in
                self?.showAlert(message: error,color: .red, reload: nil)
            }.disposed(by: bag)

        view.sealButton.rx.tap.withLatestFrom(self.id)
            .asDriver(onErrorJustReturn: 0)
            .drive { [weak self] id in
                let vc = KhuiSealViewController(id: id)
                self?.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: bag)
        
       

    }
    
    
    @objc private func onTouchSignature(){
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: true)
        signatureVC.subtitleText = "Khách hàng ký tên ở đây"
        signatureVC.title = "Ký tên"
        let nav = UINavigationController(rootViewController: signatureVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    private func updateHeightScrollView(){
        let contentRect: CGRect = self.mainView.scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        self.mainView.scrollView.contentSize = contentRect.size
        view.layoutIfNeeded()
    }
    
    private func showAlert(message:String,
                           isShow:Bool = false,
                           isBack:Bool = false,
                           color:UIColor = Common.Colors.CamKet.blue,
                           reload:BehaviorRelay<Void>?,
                           isReload:Bool = false
    ) {
        AlertManager
            .shared
            .alertCoreICT(
                title: "Thông báo",
                message:message,
                colorTitle: color,
                colorButtons: .darkGray,
                placeholder: "",
                buttons: "Đồng ý",
                self: self) { text, index in
           
                    if isReload {
                        reload?.accept(())
                    }
                    if isShow {
                        self.showOTP()
                    }
                    if isBack {
                        self.navigationController?.popViewController(animated: true)
                    }
        }
        self.stopLoading()

    }
    
    private func showOTP(){
        AlertManager.shared.alertCoreICT(title: "Nhập OTP",
                                         colorTitle: Common.Colors.CamKet.blue,
                                         colorButtons: .darkGray,Common.Colors.CamKet.blue,
                                         placeholder: "Nhập OTP",
                                         buttons: "Gửi lại mã", "Xác nhận",
                                         isTextField:true,
                                         isNumber:true,
                                         self: self) { text, index in
            if index == 0 {
                self.resent.onNext(())
            }else {
                if text?.count ?? 0 > 0 {
                    self.otp.onNext(text ?? "")
                }
            }
        }
    }
}

extension BanCamKetViewController: EPSignatureDelegate {
    private func cropImage(image: UIImage, toRect rect: CGRect) -> UIImage {
        let imageRef: CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage: UIImage = UIImage(cgImage: imageRef)
        return croppedImage
    }
    func epSignature(_: EPSignatureViewController, didCancel error: NSError) {
        self.dismiss(animated: true, completion: nil)
    }

    func epSignature(_: EPSignatureViewController, didSign signatureImage: UIImage, boundingRect: CGRect) {
        self.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            self.mainView.signView.imageSign.image = self.cropImage(image: signatureImage, toRect: boundingRect)
            self.mainView.signView.iconSign.isHidden = true
            let imageSign: UIImage = self.resizeImage(image: self.mainView.signView.imageSign.image!, newHeight: 170)!
            let imageDataSign: NSData = (imageSign.jpegData(compressionQuality: 0.75) as NSData?)!
            let stringBase64Sign = imageDataSign.base64EncodedString(options: .endLineWithLineFeed)
            self.sign.onNext(stringBase64Sign)
        }

    }

    private func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {

        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

}
