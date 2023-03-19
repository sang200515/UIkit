    //
    //  ChoooseThanhPhoVCPopupVC.swift
    //  QuickCode
    //
    //  Created by Sang Trương on 16/07/2022.
    //

import UIKit


class ChoooseThanhPhoVCPopupVC: UIViewController {
    var listThanhPho = [ListTinhThanhCore]()
    var listThanhPhoSearchResult = [ListTinhThanhCore]()

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    var onSelected: ((ListTinhThanhCore) -> Void)?

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listTPCell")
        searchBar.delegate = self
        searchBar.placeholder = "tìm kiếm Tỉnh/Thành Phố"
        listThanhPhoSearchResult = listThanhPho
        searchBar.becomeFirstResponder()

    }
        //MARK: API

}
extension ChoooseThanhPhoVCPopupVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listThanhPho.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTPCell")!
        cell.textLabel?.text = listThanhPho[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let select = onSelected {
            select(listThanhPho[indexPath.row])
            self.dismiss(animated: true)
        }
    }
}
extension ChoooseThanhPhoVCPopupVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            listThanhPho = listThanhPhoSearchResult.filter({
                $0.name!.localizedCaseInsensitiveContains(searchText)
            })
        } else {
            listThanhPho = listThanhPhoSearchResult
        }
        tableView.reloadData()

    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did begin..")
        tableView.reloadData()
    }
}
