//
//  SelectLocationBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 17/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SelectLocationBaoKimViewController: UIViewController {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tbvLocation: UITableView!
    
    var titleString: String = ""
    var didSelectLocation: ((BaoKimLocation) -> Void)?
    private var locations: [BaoKimLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        lbTitle.text = titleString
        
        vBackground.roundCorners(.allCorners, radius: 5)
        locations = BaoKimDataManager.shared.cities
    }
    
    private func setupTableView() {
        tbvLocation.registerTableCell(LocationBaoKimCell.self)
        tbvLocation.rowHeight = 60
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SelectLocationBaoKimViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(LocationBaoKimCell.self)
        cell.setupCell(location: locations[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissKeyboard()
        didSelectLocation?(locations[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}

extension SelectLocationBaoKimViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            locations = BaoKimDataManager.shared.cities
            tbvLocation.reloadData()
            return
        }

        var listDataSuggest: [BaoKimLocation] = []
        let locale = Locale(identifier: "vi_VN")
        for item in BaoKimDataManager.shared.cities {
            let string = item.name.folding(options: .diacriticInsensitive, locale: locale)
            if string.contains(searchText.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                listDataSuggest.append(item)
            }
        }

        locations = listDataSuggest
        tbvLocation.reloadData()
    }
}
