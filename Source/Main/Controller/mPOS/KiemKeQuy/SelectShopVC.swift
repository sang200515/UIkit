//
//  SelectShopVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 06/09/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import UIKit

class SelectShopVC: UIViewController {
    private var warehouses: [ItemShop] = []
    @IBOutlet weak var shopTxt: SearchTextField!
    var selectedShop: ItemShop?
    override func viewDidLoad() {
        super.viewDidLoad()

        APIManager.searchShop() { (results) in
            var listCom: [String] = []
            self.warehouses = results
            results.forEach { item in
                listCom.append("\(item.code) - \(item.name)")
            }
            self.shopTxt.filterStrings(listCom)
        }
        shopTxt.startVisible = true
        shopTxt.theme.bgColor = UIColor.white
        shopTxt.theme.fontColor = UIColor.black
        shopTxt.theme.fontColor = UIColor.black
        shopTxt.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        shopTxt.theme.cellHeight = Common.Size(s:40)
        shopTxt.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        self.shopTxt.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.shopTxt.text = item.title
            self.selectedShop = self.warehouses.filter({item.title.components(separatedBy: "-").first?.trim() == $0.code}).first
            self.selectedShop?.needFullName = true
            self.view.endEditing(true)
        }
    }
    
    @IBAction func onSelect() {
        if selectedShop != nil {
            let vc = KiemkequyMenuVC()
            vc.shopItem = selectedShop!
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            showPopUp("Bạn chưa chọn shop", "Thông báo", buttonTitle: "OK")
        }
    }
}
