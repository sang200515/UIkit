//
//  ComfirmOrderEcomPopup.swift
//  fptshop
//
//  Created by Ngoc Bao on 17/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Presentr
import DropDown

class ComfirmOrderEcomPopup: UIViewController {

    @IBOutlet weak var xacNhanButton: UIButton!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var phuongXaTextField: UITextField!
    @IBOutlet weak var quanHuyenTextField: UITextField!
    @IBOutlet weak var tinhThanhPhoTextField: UITextField!
    @IBOutlet weak var diaChiKhachHangTextField: UITextField!
    @IBOutlet weak var gioGiaoTextField: UITextField!
    @IBOutlet weak var ngayGiaoTextField: UITextField!
    @IBOutlet weak var contextTv: UITextView!
    @IBOutlet weak var ngheMayRadio: UIImageView!
    @IBOutlet weak var khonggoiduocImg: UIImageView!
    @IBOutlet weak var khongnghemayImg: UIImageView!
    var picker : UIPickerView = UIPickerView()
    var dropDownMenu = DropDown()
    var isReview:Bool = false
    var reasonCode = -1
    var hour:Int = 0
    var minutes:Int = 0
    var tinhThanhPhoID:String = ""
    var quanHuyenID:String = ""
    var phuongXaID:String = ""
    var model:Ecom_Order_Item?
    var listTinh:[EcomOrderTinhModel] = []
    var listQuanHuyen:[EcomOrderQuanHuyenModel] = []
    var listPhuongXa:[EcomOrderPhuongXaModel] = []
    var onConfirm: ((Int,String,String,String,String,String,String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchDataTinhThanh()
        self.configureTextField()
        self.bindingData()
    }
    
    private func configureTextField(){
        self.picker.delegate = self
        self.picker.dataSource = self
        self.gioGiaoTextField.inputView = self.picker
        self.ngayGiaoTextField.delegate = self
        self.phuongXaTextField.delegate = self
        self.quanHuyenTextField.delegate = self
        self.tinhThanhPhoTextField.delegate = self
    }
    
    private func bindingData(){
        guard let model = model else {
            return
        }
        self.tinhThanhPhoID = model.codeTinh
        self.quanHuyenID = model.codeHuyen
        self.phuongXaID = model.codeXa
        let arrayDateTime = model.p_timeDelivery.components(separatedBy: " ")
        if arrayDateTime.count > 1 {
            self.ngayGiaoTextField.text = arrayDateTime[0]
            self.gioGiaoTextField.text = arrayDateTime[1]
        }
        self.diaChiKhachHangTextField.text = model.p_addressdelivery
        self.tinhThanhPhoTextField.text = model.tinh
        self.quanHuyenTextField.text = model.huyen
        self.phuongXaTextField.text = model.xa
        
        if isReview {
            let view = UIView()
            self.view.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.leading.bottom.trailing.equalTo(self.parentView)
            }
            self.xacNhanButton.isHidden = true
            self.contextTv.text = model.p_comment
            self.onSelect(tag: Int(model.p_status_call_code) ?? 0)
        }else {
            self.fetchDataQuanHuyen(tinhThanhPhoID: self.tinhThanhPhoID)
            self.fetchDataPhuongXa(quanHuyenID: self.quanHuyenID)
        }
    }
    
