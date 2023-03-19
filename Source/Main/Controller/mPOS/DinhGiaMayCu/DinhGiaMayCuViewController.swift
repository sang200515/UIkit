//
//  DinhGiaMayCuViewController.swift
//  fptshop
//
//  Created by tan on 9/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class DinhGiaMayCuViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let searchController = UISearchController(searchResultsController: nil)
    var collectionView: UICollectionView!
    var items: [ThuMuaMayCuList] = []
    var listTemp:[ThuMuaMayCuList] = []
     var barSearchRight : UIBarButtonItem!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sản phẩm thu cũ"
        //navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(DinhGiaMayCuViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        let btRightIcon = UIButton.init(type: .custom)
        
        btRightIcon.setImage(#imageLiteral(resourceName: "LSCC"),for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(DinhGiaMayCuViewController.actionViewTheLe), for: UIControl.Event.touchUpInside)
        btRightIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barRight = UIBarButtonItem(customView: btRightIcon)
        
        self.navigationItem.rightBarButtonItem = barRight
        
//        let btSearchIcon = UIButton.init(type: .custom)
//
//        btSearchIcon.setImage(#imageLiteral(resourceName: "Lichsu-1"), for: UIControl.State.normal)
//        btSearchIcon.imageView?.contentMode = .scaleAspectFit
//        btSearchIcon.addTarget(self, action: #selector(DinhGiaMayCuViewController.actionViewTheLe), for: UIControl.Event.touchUpInside)
//        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
//        barSearchRight = UIBarButtonItem(customView: btSearchIcon)
//
//        self.navigationItem.rightBarButtonItems = [barSearchRight]
        
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Nhập từ khoá cần tìm..."
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .red
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                textfield.textColor = UIColor(netHex:0x00579c)
                textfield.tintColor = UIColor(netHex:0x00579c)
                if let backgroundview = textfield.subviews.first {
                    // Background color
                    backgroundview.backgroundColor = UIColor.white
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 5;
                    backgroundview.clipsToBounds = true;
                }
                if let navigationbar = self.navigationController?.navigationBar {
                    navigationbar.barTintColor = UIColor(patternImage: Common.imageLayerForGradientBackground(searchBar: (self.searchController.searchBar)))
                }
                navigationController?.navigationBar.isTranslucent = true
            }
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["Tên SP", "Mã SP"]
        searchController.searchBar.delegate = self
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))

        // layout.itemSize = CGSize(width: self.view.frame.size.width , height: (self.view.frame.size.width - Common.Size(s:150)))

        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * 1.4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2



        collectionView = UICollectionView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height ), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductDinhGiaOnlineCell.self, forCellWithReuseIdentifier: "ProductDinhGiaOnlineCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
    
        
//        let newViewController = LoadingViewController()
//        newViewController.content = "Đang tải danh sách sản phẩm..."
//        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.navigationController?.present(newViewController, animated: true, completion: nil)
//        let nc = NotificationCenter.default
        MPOSAPIManager.mpos_FRT_SP_ThuMuaMC_get_list() { (results, err) in
           // nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    self.items = results
                    self.listTemp = results
                    self.collectionView.reloadData()
                }else{
                    let title = "THÔNG BÁO"
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {

                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }

            }

        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionViewTheLe(){
        let newViewController = TheLeViewController()

        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDinhGiaOnlineCell", for: indexPath) as! ProductDinhGiaOnlineCell
        let item:ThuMuaMayCuList = self.items[indexPath.row]
        
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item:ThuMuaMayCuList = self.items[indexPath.row]
         navigationController?.navigationBar.isTranslucent = false
        let newViewController = ChooseLoaiDinhGiaMayCuViewController()
        newViewController.product = item
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Tên ") {
        if(searchText.count > 0){
            let searchText =  searchText.folding(options: .diacriticInsensitive, locale: nil)
            if (scope == "Tên SP"){
                
                
                self.items.removeAll()

                self.items = self.listTemp.filter { "\($0.Name.lowercased())".contains(searchText.lowercased()) }


                self.collectionView.reloadData()
            }else if (scope == "Mã SP"){
                
                
                self.items.removeAll()

                self.items = self.listTemp.filter { "\($0.Itemcode)".contains(searchText) }

                self.collectionView.reloadData()
            }
            if(self.items.count <= 0){
//                TableViewHelper.EmptyMessage(message: "Không tìm thấy từ khoá cần tìm.\r\nVui lòng kiểm tra lại.", viewController: self.tableView)
            }else{
                //TableViewHelper.removeEmptyMessage(viewController: self.tableView)
            }
            self.collectionView.reloadData()
        }else{
            self.items.removeAll()
            self.items = self.listTemp
            self.collectionView.reloadData()
        }
    }
    
}
extension DinhGiaMayCuViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension DinhGiaMayCuViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
class ProductDinhGiaOnlineCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
 
    var itemcode:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:ThuMuaMayCuList){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        //        iconImage.image = Image(named: "demo")
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        //iconImage.backgroundColor = .red
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = item.UrlPicture.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            if(escapedString != ""){
                let url = URL(string: "\(escapedString)")!
                iconImage.kf.setImage(with: url,
                                      placeholder: nil,
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: nil)
            }
            
        }
        
        let heightTitel = item.Name.height(withConstrainedWidth: self.frame.size.width - Common.Size(s:4), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: Common.Size(s:15), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        title.text = item.Name
        title.numberOfLines = 2
        title.sizeToFit()
        addSubview(title)
        
        itemcode = UILabel(frame: CGRect(x: Common.Size(s:2), y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        itemcode.textAlignment = .center
        itemcode.textColor =  .red
        
        itemcode.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        itemcode.text = "Mã SP: \(item.Itemcode)"
        itemcode.numberOfLines = 1
        addSubview(itemcode)
        
   
        
        
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
