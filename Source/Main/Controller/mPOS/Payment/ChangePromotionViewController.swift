//
//  ChangePromotionViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import AVFoundation
protocol ChangePromotionViewControllerDelegate: NSObjectProtocol {
    
    func changePromotion(_ secsion: Int, index: Int, promotion: ProductPromotions)
    
}
class ChangePromotionViewController: UIViewController{
    // MARK: - Properties
    
    var promotion: ProductPromotionsArray!
    var promotionsObject: PromotionsObject!
    var tableView: UITableView  =   UITableView()

    weak var delegate: ChangePromotionViewControllerDelegate?
    var secsion:Int!
    var index:Int!
    var items:[ProductPromotions] = []
    var itemsFilter:[ProductPromotions] = []
    private let searchBar = UISearchBar()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.title = "KM thay thế"
        self.view.backgroundColor = UIColor.white
        configureNavigationItem()

        setData()
        configureUI()
        showSearchBarButton(shouldShow: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
 
        search(shouldShow: true)
        searchBar.setRightImage(normalImage: #imageLiteral(resourceName: "scan_barcode"), highLightedImage: #imageLiteral(resourceName: "scan_barcode_1"))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Selectors
    @objc func handleBack(){
        search(shouldShow: false)
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleSearch(){
        search(shouldShow: true)
        
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Helpers
    func configureNavigationItem(){
        self.navigationItem.hidesBackButton = true
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        btBackIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let btnBack = UIBarButtonItem(customView: btBackIcon)
        self.navigationItem.leftBarButtonItems = [btnBack]
        
        searchBar.delegate = self
        searchBar.sizeToFit()
    }
    
    func configureUI(){
        tableView.frame = CGRect(x: 0, y:0, width: view.frame.size.width, height: self.view.frame.size.height  - (UIApplication.shared.statusBarFrame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemGiftTableViewCellV2.self, forCellReuseIdentifier: "ItemGiftTableViewCellV2")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
    }
    func showSearchBarButton(shouldShow :Bool){
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
        }else{
            navigationItem.rightBarButtonItem = nil
        }
    }
    func search(shouldShow: Bool){
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow

        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = UIColor.init(netHex: 0xEEEEEE)
        } else {
            // Fallback on earlier versions
        }
        navigationItem.titleView = shouldShow ? searchBar : nil
        
        //        if shouldShow {
        //            navigationItem.titleView = searchBar
        //        }else{
        //            navigationItem.titleView = nil
        //        }
    }
    func setData(){
        items.append(promotion.promotionsMain)
        for item in promotion.productPromotions! {
            items.append(item)
        }
        itemsFilter = items
    }
    
    

}
    // MARK: - UITableViewDataSource
extension ChangePromotionViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        search(shouldShow: false)
        let pro:ProductPromotions = self.items[indexPath.row]
        delegate?.changePromotion(secsion, index: index, promotion: pro)
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemGiftTableViewCellV2(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemGiftTableViewCellV2")
        let item:ProductPromotions = self.items[indexPath.row]
        
        // cell.setup(promotion: item)
        var price:String = ""
        if (item.TienGiam > 0){
            price = "Giảm giá: \(Common.convertCurrencyFloat(value: item.TienGiam))"
            cell.quanlity.isHidden = true
        }else{
            price = "Tặng: \(item.TenSanPham_Tang)"
            cell.quanlity.isHidden = false
            cell.quanlity.text = "Số lượng: \(item.SL_Tang)"
        }
        cell.title.text = price
        cell.note.text = "(Khi mua: \(item.TenSanPham_Mua))"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:100)
    }
}

    // MARK: - UISearchBarDelegate
extension ChangePromotionViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        items.removeAll()
        if searchText != ""{
            items = itemsFilter.filter({$0.TenSanPham_Tang.lowercased().contains(find: searchText.lowercased())})
        }else{
            
            items = itemsFilter
        }
        tableView.reloadData()

        
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {

        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { text in
            self.search(shouldShow: false)

            guard let promotion = self.itemsFilter.filter({ $0.SanPham_Tang == "\(text)" }).first else {return}
        
            self.delegate?.changePromotion(self.secsion, index: self.index, promotion: promotion)
        }
        self.present(viewController, animated: false, completion: nil)
        
    }
}

