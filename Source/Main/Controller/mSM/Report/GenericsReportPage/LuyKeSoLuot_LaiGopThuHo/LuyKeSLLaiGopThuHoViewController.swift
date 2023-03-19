//
//  LuyKeSLLaiGopThuHoViewController.swift
//  fptshop
//
//  Created by Apple on 5/17/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI

class LuyKeSLLaiGopThuHoViewController: UIViewController, MFMailComposeViewControllerDelegate, UISearchBarDelegate {
    
    var reportCollectionView: UICollectionView!;
    
    var header: [String] = [];
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    var reportSection: ReportCase!;
    var mailComposer = MFMailComposeViewController();
    var isDetailsOn: Bool = false;
    var btnSearch: UIBarButtonItem!
    var btnExport: UIBarButtonItem!
    var switchDetail = UISwitch()
    var btnBack:UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    var listSLLaiGopThuHo: [SLLaiGopThuHo] = []
    var comboPKType = ""
    let username = (Cache.user?.UserName)!;
    let token = (Cache.user?.Token)!
    
    //Setting up view to portrait when view disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        self.view.subviews.forEach({$0.removeFromSuperview()});
    }
    
    @objc func canRotate() -> Void{}
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .allButUpsideDown;
    }
    override var shouldAutorotate: Bool{
        return true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set up navigationbarItem
        
        btnExport = UIBarButtonItem(image: UIImage(named: "ic_export"), style: .plain, target: self, action: #selector(ExportFile))
        btnSearch = UIBarButtonItem(image: #imageLiteral(resourceName: "Search"), style: .plain, target: self, action: #selector(actionSearchAssets))
        self.navigationItem.rightBarButtonItems = [btnExport, btnSearch]
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = reportSection.caseName;
        mailComposer.mailComposeDelegate = self;
        
        self.SetUpCollectionView()
        
        //search bar custom
        let searchBar = UISearchBar()
        searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
        searchBarContainer.searchBar.showsCancelButton = true
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        searchBarContainer.searchBar.delegate = self
        
        if #available(iOS 11.0, *) {
            searchBarContainer.searchBar.placeholder = "Nhập từ khoá cần tìm..."
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Nhập từ khoá cần tìm...",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        
        switch self.comboPKType {
        case "BCSL_LaiGopThuHoVung":
            self.title = "Luỹ kế SL-Lãi gộp thu hộ vùng"
            self.listSLLaiGopThuHo.removeAll()
            self.header = ["Vùng", "Lãi gộp\n( chiết khấu )", "Tổng SL", "Nạp/rút", "Chuyển tiền", "Thu hộ khác"]
            self.getThanhToanHoaDon_CRM001_Vung(username: self.username, token: self.token)
            break
            
        case "BCSL_LaiGopThuHoKhuVuc" :
            self.title = "Luỹ kế SL-Lãi gộp thu hộ khu vực"
            self.listSLLaiGopThuHo.removeAll()
            self.header = ["ASM", "Lãi gộp\n( chiết khấu )", "Tổng SL", "Nạp/rút", "Chuyển tiền", "Thu hộ khác"]
            self.getThanhToanHoaDon_CRM001_KhuVuc(username: self.username, token: self.token)
            break
            
        case "BCSL_LaiGopThuHoShop" :
            self.title = "Luỹ kế SL-Lãi gộp thu hộ shop"
            self.listSLLaiGopThuHo.removeAll()
            self.header = ["ASM", "Shop", "Lãi gộp\n( chiết khấu )", "Tổng SL", "Nạp/rút", "Chuyển tiền", "Thu hộ khác"]
            self.getThanhToanHoaDon_CRM001_Shop(username: self.username, token: self.token)
            break
            
        default:
            break
        }
    }
    
    /////------------SEARCH--------
    
    @objc func actionSearchAssets(){
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
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in
            
        })
        self.navigationItem.setRightBarButtonItems([btnExport,btnSearch, UIBarButtonItem.init(customView: switchDetail)], animated: true)
        search(key: "")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        search(key: "\(searchBar.text!)")
        self.navigationItem.setRightBarButtonItems([btnExport,btnSearch, UIBarButtonItem.init(customView: switchDetail)], animated: true)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in
            
        })
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }
    //////////////////////////////////////////////
    func search(key:String){
        
        var list:[SLLaiGopThuHo] = []
        
        switch self.comboPKType {
        case "BCSL_LaiGopThuHoVung":
            list.removeAll()
            if(key.count > 0) {
                for item in listSLLaiGopThuHo {
                    if ((item.Vung.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateThanhToanHoaDon_CRM001_Vung(list)
                self.reportCollectionView.reloadData()
                
            } else {
                self.generateThanhToanHoaDon_CRM001_Vung(listSLLaiGopThuHo)
                self.reportCollectionView.reloadData()
            }
            break
        case "BCSL_LaiGopThuHoKhuVuc":
            list.removeAll()
            if(key.count > 0) {
                for item in listSLLaiGopThuHo {
                    if ((item.ASM.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateThanhToanHoaDon_CRM001_Khuvuc(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateThanhToanHoaDon_CRM001_Khuvuc(listSLLaiGopThuHo)
                self.reportCollectionView.reloadData()
            }
            break
        case "BCSL_LaiGopThuHoShop":
            list.removeAll()
            if(key.count > 0) {
                for item in listSLLaiGopThuHo {
                    if ((item.TenShop.lowercased().range(of: key.lowercased())) != nil || (item.ASM.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateThanhToanHoaDon_CRM001_Shop(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateThanhToanHoaDon_CRM001_Shop(listSLLaiGopThuHo)
                self.reportCollectionView.reloadData()
            }
            break
        
        default:
            break
        }
        
        
    }
    
    
    ////-------GET DATA-----------------------
    
    func getThanhToanHoaDon_CRM001_Vung(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.ThanhToanHoaDon_CRM001_Vung(username: username, token: token).Data
            if data != nil {
                self.listSLLaiGopThuHo = data ?? []
                if self.listSLLaiGopThuHo.count > 0 {
                    self.generateThanhToanHoaDon_CRM001_Vung(self.listSLLaiGopThuHo)
                    self.reportCollectionView.removeFromSuperview()
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.SetUpCollectionView()
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    debugPrint("Không lấy được data!")
                    self.SetUpCollectionView()
                }
            }
        }
    }
    
    func getThanhToanHoaDon_CRM001_KhuVuc(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.ThanhToanHoaDon_CRM001_KhuVuc(username: username, token: token).Data
            if data != nil {
                self.listSLLaiGopThuHo = data ?? []
                if self.listSLLaiGopThuHo.count > 0 {
                    self.generateThanhToanHoaDon_CRM001_Khuvuc(self.listSLLaiGopThuHo)
                    self.reportCollectionView.removeFromSuperview()
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.SetUpCollectionView()
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    debugPrint("Không lấy được data!")
                    self.SetUpCollectionView()
                }
            }
        }
    }
    
    func getThanhToanHoaDon_CRM001_Shop(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            let data = mSMApiManager.ThanhToanHoaDon_CRM001_Shop(username: username, token: token).Data
            if data != nil {
                self.listSLLaiGopThuHo = data ?? []
                if self.listSLLaiGopThuHo.count > 0 {
                    self.generateThanhToanHoaDon_CRM001_Shop(self.listSLLaiGopThuHo)
                    self.reportCollectionView.removeFromSuperview()
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.SetUpCollectionView()
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    debugPrint("Không lấy được data!")
                    self.SetUpCollectionView()
                }
            }
        }
    }
    
    ///--GENERATE DATA-----------------------
    //VUNG
    func generateThanhToanHoaDon_CRM001_Vung(_ data:[SLLaiGopThuHo]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(Common.convertCurrencyV2(value: Int(item.LaiGop_ChietKhau) ?? 0))",
                "\(Common.convertCurrencyV2(value: item.SL_Tong))",
                "\(Common.convertCurrencyV2(value: item.SL_NapRut))",
                "\(Common.convertCurrencyV2(value: item.SL_NhanChuyen))",
                "\(Common.convertCurrencyV2(value: item.SL_ThuHoCoBan))"
                ]);
        }
    }
    
    //KHU VUC
    func generateThanhToanHoaDon_CRM001_Khuvuc(_ data:[SLLaiGopThuHo]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(Common.convertCurrencyV2(value: Int(item.LaiGop_ChietKhau) ?? 0))",
                "\(Common.convertCurrencyV2(value: item.SL_Tong))",
                "\(Common.convertCurrencyV2(value: item.SL_NapRut))",
                "\(Common.convertCurrencyV2(value: item.SL_NhanChuyen))",
                "\(Common.convertCurrencyV2(value: item.SL_ThuHoCoBan))"
                ]);
        }
    }
    //SHOP
    func generateThanhToanHoaDon_CRM001_Shop(_ data:[SLLaiGopThuHo]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ASM)",
                "\(item.TenShop)",
                "\(Common.convertCurrencyV2(value: Int(item.LaiGop_ChietKhau) ?? 0))",
                "\(Common.convertCurrencyV2(value: item.SL_Tong))",
                "\(Common.convertCurrencyV2(value: item.SL_NapRut))",
                "\(Common.convertCurrencyV2(value: item.SL_NhanChuyen))",
                "\(Common.convertCurrencyV2(value: item.SL_ThuHoCoBan))"
                ]);
        }
    }
    
    ///export file
    @objc func ExportFile() {
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        switch self.comboPKType {
        case "BCSL_LaiGopThuHoVung":
            self.exportThanhToanHoaDon_CRM001_Vung()
            break
            
        case "BCSL_LaiGopThuHoKhuVuc" :
            self.exportThanhToanHoaDon_CRM001_KhuVuc()
            break
            
        case "BCSL_LaiGopThuHoShop" :
            self.exportThanhToanHoaDon_CRM001_Shop()
            break
        default:
            break
        }
    }
    
    func writeFile(path: String, content: String, reportName: String) {
        do {
            if #available(iOS 15.2, *) {
                let filName = "\(reportName).csv"
                let newPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(filName)
                try content.write(to: newPath!, atomically: true, encoding: .utf16)
                let exportSheet = UIActivityViewController(activityItems: [newPath!] as [Any], applicationActivities: nil)
                self.present(exportSheet, animated: true, completion: nil)
            } else {
                try content.write(toFile: path, atomically: false, encoding: String.Encoding.utf16)
                print("Nơi lưu file: \(path)")
                
                //Check to see the device can send email.
                let alertVC = UIAlertController(title: "Xuất báo cáo thành công!", message: "Nơi lưu file: \n" + path, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                    //Check to see the device can send email.
                    if( MFMailComposeViewController.canSendMail() ) {
                        print("Can send email.")
                        //Set the subject and message of the email
                        let currentDate = Date()
                        let formater = DateFormatter()
                        formater.dateFormat = "dd-MM-yyyy_HH:mm"
                        let currentDateString = formater.string(from: currentDate)
                        
                        self.mailComposer.setSubject("mSM - Xuat bao cao \(reportName) \(currentDateString)")
                        self.mailComposer.setMessageBody("\(reportName) xuat tu ung dung mSM ngay \(currentDateString)", isHTML: false)
                        
                        if let fileData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                            print("File data loaded.")
                            self.mailComposer.addAttachmentData(fileData, mimeType: "text/csv", fileName: "\(reportName) \(currentDateString).csv")
                        } else {
                            let alertVC = UIAlertController(title: "Thông báo", message: "Không thể nạp nội dung file báo cáo!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        }
                        self.present(self.mailComposer, animated: true, completion: nil)
                    } else {
                        let alertVC = UIAlertController(title: "Thông báo", message: "Vui lòng đăng nhập vào app Mail trên máy để xuất báo cáo qua mail!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }
        } catch let error as NSError{
            let alertVC = UIAlertController(title: "Xuất báo cáo không thành công!", message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            
            print("Failed to create file")
            print("\(error)")
        }

    }
    
    func exportThanhToanHoaDon_CRM001_Vung() {
        let path = NSTemporaryDirectory() + "ReportLuyKeSLLaiGopThuHoVung.csv"
        
        //generate contents of file
        let data = self.listSLLaiGopThuHo
        let header = ["Vùng", "Lãi gộp\n( chiết khấu )", "Tổng SL", "Nạp/rút", "Chuyển tiền", "Thu hộ khác"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.Vung)\t \(item.LaiGop_ChietKhau)\t \(item.SL_Tong)\t \(item.SL_NapRut)\t \(item.SL_NhanChuyen)\t \(item.SL_ThuHoCoBan)"
        }
        self.writeFile(path: path, content: content, reportName: "ReportLuyKeSLLaiGopThuHoVung")
    }
    
    func exportThanhToanHoaDon_CRM001_KhuVuc() {
        let path = NSTemporaryDirectory() + "ReportLuyKeSLLaiGopThuHoKhuvuc.csv"
        
        //generate contents of file
        let data = self.listSLLaiGopThuHo
        let header = ["ASM", "Lãi gộp\n( chiết khấu )", "Tổng SL", "Nạp/rút", "Chuyển tiền", "Thu hộ khác"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.ASM)\t \(item.LaiGop_ChietKhau)\t \(item.SL_Tong)\t \(item.SL_NapRut)\t \(item.SL_NhanChuyen)\t \(item.SL_ThuHoCoBan)"
        }
        self.writeFile(path: path, content: content, reportName: "ReportLuyKeSLLaiGopThuHoKhuvuc")
    }
    
    
    func exportThanhToanHoaDon_CRM001_Shop() {
        let path = NSTemporaryDirectory() + "ReportLuyKeSLLaiGopThuHoShop.csv"
        
        //generate contents of file
        let data = self.listSLLaiGopThuHo
        let header = ["ASM", "Shop", "Lãi gộp\n( chiết khấu )", "Tổng SL", "Nạp/rút", "Chuyển tiền", "Thu hộ khác"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.TenShop)\t \(item.ASM)\t \(item.LaiGop_ChietKhau)\t \(item.SL_Tong)\t \(item.SL_NapRut)\t \(item.SL_NhanChuyen)\t \(item.SL_ThuHoCoBan)"
        }
        self.writeFile(path: path, content: content, reportName: "ReportLuyKeSLLaiGopThuHoShop")
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
        print("Mail Compose controller didFinished");
        controller.dismiss(animated: true, completion: nil);
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
            case .portrait:
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.SetUpCollectionView();
            case .landscapeLeft,.landscapeRight :
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.SetUpCollectionView();
            default:
                print("Upside down, and that is not supported");
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in})
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    ///-------setUpCollectionView-------
    func SetUpCollectionView(){
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
        
        self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout);
        
        self.reportCollectionView.delegate = self;
        self.reportCollectionView.dataSource = self;
        self.reportCollectionView.showsHorizontalScrollIndicator = true;
        self.reportCollectionView.backgroundColor = UIColor.white;
        
        self.view.bringSubviewToFront(reportCollectionView);
        self.reportCollectionView.register(ReportDataCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        
        
        self.reportCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.reportCollectionView)
        
        if(cellData.count == 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
            self.view.addSubview(emptyView);
        }
        self.navigationController?.navigationBar.isTranslucent = false;
        
    }
    
}

extension LuyKeSLLaiGopThuHoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellData.count + 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return header.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReportDataCollectionViewCell;
        
        if indexPath.section % 2 == 0 {
            cell.backgroundColor = UIColor(white: 235/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if(header.count > 0 || cellData.count > 0 ){
            if(indexPath.section == 0){
                cell.setupHeader(item: header[indexPath.row]);
                cell.backgroundColor = UIColor.lightGray;
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }else{
                
                switch self.comboPKType {
                case "BCSL_LaiGopThuHoVung":
                    if indexPath.row == 0 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                    
                case "BCSL_LaiGopThuHoKhuVuc" :
                    if indexPath.row == 0{
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                    
                case "BCSL_LaiGopThuHoShop" :
                    if indexPath.row == 0 || indexPath.row == 1 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                default:
                    break
                }
            }
        }
        return cell;
    }
}