    private func fetchDataTinhThanh(){
        Provider.shared.ecomOrders.getEcomOderTinh(success: { [weak self] result in
            guard let self = self else { return }
            self.listTinh = result
            if result.count == 0 {
                self.showPopUpDialog("Danh sách Tỉnh, Thành Phố đang rỗng")
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUpDialog(error.description)
        })
    }
    
    private func fetchDataQuanHuyen(tinhThanhPhoID:String){
        Provider.shared.ecomOrders.getEcomOderQuanHuyen(tinhThanhPhoID: tinhThanhPhoID,success: { [weak self] result in
            guard let self = self else { return }
            self.listQuanHuyen = result
            if result.count == 0 {
                self.showPopUpDialog("Danh sách Quận, Huyện đang rỗng")
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUpDialog(error.description)
        })
    }
    
    private func fetchDataPhuongXa(quanHuyenID:String){
        Provider.shared.ecomOrders.getEcomOderPhuongXa(quanHuyenID: quanHuyenID,success: { [weak self] result in
            guard let self = self else { return }
            self.listPhuongXa = result
            if result.count == 0 {
                self.showPopUpDialog("Danh sách Phường, Xã đang rỗng")
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUpDialog(error.description)
        })
    }
    
    func onSelect(tag: Int) {
        ngheMayRadio.image = tag == 3 ? UIImage(named: "selected_radio_ic") : UIImage(named: "unselected_radio_ic")
        khonggoiduocImg.image = tag == 2 ? UIImage(named: "selected_radio_ic") : UIImage(named: "unselected_radio_ic")
        khongnghemayImg.image = tag == 1 ? UIImage(named: "selected_radio_ic") : UIImage(named: "unselected_radio_ic")
    }
    @IBAction func onDismiss(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func onRadio(_ sender: UIButton) {
        reasonCode = sender.tag
        onSelect(tag: sender.tag)
        //tag = 1 : KH khong nghe may
        // tag = 2: khong goi duoc thue bao
        //tag = 3 kh nghe may
    }
    @IBAction func confirm(_ sender: Any) {
//        if reasonCode == -1 {
//            self.showPopUpDialog("Bạn chưa chọn tình trạng cuộc gọi.")
//            return
//        }
        let value = contextTv.text ?? ""
        guard let ngayGiao = self.ngayGiaoTextField.text,
              !ngayGiao.isEmpty else {
            self.showPopUpDialog("Bạn chưa nhập ngày giao.")
            return
        }
        guard let gioGiao = self.gioGiaoTextField.text,
              !gioGiao.isEmpty else {
            self.showPopUpDialog("Bạn chưa nhập giờ giao.")
            return
        }
        guard let tinhThanhPho = self.tinhThanhPhoTextField.text,
              !tinhThanhPho.isEmpty else {
            self.showPopUpDialog("Bạn chưa nhập Tỉnh/Thành Phố.")
            return
        }
        guard let quanHuyen = self.quanHuyenTextField.text,
              !quanHuyen.isEmpty else {
            self.showPopUpDialog("Bạn chưa nhập Quận/Huyện.")
            return
        }
        guard let phuongXa = self.phuongXaTextField.text,
              !phuongXa.isEmpty else {
            self.showPopUpDialog("Bạn chưa nhập Phường/Xã.")
            return
        }
        guard let diaChi = self.diaChiKhachHangTextField.text,
              !diaChi.isEmpty else {
            self.showPopUpDialog("Bạn chưa nhập địa chỉ khách hàng.")
            return
        }
//        if reasonCode == 3 {
//            guard let text = contextTv.text,
//                  !text.isEmpty else {
//                self.showPopUpDialog("Bạn chưa nhập nội dung liên hệ khách hàng.")
//                return
//            }
//        }
        AlertManager.shared.showAlertMultiOption(title: "Thông Báo", message: "Lưu ý: Bạn sẽ không thể thay đổi địa chỉ và thời gian giao sau khi xác nhận!", options: "Cancel","OK", viewController: self, buttonAlignment: .horizontal) { index in
            if index == 1 {
                self.dismiss(animated: true) {
                    if let xacnhan = self.onConfirm {
                        let ngayGiao = self.ngayGiaoTextField.text ?? ""
                        let gioGiao = self.gioGiaoTextField.text ?? ""
                        let diaChi:String = self.diaChiKhachHangTextField.text ?? ""
                        let tinh:String = self.tinhThanhPhoID
                        let huyen:String = self.quanHuyenID
                        let xa:String = self.phuongXaID
                        xacnhan(self.reasonCode,value,ngayGiao + " " + gioGiao, diaChi, tinh, huyen, xa)
                    }
                }
            }
        }
        
    }
    
    private func showPopUpDialog(_ message:String){
        self.showPopUp(message, "Thông báo", buttonTitle: "OK")
    }
    
    @objc func setupDrop(textField:UITextField) {
        dropDownMenu.setupCornerRadius(10)
        dropDownMenu.anchorView = textField
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.direction = .bottom
        dropDownMenu.offsetFromWindowBottom = 20
        if textField == self.tinhThanhPhoTextField {
            dropDownMenu.dataSource = self.listTinh.map({ object in
                return (object.tenTinh)
            })
        }
        if textField == self.quanHuyenTextField {
            dropDownMenu.dataSource = self.listQuanHuyen.map({ object in
                return (object.tenQuanHuyen)
            })
        }
        if textField == self.phuongXaTextField {
            dropDownMenu.dataSource = self.listPhuongXa.map({ object in
                return (object.tenPhuongXa)
            })
        }
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            guard let self = self else { return }
            textField.text = item
            switch textField.tag {
            case 1:
                self.tinhThanhPhoID = self.listTinh[index].value
                self.fetchDataQuanHuyen(tinhThanhPhoID: self.listTinh[index].value)
            case 2:
                self.quanHuyenID = self.listQuanHuyen[index].value
                self.fetchDataPhuongXa(quanHuyenID: self.listQuanHuyen[index].value)
            case 3:
                self.phuongXaID = self.listPhuongXa[index].value
            default:
                break
            }
            
        }
        self.dropDownMenu.show()
    }
}

extension ComfirmOrderEcomPopup: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.ngayGiaoTextField:
            let presenter: Presentr = {
                let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
                let customPresenter = Presentr(presentationType: dynamicType)
                customPresenter.backgroundOpacity = 0.3
                customPresenter.roundCorners = true
                customPresenter.dismissOnSwipe = false
                customPresenter.dismissAnimated = false
                return customPresenter
            }()
            let calendarVC = CalendarViewController()
            self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
            calendarVC.delegate = self
        default:
            self.setupDrop(textField: textField)
        }
        self.view.endEditing(true)
    }
}

extension ComfirmOrderEcomPopup : CalendarViewControllerDelegate {
    func getDate(dateString: String) {
        DispatchQueue.main.async {
            self.ngayGiaoTextField.text = dateString.replace(target: "-", withString: "/")
        }
    }
}

extension ComfirmOrderEcomPopup : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1:
            return 60

        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) Giờ"
        case 1:
            return "\(row) Phút"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            self.hour = row
        case 1:
            self.minutes = row
        default:
            break
        }
        let gioGiao:String = "\(String(format: "%02d", self.hour)):\(String(format: "%02d", self.minutes))"
        self.gioGiaoTextField.text = gioGiao
    }
}
