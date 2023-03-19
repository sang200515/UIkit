//
//  ChoosePhuongXaPopupVC.swift
//  QuickCode
//
//  Created by Sang Trương on 16/07/2022.
//

import UIKit

class ChoosePhuongXaPopupVC: UIViewController {
	var listPhuongXa = [ListPhuongXaCore]()
    var listPhuongXaResult = [ListPhuongXaCore]()

	@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
	var onSelected: ((ListPhuongXaCore) -> Void)?

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
        searchBar.delegate = self
        searchBar.placeholder = "tìm kiếm Phường/Xã"
        listPhuongXaResult = listPhuongXa
        searchBar.becomeFirstResponder()
	}
	//MARK: API

}
extension ChoosePhuongXaPopupVC: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listPhuongXa.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "listPhuongXaCell")!
		cell.textLabel?.text = listPhuongXa[indexPath.row].name
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let select = onSelected {
			select(listPhuongXa[indexPath.row])
			self.dismiss(animated: true)
		}
	}
}
extension ChoosePhuongXaPopupVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            listPhuongXa = listPhuongXaResult.filter({
                $0.name!.stripingDiacritics.lowercased().contains(searchText.lowercased())
            })
        } else {
            listPhuongXa = listPhuongXaResult
        }
        tableView.reloadData()

    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did begin..")
        tableView.reloadData()
    }
}
