    //
    //  ChooseQuanHuyenPopupVC.swift
    //  QuickCode
    //
    //  Created by Sang Trương on 16/07/2022.
    //

import UIKit

class PopupChonShopVC: UIViewController {

	var listShop:[ListShopDanhGiaModel] = []
	var listShopResult:[ListShopDanhGiaModel] = []
	var isSelectedItem:Bool = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
	deinit {

	}
    var onSelected: ((ListShopDanhGiaModel) -> Void)?
	var didSelectedItem:((Bool) -> Void)?
	override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		if isSelectedItem == false {
			if let select = didSelectedItem {
				select(false)
			}
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.registerTableCell(ItemShoporASMCell.self)
        searchBar.delegate = self
//        searchBar.placeholder = "Chọn Shop"
		listShopResult = listShop
        searchBar.becomeFirstResponder()
		tableView.separatorStyle = .none
    }
        //MARK: API

}
extension PopupChonShopVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listShop.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueTableCell(ItemShoporASMCell.self)
		cell.bindCell(item: listShop[indexPath.row])
		cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let select = onSelected {
			self.isSelectedItem = true
			select(listShop[indexPath.row])
			self.dismiss(animated: true)
		}
    }
}
extension PopupChonShopVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
			listShop = listShopResult.filter({
                $0.warehouseCode!.localizedCaseInsensitiveContains(searchText) ||    $0.warehouseName!.localizedCaseInsensitiveContains(searchText)
            })
        } else {
			listShop = listShopResult
        }
        tableView.reloadData()

    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did begin..")
        tableView.reloadData()
    }

}
