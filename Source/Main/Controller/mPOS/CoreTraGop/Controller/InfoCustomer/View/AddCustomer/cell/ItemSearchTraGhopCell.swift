//
//  ItemSearchTraGhopCell.swift
//  QuickCode
//
//  Created by Sang Trương on 24/07/2022.
//
import UIKit
class ItemSearchTraGhopCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var dateMonthLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var cmndLbl: UILabel!
    @IBOutlet weak var gplxLbl: UILabel!
    @IBOutlet weak var addressHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.backgroundColor = .white
    }

    func bindCell(item: CreateCustomerModel) {
        nameLbl.text = item.fullName
        phoneLbl.text = item.phone
        dateMonthLbl.text = Common.convertDateToStringWith(dateString: item.birthDate ?? "", formatIn: "yyyy-MM-dd", formatOut: "dd/MM/yyyy")

        emailLbl.text = item.email
        addressLbl.text = item.addresses?[0].fullAddress ?? ""
        let height = addressLbl.heightForView(text: item.addresses?[0].fullAddress ?? "", font: .systemFont(ofSize: 14, weight: .semibold), width: addressLbl.bounds.size.width)
        addressHeight.constant = height <= 20 ? 20 : height + 10
        cmndLbl.text = item.idCard
        if item.relatedDocType == "DL" {
            gplxLbl.text = "GPLX"
        }else {
            gplxLbl.text = "Sổ hộ khẩu"
        }
    }

}

extension String {
    func convertDate(dateString: String) -> String {
        if !(dateString.isEmpty) {
            let dateStrOld = dateString
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)

            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy"
            let str = newFormatter.string(from: date2 ?? Date())
            return str
        } else {
            return dateString
        }
    }
    func convertCurrencyFloat(value:Float)->String{
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        return "\(fmt.string(for: value)!)đ"
    }
}
