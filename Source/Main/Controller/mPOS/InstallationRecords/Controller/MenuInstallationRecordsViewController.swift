//
//  MenuInstallationRecordsViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 08/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
private let menuIdentifier = "menuIdentifier"
class MenuInstallationRecordsViewController: UICollectionViewController {

    
    // MARK: - Properties
    
    
    private var items = [ItemApp](){
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Lifecyle
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Biên bản cài đặt"
        configureCollectionView()
        fetchMenu()
       
    }

    // MARK: - API
    func fetchMenu(){
        let items:[ItemApp] = [ItemApp(id: "0", name: "Cài đặt laptop", type: "0", icon: #imageLiteral(resourceName: "install-laptop")),
                                       ItemApp(id: "1", name: "Cài đặt Apple/Mobile", type: "1", icon: #imageLiteral(resourceName: "install-apple")),
        ItemApp(id: "2", name: "Lịch sử", type: "2", icon: #imageLiteral(resourceName: "ic_report_realtime"))]
        self.items = items
    }
    
    
    // MARK: - Helpers
    
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.register(MenuItemCollectionViewCell.self, forCellWithReuseIdentifier: menuIdentifier)

 
    }
}
    // MARK: - UICollectionViewDataSource

extension MenuInstallationRecordsViewController {
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuIdentifier, for: indexPath) as! MenuItemCollectionViewCell
        cell.item = items[indexPath.row]
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return cell
    }
  
}


// MARK: - UICollectionViewDelegateFlowLayout
extension MenuInstallationRecordsViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ceoWidth = view.frame.width/3.0
        return CGSize(width: ceoWidth, height: ceoWidth * 0.7)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionViewDelegate
extension MenuInstallationRecordsViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        switch item.id {
        case "0":
            let newViewController = InstallLaptopViewController()
            navigationController?.pushViewController(newViewController, animated: true)
        case "1":
            let newViewController = InstallAppleMobileViewController()
            navigationController?.pushViewController(newViewController, animated: true)
        case "2":
            let newViewController = HistoryInstallRecordsViewController()
            navigationController?.pushViewController(newViewController, animated: true)
            
        default:
            break
        }
    }
}
