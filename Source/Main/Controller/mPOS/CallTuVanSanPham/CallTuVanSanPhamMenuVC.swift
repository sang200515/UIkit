	//
	//  CallTuVanSanPhamMenuVC.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 26/12/2022.
	//

import RxCocoa
import RxSwift
import UIKit

class CallTuVanSanPhamMenuVC: BaseRXViewController {
	@IBOutlet weak var tableView: UITableView!
	private let model = ["CALL TƯ VẤN SẢN PHẨM", "CALL CHĂM SÓC KHÁCH HÀNG TRẢ GÓP"]
	private let listIcon:[String] = ["CallTVKH","CallCSKH"]
	let disposeBag = DisposeBag()
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupTableView()

	}
	override func setupUI() {
		self.tableView.separatorStyle = .none
	}
	private func setupTableView() {
		self.tableView.registerTableCell(CallTuVanSanPhamMenuCell.self)
		_ = Observable.of(model).bind(
			to: tableView.rx.items(
				cellIdentifier:
					"CallTuVanSanPhamMenuCell",
				cellType: CallTuVanSanPhamMenuCell
					.self)
		) { (index, element, cell) in
			cell.titleLabel.text = element
			cell.iconImage.image  = UIImage(named: self.listIcon[index])
			cell.selectionStyle = .none
		}
		.disposed(by: bag)

		self.tableView.rx.itemSelected.subscribe(onNext: { indexPath in
			var vc = UIViewController()
			switch indexPath.row {
				case 0:
					vc = CallCSKHViewController()
				case 1:
					vc = CallTuVanSanPhamVC()
				default:
					return
			}
			self.navigationController?.pushViewController(
				vc, animated: true)
		}).disposed(by: self.bag)
	}

}
