//
//  EcomOrderCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 08/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import CallKit

protocol EcomOrderCellDelegate:AnyObject {
    func didSelect(numberSO:Int)
    func showLichSu(model:Ecom_Order_Item)
}

class EcomOrderCell: UITableViewCell {

    @IBOutlet weak var lichSuThayDoiLabel: UILabel!
        
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var ecomLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cusNameLabel: UILabel!
    
    @IBOutlet weak var viewPhone: UIStackView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var sdtLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var orderTypeLaebel: UILabel!
    
    @IBOutlet weak var totalOrderLabel: UILabel!
    
    @IBOutlet weak var onlinePaymentLabel: UILabel!
    
    @IBOutlet weak var totalPaymentLabel: UILabel!
    
    @IBOutlet weak var employLabel: UILabel!
    
    @IBOutlet weak var smStack: UIStackView!
    @IBOutlet weak var datePhacongStack: UIStackView!
    @IBOutlet weak var timeCallStack: UIStackView!
    @IBOutlet weak var statusCallLabel: UILabel!
    @IBOutlet weak var stackStatusCuocGoi: UIStackView!
    @IBOutlet weak var connectCusLabel: UILabel!
    @IBOutlet weak var stackLienHeKH: UIStackView!
    
    @IBOutlet weak var smLabel: UILabel!
    @IBOutlet weak var timeCallLabel: UILabel!
    @IBOutlet weak var datePhanCong: UILabel!
    
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var chonLaiView: UIView!
    @IBOutlet weak var xacNhanView: UIView!
    
    @IBOutlet weak var chuaPhancongBottom: UIStackView!
    @IBOutlet weak var daPhanCongBottom: UIStackView!
    @IBOutlet weak var phanCongButton: UIButton!
    let viewContent:UIView = UIView()
    
    weak var delegate:EcomOrderCellDelegate?
    var phancong:(()->Void)?
    var xacNhan:(()->Void)?
    var order: Ecom_Order_Item?
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainView.layer.shadowOpacity = 0.6
        mainView.layer.shadowRadius = 3.0
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
        self.addSubview(self.viewContent)
        self.viewContent.snp.makeConstraints { make in
            make.top.equalTo(self.ecomLabel)
            make.bottom.equalTo(self.totalPaymentLabel)
            make.leading.trailing.equalToSuperview()
        }
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.contentClick))
        self.viewContent.addGestureRecognizer(gesture)
        self.setViewLichSu()
    }
    
    private func setViewLichSu(){
        let view = UIView()
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.lichSuThayDoiLabel)
        }
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.xemLaiLichSuThayDoi))
        view.addGestureRecognizer(gesture)
    }
    
    func bindCell(item: Ecom_Order_Item, isChuaPhanCong: Bool) {
        self.order = item
        ecomLabel.text = "Ecom: \(item.docNum)"
        timeLabel.text = item.so_dateFormated
        cusNameLabel.text = item.cardName
        phoneLabel.text = item.u_LicTrad
        orderTypeLaebel.text = item.so_type
        totalOrderLabel.text = "\(Common.convertCurrencyDouble(value: item.u_TMonBi)) đ"
        onlinePaymentLabel.text = "\(Common.convertCurrencyDouble(value: item.downpayment)) đ"
        totalPaymentLabel.text = "\(Common.convertCurrencyDouble(value: item.doctal_pay)) đ"
        employLabel.text = item.employeeName
        chonLaiView.isHidden = !((item.p_allow_action == "Y") && !isChuaPhanCong)
        xacNhanView.isHidden = !((item.call_date != "") && !isChuaPhanCong)
        stackStatusCuocGoi.isHidden = !((item.p_status_name_call != "") && !isChuaPhanCong)
        statusCallLabel.text = item.p_status_name_call
        stackLienHeKH.isHidden = !((item.p_comment != "") && !isChuaPhanCong)
        connectCusLabel.text = item.p_comment
        smStack.isHidden = isChuaPhanCong
        datePhacongStack.isHidden = isChuaPhanCong
        timeCallStack.isHidden = isChuaPhanCong
        chuaPhancongBottom.isHidden = !isChuaPhanCong
        phanCongButton.isHidden = item.p_allow_action == "N"
        daPhanCongBottom.isHidden = isChuaPhanCong
        smLabel.text = item.sm_name
        timeCallLabel.text = item.so_callDate
        datePhanCong.text = item.so_asignDate
        callView.isHidden = isChuaPhanCong
        employLabel.isHidden = isChuaPhanCong
        if !isChuaPhanCong && item.p_Allow_call  == "N" {
            callView.isHidden = true
            xacNhanView.isHidden = true
            chonLaiView.isHidden = true
        }
        self.viewPhone.isHidden = isChuaPhanCong
        self.lichSuThayDoiLabel.isHidden = !(!isChuaPhanCong && item.status == "C" && self.xacNhanView.isHidden == true)

    }
    
    @IBAction func onPhanCong(_ sender: Any) {
        if let work = phancong {
            work()
        }
    }
    
    @IBAction func xacNhanAction(_ sender: Any) {
        if let xn = xacNhan {
            xn()
        }
    }
    @IBAction func chonLaiAction(_ sender: Any) {
        if let work = phancong {
            work()
        }
    }
    
    @IBAction func onCall(_ sender: Any) {
        docNumEcom = order?.docNum ?? 0
        guard let number = URL(string: "tel://" + "\(order?.u_LicTrad ?? "")") else { return }
        UIApplication.shared.open(number)
    }
    
    @objc private func contentClick(){
        self.delegate?.didSelect(numberSO: self.order?.docNum ?? 0)
    }
    
    @objc private func xemLaiLichSuThayDoi(){
        guard let model = self.order else { return }
        self.delegate?.showLichSu(model: model)
    }
}
