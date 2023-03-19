//
//  DetailDSTargetVC.swift
//  mSM
//
//  Created by MinhDH on 2/1/18.
//  Copyright © 2018 fptshop.com.vn. All rights reserved.
//

import Foundation
import UIKit
import Alamofire;
import SwiftyJSON;

class DetailDSTargetVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var indx:Int!
    var list:[TargetReport] = [];
    var pkSum: Double = 0;
    var dsSum: Double = 0;
    var sectionTongCong = 0
    var shopCode = Cache.selectedShopCode
    
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    
    var collectionView: UICollectionView!
    
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    let header:[String] = ["STT","Tên NV", "Nhóm CD","Số ngày làm việc","Doanh số PK","DS Tổng","Trạng thái"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(Cache.selectedShopNameDSTarget)"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s: 45), height: Common.Size(s: 45))))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        let btSaveIcon = UIButton.init(type: .custom)
        let saveImg = #imageLiteral(resourceName: "icon-save")
        let tintedImage = saveImg.withRenderingMode(.alwaysTemplate)
        btSaveIcon.setImage(tintedImage, for: UIControl.State.normal)
        btSaveIcon.imageView?.contentMode = .scaleAspectFit
        btSaveIcon.addTarget(self, action: #selector(saveAll), for: UIControl.Event.touchUpInside)
        btSaveIcon.frame = CGRect(x: 15, y: 0, width: Common.Size(s: 25), height: Common.Size(s: 30))
        btSaveIcon.tintColor = .white
        viewRightNav.addSubview(btSaveIcon)
        
        self.loadData()
    }
    
    func loadData() {
        var date = Date()
        let calendar = Calendar.current;
        
        date = calendar.date(byAdding: .month, value: 0, to: date)!;
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.list = mSMApiManager.NhapChiTieuDoanhSo_Report(p_Nam: "\(year)", p_Thang: "\(month)", p_MaShop: self.shopCode).Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if self.list.count > 0 {
                    self.generateData(data:self.list)
                } else {
                    self.showAlert(title: "Thông báo", message: "Không tìm thấy báo cáo!")
                }
                self.setUpView()
            }
        }
    }
    
    
    func setUpView() {
        self.navigationController?.navigationBar.isTranslucent = true;
        self.tempHeaderForSize = self.header;
        
        //Setup cell size
        for i in 0..<cellData.count{
            for j in 0..<tempHeaderForSize.count{
                if("\(self.tempHeaderForSize[j])".count < "\(cellData[i][j])".count){
                    self.tempHeaderForSize[j] = "\(cellData[i][j])";
                }
            }
        }
        
        let collectionViewLayout = ReportLayout();
        collectionViewLayout.numberOfColumns = header.count;
        collectionViewLayout.titleArray = self.tempHeaderForSize;
        collectionViewLayout.numberColumnFixed = 2
        
        self.collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout);
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.showsHorizontalScrollIndicator = true
        
        self.collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: "DateCollectionViewCell")
        self.collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
        
        self.collectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView);
        self.collectionView.reloadData()
        collectionView.scrollToLast()
        
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    
    func generateData(data: [TargetReport]) {
        var stt = 0
        cellData = [[String]]()
        for item in data {
            stt += 1
            self.cellData.append([
                "\(stt)",
                "\(item.MaTenNV!))",
                "\(item.NhomCD!)",
                "\(item.SoNgayLamViec!)",
                "\(Common.convertCurrencyDoubleV2(value: item.Target_PK!))",
                "\(Common.convertCurrencyDoubleV2(value: item.Target_DS!))",
                "\(item.GhiChu!)"
                ]);
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func canRotate() -> Void{}
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation;
            switch orient {
            case .portrait:
                self.view.subviews.forEach({$0.removeFromSuperview()})
                self.setUpView()
            case .landscapeLeft,
                 .landscapeRight:
                self.view.subviews.forEach({$0.removeFromSuperview()})
                self.setUpView()
            default:
                break;
            }
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellData.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return header.count
    }
    let disString:[String] = ["00004","00005","00407","00447"]
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section > 0 && indexPath.row >= 3){
            let itemTarget = list[indexPath.section - 1]
            
            let jobTitle = (Cache.user?.JobTitle)!;
            var checkEdit = true
            for item in disString{
                if(item == jobTitle){
                    checkEdit = false
                    break
                }
            }
            
            if(indexPath.row == 4  && checkEdit){
                if itemTarget.ID != 0 {
                    
                    let alertController = UIAlertController(title: "Doanh số PK", message: nil, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Huỷ", style: .default, handler: {
                        alert -> Void in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: {
                        alert -> Void in
                        let fNameField = alertController.textFields![0] as UITextField
                        if fNameField.text != ""{
                            let value = Double(fNameField.text!)!
                            self.list[indexPath.section - 1].Target_PK = value
                            self.collectionView.reloadData()
                            self.dismiss(animated: true, completion: nil)
                        }
                    }))
                    alertController.addTextField(configurationHandler: { (textField) -> Void in
                        textField.keyboardType = .numberPad
                        textField.placeholder = "Nhập tỉ trọng phụ kiện..."
                        textField.textAlignment = .center
                        textField.text = "\(Int(self.list[indexPath.section - 1].Target_PK!))";
                        textField.font = UIFont.systemFont(ofSize: 15)
                    })
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    debugPrint("không chỉnh sửa DS PK tong")
                }
                
            }
            
            if(indexPath.row == 5 && checkEdit){
                if itemTarget.ID != 0 {
                    
                    let alertController = UIAlertController(title: "Doanh số tổng", message: nil, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Huỷ", style: .default, handler: {
                        alert -> Void in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: {
                        alert -> Void in
                        let fNameField = alertController.textFields![0] as UITextField
                        if fNameField.text != ""{
                            let value = Double(fNameField.text!)!
                            self.list[indexPath.section - 1].Target_DS = value
                            self.collectionView.reloadData()
                            self.dismiss(animated: true, completion: nil)
                        }
                    }))
                    alertController.addTextField(configurationHandler: { (textField) -> Void in
                        textField.keyboardType = .numberPad
                        textField.placeholder = "Nhập doanh số..."
                        textField.textAlignment = .center
                        textField.font = UIFont.systemFont(ofSize: 15)
                        textField.text = "\(Int(self.list[indexPath.section - 1].Target_DS!))";
                    })
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    debugPrint("không chỉnh sửa DS tổng")
                }
                
            }
        }
    }
    
    @objc func saveAll() {
        var arrStr = [String]()
        arrStr.removeAll()
        //        <DATA><LINE ID="1" MaNV="15200" Target_DS="10000" Target_PK="20000" /></DATA>
        for item in list {
            arrStr.append("<LINE ID=\"\(item.ID!)\" MaNV=\"\(item.MaNV!)\" Target_DS=\"\(item.Target_DS!)\" Target_PK=\"\(item.Target_PK!)\" />")
        }
        
        let submitStr = "<DATA>\(arrStr.joined())</DATA>"
        debugPrint("submitStr: \(submitStr)")
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        debugPrint("saveAll")
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let rs = mSMApiManager.NhapChiTieuDoanhSo_Save(p_Nam: "\(year)", p_Thang: "\(month)", p_Base64_XML_Data: "\(submitStr)".toBase64(), p_MaShop: self.shopCode).Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if rs.count > 0 {
                    if rs[0].Result == 0 {
                        let alert = UIAlertController(title: "Thông báo", message: "\(rs[0].Msg ?? "Lỗi!")", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            
                            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                                self.list = mSMApiManager.NhapChiTieuDoanhSo_Report(p_Nam: "\(year)", p_Thang: "\(month)", p_MaShop: self.shopCode).Data ?? []
                                WaitingNetworkResponseAlert.DismissWaitingAlert {
                                    if self.list.count > 0 {
                                        self.generateData(data:self.list)
                                    } else {
                                        self.showAlert(title: "Thông báo", message: "Không tìm thấy báo cáo!")
                                    }
                                    
                                    self.view.subviews.forEach({$0.removeFromSuperview()})
                                    self.setUpView()
                                }
                            }
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(rs[0].Msg ?? "Lưu thành công!")", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            
                            self.list.removeAll()
                            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self, completion: {
                                self.list = mSMApiManager.NhapChiTieuDoanhSo_Report(p_Nam: "\(year)", p_Thang: "\(month)", p_MaShop: self.shopCode).Data ?? []
                                WaitingNetworkResponseAlert.DismissWaitingAlert {
                                    if self.list.count > 0 {
                                        self.generateData(data:self.list)
                                    } else {
                                        self.showAlert(title: "Thông báo", message: "Không tìm thấy báo cáo!")
                                    }
                                    self.view.subviews.forEach({$0.removeFromSuperview()})
                                    self.setUpView()
                                }
                            })
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    func save(item: TargetReport){
        let userName = (Cache.user?.UserName)!;
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        let action = "/mSM/Service.svc/NhapChiTieuDoanhSo_Save"
        
        let url = "\(Config.manager.URL_GATEWAY!)/mpos-cloud-msm\(action)"
        
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        let parameters: [String: String] = [
            "p_ID":"\(item.ID!)"
            , "p_UserCode":userName
            , "p_Nam":"\(year)"
            , "p_Thang":"\(month)"
            , "p_MaShop":"\(Cache.selectedShopCode)"
            , "p_MaNV":"\(item.MaNV!)"
            , "p_SoNgayLamViec":"\(item.SoNgayLamViec!)"
            , "p_Target_DS":"\(item.Target_DS!)"
            , "p_Target_PK":"\(item.Target_PK!)"
            , "p_GhiChu":"\(item.GhiChu!)"
            , "p_DeviceType":"\(2)"
        ]
        manager.request(url,method: .post,parameters:parameters,encoding: JSONEncoding(options: [])).responseJSON{ response in
            switch response.result {
            case .success(let value):
//                if let json = response.result.value {
                    let results = value as! NSDictionary
                    if let trafficResult = results .object(forKey: "mSM_NhapChiTieuDoanhSo_SaveResult") as? NSArray {
                        if(trafficResult.count > 0){
                            let item2 = trafficResult[0] as! NSDictionary
                            
                            let alertVC = UIAlertController(title: "Thông báo", message: item2["Msg"] as? String, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                            
                            self.view.subviews.forEach({$0.removeFromSuperview();});
                            self.loadData()
                        }
                    } else {
                        let alertVC = UIAlertController(title: "Thông báo", message: "Không lưu dữ liệu! (API)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
//                }else{
//                    let alertVC = UIAlertController(title: "Thông báo", message: "Không lưu dữ liệu! (API)", preferredStyle: .alert)
//                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                    alertVC.addAction(action)
//                    self.present(alertVC, animated: true, completion: nil)
//                }
            case .failure(let err):
                print("Load API thất bại! \(err)")
                let alertVC = UIAlertController(title: "Thông báo", message: "Không lưu dữ liệu! (API)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    func delete(item: TargetReport,ind:Int){
        let userName = (Cache.user?.UserName)!;
        let action = "/mSM/Service.svc/NhapChiTieuDoanhSo_Delete"
        
        let url = "\(Config.manager.URL_GATEWAY!)/mpos-cloud-msm\(action)"
        
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        let parameters: [String: String] = [
            "p_ID":"\(item.ID!)"
            ,"p_UserCode":userName
        ]
        
        manager.request(url,method: .post,parameters:parameters,encoding: JSONEncoding(options: [])).responseJSON{ response in
            switch response.result {
            case .success(let value):
//                if let json = response.result.value {
                    let results = value as! NSDictionary
                    if let trafficResult = results.object(forKey: "mSM_NhapChiTieuDoanhSo_DeleteResult") as? NSArray {
                        if(trafficResult.count > 0){
                            let item2 = trafficResult[0] as! NSDictionary
                            self.list[ind].ID = 0
                            self.list[ind].Target_DS = 0
                            self.list[ind].Target_PK = 0
                            self.list[ind].GhiChu = ""
                            self.collectionView.reloadData()
                            
                            let alertVC = UIAlertController(title: "Thông báo", message: item2["Msg"] as? String, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                            self.view.subviews.forEach({$0.removeFromSuperview();});
                            self.loadData()
                        }
                    } else {
                        print("Load API thất bại!")
                        let alertVC = UIAlertController(title: "Thông báo", message: "Không thể xoá!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
//                }else{
//                    print("Load API thất bại!")
//
//                    let alertVC = UIAlertController(title: "Thông báo", message: "Không thể xoá!", preferredStyle: .alert)
//                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                    alertVC.addAction(action)
//                    self.present(alertVC, animated: true, completion: nil)
//                }
            case .failure(let err):
                print("Load API thất bại! \(err)")
           
                
                let alertVC = UIAlertController(title: "Thông báo", message: "Không thể xoá! (API)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let dateCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionViewCell", for: indexPath) as! DateCollectionViewCell
                dateCell.setupHeader(item: header[indexPath.row])
                dateCell.backgroundColor = UIColor.white
                dateCell.layer.borderWidth = 0.5;
                dateCell.layer.borderColor = UIColor.lightGray.cgColor
                return dateCell
            } else {
                let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
                contentCell.setupHeader(item: header[indexPath.row])
                
                if indexPath.section % 2 != 0 {
                    contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    contentCell.backgroundColor = UIColor.white
                }
                contentCell.layer.borderWidth = 0.5;
                contentCell.layer.borderColor = UIColor.lightGray.cgColor
                return contentCell
            }
        } else {
            
            let itemTarget = self.list[indexPath.section - 1]
            
            if indexPath.row == 0 {
                let dateCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionViewCell", for: indexPath) as! DateCollectionViewCell
                
                dateCell.setup(item: String(indexPath.section))
                
                if itemTarget.ID == 0 {
                    dateCell.setupNameRed(item: String(indexPath.section))
                } else {
                    dateCell.setupName(item: String(indexPath.section))
                }
                
                if indexPath.section % 2 != 0 {
                    dateCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    dateCell.backgroundColor = UIColor.white
                }
                dateCell.layer.borderWidth = 0.5;
                dateCell.layer.borderColor = UIColor.lightGray.cgColor
                return dateCell
            } else {
                let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell;
                
                if (indexPath.row == 1){
                    if itemTarget.ID == 0 {
                        contentCell.setupRed(item: "\(list[indexPath.section - 1].MaTenNV!)")
                    } else {
                        if( "\(list[indexPath.section - 1].MaTenNV!)" != "Tổng cộng"){
                            contentCell.setup(item: "\(list[indexPath.section - 1].MaTenNV!)")
                        }
                        else{
                            contentCell.setupBold(item: "\(list[indexPath.section - 1].MaTenNV!)")
                        }
                    }
                    
                }else if (indexPath.row == 2){
                    if itemTarget.ID == 0 {
                        contentCell.setupRed(item: "\(list[indexPath.section - 1].NhomCD!)")
                    } else {
                        contentCell.setup(item: "\(list[indexPath.section - 1].NhomCD!)")
                    }
                    
                }else if (indexPath.row == 3){
                    if itemTarget.ID == 0 {
                        contentCell.setupRed(item: "\(list[indexPath.section - 1].SoNgayLamViec!)")
                    } else {
                        contentCell.setup(item: "\(list[indexPath.section - 1].SoNgayLamViec!)")
                    }
                    
                }else if (indexPath.row == 4){
                    if itemTarget.ID == 0 {
                        contentCell.setupRed(item: "\(Common.convertCurrencyDoubleV2(value: list[indexPath.section - 1].Target_PK!))")
                    } else {
                        contentCell.setup(item: "\(Common.convertCurrencyDoubleV2(value: list[indexPath.section - 1].Target_PK!))")
                    }
                    
                }else if (indexPath.row == 5){
                    
                    if itemTarget.ID == 0 {
                        contentCell.setupRed(item: "\(Common.convertCurrencyDoubleV2(value: list[indexPath.section - 1].Target_DS!))")
                    } else {
                        contentCell.setup(item: "\(Common.convertCurrencyDoubleV2(value: list[indexPath.section - 1].Target_DS!))")
                    }
                    
                }else if (indexPath.row == 6){
                    if itemTarget.ID == 0 {
                        contentCell.setupRed(item: "\(list[indexPath.section - 1].GhiChu!)")
                    } else {
                        contentCell.setup(item: "\(list[indexPath.section - 1].GhiChu!)")
                    }
                    
                }
                
                if indexPath.section % 2 != 0 {
                    contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    contentCell.backgroundColor = UIColor.white
                }
                contentCell.layer.borderWidth = 0.5;
                contentCell.layer.borderColor = UIColor.lightGray.cgColor
                return contentCell
            }
        }
    }
}


class DateCollectionViewCell: UICollectionViewCell {
    var title:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        //        title.sizeToFit()
        //        title.frame.origin.x = self.frame.size.width/2 -  title.frame.size.width/2
        addSubview(title)
        
    }
    func setupHeader(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 9)
        title.text = item
        title.numberOfLines = 0
        addSubview(title)
        
    }
    
    func setupRed(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.textColor = .red
        title.numberOfLines = 0
        addSubview(title)
    }
    
    func setupNameRed(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: Common.Size(s:5), y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        title.textColor = .red
        //        title.sizeToFit()
        addSubview(title)
        
    }
    func setupName(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: Common.Size(s:5), y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        //        title.sizeToFit()
        addSubview(title)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class ContentCollectionViewCell: UICollectionViewCell {
    var title:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        addSubview(title)
    }
    func setupBlue(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.textColor = .blue
        title.numberOfLines = 0
        addSubview(title)
    }
    func setupBold(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        addSubview(title)
    }
    func setupRed(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.textColor = .red
        title.numberOfLines = 0
        addSubview(title)
    }
    func setupName(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: Common.Size(s:5), y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        //        title.sizeToFit()
        addSubview(title)
        
    }
    func setupLink(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: Common.Size(s:5), y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        //        title.text = item
        
        //        title.sizeToFit()
        
        let textRange = NSMakeRange(0, item.count)
        let attributedText = NSMutableAttributedString(string: item)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed
        title.attributedText = attributedText
        title.numberOfLines = 0
        title.textColor = .blue
        addSubview(title)
        
    }
    func setupNameBold(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: Common.Size(s:5), y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        //        title.sizeToFit()
        addSubview(title)
        
    }
    func setupNameRed(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: Common.Size(s:5), y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        title.textColor = .red
        //        title.sizeToFit()
        addSubview(title)
        
    }
    func setupPrice(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width - Common.Size(s:10), height: self.frame.size.height))
        title.textAlignment = .right
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = "\(item)"
        title.numberOfLines = 0
        //        title.sizeToFit()
        addSubview(title)
        
    }
    func setupHeader(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        addSubview(title)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionView {
    func scrollToLast() {
        guard numberOfSections > 0 else {
            return
        }
        
        let lastSection = numberOfSections - 1
        
        guard numberOfItems(inSection: lastSection) > 0 else {
            return
        }
        
        let lastItemIndexPath = IndexPath(item: numberOfItems(inSection: lastSection) - 1,
                                          section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
    }
}
