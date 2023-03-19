//
//  ListUserCCViewController.swift
//  fptshop
//
//  Created by Apple on 5/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol ListUserCCViewControllerDelegate: AnyObject {
    func getListCC(ccString: String, codeCCString: String)
}

class ListUserCCViewController: UIViewController {
    
    var tableView: UITableView!
    var listNameAccept:[String] = []
    var listCodeCCAccept:[String] = []
    var nameString = ""
    lazy var searchBar:UISearchBar = UISearchBar()
    var searchActive : Bool = false
    
    var allCharacters:[Character] = []
    var listCC:[BillLoadCC] = []
    
    weak var delegate: ListUserCCViewControllerDelegate?
    var arrFilter = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = true

        for item in listCC {
            self.allCharacters.append(Character(name: item.Name ?? ""))
        }
        self.arrFilter = self.allCharacters
        
        self.navigationItem.hidesBackButton = true
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        backView.addSubview(btBackIcon)
        
        let btnSearchDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(showName))
        self.navigationItem.rightBarButtonItem = btnSearchDone
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        self.navigationItem.titleView = searchBar
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        
        tableView = UITableView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: self.view.frame.height))
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
    
    @objc func showName() {
        nameString = listNameAccept.joined(separator: ";")
        debugPrint(nameString)
        
        for item in listCC {
            if listNameAccept.contains(item.Name!) {
                listCodeCCAccept.append(item.Code!)
            }
        }
        let arrCodeCCString = listCodeCCAccept.joined(separator: ",")
        debugPrint("ccCode: \(arrCodeCCString)")
        self.delegate?.getListCC(ccString: nameString, codeCCString: arrCodeCCString)
        self.navigationController?.popViewController(animated: true)
    }
    
    func find(value searchValue: String, in array: [Character]) -> Int? {
        for (index, value) in array.enumerated() {
            if value.name == searchValue {
                return index
            }
        }
        return nil
    }
}

extension ListUserCCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let key = self.searchBar.text ?? ""
        if key.count > 0 {
            return arrFilter.count
        } else {
            return allCharacters.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }
        
        let key = self.searchBar.text ?? ""
        if key.count > 0 {
            cell?.textLabel?.text = arrFilter[indexPath.row].name
            if arrFilter[indexPath.row].isSelected {
                cell?.accessoryType = .checkmark
            } else {
                cell?.accessoryType = .none
            }
            cell?.selectionStyle = .none
            
        } else {
            cell?.textLabel?.text = allCharacters[indexPath.row].name
            if allCharacters[indexPath.row].isSelected {
                cell?.accessoryType = .checkmark
            } else {
                cell?.accessoryType = .none
            }
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let key = self.searchBar.text ?? ""
        if key.count > 0 {
            arrFilter[indexPath.row].isSelected = !arrFilter[indexPath.row].isSelected
            tableView.reloadData()
            
            if (listNameAccept.count > 0){
                if arrFilter[indexPath.row].isSelected == true {
                    if !(listNameAccept.contains(arrFilter[indexPath.row].name)) {
                        self.listNameAccept.append(arrFilter[indexPath.row].name)
                        
                    }
                } else {
                    if (listNameAccept.contains(arrFilter[indexPath.row].name)) {
                        var ix = 0
                        for i in listNameAccept {
                            if i == arrFilter[indexPath.row].name{
                                self.listNameAccept.remove(at: ix)
                            }
                            ix = ix + 1
                        }
                    }
                }
            } else {
                if arrFilter[indexPath.row].isSelected == true {
                    self.listNameAccept.append(arrFilter[indexPath.row].name)
                }
            }
            
            let index = find(value: arrFilter[indexPath.row].name, in: allCharacters)
            allCharacters[index ?? 0].isSelected = arrFilter[indexPath.row].isSelected
            
        } else {
            allCharacters[indexPath.row].isSelected = !allCharacters[indexPath.row].isSelected
            tableView.reloadData()
            
            if (listNameAccept.count > 0){
                if allCharacters[indexPath.row].isSelected == true {
                    if !(listNameAccept.contains(allCharacters[indexPath.row].name)) {
                        self.listNameAccept.append(allCharacters[indexPath.row].name)
                    }
                } else {
                    if (listNameAccept.contains(allCharacters[indexPath.row].name)) {
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
                    self.listNameAccept.append(allCharacters[indexPath.row].name)
                }
            }

        }
        
    }

}


extension ListUserCCViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }

    func search(key:String){
        if key.count > 0 {
            arrFilter = allCharacters.filter({$0.name.localizedCaseInsensitiveContains(key)})
        } else {
            arrFilter = allCharacters
        }
        self.tableView.reloadData()
    }
}

struct Character
{
    var name:String
    var isSelected:Bool = false
    init(name:String) {
        self.name = name
    }
}

