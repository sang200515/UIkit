//
//  SelectImeiRaPCPopup.swift
//  fptshop
//
//  Created by Sang Truong on 11/30/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SelectImeiRaPCPopup: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var listImei:[Imei] = []
    var onSelectImei:((Imei)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.alpha = 0.5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ImeiRaPCCell", bundle: nil), forCellReuseIdentifier: "ImeiRaPCCell")
        
    }

    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension SelectImeiRaPCPopup: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listImei.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImeiRaPCCell", for: indexPath) as! ImeiRaPCCell
        let item = listImei[indexPath.row]
        cell.titleLabel.text = "\(item.DistNumber) - " +  "\(item.CreateDate)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let select = onSelectImei {
            select(listImei[indexPath.row])
            self.dismiss(animated: true)
            
        }
       

    }
}
