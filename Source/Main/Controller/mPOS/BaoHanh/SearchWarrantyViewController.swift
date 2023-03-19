//
//  SearchWarrantyViewController.swift
//  mPOS
//
//  Created by MinhDH on 5/11/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog


class SearchWarrantyViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate{
    var scrollView:UIScrollView!
    var companyButton: SearchTextField!
    var tfSO,tfPhone:UITextField!
    var listWarrantyType:[WarrantyType]!
    var warranyType:Int!
    
    var tableView: UITableView  =   UITableView()
    var items: [WarrantyItem] = []
    var btSearch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tra cứu Bảo hành"
        listWarrantyType = []
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        navigationController?.navigationBar.isTranslucent = false
        
        let lbTextCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y:  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCompany.textAlignment = .left
        lbTextCompany.textColor = UIColor.black
        lbTextCompany.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCompany.text = "Loại tìm kiếm (*)"
        scrollView.addSubview(lbTextCompany)
        
//        companyButton = SearchTextField(frame: CGRect(x: lbTextCompany.frame.origin.x, y: lbTextCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
//
//        companyButton.placeholder = "Chọn loại tìm kiếm"
//        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
//        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
//        companyButton.autocorrectionType = UITextAutocorrectionType.no
//        companyButton.keyboardType = UIKeyboardType.default
//        companyButton.returnKeyType = UIReturnKeyType.done
//        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
//        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        companyButton.delegate = self
//        scrollView.addSubview(companyButton)
//
//        companyButton.startVisible = true
//        companyButton.theme.bgColor = UIColor.white
//        companyButton.theme.fontColor = UIColor.black
//        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
//        companyButton.theme.cellHeight = Common.Size(s:40)
//        companyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        
        //
       companyButton = SearchTextField(frame: CGRect(x: lbTextCompany.frame.origin.x, y: lbTextCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
          companyButton.placeholder = "Chọn loại tìm kiếm"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        scrollView.addSubview(companyButton)
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
        companyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        //
        
        
        let lbTextSO = UILabel(frame: CGRect(x: Common.Size(s:15), y:companyButton.frame.size.height + companyButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSO.textAlignment = .left
        lbTextSO.textColor = UIColor.black
        lbTextSO.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSO.text = "Số đơn hàng"
        scrollView.addSubview(lbTextSO)
        
        tfSO = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextSO.frame.size.height + lbTextSO.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfSO.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSO.borderStyle = UITextField.BorderStyle.roundedRect
        tfSO.autocorrectionType = UITextAutocorrectionType.no
        tfSO.keyboardType = UIKeyboardType.numberPad
        tfSO.returnKeyType = UIReturnKeyType.done
        tfSO.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSO.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSO.delegate = self
        tfSO.placeholder = "Nhập số đơn hàng"
        scrollView.addSubview(tfSO)
        
        let lbTextPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfSO.frame.size.height + tfSO.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại"
        scrollView.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.size.height + lbTextPhone.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        tfPhone.placeholder = "Nhập số điện thoại"
        scrollView.addSubview(tfPhone)
        
        btSearch = UIButton()
        btSearch.frame = CGRect(x: Common.Size(s:15), y: tfPhone.frame.origin.y + tfPhone.frame.size.height +  Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) * 1.2)
        btSearch.backgroundColor = UIColor(netHex:0xEF4A40)
        btSearch.setTitle("Tra cứu", for: .normal)
        btSearch.addTarget(self, action: #selector(actionSearch), for: .touchUpInside)
        btSearch.layer.borderWidth = 0.5
        btSearch.layer.borderColor = UIColor.white.cgColor
        btSearch.layer.cornerRadius = 3
        scrollView.addSubview(btSearch)
        
        tableView.frame = CGRect(x: 0, y:btSearch.frame.size.height + btSearch.frame.origin.y + Common.Size(s: 10), width: self.view.frame.size.width, height: self.view.frame.size.height - (btSearch.frame.size.height + btSearch.frame.origin.y + Common.Size(s: 10)) - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemWarrantyTableViewCell.self, forCellReuseIdentifier: "ItemWarrantyTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Common.Size(s:110)
        scrollView.addSubview(tableView)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btSearch.frame.origin.y + btSearch.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin loại bảo hành..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.companyButton.text = item.title
            let obj =  self.listWarrantyType.filter{ $0.TenLoai == "\(item.title)" }.first
            if let id = obj?.ID {
                self.warranyType = id
            }
        }
        MPOSAPIManager.baoHanhPhuKien_LoadLoai { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count<=0){
                    var listCom: [String] = []
                    self.listWarrantyType = results
                    for item in results {
                        listCom.append("\(item.TenLoai)")
                    }
                    self.companyButton.filterStrings(listCom)
                }
            }
        }
    }
    @objc func actionSearch(){
        if(warranyType != nil){
            let so = tfSO.text!
            let phone = tfPhone.text!
            tfSO.resignFirstResponder()
            tfPhone.resignFirstResponder()
            if(so.isEmpty && phone.isEmpty){
             
                 self.showDialog(message: "Bạn phải nhập số SO hoặc SĐT")
                
                return
            }
            let newViewController = LoadingViewController()
            newViewController.content = "Đang tra cứu thông tin bảo hành..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.baoHanhPhuKien_SearchLichSu(p_sodonhang: so, p_type: "\(warranyType!)", sdt_so: phone, handler: { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    self.items = []
                    if(err.count<=0){
                        if(results.count > 0){
                            self.items = results
                            self.tableView.reloadData()
                            self.tableView.frame.size.height = self.tableView.contentSize.height + self.tableView.frame.origin.y
                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.btSearch.frame.origin.y + self.btSearch.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + self.tableView.frame.size.height)
                            
                        }else{
                            let title = "THÔNG BÁO"
                        
                            
                            let popup = PopupDialog(title: title, message: "Không tìm thấy thông tin bảo hành!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            
                            let buttonOne = CancelButton(title: "OK") {
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                            self.tableView.frame.size.height =  self.view.frame.size.height - (self.btSearch.frame.size.height + self.btSearch.frame.origin.y + Common.Size(s: 10)) - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.btSearch.frame.origin.y + self.btSearch.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                            
                        }
                    }else{
                        let title = "THÔNG BÁO"
                     
                        let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        self.tableView.frame.size.height =  self.view.frame.size.height - (self.btSearch.frame.size.height + self.btSearch.frame.origin.y + Common.Size(s: 10)) - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.btSearch.frame.origin.y + self.btSearch.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
                        
                    }
                }
            })
        }else{
        
                  self.showDialog(message: "Bạn chưa chọn loại tìm kiếm!")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemWarrantyTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemWarrantyTableViewCell")
        let item:WarrantyItem = items[indexPath.row]
        cell.cardName.text = "\(item.ItemCodeP)-\(item.ItemNameP)"
        cell.address.text = "IMEI: \(item.Imei)"
        cell.package.text = "Số SO: \(item.DocEntrySO)"
        cell.soType.text = "Số lượng: \(item.Quantity)"
        cell.phoneSubsidy.text = "Mã SP BH: \(item.ItemCodeBH)"
        cell.provider.text = "Số lượng BH: \(item.QuantityBH)"
        cell.soMPOS.text = "CTừ: \(item.DocEntry)"
        cell.soPOS.text = "\(item.NgayBH)"
        cell.status.text = "\(item.SoDT_SO)"
        cell.selectionStyle = .none
        
        return cell
    }
    
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}

