//
//  SelectCompaniesBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 14/01/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SelectCompaniesBaoKimViewController: UIViewController {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tbvCompany: UITableView!
    
    var titleString: String = ""
    var didSelectCompanies: (([BaoKimFilterCompaniesData]) -> Void)?
    private var companies: [BaoKimFilterCompaniesData] = []
    var selectedCompanies: [BaoKimFilterCompaniesData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        hideKeyboardWhenTappedAround()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        lbTitle.text = titleString
        
        vBackground.roundCorners(.allCorners, radius: 5)
        companies = BaoKimDataManager.shared.companies
    }
    
    private func setupTableView() {
        tbvCompany.registerTableCell(LocationBaoKimCell.self)
        tbvCompany.rowHeight = 60
    }
    
    @IBAction func uncheckAllButtonPressed(_ sender: Any) {
        selectedCompanies = []
        tbvCompany.reloadData()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        didSelectCompanies?(selectedCompanies)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SelectCompaniesBaoKimViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(LocationBaoKimCell.self)
        cell.setupCell(location: companies[indexPath.row].name, isSelected: selectedCompanies.contains(where: { $0.id == companies[indexPath.row].id }), isShow: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCompanies.contains(where: { $0.id == companies[indexPath.row].id }) {
            selectedCompanies.removeAll(where: { $0.id == companies[indexPath.row].id })
        } else {
            selectedCompanies.append(companies[indexPath.row])
        }
        
        tbvCompany.reloadData()
    }
}

extension SelectCompaniesBaoKimViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            companies = BaoKimDataManager.shared.companies
            tbvCompany.reloadData()
            return
        }

        var listDataSuggest: [BaoKimFilterCompaniesData] = []
        let locale = Locale(identifier: "vi_VN")
        for item in BaoKimDataManager.shared.companies {
            let string = item.name.folding(options: .diacriticInsensitive, locale: locale)
            if string.contains(searchText.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                listDataSuggest.append(item)
            }
        }

        companies = listDataSuggest
        tbvCompany.reloadData()
    }
}
