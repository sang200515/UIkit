//
//  ListShopASMViewController.swift
//  fptshop
//
//  Created by Apple on 8/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListShopASMViewController: UIViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Shop ASM"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 45)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        let btnAdd = UIButton.init(type: .custom)
        btnAdd.setImage(#imageLiteral(resourceName: "add-1"), for: UIControl.State.normal)
        btnAdd.imageView?.contentMode = .scaleAspectFit
        btnAdd.addTarget(self, action: #selector(addNewShopASM), for: UIControl.Event.touchUpInside)
        btnAdd.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        viewRightNav.addSubview(btnAdd)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addNewShopASM() {
        let vc = AddNewCheckListShopASMViewController()
        self.navigationController?.pushViewController(vc, animated: true);
    }

}

extension ListShopASMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Shop1"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailCheckListShopASMViewController()
        self.navigationController?.pushViewController(vc, animated: true);
    }
}
