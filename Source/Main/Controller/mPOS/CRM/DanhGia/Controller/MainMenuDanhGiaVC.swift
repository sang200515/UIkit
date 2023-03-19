//
//  MainMenuDanhGiaVC.swift
//  QuickCode
//
//  Created by Sang Trương on 01/11/2022.
//

import UIKit
import SnapKit
import PopupDialog
class MainMenuDanhGiaVC: UIViewController {

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
			id: "104", name: "Chuyên cần", type: "104",
			icon: UIImage(named: "chuyencan_ic") ?? UIImage())
		items.append(crmItem3)
		let crmItem2 = ItemApp(
			id: "105", name: "Sáng kiến", type: "105",
			icon: UIImage(named: "sangkien_ic") ?? UIImage())
		items.append(crmItem2)
        let crmItem1 = ItemApp(
            id: "106", name: "Lịch sử đánh giá", type: "106",
            icon: UIImage(named: "lichsu_ic") ?? UIImage())
        items.append(crmItem1)
		collectionView.reloadData()
	}

}
// MARK: - UICollectionViewDelegateFlowLayout
extension MainMenuDanhGiaVC: UICollectionViewDelegate, UICollectionViewDataSource,
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
		var check = false
		let item = items[indexPath.row]
		for ruleItem in Cache.ruleMenus {
			if ruleItem.p_messagess == item.type {
				check = true
				break
			}
		}
		if check {
			if(item.id == "104"){
				let vc = ChuyenCanMenuVC()
				self.navigationController?.pushViewController(vc, animated: true)
			}else if(item.id == "105"){
				let vc = QuestionsViewController()
				self.navigationController?.pushViewController(vc, animated: true)
			}else if(item.id == "106"){
				let vc = LichSuDanhGiaVC()
				self.navigationController?.pushViewController(vc, animated: true)
			}
		} else {
			let popup = PopupDialog(title: "Thông báo", message: "Bạn không được cấp quyền sử dụng chức năng này. Vui lòng kiểm tra lại.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
				print("Completed")
			}
			let buttonOne = CancelButton(title: "OK") {}
			popup.addButtons([buttonOne])
			self.present(popup, animated: true, completion: nil)
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
