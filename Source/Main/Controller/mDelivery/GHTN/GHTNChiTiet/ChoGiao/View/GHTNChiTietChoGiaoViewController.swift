//
//  GHTNChiTietChoGiaoViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit
import Toaster
import DropDown
import CoreLocation
import Kingfisher

class GHTNChiTietChoGiaoViewController: BaseVC<GHTNChiTietChoGiaoView> {
   
    //MARK: - Properties
    var presenter: GHTNChiTietChoGiaoPresenter?
    var buttonRight:UIBarButtonItem!
    var mViewOptionMenu:UIView!
    var dropDownMenu = DropDown()
    var locationManager = CLLocationManager()
    //MARK: - Create ComponentUI
    

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.configureTableView()
        self.confiureUIImageView()
        self.configureButton()
        self.configureLayout()
        self.configureLocation()
    }
    
    private func configureTableView(){
        let view = self.mainView
        view.tableView.dataSource = self
        view.tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configureScrollView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configureScrollView()
    }
    
    deinit {
        print("Denit GHTNChiTietChoGiaoViewControllerViewController is Success")
    }
    
    //MARK:- Configure
    private func configureLocation(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    private func configureLayout(){
        let view = self.mainView
        DispatchQueue.main.async {
            guard let presenter = self.presenter else {
                return
            }
            self.updateLayout(view: view.chupAnhTaiNhaLabel, height: presenter.hide)
            self.updateLayout(view: view.anhChupTaiNhaImageView, height: presenter.hide)
            self.updateLayout(view: view.chupAnhChanDungLabel, height: presenter.hide)
            self.updateLayout(view: view.chupAnhChanDungImageView, height: presenter.hide)
            self.updateLayout(view: view.xacNhanButton, height: presenter.hide)
            self.updateLayout(view: view.datGrabButton, height: presenter.hide)
        }
    }
    
    private func configureScrollView(){
        var height:CGFloat = 0
        let view = self.mainView
        height += view.iconNguoiMuaImageView.bounds.size.height + 10
        height += view.tenNguoiMuaLabel.bounds.size.height + 10
        height += view.soDTNguoiMuaLabel.bounds.size.height + 10
        height += view.diaChiNguoiMuaLabel.bounds.size.height + 10
        height += view.iconNguoiNhanImageView.bounds.size.height + 10
        height += view.tenNguoiNhanLabel.bounds.size.height + 10
        height += view.soDTNguoiNhanLabel.bounds.size.height + 10
        height += view.diaChiNguoiNhanLabel.bounds.size.height + 10
        height += view.iconPhanCongImageView.bounds.size.height + 10
        height += view.nhanVienGiaoLabel.bounds.size.height + 30
        height += view.iconThongTinDonHangImageView.bounds.size.height + 10
        height += view.donHangResultLabel.bounds.size.height + 10
        height += view.thoiGianTreResultLabel.bounds.size.height + 10
        height += view.thoiGianTreResultLabel.bounds.size.height + 10
        height += view.ghiChuLabel.bounds.size.height + 10
        height += view.ghiChuTextView.bounds.size.height + 10
        height += view.donHangTitleLabel.bounds.size.height + 10
        height += view.tableView.bounds.size.height + 10
        height += view.tongDonHangResultLabel.bounds.size.height + 10
        height += view.tienGiamResultLabel.bounds.size.height + 10
        height += view.datCocLabel.bounds.size.height + 10
        height += view.phaiThuResult.bounds.size.height + 10
        height += view.khachNhanHangButton.bounds.size.height + 10
        height += view.chupAnhTaiNhaLabel.bounds.size.height + 10
        height += view.anhChupTaiNhaImageView.bounds.size.height + 10
        height += view.chupAnhChanDungLabel.bounds.size.height + 10
        height += view.chupAnhChanDungImageView.bounds.size.height + 10
        height += view.xacNhanButton.bounds.size.height + 10 + 50
        self.mainView.scrollView.contentSize = CGSize(width: self.view.frame.width, height: height)
        print(view.chupAnhChanDungImageView.bounds.size.height)
    }
    
    private func configureButton(){
        let view = self.mainView
        view.nhanVienGiaoTextField.delegate = self
        view.datGrabButton.addTarget(self, action: #selector(self.datGrabTapped), for: .touchUpInside)
        view.khachKhongNhanHangButton.addTarget(self, action: #selector(self.khachKhongNhanHangTapped), for: .touchUpInside)
        view.khachNhanHangButton.addTarget(self, action: #selector(self.khachNhanHangTapped), for: .touchUpInside)
        view.xacNhanButton.addTarget(self, action: #selector(self.xacNhanTapped), for: .touchUpInside)
        view.goiNhanhButton.addTarget(self, action: #selector(self.goiNhanhKhachHang), for: .touchUpInside)
        view.capNhatButton.addTarget(self, action: #selector(self.capNhapDonHang), for: .touchUpInside)
        view.huyDHButton.addTarget(self, action: #selector(self.huyDonHang), for: .touchUpInside)
    }
    
    private func confiureUIImageView(){
        let mUserName = Cache.user!.UserName
        if mUserName == self.presenter?.model?.userName {
            let view = self.mainView
            let gestureChupTaiNhaKH = UITapGestureRecognizer(target: self, action:  #selector(self.chupTaiNhaKhachHangTapped(sender:)))
            view.anhChupTaiNhaImageView.isUserInteractionEnabled = true
            view.anhChupTaiNhaImageView.addGestureRecognizer(gestureChupTaiNhaKH)
            let gestureChupCDung = UITapGestureRecognizer(target: self, action:  #selector(self.chupChanDungKhachHangTapped(sender:)))
            view.chupAnhChanDungImageView.isUserInteractionEnabled = true
            view.chupAnhChanDungImageView.addGestureRecognizer(gestureChupCDung)
        }
    }
    
    private func configureNavigationBarButton(){
        let buttonRight = UIButton.init(type: .custom)
        buttonRight.setImage(#imageLiteral(resourceName: "moreIC"), for: .normal)
        buttonRight.imageView?.contentMode = .scaleAspectFit
        buttonRight.addTarget(self, action: #selector(self.showHideMenuButton), for: UIControl.Event.touchUpInside)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        self.buttonRight = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.rightBarButtonItems = [self.buttonRight]
    }
    
    private func bindingData(tongTien:Double,phaiThu:Double){
        guard let model = self.presenter?.model else { return }
        guard let presenter = self.presenter else { return }
        let view = self.mainView
        DispatchQueue.main.async {
//            if model.btnBatDauGiaoHang != "" {
//                self.configureNavigationBarButton()
//            } else if model.btnHuyGiaoHang != "" {
//                self.navigationItem.rightBarButtonItems = []
//            } else if model.btnXacNhanXuatKho != "" {
//                self.configureNavigationBarButton()
//            }
            
            view.tenNguoiMuaLabel.text = model.uCrdName ?? ""
            view.soDTNguoiMuaLabel.text = model.uCPhone ?? ""
            view.diaChiNguoiMuaLabel.text = model.uCAddress ?? ""
            view.tenNguoiNhanLabel.text = model.pThongTinNguoiNhanName ?? ""
            view.soDTNguoiNhanLabel.text = model.pThongTinNguoiNhanSDT ?? ""
            view.diaChiNguoiNhanLabel.text = model.pThongTinNguoiNhanAddress ?? ""
            view.thoiGianGiaoResultLabel.text = model.pThongTinNguoiNhanDate ?? ""
            view.donHangResultLabel.text = "\(model.docEntry ?? 0)"
            view.ecomResultLabel.text = "\(model.uNumEcom ?? 0)"
            view.datCocResultLabel.text = Common.convertCurrencyDouble(value: model.soTienTraTruoc ?? 0)
            view.nhanVienGiaoTextField.text = model.empName ?? ""
            view.thoiGianTreResultLabel.text = self.presenter?.GetTime(mObject: model).replacingOccurrences(of: ",", with: " ")
            view.phaiThuResult.text = Common.convertCurrencyDouble(value: phaiThu)
            view.tongDonHangResultLabel.text = Common.convertCurrencyDouble(value: tongTien)
            view.ghiChuTextView.text = model.uDesc ?? ""
            
            if model.partnerCode?.lowercased() == "grab" || model.partnerCode?.lowercased() == "ahamove" {
                if model.btnBatDauGiaoHang == "" {
                    self.updateLayout(view: view.datGrabButton, height: presenter.hide)
                }else {
                    view.datGrabButton.setTitle(model.btnBatDauGiaoHang, for: .normal)
                    let mUserName = Cache.user!.UserName
                    if mUserName == self.presenter?.model?.userName {
                        self.updateLayout(view: view.datGrabButton, height: presenter.showButton)
                    }else {
                        self.updateLayout(view: view.datGrabButton, height: presenter.hide)
                    }
                }
                self.updateLayout(view: view.khachKhongNhanHangButton, height: presenter.hide)
                self.updateLayout(view: view.khachNhanHangButton, height: presenter.hide)
            }else {
                self.updateLayout(view: view.datGrabButton, height: presenter.hide)
                let mUserName = Cache.user!.UserName
                if mUserName != self.presenter?.model?.userName {
                    self.updateLayout(view: view.khachKhongNhanHangButton, height: presenter.hide)
                    self.updateLayout(view: view.khachNhanHangButton, height: presenter.hide)
                }else {
                    if model.imgURLNKH != "" {
                        self.updateLayout(view: view.khachKhongNhanHangButton, height: presenter.hide)
                        self.updateLayout(view: view.khachNhanHangButton, height: presenter.hide)
                        self.updateLayout(view: view.xacNhanButton, height: presenter.showButton)
                        if model.type == 12 {
                            view.xacNhanButton.setTitle("XÁC THỰC BACK TO SCHOOL", for: .normal)
                        }
                    }else {
                        self.updateLayout(view: view.khachKhongNhanHangButton, height: presenter.showButton)
                        self.updateLayout(view: view.khachNhanHangButton, height: presenter.showButton)
                        self.updateLayout(view: view.xacNhanButton, height: presenter.hide)
                    }
                }
                if model.imgURLNKH != "" {
                    self.updateLayout(view: view.chupAnhTaiNhaLabel, height: presenter.showLabel)
                    self.updateLayout(view: view.anhChupTaiNhaImageView, height: presenter.showImage)
                    if model.type == 11 {
                        if self.mainView.chupAnhChanDungImageView.image == nil ||
                            self.mainView.chupAnhChanDungImageView.image == UIImage(named: "plus-icon") {
                            self.updateLayout(view: view.chupAnhChanDungImageView, height: 200)
                            self.updateLayout(view: view.chupAnhChanDungLabel, height: 18)
                        }
                    }
                }
                if let urlAnhTaiNha = URL(string: model.imgURLNKH ?? "") {
                    view.anhChupTaiNhaImageView.kf.setImage(with: urlAnhTaiNha)
                }
            }
            
            let jobTitle = self.presenter?.jobtitle
            if jobTitle == JOBTITLE.JOB_TITLE_SM ||
                jobTitle == JOBTITLE.JOB_TITLE_DSM ||
                jobTitle == JOBTITLE.JOB_TITLE_TRUONG_CA ||
                jobTitle == JOBTITLE.JOB_TITLE_PHO_QUANLY_CUAHANG_APR ||
                jobTitle == JOBTITLE.JOB_TITLE_TRUONG_QUANLY_CUAHANG_APR {
                view.nhanVienGiaoTextField.isEnabled = model.imgURLNKH == "" ? true : false
                if model.maShopNhoGiaoHang != "" {
                    self.configureNavigationBarButton()
                    view.nhanVienGiaoTextField.isEnabled = true
                }else {
                    view.nhanVienGiaoTextField.isEnabled = false
                    self.navigationItem.rightBarButtonItems = []
                }
                
            } else {
                view.nhanVienGiaoTextField.isEnabled = false
                self.navigationItem.rightBarButtonItems = []
            }
            
            view.tableView.reloadData()
        }
    }
    
    //MARK:- Actions
    @objc private func chupTaiNhaKhachHangTapped(sender : UITapGestureRecognizer){
        self.takePhoto(tag: self.mainView.anhChupTaiNhaImageView.tag, mirea:false)
    }
    
    @objc private func chupChanDungKhachHangTapped(sender : UITapGestureRecognizer){
        self.takePhoto(tag: self.mainView.chupAnhChanDungImageView.tag,mirea:true)
    }
    
    private func updateLayout(view:UIView,height:CGFloat){
        view.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        view.isHidden = height == 0 ? true : false
    }
 
    private func takePhoto(tag:Int,mirea:Bool){
        ImagePickerManager().pickImage(isCamera: true, self) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.presenter?.imageUpload = image
                guard let imageData:NSData = image.jpegData(compressionQuality: 0.5) as NSData? else { return }
                let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
                if mirea {
                    self.presenter?.xacMinhDanhTinhKhachHang(imageString: strBase64)
                }else {
                    self.presenter?.uploadImageGHTN(image: strBase64,
                                                     type: "\(tag)",
                                                     latitude:"\(self.locationManager.location?.coordinate.latitude ?? 0)",
                                                     longitude:"\(self.locationManager.location?.coordinate.longitude ?? 0)")
                }
                self.presenter?.typeUpload = tag
            }
            self.configureScrollView()
        }
    }
    
    @objc private func khachNhanHangTapped(){
        self.takePhoto(tag: self.mainView.anhChupTaiNhaImageView.tag,mirea: false)
    }
    
    @objc private func khachKhongNhanHangTapped(){
        let vc = PopUpKhachKhongNhanHangViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func xacNhanTapped(){
        if self.mainView.anhChupTaiNhaImageView.image == nil {
            self.outPutFailed(error: "Bạn chưa chụp ảnh tại nhà khách hàng.")
            return
        }
        if self.presenter?.model?.type == 11 {
            if self.mainView.chupAnhChanDungImageView.image == nil ||
                self.mainView.chupAnhChanDungImageView.image == UIImage(named: "plus-icon") {
                self.outPutFailed(error: "Bạn chưa chụp ảnh chân dung khách hàng.")
                return
            }
        }
        if self.mainView.xacNhanButton.title(for: .normal)?.lowercased() == "XÁC THỰC BACK TO SCHOOL".lowercased() {
            self.presenter?.checkImageUpLoadBackToSchool()
        }else {
            self.presenter?.khachNhanHang()
        }
    }
    
    @objc private func goiNhanhKhachHang(){
        self.presenter?.goiNhanhKhachHang()
    }
    
    @objc private func datGrabTapped(){
        self.presenter?.datGrabGiaoHang()
    }
    
    @objc private func showHideMenuButton(){
        self.mainView.viewMenuButton.isHidden = !self.mainView.viewMenuButton.isHidden
    }
    
    @objc private func capNhapDonHang(){
        self.showHideMenuButton()
        let vc = CapNhatThongTinGiaoHangViewController()
        vc.mTimeGiao = self.mainView.thoiGianGiaoLabel.text ?? ""
        vc.mObjectData = self.presenter?.mObjectData
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func huyDonHang(){
        self.showHideMenuButton()
        let vc = HuyDonGHTNViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func setupDrop(textField:UITextField) {
        guard let model = self.presenter?.model else {return}
        if model.partnerCode?.lowercased() == "grab" {
            return
        }
        dropDownMenu.setupCornerRadius(10)
        dropDownMenu.anchorView = textField
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.direction = .bottom
        dropDownMenu.offsetFromWindowBottom = 20
        dropDownMenu.dataSource = self.presenter?.modelListNVGH.map({ object in
            return ("\(object.UserName) - \(object.EmployeeName)")
        }) ?? []
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            guard let view = self else { return }
            view.showAlertMultiOption(title: "Thông Báo", message: "Bạn có muốn đổi nhân viên \(item) làm nhân viên giao hàng không ?", options: "OK","Cancel", buttonAlignment: .horizontal) { row in
                if row == 0 {
                    self?.presenter?.userPicker = item
                    let empName = (self?.presenter?.modelListNVGH[index].EmployeeName ?? "").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    self?.presenter?.chonNVGiaoHang(userCode: self?.presenter?.modelListNVGH[index].UserName ?? "", empName: empName ?? "")
                }
            }
        }
        self.dropDownMenu.show()
    }
    
}

extension GHTNChiTietChoGiaoViewController : GHTNChiTietChoGiaoPresenterToViewProtocol {
    func didXacMinhDanhTinhKhachHangMieraSuccess(image:String) {
        var imageString = ""
        imageString = String(image.map({ $0 == "\r" ? " " : $0 }))
        imageString = String(image.map({ $0 == "\n" ? " " : $0 }))
        imageString = String(image.map({ $0 == "\r\n" ? " " : $0 }))
        let dataDecoded:NSData? = NSData(base64Encoded: imageString, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        self.mainView.chupAnhChanDungImageView.image = UIImage(data: dataDecoded! as Data)
        
        self.presenter?.uploadImageGHTN(image: image,
                                        type: "\(self.mainView.chupAnhChanDungImageView.tag)",
                                        latitude: "\(self.locationManager.location?.coordinate.latitude ?? 0)",
                                        longitude: "\(self.locationManager.location?.coordinate.longitude ?? 0)")
    }
    
    func didCheckImageUploadSuccess(idBackToSchool: Int) {
        let vc = GHTNBacktoSchool()
        vc.btsID = idBackToSchool
        vc.onSuccess = {
//            self.presenter?.khachNhanHang()
            self.mainView.xacNhanButton.setTitle("Xác nhận", for: .normal)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func didChonNhanVienGiaoHangSuccess(message:String) {
        self.showLoading(message: "")
        self.presenter?.viewDidLoad()
    }
    
    func didBookGrabGHTNSuccess(message:String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo",
                                                    message: message,
                                                    titleButton: "OK",
                                                    viewController: self) {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func didgetPlainningGrabSuccess(model: GrabPlainingItem) {
        let popup = GrabBookingPopup()
        popup.modalTransitionStyle = .crossDissolve
        popup.modalPresentationStyle = .overCurrentContext
        popup.planningItem = model
        popup.titleButton = self.presenter?.model?.btnBatDauGiaoHang ?? ""
        popup.orderItem = self.presenter?.mObjectData
        popup.onBook = {
            self.presenter?.bookGrabGHTN(plaining: model)
        }
        self.present(popup, animated: true, completion: nil)
    }
    
    
    func didHuyDonHangGHTNSuccess() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didGoiNhanhKhachHang(numberPhone: String) {
        if let url = URL(string: "tel://\(numberPhone)") {
             UIApplication.shared.open(url)
        }
    }
    
    func didxacNhanGiaoHangSuccess(message: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: message, titleButton: "OK", viewController: self) {
            self.navigationController?.popViewController(animated: true)
        }
    }
 
    func didUploadChupTaiNhaSuccess(image: UIImage) {
        DispatchQueue.main.async {
            let view = self.mainView
            guard let presenter = self.presenter else {return}
            self.updateLayout(view: view.khachNhanHangButton, height: presenter.hide)
            self.updateLayout(view: view.khachKhongNhanHangButton, height: presenter.hide)
            self.updateLayout(view: view.chupAnhTaiNhaLabel, height: presenter.showLabel)
            self.updateLayout(view: view.anhChupTaiNhaImageView, height: presenter.showImage)
            self.updateLayout(view: view.xacNhanButton, height: presenter.showButton)
            self.mainView.anhChupTaiNhaImageView.image = image
            self.viewDidLayoutSubviews()
            guard let model = self.presenter?.model else { return }
            if model.type == 12 {
                view.xacNhanButton.setTitle("XÁC THỰC BACK TO SCHOOL", for: .normal)
            }
        }
    }
    
    func didUploadChupChanDungSuccess(image: UIImage) {
        DispatchQueue.main.async {
            guard let presenter = self.presenter else {return}
            let view = self.mainView
            self.updateLayout(view: view.chupAnhChanDungLabel, height: presenter.showLabel)
            self.updateLayout(view: view.chupAnhChanDungImageView, height: presenter.showImage)
            self.mainView.chupAnhChanDungImageView.image = image
            self.viewDidLayoutSubviews()
        }
    }
    
    func didgetSODetailsSuccess(tongTien:Double, phaiThu:Double) {
        self.bindingData(tongTien:tongTien, phaiThu:phaiThu)
    }

    func outPutFailed(error: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: error, titleButton: "OK", viewController: self) {
            
        }
    }
    
    func showLoading(message: String) {
        self.startLoading(message: message)
    }
    
    func hideLoading() {
        self.stopLoading()
    }
    
    func showToast(message:String) {
        Toast(text: message).show()
    }
}

extension GHTNChiTietChoGiaoViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.modelListChiTietDonHang.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.mainView.identifier, for: indexPath) as! GHTNChiTietChoGiaoTableViewCell
        cell.model = self.presenter?.modelListChiTietDonHang[indexPath.row]
        return cell
    }
    
    
}

extension GHTNChiTietChoGiaoViewController : CapNhatThongTinGiaoHangViewControllerDelegate {
    func updateListGHTN() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension GHTNChiTietChoGiaoViewController : PopUpKhachKhongNhanHangViewControllerDelegate {
    func xacNhanHandle(content: String) {
        self.presenter?.khachKhongNhanHang(reason: content)
    }

}
extension GHTNChiTietChoGiaoViewController : HuyDonGHTNViewControllerDelegate {
    func xacNhanHuyDonHang(reason:String) {
        self.presenter?.huyDonHang(reason:reason)
    }
}

extension GHTNChiTietChoGiaoViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        self.setupDrop(textField: textField)
    }
}

extension GHTNChiTietChoGiaoViewController : CLLocationManagerDelegate {
    
}
