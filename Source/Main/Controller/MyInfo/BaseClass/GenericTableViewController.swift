//
//  GenericTableViewController.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/23/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class GenericCell<U>: UITableViewCell {
    var item: U!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GenericTableViewController<T: GenericCell<U>, U>: UITableViewController {
    
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reuseIdentifier = NSStringFromClass(T.self)
        tableView.register(T.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = NSStringFromClass(T.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
        cell.item = items[indexPath.row]
        return cell
    }
}
