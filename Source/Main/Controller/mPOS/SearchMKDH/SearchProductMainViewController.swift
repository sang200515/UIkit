//
//  SearchProductMainViewController.swift
//  fptshop
//
//  Created by Apple on 8/21/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DLRadioButton
import AVFoundation
import Presentr

class SearchProductMainViewController: UIViewController {
    
    var radioMaSP:DLRadioButton!
    var radioViTriHocTu:DLRadioButton!
    var searchTextFeild: UITextField!
    var btnSearch:UIButton!
    var btnScanBarCode:UIButton!
    //    var raidioType = 1
    
    var listInfoProduct:[InfoProduct] = []
    var tableView: UITableView!
    var imgProduct: ImgSearchProduct?
    var searchPlaceCellHeight:CGFloat = 0
    var searchItemCodeCellHeight:CGFloat = 0
    
    var contentView: UIView!
    var imgViewProduct: UIImageView!
    var imgViewProduct_Tu: UIImageView!
    
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
//        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tra cứu đồng hồ và mắt kính"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        radioMaSP = createRadioButtonGender(CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: (self.view.frame.size.width - Common.Size(s: 30))/2, height: 15), title: "Mã sản phẩm", color: UIColor.black);
        radioMaSP.isSelected = true
        self.view.addSubview(radioMaSP)
        
        radioViTriHocTu = createRadioButtonGender(CGRect(x: radioMaSP.frame.origin.x + radioMaSP.frame.size.width ,y: radioMaSP.frame.origin.y, width: radioMaSP.frame.size.width, height: radioMaSP.frame.size.height), title: "Vị trí học tủ", color: UIColor.black);
        radioViTriHocTu.isSelected = false
        self.view.addSubview(radioViTriHocTu)
        
        searchTextFeild = UITextField(frame: CGRect(x: Common.Size(s: 15), y: radioMaSP.frame.origin.y + radioMaSP.frame.height + Common.Size(s: 15), width: self.view.frame.size.width - Common.Size(s: 30) - Common.Size(s: 45), height: Common.Size(s: 35)))
        searchTextFeild.borderStyle = .roundedRect
        searchTextFeild.placeholder = "Nhập mã sản phẩm"
        searchTextFeild.clearButtonMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(searchTextFeild)
        
