//
//  MoiQuanHeVC.swift
//  QuickCode
//
//  Created by Sang Trương on 22/07/2022.
//

import UIKit

class MoiQuanHeVC: UIViewController {
	var listMQH = [ListMoiQuanHe]()
    var onReloadCell:(() ->Void)?
	var index = 0
    var flow = ""
	@IBOutlet weak var tableView: UITableView!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listPhuongXaCell")
	}
	//MARK: API

}
extension MoiQuanHeVC: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listMQH.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "listPhuongXaCell")!
		cell.textLabel?.text = listMQH[indexPath.row].name
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if flow == "create" {
            switch index {
                case 0:
                    CoreInstallMentData.shared.listNguoiLienHe[index]["relationshipName"] = listMQH[indexPath.row].name ?? ""
                    CoreInstallMentData.shared.listNguoiLienHe[index]["relationshipCode"] = listMQH[indexPath.row].code ?? ""

                case 1:
                    CoreInstallMentData.shared.listNguoiLienHe[index]["relationshipName"] = listMQH[indexPath.row].name ?? ""
                    CoreInstallMentData.shared.listNguoiLienHe[index]["relationshipCode"] = listMQH[indexPath.row].code ?? ""

                case 2:
                    CoreInstallMentData.shared.listNguoiLienHe[index]["relationshipName"] = listMQH[indexPath.row].name ?? ""
                    CoreInstallMentData.shared.listNguoiLienHe[index]["relationshipCode"] = listMQH[indexPath.row].code ?? ""

                default:
                    return
            }
        }else if flow == "edit"{
            switch index {
                case 0:
                    CoreInstallMentData.shared.editItemNguoiLienHe1["relationshipName"] = listMQH[indexPath.row].name ?? ""
                    CoreInstallMentData.shared.editItemNguoiLienHe1["relationshipCode"] = listMQH[indexPath.row].code ?? ""

                case 1:
                    CoreInstallMentData.shared.editItemNguoiLienHe2["relationshipName"] = listMQH[indexPath.row].name ?? ""
                    CoreInstallMentData.shared.editItemNguoiLienHe2["relationshipCode"] = listMQH[indexPath.row].code ?? ""

//                case 2:
//                    CoreInstallMentData.shared.editItemListNguoiLienHe[index]["relationshipName"] = listMQH[indexPath.row].name ?? ""
//                    CoreInstallMentData.shared.editItemListNguoiLienHe[index]["relationshipCode"] = listMQH[indexPath.row].code ?? ""

                default:
                    return
            }
        }
        if let reload = onReloadCell {
            reload()
        }
        self.dismiss(animated: true)
	}
}
