//
//  PopupHuyDonHangMiraeViewController.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 18/05/2022.
//

import UIKit
import DropDown

protocol PopupHuyDonHangMiraeViewControllerDelegate:AnyObject {
    func cancelSuccess()
}

class PopupHuyDonHangMiraeViewController : BaseViewController {
    
    var model:[CapNhatChungTuMiraeEntity.DataLyDoHuyModel] = []
    var docEntry:String = ""
    let dropDown = DropDown()
    weak var delegate:PopupHuyDonHangMiraeViewControllerDelegate?
    
    let lydoTextField:SelectTextField = {
        let textField = SelectTextField()
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.dropDownImageView.image = UIImage(named: "arrowDropICON")
        textField.placeholder = "Chọn lý do hủy"
        return textField
    }()
    
    let titleLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "LÝ DO HỦY"
        label.textAlignment = .center
        label.textColor = Common.TraGopMirae.Color.green
        return label
    }()
    
    let textView:UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        return textView
    }()
    
    let cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("THOÁT", for: .normal)
        button.setTitleColor(Common.TraGopMirae.Color.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        return button
    }()
    
    let confirmButton:UIButton = {
        let button = UIButton()
        button.setTitle("XÁC NHẬN", for: .normal)
        button.setTitleColor(Common.TraGopMirae.Color.green, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        return button
    }()
    
    let parentView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.lydoTextField.selectTextFieldDelegate = self
        
        self.view.addSubview(self.textView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.lydoTextField)
        self.view.addSubview(self.cancelButton)
        self.view.addSubview(self.confirmButton)
        self.view.addSubview(self.parentView)
        
        self.textView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 40)
            make.height.equalTo(150)
        }
        self.lydoTextField.snp.makeConstraints { make in
            make.bottom.equalTo(self.textView.snp.top).offset(-10)
            make.leading.trailing.equalTo(self.textView)
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField - 18)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.lydoTextField.snp.top).offset(-10)
            make.leading.trailing.equalTo(self.textView)
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField - 18)
        }
        self.cancelButton.snp.makeConstraints { make in
            make.top.equalTo(self.textView.snp.bottom).offset(10)
            make.leading.equalTo(self.textView)
            make.trailing.equalTo(self.view.snp.centerX)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.confirmButton.snp.makeConstraints { make in
            make.top.equalTo(self.textView.snp.bottom).offset(10)
            make.trailing.equalTo(self.textView)
            make.leading.equalTo(self.view.snp.centerX)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.parentView.snp.makeConstraints { make in
            make.top.leading.equalTo(self.titleLabel).offset(-10)
            make.bottom.trailing.equalTo(self.confirmButton).offset(10)
        }
        self.view.insertSubview(self.parentView, at: 0)
        
        self.cancelButton.addTarget(self, action: #selector(self.cancelTapped), for: .touchUpInside)
        self.confirmButton.addTarget(self, action: #selector(self.confirmTapped), for: .touchUpInside)
        self.loadLyDoHuy()
        
    }
    
    private func loadLyDoHuy(){
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        ApiRequestMirae.request(.loadLyDoHuy(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)"),CapNhatChungTuMiraeEntity.LyDoHuyModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.model = data.data ?? []
                }else {
                    self.showAlert(message: "Lấy lý do hủy không thành công")
                }
            case .failure(let error):
                self.showAlert(message: "Lấy lý do hủy không thành công. \(error.message)")
            }
        }
    }
    
    @objc private func cancelTapped(){
        self.dismiss(animated: true)
    }
    @objc private func confirmTapped(){
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        if self.lydoTextField.text == "Khác" {
            if self.textView.text.isEmpty {
                self.showAlert(message: "Vui lòng nhập lý do hủy")
                return
            }
        }
        ApiRequestMirae.request(.huyHopDong(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", appDocEntry: self.docEntry, reason: self.lydoTextField.text == "Khác" ? self.textView.text ?? "" : self.lydoTextField.text ?? ""), ThongTinKhachHangMireaEntity.HuyDonHangModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    AlertManager.shared.alertWithViewController(title: "Thông báo", message: data.message ?? "", titleButton: "OK", viewController: self) {
                        self.dismiss(animated: true) {
                            self.delegate?.cancelSuccess()
                        }
                    }
                }else {
                    self.showAlert(message: "Hủy đơn hàng không thành công. \(data.message ?? "")")
                }
            case .failure(let error):
                self.showAlert(message: "Hủy đơn hàng không thành công. \(error.message)")
            }
        }
        
    }
    private func showAlert(message:String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: message, titleButton: "OK", viewController: self) {
            
        }
    }
}

extension PopupHuyDonHangMiraeViewController : SelectTextFieldDelegate {
    func selectTextField(index: Int) {
        self.dropDown.direction = .bottom
        self.dropDown.offsetFromWindowBottom = 20
        self.dropDown.anchorView = self.lydoTextField
        self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)! + 5)
 
        self.dropDown.dataSource = model.map({ item in
            return item.text ?? ""
        })
        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lydoTextField.text = item
        }
        self.dropDown.show()
    }
}
