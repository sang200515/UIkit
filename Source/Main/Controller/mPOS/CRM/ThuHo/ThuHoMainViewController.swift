//
//  ThuHoMainViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 8/3/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ThuHoMainViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var items = [ItemAppThuHoService]()
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    var collectionViewHeightConstraint = NSLayoutConstraint()
    
    var btnSearch: UIBarButtonItem!
    var btnBack: UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    var arrFilter: [ItemAppThuHoService] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Thu hộ"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btnBack = UIBarButtonItem(customView: btBackIcon)
        self.navigationItem.leftBarButtonItems = [btnBack]
        
        let btSearchIcon = UIButton.init(type: .custom)
        btSearchIcon.setImage(#imageLiteral(resourceName: "Search"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        btSearchIcon.addTarget(self, action: #selector(actionSearchAssets), for: UIControl.Event.touchUpInside)
        btnSearch = UIBarButtonItem(customView: btSearchIcon)
        self.navigationItem.rightBarButtonItems = [btnSearch]
        
        //search bar custom
        let searchBar = UISearchBar()
        searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
        searchBarContainer.searchBar.showsCancelButton = true
//        searchBarContainer.searchBar.addDoneButtonOnKeyboard()
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        if #available(iOS 13.0, *) {
            searchBarContainer.searchBar.searchTextField.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }
        searchBarContainer.searchBar.delegate = self
        
        if #available(iOS 11.0, *) {
            searchBarContainer.searchBar.placeholder = "Tìm loại dịch vụ"
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Tìm loại dịch vụ",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        
        self.initSection()
        cellWidth = self.view.frame.width
        self.setUpCollectionView()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.itemSize = CGSize(width: 111, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.height ?? 0)), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true

        collectionView.register(ItemSessionCollectionViewCell.self, forCellWithReuseIdentifier: "ItemSessionCollectionViewCell")
        self.view.addSubview(collectionView)
    }
    
    func initSection() {
        self.items.removeAll()
        self.arrFilter.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.items.append(ItemAppThuHoService(id: "0", name: "FPT Telecom", type: "0", icon: #imageLiteral(resourceName: "Logo"), item: ThuHoService(PaymentBillServiceName: "", ListProvider: [])))
            MPOSAPIManager.GetThuHoServices(MaNV: "\(Cache.user!.UserName)", MaShop: "\(Cache.user!.ShopCode)") { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        for i in 1...results.count {
                            let itemService = results[i - 1]
                            let item1 = ItemAppThuHoService(id: "\(i)", name: "\(itemService.PaymentBillServiceName)", type: "\(i)", icon: UIImage(named: itemService.PaymentBillServiceName) ?? #imageLiteral(resourceName: "Vé xemáybay"), item: itemService)
                            
//                            if itemService.PaymentBillServiceName == "Đăng ký dịch vụ" {
//                                item1.name = "Thu hộ Ftel"
//                                item1.icon = #imageLiteral(resourceName: "Logo")
//                            }
                            
                            self.items.append(item1)
                        }
                        self.arrFilter = self.items
                        self.collectionView.reloadData()
                    } else {
                        debugPrint("err: \(err)")
                    }
                }
            }
        }
    }
    
    @objc func actionSearchAssets() {
        self.searchBarContainer.searchBar.text = ""
        navigationItem.titleView = searchBarContainer
        self.searchBarContainer.searchBar.alpha = 0
        navigationItem.setRightBarButtonItems(nil, animated: true)
        navigationItem.setLeftBarButtonItems(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBarContainer.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBarContainer.searchBar.becomeFirstResponder()
        })
    }
}

extension ThuHoMainViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in

        })
        self.navigationItem.setLeftBarButton(btnBack, animated: true)
        self.navigationItem.setRightBarButton(btnSearch, animated: true)
        search(key: "")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(key: "\(searchBar.text!)")
        self.navigationItem.setLeftBarButton(btnBack, animated: true)
        self.navigationItem.setRightBarButton(btnSearch, animated: true)

        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in

        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }

    func search(key:String){
        if key.count > 0 {
            arrFilter = items.filter({($0.item.PaymentBillServiceName.localizedCaseInsensitiveContains(key))})
        } else {
            arrFilter = items
        }
        self.collectionView.reloadData()
    }
}

extension ThuHoMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = self.searchBarContainer.searchBar.text ?? ""
        if !(key.isEmpty) {
            return arrFilter.count
        } else {
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let coCell: ItemSessionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSessionCollectionViewCell", for: indexPath) as! ItemSessionCollectionViewCell
        
        let key = self.searchBarContainer.searchBar.text ?? ""
        if !(key.isEmpty) {
            let item = arrFilter[indexPath.item]
            coCell.setUpCollectionViewCellThuHoService(item: item)
        }else{
           let item = items[indexPath.item]
           coCell.setUpCollectionViewCellThuHoService(item: item)
        }
        
        coCell.layer.borderWidth = 0.5
        coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return coCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let key = self.searchBarContainer.searchBar.text ?? ""
        var itemTHService:ItemAppThuHoService
        if !(key.isEmpty) {
            itemTHService = arrFilter[indexPath.row]
        } else {
            itemTHService = items[indexPath.row]
        }
        if itemTHService.id == "0" { //fpt telecom
            let vc = ThuHoFTelViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if itemTHService.name == "Thu hộ Ftel" {
            let vc = ThuHoFtelv2ViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = ChooseNCCThuHoServiceViewController()
            vc.items = itemTHService.item.ListProvider
            vc.itemThuHoService = itemTHService.item
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        coCellWidth = cellWidth/3.0
        coCellHeight = (coCellWidth * 0.7)/2 + Common.Size(s: 40)
        let size = CGSize(width: coCellWidth, height: coCellHeight)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}


public class ItemAppThuHoService:NSObject{
    var id:String
    var name:String
    var type:String
    var icon:UIImage
    var item:ThuHoService
    
    init(id:String,name:String,type:String,icon:UIImage, item:ThuHoService){
        self.id = id
        self.name = name
        self.type = type
        self.icon = icon
        self.item = item
    }
}
