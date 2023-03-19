//
//  AppearanceInstallLaptopMobileViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 15/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
protocol ItemDataInstallLaptopMobileDelegate: AnyObject {
    func handleChooseItem(_ config:DataInstallLaptopConfiguration,_ itemsDataInstallLaptop:[ItemDataInstallLaptop])
}
private let reuseIdentifier = "AppearanceCell"
class ItemDataInstallLaptopMobileViewController: UITableViewController {
 
    
    
    // MARK: - Properties

    private var itemsDataInstallLaptop = [ItemDataInstallLaptop](){
        didSet { tableView.reloadData() }
    }
    

    private var config: DataInstallLaptopConfiguration
    weak var delegate: ItemDataInstallLaptopMobileDelegate?
    // MARK: - Lifecycle
    init(items: [ItemDataInstallLaptop],config:DataInstallLaptopConfiguration){
        self.itemsDataInstallLaptop = items
        self.config = config
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureUI()
        
    }
    
    // MARK: - Selectors
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone(){
//        let itemsDataFilter = itemsDataInstallLaptop.filter {  item in
//            return item.isSelected == true
//        }
        switch config {
        case .appearance:
            delegate?.handleChooseItem(.appearance,itemsDataInstallLaptop)
        case .charge:
            delegate?.handleChooseItem(.charge, itemsDataInstallLaptop)
        case .battery:
            delegate?.handleChooseItem(.battery, itemsDataInstallLaptop)
        case .ram:
            delegate?.handleChooseItem(.ram, itemsDataInstallLaptop)
        case .storage:
            delegate?.handleChooseItem(.storage, itemsDataInstallLaptop)
        case .display:
            delegate?.handleChooseItem(.display, itemsDataInstallLaptop)
        case .memory:
            delegate?.handleChooseItem(.memory, itemsDataInstallLaptop)
        case .memorycard:
            delegate?.handleChooseItem(.memorycard, itemsDataInstallLaptop)
        case .info:
            delegate?.handleChooseItem(.info, itemsDataInstallLaptop)
        case .term:
            break
        case .confirm:
            break
        case .confirmMobile:
            break
        case .confirmMobile:
            break
        case .appearancemobile:
            delegate?.handleChooseItem(.appearancemobile, itemsDataInstallLaptop)
        case .keyboard:
            delegate?.handleChooseItem(.keyboard, itemsDataInstallLaptop)
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
  
        tableView.register(AppearanceCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
   
    }
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .mainGreen
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Vui lòng chọn thông tin"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
       
        
     }
    
}
 // MARK: - UITableViewDataSource
extension ItemDataInstallLaptopMobileViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsDataInstallLaptop.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AppearanceCell
        cell.itemDataInstallLaptop = itemsDataInstallLaptop[indexPath.row]
        cell.selectionStyle = .none
      
//        cell.config = config
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemsDataInstallLaptop[indexPath.row]
        switch config {
        
        case .appearance:
            if let row = itemsDataInstallLaptop.firstIndex(where: {$0.id == item.id}) {
                itemsDataInstallLaptop[row].isSelected = item.isSelected == true ? false : true
            }
        case .charge:
            for index in 0...itemsDataInstallLaptop.count - 1 {
                itemsDataInstallLaptop[index].isSelected = item.id == itemsDataInstallLaptop[index].id ? true : false
            }
        case .battery:
            for index in 0...itemsDataInstallLaptop.count - 1 {
                itemsDataInstallLaptop[index].isSelected = item.id == itemsDataInstallLaptop[index].id ? true : false
            }
        case .ram:
            if let row = itemsDataInstallLaptop.firstIndex(where: {$0.id == item.id}) {
                itemsDataInstallLaptop[row].isSelected = item.isSelected == true ? false : true
            }
        case .storage:
            if let row = itemsDataInstallLaptop.firstIndex(where: {$0.id == item.id}) {
                itemsDataInstallLaptop[row].isSelected = item.isSelected == true ? false : true
            }
        case .display:
            if let row = itemsDataInstallLaptop.firstIndex(where: {$0.id == item.id}) {
                itemsDataInstallLaptop[row].isSelected = item.isSelected == true ? false : true
            }
        case .memory:
            for index in 0...itemsDataInstallLaptop.count - 1 {
                itemsDataInstallLaptop[index].isSelected = item.id == itemsDataInstallLaptop[index].id ? true : false
            }
        case .memorycard:
            for index in 0...itemsDataInstallLaptop.count - 1 {
                if item.isSelected{
                    itemsDataInstallLaptop[index].isSelected = false
                }else{
                    itemsDataInstallLaptop[index].isSelected = item.id == itemsDataInstallLaptop[index].id ? true : false
                }
            
            }
        case .term:
            break
        case .confirm:
            break
        case .confirmMobile:
            break
        case .info:
            break
        case .appearancemobile:
            if let row = itemsDataInstallLaptop.firstIndex(where: {$0.id == item.id}) {
                itemsDataInstallLaptop[row].isSelected = item.isSelected == true ? false : true
            }
        case .keyboard:
            if let row = itemsDataInstallLaptop.firstIndex(where: {$0.id == item.id}) {
                itemsDataInstallLaptop[row].isSelected = item.isSelected == true ? false : true
            }
        }
     
    }
    
    
}