class ItemWarrantyTableViewCell: UITableViewCell {
    
    var package = UILabel()
    var viewBottom = UIView()
    var viewSubsidy = UIView()
    var viewSO = UIView()
    
    var soType = UILabel()
    var phoneSubsidy = UILabel()
    var provider = UILabel()
    
    let cardName = UILabel()
    let address = UILabel()
    let soTime = UILabel()
    var iconPhone = UIImageView()
    
    var soMPOS = UILabel()
    var soPOS = UILabel()
    var status = UILabel()
    
    var line1 = UIView()
    var line2 = UIView()
    var line3 = UIView()
    var line4 = UIView()
    var line5 = UIView()
    var line6 = UIView()
    var line7 = UIView()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(cardName)
        cardName.translatesAutoresizingMaskIntoConstraints = false
        cardName.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        cardName.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        cardName.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        cardName.numberOfLines = 0
        cardName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        
        // configure authorLabel
        contentView.addSubview(address)
        address.translatesAutoresizingMaskIntoConstraints = false
        address.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        //        product.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        address.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        address.topAnchor.constraint(equalTo: cardName.bottomAnchor, constant: Common.Size(s:3)).isActive = true
        address.numberOfLines = 0
        address.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        address.textColor = UIColor.darkGray
        
        contentView.addSubview(soTime)
        soTime.translatesAutoresizingMaskIntoConstraints = false
        soTime.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        soTime.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        soTime.topAnchor.constraint(equalTo: address.bottomAnchor, constant: Common.Size(s:3)).isActive = true
        soTime.numberOfLines = 0
        soTime.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        soTime.textColor = UIColor.darkGray
        
        contentView.addSubview(viewBottom)
        viewBottom.translatesAutoresizingMaskIntoConstraints = false
        viewBottom.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        viewBottom.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        viewBottom.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        viewBottom.topAnchor.constraint(equalTo: soTime.bottomAnchor, constant: Common.Size(s:5)).isActive = true
        
        viewSubsidy.frame = CGRect(x: 0, y:0, width: UIScreen.main.bounds.size.width - Common.Size(s:28), height: Common.Size(s:50))
        viewSubsidy.clipsToBounds = true
        viewBottom.addSubview(viewSubsidy)
        
