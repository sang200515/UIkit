    //
    //  ChooseQuanHuyenPopupVC.swift
    //  QuickCode
    //
    //  Created by Sang Trương on 16/07/2022.
    //

import UIKit

class ChooseQuanHuyenPopupVC: UIViewController {
    var listQuanhuyen = [ListQuanHuyenCore]()
    var listQuanhuyenResult = [ListQuanHuyenCore]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var onSelected: ((ListQuanHuyenCore) -> Void)?

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listQHCell")
        searchBar.delegate = self
        searchBar.placeholder = "tìm kiếm Quận/Huyện"
        listQuanhuyenResult = listQuanhuyen
        searchBar.becomeFirstResponder()
    }
        //MARK: API

}
extension ChooseQuanHuyenPopupVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listQuanhuyen.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listQHCell")!
        cell.textLabel?.text = listQuanhuyen[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let select = onSelected {
            select(listQuanhuyen[indexPath.row])
            self.dismiss(animated: true)
        }
    }
}
extension ChooseQuanHuyenPopupVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            listQuanhuyen = listQuanhuyenResult.filter({
                $0.name!.localizedCaseInsensitiveContains(searchText)
            })
        } else {
            listQuanhuyen = listQuanhuyenResult
        }
        tableView.reloadData()

    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did begin..")
        tableView.reloadData()
    }
}
