//
//  SearchViewControllerV2.swift
//  mCallLogThuoc
//
//  Created by tan on 9/13/18.
//  Copyright © 2018 fptshop. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import PopupDialog
class SearchGoiCuocViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UISearchBarDelegate {
    var searchBarContainer:SearchBarContainerViewV2!
    var collectionView: UICollectionView!
    var callLogs: [GoiCuocBookSimV2] = []
    var loadingView:UIView!
    var loading:NVActivityIndicatorView!
    var key:String = ""
    var lbNotFound: UILabel!
    var listTemp:[GoiCuocBookSimV2] = []
    var telecom:ProviderName?
    var window: UIWindow?
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let searchBar = UISearchBar()
        searchBarContainer = SearchBarContainerViewV2(customSearchBar: searchBar)
        searchBarContainer.searchBar.showsCancelButton = true
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        
        
        
        if #available(iOS 11.0, *) {
            searchBarContainer.searchBar.placeholder = "Nhập gói cước cần tìm?"
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            //             setTextFieldTintColor(to: UIColor(netHex:0x47B054), for: searchBarContainer.searchBar)
            
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Nhập gói cước cần tìm?",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        
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
        searchBar.delegate = self
        
        searchBarContainer.searchBar.endEditing(true)
        navigationController?.navigationBar.isTranslucent = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: self.view.frame.size.width , height: (self.view.frame.size.width - Common.Size(s:200)))
        layout.minimumInteritemSpacing = 0;
        
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CallLogCollectionCell2.self, forCellWithReuseIdentifier: "CallLogCollectionCell2")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        //        }
        
        loadingView  = UIView(frame: CGRect(x: 0, y:UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: self.view.frame.size.height))
        loadingView.backgroundColor = .white
        self.view.addSubview(loadingView)
        //loading
        let frameLoading = CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y:loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50))
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor(netHex:0x47B054)
        loading = NVActivityIndicatorView(frame: frameLoading,
                                          type: .ballClipRotateMultiple)
        loading.startAnimating()
        loadingView.addSubview(loading)
        loadingView.isHidden = true
        
        let productNotFound = "Không tìm thấy gói cước!"
        lbNotFound = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height/2 - Common.Size(s:22), width: self.view.frame.size.width, height: Common.Size(s:22)))
        lbNotFound.textAlignment = .center
        lbNotFound.textColor = UIColor.lightGray
        lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        lbNotFound.text = productNotFound
        loadingView.addSubview(lbNotFound)
        lbNotFound.isHidden = true
        
        
        self.loadData()
    }
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        
        if(self.listTemp.count == 0){
            self.listTemp = self.callLogs
        }
        
        self.callLogs.removeAll()
        
        self.callLogs = self.listTemp.filter { "\($0.TenSP)".lowercased().contains(searchText.lowercased()) }
        if(self.callLogs.count == 0){
            self.callLogs = self.listTemp.filter { "\($0.MaSP)".lowercased().contains(searchText.lowercased()) }
        }
        
        self.collectionView.reloadData()
        //
        if(searchText == ""){
            self.callLogs.removeAll()
            self.callLogs = listTemp
            self.listTemp = []
            self.collectionView.reloadData()
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
        //        let newViewController2 = ChooseGoiCuocBSV2ViewController()
        //
        //        newViewController2.self.telecom = self.telecom
        //        self.navigationController?.pushViewController(newViewController2, animated: true)
        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let myDict = [ "key": searchBar.text!]
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("searchAction"), object: myDict)
        searchBar.endEditing(true)
    }
    
    
    
    
    func loadData(){
        loadingView.isHidden = false
        self.loadingView.alpha = 1
        lbNotFound.isHidden = true

        MPOSAPIManager.getListGoiCuocBookSimV2(NhaMang: "\(telecom!.NhaMang)") { (results,IsLogin,p_Status, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                
                if(IsLogin == "1"){
                    let title = "Thông báo"
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                        let defaults = UserDefaults.standard
                        defaults.removeObject(forKey: "UserName")
                        defaults.removeObject(forKey: "Password")
                        defaults.removeObject(forKey: "mDate")
                        defaults.removeObject(forKey: "mCardNumber")
                        defaults.removeObject(forKey: "typePhone")
                        defaults.removeObject(forKey: "mPrice")
                        defaults.removeObject(forKey: "mPriceCardDisplay")
                        defaults.removeObject(forKey: "CRMCodeLogin")
                        defaults.synchronize()
//                        APIService.removeDeviceToken()
                        // Initialize the window
                        self.window = UIWindow.init(frame: UIScreen.main.bounds)
                        
                        // Set Background Color of window
                        self.window?.backgroundColor = UIColor.white
                        
                        // Allocate memory for an instance of the 'MainViewController' class
                        let mainViewController = LoginViewController()
                        
                        // Set the root view controller of the app's window
                        self.window!.rootViewController = mainViewController
                        
                        // Make the window visible
                        self.window!.makeKeyAndVisible()
                        
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
                if(p_Status == "0"){
                    let title = "Thông báo"
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                        
                        
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    return
                    
                }
                if(err.count <= 0){
                    self.callLogs.removeAll()
                    
                    //                    self.callLogs = results.filter { "\($0.RequestId)".contains(self.key) }
                    
                    self.callLogs = results
                    self.collectionView.reloadData()
                    
                    
                    UIView.animate(withDuration: 0.2, delay: 0.2, options:
                        UIView.AnimationOptions.curveEaseOut, animations: {
                            
                            if (results.count > 0){
                                self.loadingView.alpha = 0
                            }
                    }, completion: { finished in
                        self.navigationController?.navigationBar.isTranslucent = false
                        if (results.count <= 0){
                            self.loading.stopAnimating()
                            self.lbNotFound.isHidden = false
                        }else{
                            self.loadingView.isHidden = true
                        }
                    })
                    
                }else{
                    let title = "Thông báo"
                    
                    
                    let popup = PopupDialog(title: title, message: err)
                    
                    let buttonOne = CancelButton(title: "OK") {
                        print("Completed")
                    }
                    
                    popup.addButtons([buttonOne])
                    
                    self.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @objc func searchAction(notification:Notification) -> Void {
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.callLogs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CallLogCollectionCell2", for: indexPath) as! CallLogCollectionCell2
        let item:GoiCuocBookSimV2 = self.callLogs[indexPath.row]
        cell.setup(item: item)
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let item:GoiCuocBookSimV2 = self.callLogs[indexPath.row]
        
        print("\(indexPath.row)")
        let newViewController = ChonSoV2ViewController()
        newViewController.telecom = self.telecom
        newViewController.goiCuoc = item
        self.navigationController?.pushViewController(newViewController, animated: true)

    }
}

class CallLogCollectionCell2: UICollectionViewCell {
    var tensanpham: UILabel!
    var masanpham: UILabel!
    var gia: UILabel!
    var lblLine: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:GoiCuocBookSimV2){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        
        tensanpham = UILabel()
        tensanpham.textColor = UIColor.black
        
        tensanpham.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        
        tensanpham.numberOfLines = 0
        tensanpham.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        tensanpham.minimumScaleFactor = 0.8
        
        
        addSubview(tensanpham)
        
        masanpham = UILabel()
        masanpham.textColor = UIColor.black
        masanpham.numberOfLines = 1
        masanpham.font = masanpham.font.withSize(12)
        addSubview(masanpham)
        
        
        gia = UILabel()
        gia.textColor = UIColor.red
        gia.numberOfLines = 1
        gia.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        addSubview(gia)
        
        tensanpham.frame = CGRect(x: Common.Size(s:5),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:30))
        tensanpham.text = "\(item.TenSP)"
        
        
        masanpham.frame = CGRect(x:Common.Size(s:5) ,y: tensanpham.frame.origin.y +  tensanpham.frame.size.height + Common.Size(s: 10),width: tensanpham.frame.size.width ,height: Common.Size(s:16))
        masanpham.text = "Mã SP: \(item.MaSP)"
        
        
        gia.frame = CGRect(x:Common.Size(s:5) ,y: masanpham.frame.origin.y +  masanpham.frame.size.height + Common.Size(s: 10),width: tensanpham.frame.size.width ,height: Common.Size(s:16))
        let giacuoc = Common.convertCurrencyV2(value: item.GiaCuoc)
        gia.text = "Giá Cước: \(giacuoc) VNĐ"
        
        lblLine = UILabel()
        lblLine.backgroundColor = UIColor.gray
        lblLine.frame = CGRect(x: Common.Size(s:0) ,y: gia.frame.origin.y + gia.frame.size.height + Common.Size(s: 10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:2))
        addSubview(lblLine)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchBarContainerViewV2: UIView {
    
    let searchBar: UISearchBar
    
    init(customSearchBar: UISearchBar) {
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)
        
        addSubview(searchBar)
    }
    
    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
}