        line1.frame = CGRect(x: Common.Size(s:1), y:Common.Size(s:5), width: Common.Size(s:1), height: Common.Size(s:16))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        viewSubsidy.addSubview(line1)
        
        line2.frame = CGRect(x: viewSubsidy.frame.size.width * 2/3 , y:line1.frame.origin.y, width: line1.frame.size.width, height: Common.Size(s:16))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        viewSubsidy.addSubview(line2)
        
        viewSubsidy.addSubview(package)
        package.frame = CGRect(x: line1.frame.origin.x + line1.frame.size.width + Common.Size(s: 3),y: line1.frame.origin.y,width: viewSubsidy.frame.size.width * 2/3 ,height: line1.frame.size.height)
        package.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        package.textColor = UIColor.black
        
        viewSubsidy.addSubview(soType)
        soType.frame = CGRect(x: line2.frame.origin.x + line2.frame.size.width + Common.Size(s: 3),y: line2.frame.origin.y,width: viewSubsidy.frame.size.width/3 ,height: line2.frame.size.height)
        soType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        soType.textColor = UIColor(netHex:0x47B054)
        
        line3.frame = CGRect(x: line1.frame.origin.x, y: line1.frame.size.height + line1.frame.origin.y + Common.Size(s:5), width: Common.Size(s:1), height: Common.Size(s:16))
        line3.backgroundColor = UIColor(netHex:0x47B054)
        viewSubsidy.addSubview(line3)
        
        line4.frame = CGRect(x: line2.frame.origin.x, y:line3.frame.origin.y, width: Common.Size(s:1), height: Common.Size(s:16))
        line4.backgroundColor = UIColor(netHex:0x47B054)
        viewSubsidy.addSubview(line4)
        
        viewSubsidy.addSubview(phoneSubsidy)
        phoneSubsidy.frame = CGRect(x: line3.frame.origin.x + line3.frame.size.width + Common.Size(s: 3),y: line3.frame.origin.y,width: viewSubsidy.frame.size.width * 2/3 ,height: line2.frame.size.height)
        phoneSubsidy.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        phoneSubsidy.textColor = UIColor.black
        
        viewSubsidy.addSubview(provider)
        provider.frame = CGRect(x: line4.frame.origin.x + line4.frame.size.width + Common.Size(s: 3),y: line4.frame.origin.y,width: viewSubsidy.frame.size.width/3 ,height: line2.frame.size.height)
        provider.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        provider.textColor = UIColor.black
        
        viewSubsidy.frame.size.height = provider.frame.size.height + provider.frame.origin.y + Common.Size(s:5)
        
        viewSO.frame = CGRect(x: 0, y:viewSubsidy.frame.size.height + viewSubsidy.frame.origin.y, width: viewSubsidy.frame.size.width, height: Common.Size(s:50))
        viewBottom.addSubview(viewSO)
        
        line5.frame = CGRect(x: Common.Size(s:1), y:0, width: Common.Size(s:1), height: Common.Size(s:16))
        line5.backgroundColor = UIColor(netHex:0x47B054)
        viewSO.addSubview(line5)
        
        viewSO.addSubview(soMPOS)
        soMPOS.frame = CGRect(x: line5.frame.origin.x + line5.frame.size.width + Common.Size(s: 3),y: line5.frame.origin.y,width: viewSubsidy.frame.size.width/3 ,height: line5.frame.size.height)
        soMPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        soMPOS.textColor = UIColor.darkGray
        
        line6.frame = CGRect(x: viewSO.frame.width/3 + Common.Size(s:1), y:0, width: Common.Size(s:1), height: Common.Size(s:16))
        line6.backgroundColor = UIColor(netHex:0x47B054)
        viewSO.addSubview(line6)
        
        viewSO.addSubview(soPOS)
        soPOS.frame = CGRect(x: line6.frame.origin.x + line6.frame.size.width + Common.Size(s: 3),y: line6.frame.origin.y,width: viewSubsidy.frame.size.width/3 ,height: line6.frame.size.height)
        soPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        soPOS.textColor = UIColor.darkGray
        
        line7.frame = CGRect(x: viewSO.frame.width * 2/3, y:0, width: Common.Size(s:1), height: Common.Size(s:16))
        line7.backgroundColor = UIColor(netHex:0x47B054)
        viewSO.addSubview(line7)
        
        viewSO.addSubview(status)
        status.frame = CGRect(x: line7.frame.origin.x + line7.frame.size.width + Common.Size(s: 3),y: line7.frame.origin.y,width: viewSubsidy.frame.size.width/3 ,height: line7.frame.size.height)
        status.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        status.textColor = UIColor.darkGray
        
        viewSO.frame.size.height = line5.frame.size.height + line5.frame.origin.y
        viewBottom.heightAnchor.constraint(equalToConstant: viewSO.frame.size.height + viewSO.frame.origin.y).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



