//
//  NhapHangViewController.swift
//  mPOS
//
//  Created by tan on 8/15/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit

import PopupDialog
import Toaster

class NhapHangViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate,ItemPOTableViewCellDelegate{
    
    func tabInsertImei(productNhap: ProductNhap) {
        
        let newViewController = NhapHangImeiViewController()
        
        newViewController.productNhap = productNhap
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    var scrollView:UIScrollView!
    var lblTitleNCC:UILabel!
    var nccButton:SearchTextField!
    var poButton:SearchTextField!
    var viewPO:UIView!
    var viewTablePO:UITableView  =   UITableView()
    
    
    
    var listNCC:[NhaCungCap] = []
    var indexTypeCard:Int = 0
    var listPOFilter:[PO] = []
    
    var barSearchRight : UIBarButtonItem!
    var barRight: UIBarButtonItem!
    var barViewHistory: UIBarButtonItem!
    var isFirstLoadView:Bool = true
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blue
        self.title = "Chi tiết"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(NhapHangViewController.actionOpenMenuLeft), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        let btSearchIcon = UIButton.init(type: .custom)
        btSearchIcon.setImage(#imageLiteral(resourceName: "DongBoPO"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.addTarget(self, action: #selector(NhapHangViewController.dongBoPO), for: UIControl.Event.touchUpInside)
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barSearchRight = UIBarButtonItem(customView: btSearchIcon)
        
        
        let btRightIcon = UIButton.init(type: .custom)
        btRightIcon.setImage(#imageLiteral(resourceName: "ReloadPO"), for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(NhapHangViewController.reloadPO), for: UIControl.Event.touchUpInside)
        btRightIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barRight = UIBarButtonItem(customView: btRightIcon)
        
        
        let btViewHistoryPO = UIButton.init(type: .custom)
        btViewHistoryPO.setImage(#imageLiteral(resourceName: "list"), for: UIControl.State.normal)
        btViewHistoryPO.imageView?.contentMode = .scaleAspectFit
        btViewHistoryPO.addTarget(self, action: #selector(NhapHangViewController.loadLichSuNH), for: UIControl.Event.touchUpInside)
        btViewHistoryPO.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barViewHistory = UIBarButtonItem(customView: btViewHistoryPO)
        
        
        self.navigationItem.rightBarButtonItems = [barViewHistory,barRight,barSearchRight]
        //        navigationController?.navigationBar.isTranslucent = false
        //        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //        scrollView.backgroundColor = UIColor.white
        //        scrollView.showsVerticalScrollIndicator = false
        //        scrollView.showsHorizontalScrollIndicator = false
        //        self.view.addSubview(scrollView)
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        
        //input tinh thanh pho
        lblTitleNCC =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitleNCC.textAlignment = .left
        lblTitleNCC.textColor = UIColor.black
        lblTitleNCC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitleNCC.text = "Chọn nhà cung cấp"
        scrollView.addSubview(lblTitleNCC)
        
        nccButton = SearchTextField(frame: CGRect(x: lblTitleNCC.frame.origin.x, y: lblTitleNCC.frame.origin.y + lblTitleNCC.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40) ));
        
        nccButton.placeholder = "Vui lòng chọn nhà cung cấp"
        nccButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        
        nccButton.borderStyle = UITextField.BorderStyle.roundedRect
        nccButton.autocorrectionType = UITextAutocorrectionType.no
        nccButton.keyboardType = UIKeyboardType.default
        nccButton.returnKeyType = UIReturnKeyType.done
        nccButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        nccButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nccButton.delegate = self
        scrollView.addSubview(nccButton)
        
        
        
        // Start visible - Default: false
        nccButton.startVisible = true
        nccButton.theme.bgColor = UIColor.white
        nccButton.theme.fontColor = UIColor.black
        nccButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        nccButton.theme.cellHeight = Common.Size(s:40)
        nccButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:12))]
        nccButton.leftViewMode = UITextField.ViewMode.always
        //        let imageButton = UIImageView(frame: CGRect(x: nccButton.frame.size.height/4, y: nccButton.frame.size.height/4, width: nccButton.frame.size.height/2, height: nccButton.frame.size.height/2))
        //        imageButton.image = #imageLiteral(resourceName: "NCC")
        //        imageButton.contentMode = UIViewContentMode.scaleAspectFit
        //
        //        let leftViewCityButton = UIView()
        //        leftViewCityButton.addSubview(imageButton)
        //        leftViewCityButton.frame = CGRect(x: 0, y: 0, width: nccButton.frame.size.height, height: nccButton.frame.size.height)
        //        nccButton.leftView = leftViewCityButton
        
        nccButton.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            self.nccButton.resignFirstResponder()
            if(Cache.listPO.count > 0){
                let popup = PopupDialog(title: "Thông báo", message: "Chuyển nhà cung cấp khác sẽ mất dữ liệu đang nhập ở nhà cung cấp hiện tại!!!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    
                }
                let buttonTwo = DefaultButton(title: "OK"){
                    let item = filteredResults[itemPosition]
                    print(item.title)
                    self.nccButton.text = item.title
                    let obj =  self.listNCC.filter{ $0.VendorNam == "\(item.title)" }.first
                    if let obj = obj?.Vendorcode {
                        print("\(obj)")
                        Cache.vendorNum = obj
                        Cache.listPO = []
                        Cache.listPONum = []
                        self.listPOFilter.removeAll()
                        self.poButton.text = ""
                        self.loadPOAll(MaNCC: "\(obj)")
                    }
                }
                let buttonOne = CancelButton(title: "Cancel") {
                    
                }
                popup.addButtons([buttonOne,buttonTwo])
                
                self.present(popup, animated: true, completion: nil)
            }else{
                let item = filteredResults[itemPosition]
                print(item.title)
                self.nccButton.text = item.title
                let obj =  self.listNCC.filter{ $0.VendorNam == "\(item.title)" }.first
                if let obj = obj?.Vendorcode {
                    print("\(obj)")
                    Cache.vendorNum = obj
                    self.loadPOAll(MaNCC: "\(obj)")
                }
            }
            
        }
        
        
        poButton = SearchTextField(frame: CGRect(x: lblTitleNCC.frame.origin.x, y: nccButton.frame.origin.y + nccButton.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40) ));
        
        poButton.placeholder = "Chọn số PO"
        
        poButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        poButton.borderStyle = UITextField.BorderStyle.roundedRect
        poButton.autocorrectionType = UITextAutocorrectionType.no
        poButton.keyboardType = UIKeyboardType.default
        poButton.returnKeyType = UIReturnKeyType.done
        poButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        poButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        poButton.delegate = self
        scrollView.addSubview(poButton)
        
        // Start visible - Default: false
        poButton.startVisible = true
        poButton.theme.bgColor = UIColor.white
        poButton.theme.fontColor = UIColor.black
        poButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        poButton.theme.cellHeight = Common.Size(s:40)
        poButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        poButton.leftViewMode = UITextField.ViewMode.always
        let imageButtonPO = UIImageView(frame: CGRect(x: poButton.frame.size.height/4, y: poButton.frame.size.height/4, width: poButton.frame.size.height/2, height: poButton.frame.size.height/2))
        imageButtonPO.image = #imageLiteral(resourceName: "POIC")
        imageButtonPO.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewPOButton = UIView()
        leftViewPOButton.addSubview(imageButtonPO)
        leftViewPOButton.frame = CGRect(x: 0, y: 0, width: poButton.frame.size.height, height: poButton.frame.size.height)
        poButton.leftView = leftViewPOButton
        
        let tapShowImei = UITapGestureRecognizer(target: self, action: #selector(self.tapShowPOFilterAction))
        poButton.isUserInteractionEnabled = true
        poButton.addGestureRecognizer(tapShowImei)
        
        
        viewPO = UIView(frame: CGRect(x:Common.Size(s: 10),y:poButton.frame.origin.y + poButton.frame.size.height ,width: scrollView.frame.size.width - Common.Size(s: 20),height: scrollView.frame.size.height))
        //        viewSearchSim.backgroundColor = .yellow
        scrollView.addSubview(viewPO)
        
        // self.loadNCC()
        
    }
    override func viewDidAppear(_ animated: Bool) {
 
        
        if((Cache.listPONum.count) > 0 && self.isFirstLoadView == false){
            var poNumString:String = ""
            
            
            if(Cache.listPONum.count == 1){
                poNumString = "\(Cache.listPONum[0])"
                self.listPOFilter.removeAll()
                for item in Cache.listPO{
                    if(item.poNumber == Cache.listPONum[0]){
                        self.listPOFilter.append(item)
                        break
                    }
                }
                
                self.viewTablePO.reloadData()
                
                
                
            }else{
                if(Cache.listPO.count == Cache.listPONum.count){
                    self.listPOFilter.removeAll()
                    self.listPOFilter = Cache.listPO
                    self.viewTablePO.reloadData()
                }else{
                    var _:[PO] = []
                    self.listPOFilter.removeAll()
                    for po in Cache.listPO{
                        for numPO in Cache.listPONum{
                            if(po.poNumber == numPO){
                                self.listPOFilter.append(po)
                                
                            }
                        }
                    }
                    self.viewTablePO.reloadData()
                }
                
                for item in Cache.listPONum{
                    poNumString = "\(item) , \(poNumString)"
                }
            }
            self.poButton.text = poNumString
            
        }else{
            
            self.poButton.text = ""
            //                print("Cache listPO: \(Cache.listPO.count)")
            //                if(Cache.listPO.count > 0){
            //                    self.listPOFilter.removeAll()
            //                    self.listPOFilter = Cache.listPO
            //                    self.viewTablePO.reloadData()
            //                }
            self.loadNCC()
        }
        
        
        
        
    }
    
    func setupUI(list: [PO]){
        viewTablePO.frame = CGRect(x: 0, y: Common.Size(s: 10), width: viewPO.frame.size.width, height: Common.Size(s: 350) )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTablePO.dataSource = self
        viewTablePO.delegate = self
        viewTablePO.register(ItemPOTableViewCell.self, forCellReuseIdentifier: "ItemPOTableViewCell")
        viewTablePO.tableFooterView = UIView()
        viewTablePO.backgroundColor = UIColor.white
        
        viewPO.addSubview(viewTablePO)
        navigationController?.navigationBar.isTranslucent = false
        
        viewPO.frame.size.height = viewTablePO.frame.size.height + viewTablePO.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewPO.frame.origin.y + viewPO.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //        Cache.indexRow = -1
        //        let item:SearchSimByShop = items[indexPath.row]
        //        if(item.NhomMua == "Y"){
        //            let newViewController = DetailSOPayDirectlyFFriendViewController()
        //            newViewController.historyFFriend = item
        //            newViewController.ocfdFFriend = self.ocfdFFriend!
        //            self.navigationController?.pushViewController(newViewController, animated: true)
        //        }else{
        //            let newViewController = DetailSOFFriendViewController()
        //            newViewController.historyFFriend = item
        //            newViewController.ocfdFFriend = self.ocfdFFriend!
        //            self.navigationController?.pushViewController(newViewController, animated: true)
        //        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.listPOFilter.count > 0){
            return self.listPOFilter[section].listProductNhap.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemPOTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemPOTableViewCell")
        let item:ProductNhap = self.listPOFilter[indexPath.section].listProductNhap[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:110);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if(Cache.listPO.count > 0){
            label.text = "PO: \(self.listPOFilter[section].poNumber)"
        }
        
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        label.backgroundColor = UIColor(netHex:0x47B054)
        return label
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listPOFilter.count
    }
    @objc func tapShowPOFilterAction(){
        poButton.resignFirstResponder()
        print("click")
        
        if(Cache.listPO.count > 0){
            let newViewController = ChoosePONumberViewController()
            newViewController.listPO = Cache.listPO
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    @objc func dongBoPO(){
        if(nccButton.text == "" || Cache.vendorNum == ""){
        
            
            let title = "Thông báo"
            let popup = PopupDialog(title: title, message: "Vui lòng chọn nhà cung cấp", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            
            
            
            return
        }
        let xmlNhapHang = parseXMLNhapHang().toBase64()
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang đồng bộ PO..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.insertXMLNhapHang(MaNCC: Cache.vendorNum,stringxml: xmlNhapHang) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results.Success == true){
                        if(results.Result == "1"){
                            let popup = PopupDialog(title: "Thông báo", message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                //reload data
                                
                                Cache.listPO = []
                                Cache.vendorNum = ""
                                Cache.listPONum = []
                                self.listPOFilter.removeAll()
                                
                                self.viewTablePO.reloadData()
                                self.nccButton.text = ""
                                //self.nccButton.hideResultsList()
                                self.poButton.text = ""
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }else{
                            let popup = PopupDialog(title: "Thông báo", message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                    
                    
                }else{
                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
                
                
            }
        }
        
    }
    
    func parseXMLNhapHang()->String{
        var rs:String = "<PO>"
//        var listTemp:[PO] = Cache.listPO
        for item in Cache.listPO {
            if(item.isInput == true){
                for product in item.listProductNhap{
                    if(product.listImei.count > 0 ){
                        for imei in product.listImei{
                            rs = rs + "<Data Imei=\"\(imei)\" ItemCode=\"\(product.ItemCode)\" PO=\"\(item.poNumber)\" U_ShpCod=\"\(Cache.user!.ShopCode)\" CardCode=\"\(Cache.vendorNum)\" SL=\"\(1)\"/>"
                        }
                        
                    }else{
                        if(product.slnhap > 0){
                            rs = rs + "<Data Imei=\"\("")\" ItemCode=\"\(product.ItemCode)\" PO=\"\(item.poNumber)\" U_ShpCod=\"\(Cache.user!.ShopCode)\" CardCode=\"\(Cache.vendorNum)\" SL=\"\(product.slnhap)\"/>"
                        }
                    }
                }
            }
            
        }
        rs = rs + "</PO>"
        print(rs)
        return rs
        
        
        
        
    }
    
    
    
    @objc func reloadPO(){
        print("Cache.listPO: \(Cache.listPO.count)")
        var isInputSL:Bool = false
        for item in Cache.listPO{
            if(item.isInput == true){
                isInputSL = true
                break
            }
            
        }
        if(isInputSL == false){
            
            Cache.vendorNum = ""
            Cache.listPO = []
            Cache.listPONum = []
            self.isFirstLoadView = true
            loadNCC()
        }else{
            loadPOALLReload()
        }
        
        
    }
    @objc func loadLichSuNH(){
        let newViewController = NhapHangViewHistoryViewController()
        // newViewController.listPO = Cache.listPO
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionOpenMenuLeft() {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func parsePO(pos: [String:[POAll]]){
        for item in pos{
            let po:PO = PO(poNumber: 0, date: "", listProductNhap: [], isInput: false)
            
            po.poNumber = Int(item.key)!
            
            for product in item.value{
                let productNhap:ProductNhap = ProductNhap(ItemCode: "", ItemName: "", slnhap: 0, SLDat: 0, listImei: [],ManSerNum:"",poNum:0)
                productNhap.ItemCode = product.ItemCode
                productNhap.ItemName = product.ItemName
                productNhap.SLDat = product.SLDat
                productNhap.ManSerNum = product.ManSerNum
                productNhap.slnhap = 0
                productNhap.poNum = product.PONum
                po.date = product.DocDate
                po.listProductNhap.append(productNhap)
            }
            Cache.listPO.append(po)
        }
    }
    
    
    func parsePOReload(pos: [String:[POAll]]) -> [PO]{
        var list:[PO] = []
        for item in pos{
            let po:PO = PO(poNumber: 0, date: "", listProductNhap: [], isInput: false)
            
            po.poNumber = Int(item.key)!
            for product in item.value{
                let productNhap:ProductNhap = ProductNhap(ItemCode: "", ItemName: "", slnhap: 0, SLDat: 0, listImei: [],ManSerNum:"",poNum:0)
                productNhap.ItemCode = product.ItemCode
                productNhap.ItemName = product.ItemName
                productNhap.SLDat = product.SLDat
                productNhap.ManSerNum = product.ManSerNum
                productNhap.slnhap = 0
                productNhap.poNum = product.PONum
                po.date = product.DocDate
                po.listProductNhap.append(productNhap)
            }
            list.append(po)
        }
        return list
    }
    
    func loadPOALLReload(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang load danh sách PO..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.getListPOAll(MaNCC:Cache.vendorNum) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    print(results.count)
                    var listPOFromServer:[PO] = []
                    let listPOLocal:[PO] = Cache.listPO
                    if(Cache.listPO.count > 0){
                        
                        var pos: [String:[POAll]] = [:]
                        for item in results {
                            if var val:[POAll] = pos["\(item.PONum)"] {
                                val.append(item)
                                pos.updateValue(val, forKey: "\(item.PONum)")
                            } else {
                                var arr: [POAll] = []
                                arr.append(item)
                                pos.updateValue(arr, forKey: "\(item.PONum)")
                            }
                        }
                        
                        listPOFromServer = self.parsePOReload(pos: pos)
                        
                        // merge list from server and list local
                        let flattenArray = [listPOFromServer, listPOLocal].reduce([], { (result: [PO], element: [PO]) -> [PO] in
                            return result + element
                        })
                        print(flattenArray.count)
                        // remove same po value
                        var flattenArray2 = self.orderedSet(array: flattenArray)
                        print(flattenArray2.count)
                        // loc po co sl nhap
                        var listTempNhap:[PO] = []
                        for item in flattenArray2{
                            
                            if(item.isInput == true){
                                listTempNhap.append(item)
                            }
                        }
                        
                        for item in listTempNhap{
                            var isSame = false
                            var poTemp:PO = PO(poNumber: 0, date: "", listProductNhap: [], isInput: false)
                            for item2 in flattenArray2{
                                if(item.poNumber == item2.poNumber){
                                    isSame = true
                                    poTemp = item2
                                    break
                                }
                            }
                            if(isSame == true){
                                if let index = flattenArray2.firstIndex(of: poTemp) {
                                    flattenArray2.remove(at: index)
                                }
                            }
                        }
                        print(flattenArray2.count)
                        
                        // loc product co sl nhap
                        
                        
                        //                        print("\(Cache.listPO.count)")
                        Cache.listPO = []
                        Cache.listPO = flattenArray2
                        self.listPOFilter.removeAll()
                        self.listPOFilter = Cache.listPO
                        self.viewTablePO.reloadData()
                    }
                }else{
                    let title = "Thông báo"
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
    
    func orderedSet<T: Hashable>(array: Array<T>) -> Array<T> {
        var unique = Set<T>()
        return array.filter { element in
            return unique.insert(element).inserted
        }
    }
    
    func tabDelete(){
        print("click2")
        if(nccButton.text == ""){
            nccButton.startVisible = true
        }
    }
    
    func loadNCC(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang load nhà cung cấp..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getListNCC() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listNCC = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.VendorNam)
                        if(Cache.vendorNum == item.Vendorcode){
                            self.nccButton.text = item.VendorNam
                            
                        }
                    }
                    if(self.isFirstLoadView == true){
                        self.nccButton.filterStrings(list)
                    }
                    
                    if(Cache.vendorNum != ""){
                        _ = Cache.listPO
                        print("Cache listPO: \(Cache.listPO.count)")
                        if(Cache.listPO.count > 0){
                            self.listPOFilter.removeAll()
                            self.listPOFilter = Cache.listPO
                            
                            if(self.isFirstLoadView == true){
                                self.setupUI(list: self.listPOFilter)
                                self.isFirstLoadView = false
                            }else{
                                self.viewTablePO.reloadData()
                            }
                            
                        }else{
                            self.loadPOAll(MaNCC: Cache.vendorNum)
                        }
                        
                    }
                    
                    
                }else{
                 
                    
                    let title = "Thông báo"
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
    
    
    
    
    func loadPOAll(MaNCC:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang load danh sách PO..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.getListPOAll(MaNCC:MaNCC) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    print(results.count)
                    if(results.count == 0){
                        self.listPOFilter.removeAll()
                        Cache.listPO = []
                        Cache.listPONum = []
                        
                        self.listPOFilter = Cache.listPO
                        self.viewTablePO.reloadData()
                        return
                    }
                    Cache.listPO = []
                    Cache.listPONum = []
                    
                    
                    var pos: [String:[POAll]] = [:]
                    for item in results {
                        if var val:[POAll] = pos["\(item.PONum)"] {
                            val.append(item)
                            pos.updateValue(val, forKey: "\(item.PONum)")
                        } else {
                            var arr: [POAll] = []
                            arr.append(item)
                            pos.updateValue(arr, forKey: "\(item.PONum)")
                        }
                    }
                    print("\(pos.count)")
                    self.parsePO(pos: pos)
                    self.listPOFilter.removeAll()
                    self.listPOFilter = Cache.listPO
                    
                    if(self.isFirstLoadView == true){
                        self.setupUI(list: self.listPOFilter)
                        self.isFirstLoadView = false
                    }else{
                        self.viewTablePO.reloadData()
                    }
                    
                    
                    
                    
                    
                    
                }else{
                    let title = "Thông báo"
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
}


protocol ItemPOTableViewCellDelegate {
    
    func tabInsertImei(productNhap:ProductNhap)
}
class ItemPOTableViewCell: UITableViewCell {
    
    
    var tenSP: UILabel!
    var sl:UILabel!
    var slNhapTitle:UILabel!
    var tfSLNhap:UITextField!
    var imeiIc:UIImageView!
    var delegate: ItemPOTableViewCellDelegate?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        
        //
        tenSP = UILabel()
        tenSP.textColor = UIColor.black
        tenSP.font = tenSP.font.withSize(14)
        //tenSP.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        
        tenSP.numberOfLines = 0
        tenSP.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        tenSP.minimumScaleFactor = 0.8
        
        tenSP.textColor =  UIColor.red
        contentView.addSubview(tenSP)
        
        sl = UILabel()
        sl.textColor = UIColor.black
        sl.numberOfLines = 1
        sl.font = sl.font.withSize(13)
        //sl.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(sl)
        
        slNhapTitle = UILabel()
        slNhapTitle.textColor = UIColor.black
        slNhapTitle.numberOfLines = 1
        slNhapTitle.font = slNhapTitle.font.withSize(13)
        // slNhapTitle.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(slNhapTitle)
        
        tfSLNhap = UITextField()
        tfSLNhap.textColor = UIColor.black
        tfSLNhap.keyboardType = UIKeyboardType.numberPad
        tfSLNhap.font = tfSLNhap.font?.withSize(13)
        // tfSLNhap.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        tfSLNhap.borderStyle = UITextField.BorderStyle.roundedRect
        contentView.addSubview(tfSLNhap)
        
        imeiIc = UIImageView()
        imeiIc.image = #imageLiteral(resourceName: "MoreImeiNH")
        imeiIc.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(imeiIc)
    }
    var so1:ProductNhap?
    func setup(so:ProductNhap){
        so1 = so
        tenSP.frame = CGRect(x: Common.Size(s: 10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 10) ,height: Common.Size(s:68))
        tenSP.text = so.ItemName
        
        
        sl.frame = CGRect(x: Common.Size(s: 10),y: tenSP.frame.origin.y + tenSP.frame.size.height + Common.Size(s: 5),width: UIScreen.main.bounds.size.width - Common.Size(s: 240)  ,height: Common.Size(s:16))
        sl.text = "SL đặt: \(so.SLDat)"
        
        
        slNhapTitle.frame = CGRect(x: sl.frame.origin.x + sl.frame.size.width + Common.Size(s: 5),y: sl.frame.origin.y ,width: sl.frame.size.width - Common.Size(s: 30)  ,height: Common.Size(s:16))
        slNhapTitle.text = "SL nhập:"
        
        
        
        
        tfSLNhap.frame = CGRect(x: slNhapTitle.frame.origin.x + slNhapTitle.frame.size.width + Common.Size(s: 80) ,y: slNhapTitle.frame.origin.y ,width: slNhapTitle.frame.size.width - Common.Size(s: 120)  ,height: Common.Size(s:20))
        tfSLNhap.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        tfSLNhap.text = "\(so.slnhap)"
        
        if(so.ManSerNum == "Y"){
            tfSLNhap.isUserInteractionEnabled = false
            tfSLNhap.isEnabled = false
        }else{
            tfSLNhap.isUserInteractionEnabled = true
            tfSLNhap.isEnabled = true
        }
        
        
        imeiIc.frame = CGRect(x: tfSLNhap.frame.origin.x + tfSLNhap.frame.size.width + Common.Size(s: 30) ,y: tfSLNhap.frame.origin.y ,width: slNhapTitle.frame.size.width - Common.Size(s: 20)  ,height: Common.Size(s:16))
        
        let tapImei = UITapGestureRecognizer(target: self, action: #selector(ItemPOTableViewCell.tabInsertImei))
        imeiIc.isUserInteractionEnabled = true
        imeiIc.addGestureRecognizer(tapImei)
        
    }
    @objc func tabInsertImei(){
        if(so1?.ManSerNum == "Y"){
            delegate?.tabInsertImei(productNhap: so1!)
            print("click insert imei")
        }
        
        
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfSLNhap){
            
            let slNhap = textField.text
            var slDat:Int = 0
            if(slNhap != "0" && slNhap != ""){
                so1?.slnhap = Int(slNhap!)!
                var isCheck:Bool = false
                for item in Cache.listPO{
                    for itemProduct in item.listProductNhap{
                        if(itemProduct.ItemName == so1?.ItemName){
                            if(itemProduct.SLDat < Int(slNhap!)!){
                                slDat = itemProduct.SLDat
                                isCheck = true
                                break
                            }
                            itemProduct.slnhap = (so1?.slnhap)!
                            item.isInput = true
                        }
                        
                    }
                }
                if(isCheck == true){
                    tfSLNhap.resignFirstResponder()
                 
                    
                    
                    
//                    let title = "Thông báo"
//                    let popup = PopupDialog(title: title, message: "Số lượng nhập không được lớn hơn số lượng đặt: \(slDat)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                        print("Completed")
//                    }
//                    let buttonOne = CancelButton(title: "OK") {
//
//                    }
//                    popup.addButtons([buttonOne])
//                    self.present(popup, animated: true, completion: nil)
                    Toast(text: "Số lượng nhập không được lớn hơn số lượng đặt: \(slDat)").show()
                   
                    
                    tfSLNhap.text = ""
                    return
                    
                }
                tfSLNhap.textColor = UIColor.red
            }
            
            
        }
    }
    
    
    
}