        btnScanBarCode = UIButton(frame: CGRect(x: searchTextFeild.frame.origin.x + searchTextFeild.frame.width + Common.Size(s: 5), y: searchTextFeild.frame.origin.y, width: Common.Size(s: 40), height: Common.Size(s: 40)))
        btnScanBarCode.setImage(#imageLiteral(resourceName: "scan_barcode_1"), for: .normal)
        self.view.addSubview(btnScanBarCode)
        btnScanBarCode.addTarget(self, action: #selector(scanMaSP), for: .touchUpInside)
        
        btnSearch = UIButton(frame: CGRect(x: Common.Size(s: 15), y: searchTextFeild.frame.origin.y + searchTextFeild.frame.height + Common.Size(s: 15), width: self.view.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnSearch.layer.cornerRadius = 5
        btnSearch.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnSearch.setTitle("TRA CỨU", for: .normal)
        self.view.addSubview(btnSearch)
        btnSearch.addTarget(self, action: #selector(searchProduct), for: .touchUpInside)
        
    }
    
    @objc func scanMaSP() {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { text in
            self.searchTextFeild.text = text
            
            self.searchProduct()
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    
    @objc func searchProduct() {
        
        if self.radioMaSP.isSelected {
            guard let str = searchTextFeild.text, !str.isEmpty else {
                self.showAlert(title: "Thông báo", message: "Bạn chưa nhập mã sản phẩm!")
                return
            }
            
            self.listInfoProduct.removeAll()
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.SearchProductWithItemCode(ItemCode: str, handler: { (message, rsInfoPlace, rsInfoProduct, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if rsInfoProduct.count > 0 {
                            for item in rsInfoProduct {
                                self.listInfoProduct.append(item)
                            }
                        } else {
                            debugPrint("Không có sp")
                        }
                        if self.tableView != nil {
                            self.tableView.removeFromSuperview()
                        }
                        self.setUpTableView()
                    }
                })
            }
        } else {
            guard let str = searchTextFeild.text, !str.isEmpty else {
                self.showAlert(title: "Thông báo", message: "Bạn chưa nhập vị trí học tủ!")
                return
            }
            
            self.listInfoProduct.removeAll()
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.SearchProductWithPlace(Place: str, handler: { (message, rsInfoProduct, rsImgSearchProduct, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if rsInfoProduct.count > 0 {
                            for item in rsInfoProduct {
                                self.listInfoProduct.append(item)
                            }
                        } else {
                            debugPrint("Không có sp")
                        }
                        
                        if rsImgSearchProduct.count > 0 {
                            self.imgProduct = rsImgSearchProduct[0]
                        } else {
                            debugPrint("Không có link hinh")
                        }
                        
                        if self.tableView != nil {
                            self.tableView.removeFromSuperview()
                        }
                        self.setUpTableView()
                    }
                })
            }
        }
    }
    
    func setUpTableView() {
        
        contentView = UIView(frame: CGRect(x: 0, y: btnSearch.frame.origin.y + btnSearch.frame.height + Common.Size(s: 15), width: self.view.frame.size.width, height: self.view.frame.size.height - (btnSearch.frame.origin.y + btnSearch.frame.height + Common.Size(s: 15))))
        self.view.addSubview(contentView)
        
        let imgViewProductWidth:CGFloat = contentView.frame.size.width/2 - Common.Size(s: 30) - Common.Size(s: 7)
        
        imgViewProduct = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: imgViewProductWidth, height: imgViewProductWidth))
        contentView.addSubview(imgViewProduct)
        
        imgViewProduct_Tu = UIImageView(frame: CGRect(x: imgViewProduct.frame.origin.x + imgViewProduct.frame.width + Common.Size(s: 15), y: imgViewProduct.frame.origin.y, width: imgViewProductWidth, height: imgViewProductWidth))
        contentView.addSubview(imgViewProduct_Tu)
        
        tableView = UITableView(frame: CGRect(x: 0, y: imgViewProduct.frame.origin.y + imgViewProduct.frame.height + Common.Size(s: 15), width: self.view.frame.size.width, height: contentView.frame.size.height - (imgViewProduct_Tu.frame.origin.y + imgViewProduct_Tu.frame.height)))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(SearchProductWithPlaceCell.self, forCellReuseIdentifier: "cellWithPlace")
        tableView.register(SearchProductWithItemCodeCell.self, forCellReuseIdentifier: "cellWithItemCode")
        contentView.addSubview(tableView)
        
        if self.radioMaSP.isSelected == true {
            imgViewProduct.isHidden = true
            imgViewProduct_Tu.isHidden = true
            
            tableView.frame = CGRect(x: tableView.frame.origin.x, y: Common.Size(s: 5), width: tableView.frame.size.width, height: contentView.frame.size.height)
        } else {
            imgViewProduct.isHidden = false
            imgViewProduct_Tu.isHidden = false
            
            let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
            
            //set url img
//            guard let urlImg = URL(string: "\(self.imgProduct?.Linkanh ?? "")") else {
//                imgViewProduct.image = #imageLiteral(resourceName: "Hinhanh")
//                return
//            }
//            let data1 = try? Data(contentsOf: urlImg)
//            if let imageData = data1 {
//                let image = UIImage(data: imageData)
//                imgViewProduct.image = image
//            }
            
            if let escapedString = self.imgProduct?.Linkanh.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                print(escapedString)
                let url = URL(string: "\(escapedString)")!
                imgViewProduct.kf.setImage(with: url,
                                              placeholder: nil,
                                              options: [.transition(.fade(0.5))],
                                              progressBlock: nil,
                                              completionHandler: nil)
            }
//
            //set url img_Tu
            
            
            
            if let escapedString_Tu = self.imgProduct?.Linkanh_Tu.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                print(escapedString_Tu)
                let url_Tu = URL(string: "\(escapedString_Tu)")!
                imgViewProduct_Tu.kf.setImage(with: url_Tu,
                                      placeholder: nil,
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: nil)
            }
            
            tableView.frame = CGRect(x: tableView.frame.origin.x, y: imgViewProduct.frame.origin.y + imgViewProduct.frame.height + Common.Size(s: 15), width: tableView.frame.size.width, height: contentView.frame.size.height - (imgViewProduct_Tu.frame.origin.y + imgViewProduct_Tu.frame.height))
            
            let tapShowImgProduct = UITapGestureRecognizer(target: self, action: #selector(showImgProduct))
            imgViewProduct.isUserInteractionEnabled = true
            imgViewProduct.addGestureRecognizer(tapShowImgProduct)
            
            let tapShowImgTu = UITapGestureRecognizer(target: self, action: #selector(showImgTu))
            imgViewProduct_Tu.isUserInteractionEnabled = true
            imgViewProduct_Tu.addGestureRecognizer(tapShowImgTu)
        }
    }
    
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showImgProduct() {
        let vc = ShowImgDHMKViewController()
        vc.img = self.imgViewProduct.image ?? #imageLiteral(resourceName: "AddImage")
        self.customPresentViewController(presenter, viewController: vc, animated: true)
    }
    
    @objc func showImgTu() {
        let vc = ShowImgDHMKViewController()
        vc.img = self.imgViewProduct_Tu.image ?? #imageLiteral(resourceName: "AddImage")
        self.customPresentViewController(presenter, viewController: vc, animated: true)
    }
    
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 13);
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioMaSP.isSelected = false
            radioViTriHocTu.isSelected = false
            switch temp {
            case "Mã sản phẩm":
                //                self.raidioType = 1
                radioMaSP.isSelected = true
                self.searchTextFeild.placeholder = "Nhập mã sản phẩm"
                break
            case "Vị trí học tủ":
                //                self.raidioType = 2
                radioViTriHocTu.isSelected = true
                self.searchTextFeild.placeholder = "Nhập vị trí học tủ"
                break
                
            default:
                break
            }
            
            if self.tableView != nil {
                self.tableView.removeFromSuperview()
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension SearchProductMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listInfoProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.listInfoProduct[indexPath.row]
        
        if self.radioMaSP.isSelected {
            let cell:SearchProductWithItemCodeCell = tableView.dequeueReusableCell(withIdentifier: "cellWithItemCode") as! SearchProductWithItemCodeCell
            cell.setUpCell(item: item)
            self.searchItemCodeCellHeight = cell.estimateCellHeight
            return cell
        } else {
            
            let cell:SearchProductWithPlaceCell = tableView.dequeueReusableCell(withIdentifier: "cellWithPlace") as! SearchProductWithPlaceCell
            cell.setUpCell(item: item)
            self.searchPlaceCellHeight = cell.estimateCellHeight
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.radioMaSP.isSelected {
            return self.searchItemCodeCellHeight
        } else {
            return self.searchPlaceCellHeight
        }
    }
}

class SearchProductWithPlaceCell: UITableViewCell {
    
//    var imgViewProduct: UIImageView!
    var lbMaSP: UILabel!
    var lbTitle: UILabel!
    var lbViTri: UILabel!
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item:InfoProduct){
        self.subviews.forEach({$0.removeFromSuperview()})

        lbMaSP = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: self.frame.width, height: Common.Size(s: 20)))
        lbMaSP.text = "\(item.ItemCode)"
        lbMaSP.textColor = UIColor(red: 38/255, green: 148/255, blue: 85/255, alpha: 1)
        lbMaSP.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbMaSP)
        
        
        lbTitle = UILabel(frame: CGRect(x: lbMaSP.frame.origin.x, y: lbMaSP.frame.origin.y + lbMaSP.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbTitle.text = "\(item.ItemName)"
        lbTitle.textColor = UIColor.red
        lbTitle.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbTitle)
        
        let lbTitleHeight = lbTitle.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTitle.optimalHeight
        lbTitle.numberOfLines = 0
        
        lbTitle.frame = CGRect(x: lbTitle.frame.origin.x, y: lbTitle.frame.origin.y, width: lbTitle.frame.width, height: lbTitleHeight)
        
        lbViTri = UILabel(frame: CGRect(x: lbTitle.frame.origin.x, y: lbTitle.frame.origin.y + lbTitleHeight + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbViTri.text = "Vị trí: \(item.Vitri)"
        lbViTri.textColor = UIColor.darkGray
        lbViTri.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbViTri)
        
        estimateCellHeight = lbViTri.frame.origin.y + lbViTri.frame.height + Common.Size(s: 20)
    }
}

