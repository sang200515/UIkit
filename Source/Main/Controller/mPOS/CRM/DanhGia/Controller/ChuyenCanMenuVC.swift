//
//  ChuyenCanMenuVC.swift
//  QuickCode
//
//  Created by Sang Trương on 01/11/2022.
//

import SnapKit
import UIKit

class ChuyenCanMenuVC: UIViewController {
	private let viewmodel = DanhGiaViewModel()
	var masterDataObject: EvaluateMasterDataModel?
	// MARK: - Properties
	private var items = [ItemApp]()

	private var collectionView: UICollectionView!

	private var cellWidth: CGFloat = 0
	private var coCellWidth: CGFloat = 0
	private var coCellHeight: CGFloat = 0
	// MARK: - Lifecycle
	override func viewDidLoad() {
		self.title = "Đánh giá NÂNG TẦM DỊCH VỤ"
		self.navigationItem.setHidesBackButton(true, animated: true)
		configureNavigationItem()
		configureUI()
		bindViewModel()

	}
	override func viewWillAppear(_ animated: Bool) {
		//notification center
		ProgressView.shared.hide()

	}
	private func bindViewModel() {

	}
	private func checUser() {
		Provider.shared.eveluateAPIService.checkUser(
			success: { [weak self] result in
				guard let self = self else { return }
				if  result?.type ?? "" == "SM"{
					let vc = DanhGiaVC()
					vc.loaiUser = "SM"
					vc.type = 1
					self.navigationController?.pushViewController(vc, animated: true)
				}else if  result?.type ?? "" == "BO"{
					let vc = DanhGiaVC()
					vc.loaiUser = "BO"
					vc.loaiDanhGia = 1
					vc.type = 1
					self.navigationController?.pushViewController(vc, animated: true)
				} else {
					let vc = ChonNhanVienVC()
					if  result?.type ?? "" == "ASM" {
						vc.typeSearch = "Shop"
					}else {
						vc.typeSearch = ""
					}
					vc.typeUser = result?.type ?? ""
					vc.loaiDanhGia = 1
					self.navigationController?.pushViewController(vc, animated: true)
				}
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlert(error.description)
			})
	}
	// MARK: - Selectors
	@objc func handleBack() {
		navigationController?.popViewController(animated: true)
	}
	// MARK: - Helpers

	func configureNavigationItem() {
		//left menu icon
		let btLeftIcon = Common.initBackButton()
		btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
		let barLeft = UIBarButtonItem(customView: btLeftIcon)
		self.navigationItem.leftBarButtonItem = barLeft
	}
	func configureUI() {
		view.backgroundColor = UIColor(hexString: "#F9F9FA")

		cellWidth = self.view.frame.size.width
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = UICollectionView.ScrollDirection.vertical
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		layout.itemSize = CGSize(width: 111, height: 10)
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		collectionView = UICollectionView(
			frame: CGRect(
				x: 25, y: 20, width: self.view.frame.size.width - 50,
				height: self.view.frame.size.height
					- ((self.navigationController?.navigationBar.frame.size.height)!
						+ UIApplication.shared.statusBarFrame.height)),
			collectionViewLayout: layout)
		view.addSubview(collectionView)

		collectionView.snp.updateConstraints { make in
			make.top.bottom.equalToSuperview()
			make.centerX.equalToSuperview()
			make.width.equalToSuperview().offset(-10)
		}
		collectionView.backgroundColor = UIColor(hexString: "#F9F9FA")
		collectionView.delegate = self
		collectionView.dataSource = self

		collectionView.register(
			ItemCoreCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCoreCollectionViewCell")
		self.view.addSubview(collectionView)

		let crmItem3 = ItemApp(
			id: "103", name: "Đánh giá Nhân Viên", type: "1",
			icon: UIImage(named: "employee_ic") ?? UIImage())
		items.append(crmItem3)
		let crmItem2 = ItemApp(
			id: "102", name: "Đánh giá Đối Tác", type: "2",
			icon: UIImage(named: "partner_ic") ?? UIImage())
		items.append(crmItem2)
		collectionView.reloadData()
	}

}
// MARK: - UICollectionViewDelegateFlowLayout
extension ChuyenCanMenuVC: UICollectionViewDelegate, UICollectionViewDataSource,
	UICollectionViewDelegateFlowLayout
{
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}

	func collectionView(
		_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {

		let coCell: ItemCoreCollectionViewCell =
			collectionView.dequeueReusableCell(
				withReuseIdentifier: "ItemCoreCollectionViewCell", for: indexPath)
			as! ItemCoreCollectionViewCell

		let item = items[indexPath.item]
		coCell.setUpCollectionViewCell(item: item)
		coCell.layer.borderWidth = 1
		coCell.backgroundColor = .white
		coCell.itemLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		coCell.contentView.layer.cornerRadius = 25
		coCell.layer.masksToBounds = true
		coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
		coCell.layer.cornerRadius = 10
		coCell.dropShadowV2()
		return coCell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let item = items[indexPath.row]
		if item.type == "1" {
			self.checUser()
		} else if item.type == "2" {
			let vc = DanhGiaVC()
			vc.loaiUser = "BO"
			vc.type = 2
			vc.loaiDanhGia = 2
			self.navigationController?.pushViewController(vc, animated: true)
		}

	}
	func collectionView(
		_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		coCellWidth = (cellWidth / 2) - 30
		coCellHeight = coCellWidth * 0.8
		let size = CGSize(width: coCellWidth, height: coCellHeight)
		return size
	}

	func collectionView(
		_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		return 10
	}

	func collectionView(
		_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int
	) -> CGFloat {
		return 10
	}

	func collectionView(
		_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
	}
}

class ItemCoreCollectionViewCell: UICollectionViewCell {

	var icon: UIImageView!
	var itemLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	public func setUpCollectionViewCell(item: ItemApp) {
		contentView.backgroundColor = UIColor.white
		contentView.layer.cornerRadius = 5
		if item.id != "0" {
			icon = UIImageView()
			itemLabel = UILabel()
			self.contentView.addSubview(icon)
			self.contentView.addSubview(itemLabel)
			icon.snp.makeConstraints { make in
				make.width.height.equalTo(40)
				make.centerY.equalToSuperview().offset(-20)
				make.centerX.equalToSuperview()
			}
			itemLabel.snp.makeConstraints { make in
				make.top.equalTo(icon.snp.bottom).offset(10)
				make.leading.equalToSuperview().offset(10)
				make.trailing.equalToSuperview().offset(-10)
				make.bottom.equalToSuperview().offset(-10)
			}
			icon.image = item.icon
			icon.contentMode = .scaleAspectFit

			itemLabel.text = item.name
			itemLabel.textAlignment = .center
			itemLabel.numberOfLines = 2
			itemLabel.font = UIFont.systemFont(ofSize: 12)
			itemLabel.textColor = UIColor(netHex: 0x6C6B6B)
			itemLabel.textColor = .black
			contentView.addSubview(icon)
			contentView.addSubview(itemLabel)
			contentView.dropShadowV2()
			contentView.layer.masksToBounds = true
		}
	}

}
