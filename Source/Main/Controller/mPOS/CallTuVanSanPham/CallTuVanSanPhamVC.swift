	//
	//  CallTuVanSanPhamVC.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 26/12/2022.
	//

import RxCocoa
import RxSwift
import UIKit
import SwiftyJSON
class CallTuVanSanPhamVC: BaseRXViewController, CustomSegmentControlDelegate,UITableViewDelegate {
	let searchBar = UISearchBar()
	@IBOutlet weak var segmentControlView: CustomSegmentControl!
	@IBOutlet weak var tableView: UITableView!
	let model = BehaviorSubject<[CallTuVanSanPhamDataModel]>(value: [])

	private let indexSegmentSubject = BehaviorSubject(value: 0)

	private let viewmodel = CallTuVanSanPhamViewModel()

	override func viewDidLoad() {

		super.viewDidLoad()
		setupUI()
		configureSearchbar()
		self.title = "CALL CHĂM SÓC KH TRẢ GÓP"
		self.bindViewModel()

	}
	override func setupUI() {

		self.tableView.dataSource = nil
		self.tableView.delegate = nil
		self.tableView.separatorStyle = .none
		self.tableView.registerTableCell(CalTuVanSanPhamCell.self)

		segmentControlView.setButtonTitles(buttonTitles: [
			"DS GỌI HÔM NAY", "LỊCH SỬ GỌI",
		])
		segmentControlView.delegate = self
			// Do any additional setup after loading the view.
		segmentControlView.backgroundColor = .white
		segmentControlView.selectorViewColor = Common.Colors.CamKet.green
		segmentControlView.selectorTextColor = .black
		segmentControlView.unSelectorViewColor = UIColor.black
		segmentControlView.unSelectorTextColor = UIColor.black
		self.view.bringSubviewToFront(segmentControlView)

	}
	func configureSearchbar() {
		self.title = ""
		searchBar.placeholder = "Tìm theo số CMND/Căn cước/SĐT"
		searchBar.sizeToFit()
		searchBar.delegate = self
		navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255,blue: 250/255, alpha: 1)
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationController?.navigationBar.isTranslucent = false
		showSearchBarButton(shouldShow: true)
			//tableView

	}

	private func bindViewModel(){
		let searchBarSubject = searchBar.rx.text.orEmpty.debounce(.milliseconds(100), scheduler: MainScheduler.instance).distinctUntilChanged()
		let input = CallTuVanSanPhamViewModel.Input(segmentIndexSubject: indexSegmentSubject.asObservable(), 										searchTextSubject:searchBarSubject.asDriver(onErrorJustReturn: ""))

		let output = viewmodel.transform(input)

		output.responeSearchCustomerSubject.drive(
			tableView.rx.items(
				cellIdentifier:"CalTuVanSanPhamCell",
				cellType: CalTuVanSanPhamCell.self)
		) {  [weak self ] (index, element, cell) in
			guard let self = self else { return }
			self.indexSegmentSubject.subscribe(onNext:{ value in
				cell.employeeStackView.isHidden = (value == 0 ? true : false )
				cell.buttonView.isHidden = (value == 1 ? true : false )
			}).disposed(by: self.bag)
			cell.element = element
			cell.delegate = self
			cell.selectionStyle = .none
		}.disposed(by: bag)

		output.errorRequest.drive {[weak self] errorMsg in
			guard let self = self else { return }
			(errorMsg != "" ) ? self.showAlert(errorMsg ) : nil
		}.disposed(by: bag)

	}
	func change(to index: Int) {
		print("segmentedControlCustom index changed to \(index)")
		self.indexSegmentSubject.onNext(index)
		self.tableView.reloadData()
	}
	private func callCustomer(numberPhone: String) {
		if let url = URL(string: "tel://\(numberPhone)") {
			UIApplication.shared.open(url)
		}
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
extension CallTuVanSanPhamVC {
	func executeObservableSearchHistory(id:String,phone:String) -> Observable<TuVanSanPhamUpdateModel> {
		Observable.create { (observer) -> Disposable in
			Provider.shared.callTuVanSanPhamService.updateCustomer(id: id, phone: phone, success: {
				result in
				observer.onNext(result ?? TuVanSanPhamUpdateModel(JSON:[:])!)
				observer.onCompleted()
			},failure: { (error) in
				observer.onError(error.description as! Error)
			})
			return Disposables.create()
		}
	}
}
extension  CallTuVanSanPhamVC:callTuVanSanPhamCellDelegate{
	func callKH(item: CallTuVanSanPhamDataModel) {
		let alert = UIAlertController(title: "Thông báo", message: "Bạn có chắc chắn thực hiện cuộc gọi vào sđt \(item.phone ?? "")?", preferredStyle: .alert)
		let actionCall = UIAlertAction(title: "Gọi", style: .default) { (_) in
			_ = self.executeObservableSearchHistory(id: "\(item.id ?? 0)", phone: "\(item.phone ?? "")").asObservable().subscribe(onNext:{ [weak self] result in
				guard let self = self else { return }
				if result.success == true {
					if result.data?.result == 1 {
						guard let number = URL(string: "tel://" + (item.phone?.trim() ?? "")) else { return }
						UIApplication.shared.open(number)
					}else {
						self.showAlert("\(result.data?.message ?? "")")
					}
				}else {
					self.showAlert(result.message ?? "Lỗi API => api/Customer/mpos_FRT_Call_Customer_UpdateInfo")
				}
			}).disposed(by: self.bag)
		}
		let actionCalcel = UIAlertAction(title: "Huỷ", style: .default, handler: nil)
		alert.addAction(actionCalcel)
		alert.addAction(actionCall)
		self.present(alert, animated: true, completion: nil)
	}


}
extension CallTuVanSanPhamVC:UISearchBarDelegate{
	func showSearchBarButton(shouldShow: Bool) {
		let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
		space.width = 0
		if shouldShow {
			navigationItem.rightBarButtonItems = [space,
												  UIBarButtonItem(barButtonSystemItem: .search,
																  target: self,
																  action: #selector(handleShowSearchBar))]
		} else {
			navigationItem.rightBarButtonItems = []
		}
	}
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		search(shouldShow: false)
	}
	@objc func handleShowSearchBar() {
		searchBar.becomeFirstResponder()
		search(shouldShow: true)
	}
	func search(shouldShow: Bool) {
		showSearchBarButton(shouldShow: !shouldShow)
		searchBar.showsCancelButton = shouldShow
		navigationItem.titleView = shouldShow ? searchBar : nil
	}

}