class SearchProductWithItemCodeCell: UITableViewCell {
    
    var lbMaSPText: UILabel!
    var lbTitle: UILabel!
    var lbViTriCodeText: UILabel!
    var lbTenViTri: UILabel!
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item:InfoProduct){
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let lbMaSP = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: self.frame.width/3 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbMaSP.text = "Mã SP:"
        lbMaSP.font = UIFont.boldSystemFont(ofSize: 14)
        lbMaSP.textColor = UIColor.darkGray
        self.addSubview(lbMaSP)
        
        lbMaSPText = UILabel(frame: CGRect(x:lbMaSP.frame.origin.x + lbMaSP.frame.width, y: lbMaSP.frame.origin.y, width: self.frame.width - lbMaSP.frame.width + Common.Size(s: 15), height: Common.Size(s: 20)))
        lbMaSPText.text = "\(item.ItemCode)"
        lbMaSPText.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbMaSPText)
        
        let lbTenSP = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbMaSPText.frame.origin.y + lbMaSPText.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbTenSP.text = "Tên SP:"
        lbTenSP.font = UIFont.boldSystemFont(ofSize: 14)
        lbTenSP.textColor = UIColor.darkGray
        self.addSubview(lbTenSP)
        
        lbTitle = UILabel(frame: CGRect(x: lbMaSPText.frame.origin.x, y: lbTenSP.frame.origin.y, width: lbMaSPText.frame.width, height: Common.Size(s: 20)))
        lbTitle.text = "\(item.ItemName)"
        lbTitle.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbTitle)
        
        let lbTitleHeight = lbTitle.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTitle.optimalHeight
        lbTitle.numberOfLines = 0
        
        lbTitle.frame = CGRect(x: lbTitle.frame.origin.x, y: lbTitle.frame.origin.y, width: lbTitle.frame.width, height: lbTitleHeight)
        
        let lbViTriCode = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTitle.frame.origin.y + lbTitleHeight + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbViTriCode.text = "Vị trí:"
        lbViTriCode.font = UIFont.boldSystemFont(ofSize: 14)
        lbViTriCode.textColor = UIColor.darkGray
        self.addSubview(lbViTriCode)
        
        lbViTriCodeText = UILabel(frame: CGRect(x: lbMaSPText.frame.origin.x, y: lbTitle.frame.origin.y + lbTitleHeight + Common.Size(s: 5), width: lbMaSPText.frame.width, height: Common.Size(s: 20)))
        lbViTriCodeText.text = "\(item.Vitri)"
        lbViTriCodeText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbViTriCodeText)
        
        let lbViTri = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbViTriCodeText.frame.origin.y + lbViTriCodeText.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbViTri.text = "Tên vị trí:"
        lbViTri.font = UIFont.boldSystemFont(ofSize: 14)
        lbViTri.textColor = UIColor.darkGray
        self.addSubview(lbViTri)
        
        lbTenViTri = UILabel(frame: CGRect(x: lbMaSPText.frame.origin.x, y: lbViTriCodeText.frame.origin.y + lbViTriCodeText.frame.height + Common.Size(s: 5), width: lbMaSPText.frame.width, height: Common.Size(s: 20)))
        lbTenViTri.text = "\(item.TenViTri)"
        lbTenViTri.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbTenViTri)
        
        estimateCellHeight = lbTenViTri.frame.origin.y + lbTenViTri.frame.height + Common.Size(s: 20)
    }
}
