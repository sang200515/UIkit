//
//  ShinhanPaymentCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 02/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShinhanPaymentCell: UITableViewCell {

    @IBOutlet weak var goitraGopStack: UIStackView!
    @IBOutlet weak var laiSuatStack: UIStackView!
    @IBOutlet weak var kyHanStack: UIStackView!
    @IBOutlet weak var goitraGopLbl: UILabel!
    @IBOutlet weak var laiSuatLbl: UILabel!
    @IBOutlet weak var kyHanlbl: UILabel!
    @IBOutlet weak var thanhTienLbl: UILabel!
    @IBOutlet weak var traTruocLbl: UILabel!
    @IBOutlet weak var tienVayLbl: UILabel!
    @IBOutlet weak var phiBaohienLbl: UILabel!
    @IBOutlet weak var giamgiaLbl: UILabel!
    @IBOutlet weak var tienCocLaLbl: UILabel!
    @IBOutlet weak var tienCocStackview: UIStackView!
    @IBOutlet weak var tongDonHangLbl: UILabel!
    var isHistory:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindCell(totalPay: Float, tratruoc: Float, tienVay: Float,giamgia:Float,baohiem: Float,tongDonhang: Int, goitragop: ShinhanTragopData? = nil, kyhan: ShinhanLoanTenure? = nil,sotiencoc:Float) {
        if goitragop != nil {
            goitraGopStack.isHidden = false
            laiSuatStack.isHidden = false
            kyHanStack.isHidden = false
            goitraGopLbl.text = goitragop?.schemeName
            let laiSuat = String(format: "%g", goitragop?.interestRate ?? 0)
            laiSuatLbl.text = "\(laiSuat)%"
            kyHanlbl.text = kyhan?.text
        } else {
            goitraGopStack.isHidden = true
            laiSuatStack.isHidden = true
            kyHanStack.isHidden = true
        }
        thanhTienLbl.text = Common.convertCurrency(value: totalPay.round())
        traTruocLbl.text = Common.convertCurrency(value: tratruoc.round())
        tienVayLbl.text = Common.convertCurrency(value: tienVay.round())
        phiBaohienLbl.text = Common.convertCurrency(value: baohiem.round())
        giamgiaLbl.text = Common.convertCurrency(value: giamgia.round())
        tienCocLaLbl.text = Common.convertCurrency(value: sotiencoc.round())
        tongDonHangLbl.text = Common.convertCurrency(value: tongDonhang)
    }
    
    func bindCellDetail(item: ShinhanPayment?) {
        goitraGopStack.isHidden = false
        laiSuatStack.isHidden = false
        kyHanStack.isHidden = false
        tienCocLaLbl.text = Common.convertCurrencyFloat(value: item?.U_DownPay ?? 0)
        goitraGopLbl.text = item?.schemeName
        laiSuatLbl.text = "\(item?.interestRate.clean ?? "0")%"
        kyHanlbl.text = "\(item?.loanTenor.clean ?? "0") tháng"
        thanhTienLbl.text = Common.convertCurrencyFloat(value: item?.totalPrice ?? 0)
        traTruocLbl.text = Common.convertCurrencyFloat(value: item?.downPayment ?? 0)
        tienVayLbl.text = Common.convertCurrencyFloat(value: item?.loanAmount ?? 0)
        phiBaohienLbl.text = Common.convertCurrencyFloat(value: item?.insuranceFee ?? 0)
        giamgiaLbl.text = Common.convertCurrencyFloat(value: item?.discount ?? 0)
        tongDonHangLbl.text = Common.convertCurrencyFloat(value: item?.finalPrice ?? 0)
    }
    
}

extension Double {
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
