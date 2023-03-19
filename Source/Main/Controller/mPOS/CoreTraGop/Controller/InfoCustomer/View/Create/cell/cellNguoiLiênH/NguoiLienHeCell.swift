//
//  NguoiLienHeCell.swift
//  QuickCode
//
//  Created by Sang Trương on 19/07/2022.
//

import UIKit
import SkyFloatingLabelTextField
class NguoiLienHeCell : UITableViewCell {
    var controller: UIViewController?
    @IBOutlet weak var infoContactPersonLbl: UILabel!
    @IBOutlet weak var tfName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var tfRalationShip: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var tfPhone: SkyFloatingLabelTextFieldWithIcon!
    var index = 0
    var flow:String = ""
    var onselectedTxt: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()

    }


    func bindCell(item:[String:Any],index:Int,controller:UIViewController,flow:String) {
        
        tfName.delegate = self
        tfRalationShip.delegate = self
        tfPhone.delegate = self
        infoContactPersonLbl.text = "Thông tin người liên hệ \(index + 1)"
        self.index = index
        let tapFromField1 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromAddress))
        tfRalationShip.addGestureRecognizer(tapFromField1)
        tfRalationShip.isUserInteractionEnabled = true
        setupTextField()
        self.flow = flow
        self.controller = controller
        switch flow {
            case "create":
                CoreInstallMentData.shared.listNguoiLienHe[index]["personNum"] = index + 1
            case "edit":
                tfRalationShip.text = item["relationshipName"] as? String
                tfPhone.text = item["phone"] as? String
                tfName.text = item["fullName"] as? String
            default :
                return
        }
    }

    private func setupTextField(){
        applySkyscannerThemeWithIcon(textField: tfName)
        applySkyscannerThemeWithIcon(textField: tfRalationShip)
        applySkyscannerThemeWithIcon(textField: tfPhone)


        tfName.iconWidth = 12.5
        tfName.iconType = .image
        tfName.iconImage = UIImage(named: "ic_user")!
        tfName.placeholder =  "Tên người liên hệ"

        tfRalationShip.iconWidth = 12.5
        tfRalationShip.iconType = .image
        tfRalationShip.iconImage = UIImage(named: "ic_user")!
        tfRalationShip.placeholder =  "Mối quan hệ với khách hàng"

        tfPhone.iconWidth = 12.5
        tfPhone.iconType = .image
        tfPhone.iconImage = UIImage(named: "ic_phone")!
        tfPhone.placeholder =  "Số điện thoại"

        
    }
    @objc func tapFromAddress()
    {
        let detailViewController = MoiQuanHeVC()
        detailViewController.index = index
        Provider.shared.coreInstallmentService.getListMoiQuanHe(success: { [weak self] result in
            guard let self = self else { return }
            detailViewController.listMQH = result
            detailViewController.flow = self.flow
            let nav = UINavigationController(rootViewController: detailViewController)
            detailViewController.onReloadCell =  {
                self.reloadCell()
            }
            nav.modalPresentationStyle = .pageSheet
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                    sheet.prefersGrabberVisible = true
                    sheet.preferredCornerRadius = 30
                    sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                    sheet.prefersEdgeAttachedInCompactHeight = true
                }
            } else {
            }
            self.controller?.present(nav, animated: true, completion: nil)
        },
                                                                failure: { [weak self] error in
            guard let self = self else { return }
            self.controller?.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    private func applySkyscannerThemeWithIcon(textField: SkyFloatingLabelTextFieldWithIcon) {
        self.applySkyscannerTheme(textField: textField)
        let overcastBlueColor: UIColor = UIColor(named: "primary_green")!
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor
        textField.iconColor = overcastBlueColor
        textField.selectedIconColor = overcastBlueColor
        textField.iconFont = UIFont(name: "FontAwesome", size: 15)
    }

    private func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        let overcastBlueColor: UIColor = UIColor(named: "primary_green")!
        textField.tintColor = overcastBlueColor
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor

    }
    @IBAction func chooseRelation(_ sender: Any) {

    }
    private func reloadCell(){
        if flow == "create"{
            switch index {
                case 0:
                    tfRalationShip.text =   (CoreInstallMentData.shared.listNguoiLienHe[index]["relationshipName"] as! String)
                case 1:
                    tfRalationShip.text = (CoreInstallMentData.shared.listNguoiLienHe[index]["relationshipName"] as! String)
                case 2:
                    tfRalationShip.text = (CoreInstallMentData.shared.listNguoiLienHe[index]["relationshipName"] as! String)
                default:
                    return
            }
        }else if flow == "edit" {
            switch index {
                case 0:
                    tfRalationShip.text =   (CoreInstallMentData.shared.editItemNguoiLienHe1["relationshipName"] as! String)
                case 1:
                    tfRalationShip.text = (CoreInstallMentData.shared.editItemNguoiLienHe2["relationshipName"] as! String)
//                case 2:
//                    tfRalationShip.text = (CoreInstallMentData.shared.editItemListNguoiLienHe[index]["relationshipName"] as! String)
                default:
                    return
            }
        }

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let select = onselectedTxt {
            select()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        let index = index
        switch flow {
            case "create":
                if textField == tfName {
                    print(textField.text ?? "")
                    CoreInstallMentData.shared.listNguoiLienHe[index]["fullName"] = textField.text ?? ""
                    print(CoreInstallMentData.shared.listNguoiLienHe)

                }

                if textField == tfRalationShip {
                    print(textField.text ?? "")
                    CoreInstallMentData.shared.listNguoiLienHe[index]["relationshipName"] = textField.text ?? ""
                    print(CoreInstallMentData.shared.listNguoiLienHe)

                }
                if textField == tfPhone {
                    print(textField.text ?? "")
                    CoreInstallMentData.shared.listNguoiLienHe[index]["phone"] = textField.text ?? ""
                    print(CoreInstallMentData.shared.listNguoiLienHe)
                }
            case "edit":
                if textField == tfName {
                    if index == 0 {
                        CoreInstallMentData.shared.editItemNguoiLienHe1["fullname"] = textField.text ?? ""
                    }else {
                        CoreInstallMentData.shared.editItemNguoiLienHe2["fullName"] = textField.text ?? ""
                    }
                    print(textField.text ?? "")
                }

                if textField == tfRalationShip {
                    print(textField.text ?? "")
                    if index == 0 {
                        CoreInstallMentData.shared.editItemNguoiLienHe1["relationshipName"] = textField.text ?? ""
                    }else {
                        CoreInstallMentData.shared.editItemNguoiLienHe2["relationshipName"] = textField.text ?? ""
                    }
                }
                if textField == tfPhone {
                    print(textField.text ?? "")
                    if index == 0 {
                        CoreInstallMentData.shared.editItemNguoiLienHe1["phone"] = textField.text ?? ""
                    }else {
                        CoreInstallMentData.shared.editItemNguoiLienHe2["phone"] = textField.text ?? ""
                    }
                }
            default :
                return
        }
    }

}


extension NguoiLienHeCell: UITextFieldDelegate {
    func textField(
        _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String
    ) -> Bool {
        if textField == tfPhone {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)

            return range.location < 10 && allowedCharacters.isSuperset(of: characterSet)
        }

        return true
    }
}
