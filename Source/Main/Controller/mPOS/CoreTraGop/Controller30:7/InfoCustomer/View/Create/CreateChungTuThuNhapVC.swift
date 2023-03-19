//
//  CreateChungTuThuNhapVC.swift
//  QuickCode
//
//  Created by Sang Trương on 19/07/2022.
//

import UIKit

class CreateChungTuThuNhapVC: BaseController {
	var flow: String = ""
	var listImgSHK = ["backtoschool", "2"]
	var listImageSeleted: [UIImage] = []
	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.registerTableCell(ChungTuCell.self)

	}

	@IBAction func onClickContinue(_ sender: Any) {
		print(listImgSHK.count)
		print(listImageSeleted.count)
		let vc = CreateRelateCustomer()
		vc.flow = flow
		self.navigationController?.navigationBar.tintColor = .white
		self.navigationController?.pushViewController(vc, animated: true)
	}
	@IBAction func addNewImageClicked(_ sender: Any) {
		//đã có sẵn place place holder để chịọn
		//        if listImgSHK.count - 1 != listImageSeleted.count {
		//
		//        }else {
		//            self.showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn ảnh đã tạo", titleButton: "OK")
		//        }

		var a = 1
		listImgSHK.append("a \(a)")
		tableView.reloadData()
		a += 1
	}

}
extension CreateChungTuThuNhapVC: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 170
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listImgSHK.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueTableCell(ChungTuCell.self)
		cell.bindCell(mainController: self, i: indexPath.row)
		cell.onCaptureImage = { image, index in
			print(index, image)

			self.listImageSeleted.append(image)
		}

		return cell
	}

}
