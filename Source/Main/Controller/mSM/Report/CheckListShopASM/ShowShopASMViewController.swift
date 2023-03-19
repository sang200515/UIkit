//
//  ShowShopASMViewController.swift
//  fptshop
//
//  Created by Apple on 8/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
protocol ShowShopASMViewControllerDelegate: AnyObject {
    func getListShop(nameString: String, codeString: String)
}

class ShowShopASMViewController: UIViewController {
    
    var tableView: UITableView!
    var listNameAccept:[String] = []
    var listCodeShopAccept:[String] = []
    var nameString = ""
    var allCharacters:[checkLitItem] = []
    var listShop:[ShopByASM] = []
    weak var delegate: ShowShopASMViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "Shop"
        self.navigationController?.navigationBar.isTranslucent = false
        
//        self.navigationItem.hidesBackButton = true
//        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
//        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
//        let btBackIcon = UIButton.init(type: .custom)
//        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
//        btBackIcon.imageView?.contentMode = .scaleAspectFit
//        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
//        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
//        backView.addSubview(btBackIcon)
        
        let btnCheckAll = UIBarButtonItem(title: "All", style: .done, target: self, action: #selector(checkAllShop))
        self.navigationItem.leftBarButtonItem = btnCheckAll
        let btnSearchDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(showName))
        self.navigationItem.rightBarButtonItem = btnSearchDone
        

        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listShop = mSMApiManager.LoadShopByASM().Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if self.listShop.count > 0 {
                    for item in self.listShop {
                        self.allCharacters.append(checkLitItem(name:"\(item.TenShop ?? "")"))
                    }
                    self.setUpView()
                } else {
                    let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
                    emptyView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
                    self.view.addSubview(emptyView);
                }
            }
        }
        
    }
    
    func setUpView() {
//        tableView = UITableView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: self.view.frame.height))
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func checkAllShop() {
        
        self.listNameAccept.removeAll()
        for i in allCharacters {
            i.isSelected = true
            self.listNameAccept.append(i.name ?? "")
        }
        
        tableView.reloadData()
    }
    
    @objc func showName() {
        
//        self.listCodeShopAccept.removeAll()
        var isAll = true
        for i in allCharacters {
            if i.isSelected == false {
                isAll = false
            }
        }
        
        nameString = isAll ? "All" : listNameAccept.joined(separator: ";")
        debugPrint(nameString)
        
        for item in listShop {
            if listNameAccept.contains(item.TenShop ?? "") {
                listCodeShopAccept.append(item.MaShop ?? "")
            }
        }
        let arrShopCodeString = listCodeShopAccept.joined(separator: ",")
        debugPrint("listShopCode: \(arrShopCodeString)")
        self.delegate?.getListShop(nameString: nameString, codeString: arrShopCodeString)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ShowShopASMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }
        
        cell?.textLabel?.text = allCharacters[indexPath.row].name
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        if allCharacters[indexPath.row].isSelected {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        allCharacters[indexPath.row].isSelected = !allCharacters[indexPath.row].isSelected
        tableView.reloadData()
        
        if (listNameAccept.count > 0){
            if allCharacters[indexPath.row].isSelected == true {
                if !(listNameAccept.contains(allCharacters[indexPath.row].name ?? "")) {
                    self.listNameAccept.append(allCharacters[indexPath.row].name ?? "")
                }
            } else {
                if (listNameAccept.contains(allCharacters[indexPath.row].name ?? "")) {
                    var ix = 0
                    for i in listNameAccept {
                        if i == allCharacters[indexPath.row].name{
                            self.listNameAccept.remove(at: ix)
                        }
                        ix = ix + 1
                    }
                }
            }
        } else {
            if allCharacters[indexPath.row].isSelected == true {
                self.listNameAccept.append(allCharacters[indexPath.row].name ?? "")
            }
        }
    }
    
}

class checkLitItem {
    var name: String?
    var isSelected:Bool = false
    
    init(name:String) {
        self.name = name
    }
}
