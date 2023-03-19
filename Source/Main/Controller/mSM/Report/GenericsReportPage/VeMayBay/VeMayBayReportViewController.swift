//
//  VeMayBayReportViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 2/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI

class VeMayBayReportViewController: UIViewController, MFMailComposeViewControllerDelegate, UISearchBarDelegate {
    
    var reportCollectionView: UICollectionView!;
    var header: [String] = [];
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    var reportSection: ReportCase!;
    var mailComposer = MFMailComposeViewController();
    var isDetailsOn: Bool = false;
    var btnSearch: UIBarButtonItem!
    var btnExport: UIBarButtonItem!
    var btnBack:UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    var listVeMayBay: [VeMayBayItem] = []
    var type = ""
    var isRealtime = false

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
        self.view.backgroundColor = UIColor.white
        
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
        
        switch self.type {
        case "VeMayBayVung":
            if isRealtime {
                self.title = "BC Realtime Vé Máy Bay Vùng"
            } else {
                self.title = "BC Luỹ Kế Vé Máy Bay Vùng"
            }
            
            self.listVeMayBay.removeAll()
            self.header = ["STT", "Vùng", "SL", "Doanh thu thực"]
            self.getDataVung()
            break
            
        case "VeMayBayASM" :
            
            if isRealtime {
                self.title = "BC Realtime Vé Máy Bay Khu Vực"
            } else {
                self.title = "BC Luỹ Kế Vé Máy Bay Khu Vực"
            }
            self.listVeMayBay.removeAll()
            self.header = ["STT", "ASM", "Khu vực", "SL", "Doanh thu"]
            self.getDataASM()
            break
            
        case "VeMayBayShop" :
            if isRealtime {
                self.title = "BC Realtime Vé Máy Bay Shop"
            } else {
                self.title = "BC Luỹ Kế Vé Máy Bay Shop"
            }
            
            self.listVeMayBay.removeAll()
            self.header = ["STT", "ASM", "Shop", "SL", "Doanh thu"]
            self.getDataShop()
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
        self.navigationItem.setRightBarButtonItems([btnExport,btnSearch], animated: true)
        search(key: "")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        search(key: "\(searchBar.text!)")
        self.navigationItem.setRightBarButtonItems([btnExport,btnSearch], animated: true)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in
            
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }
    
    func search(key:String){
        var list:[VeMayBayItem] = []
        
        switch self.type {
        case "VeMayBayVung":
            list.removeAll()
            if listVeMayBay.count > 0 {
                if(key.count > 0) {
                    for item in listVeMayBay {
                        if ((item.Vung.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDataVung(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDataVung(listVeMayBay)
                    self.reportCollectionView.reloadData()
                }
            } else {
                debugPrint("Không lấy được data!")
            }
            break
        case "VeMayBayASM":
            list.removeAll()
            if listVeMayBay.count > 0 {
                if(key.count > 0) {
                    for item in listVeMayBay {
                        if ((item.ASM.lowercased().range(of: key.lowercased())) != nil) || ((item.KhuVuc.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDataASM(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDataASM(listVeMayBay)
                    self.reportCollectionView.reloadData()
                }
            } else {
                debugPrint("Không lấy được data!")
            }
            break
        case "VeMayBayShop":
            list.removeAll()
            if listVeMayBay.count > 0 {
                if(key.count > 0) {
                    for item in listVeMayBay {
                        if ((item.TenShop.lowercased().range(of: key.lowercased())) != nil) || ((item.ASM.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDataShop(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDataShop(listVeMayBay)
                    self.reportCollectionView.reloadData()
                }
            } else {
                debugPrint("Không lấy được data!")
            }
            break
        default:
            break
        }
    }
    
    func getDataVung() {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            if self.isRealtime {
                self.listVeMayBay = mSMApiManager.ListSP_Realtime_VeMayBay_Vung_View().Data ?? []
            } else {
                self.listVeMayBay = mSMApiManager.ListSP_LuyKe_VeMayBay_Vung_View().Data ?? []
            }
            if self.listVeMayBay.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.generateDataVung(self.listVeMayBay)
                    if self.reportCollectionView != nil {
                        self.reportCollectionView.removeFromSuperview()
                    }
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
    
    func getDataASM() {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            if self.isRealtime {
                self.listVeMayBay = mSMApiManager.ListSP_Realtime_VeMayBay_ASM_View().Data ?? []
            } else {
                self.listVeMayBay = mSMApiManager.ListSP_LuyKe_VeMayBay_ASM_View().Data ?? []
            }
            if self.listVeMayBay.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.generateDataASM(self.listVeMayBay)
                    if self.reportCollectionView != nil {
                        self.reportCollectionView.removeFromSuperview()
                    }
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
    
    func getDataShop() {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            if self.isRealtime {
                self.listVeMayBay = mSMApiManager.ListSP_Realtime_VeMayBay_Shop_View().Data ?? []
            } else {
                self.listVeMayBay = mSMApiManager.ListSP_LuyKe_VeMayBay_Shop_View().Data ?? []
            }
            if self.listVeMayBay.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.generateDataShop(self.listVeMayBay)
                    if self.reportCollectionView != nil {
                        self.reportCollectionView.removeFromSuperview()
                    }
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
    
    func generateDataVung(_ data:[VeMayBayItem]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.Vung)",
                "\(Common.convertCurrencyInteger(value: item.SL))",
                "\(Common.convertCurrencyDouble(value: item.DoanhThu))"
                ]);
        }
    }
    
    func generateDataASM(_ data:[VeMayBayItem]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyInteger(value: item.SL))",
                "\(Common.convertCurrencyDouble(value: item.DoanhThu))"
                ]);
        }
    }
    
    func generateDataShop(_ data:[VeMayBayItem]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.ASM)",
                "\(item.TenShop)",
                "\(Common.convertCurrencyInteger(value: item.SL))",
                "\(Common.convertCurrencyDouble(value: item.DoanhThu))"
                ]);
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
            case .portrait:
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.SetUpCollectionView()
            case .landscapeLeft,.landscapeRight :
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.SetUpCollectionView()
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
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
        print("Mail Compose controller didFinished");
        controller.dismiss(animated: true, completion: nil);
    }
    
    @objc func ExportFile() {
        
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        var reportName = ""
        
        if isRealtime {
            reportName = "\(type)Realtime"
        } else {
            reportName = "\(type)Luyke"
        }
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        let data = self.listVeMayBay
        switch self.type {
        case "VeMayBayVung":
            let header =  ["STT", "Vùng", "SL", "Doanh thu thực"]
            var content = header.joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT)\t \(item.Vung)\t \(item.SL)\t \(item.DoanhThu)"
            }
            self.writeFile(path: path, content: content, reportName: reportName)
            break
            
        case "VeMayBayASM" :
            let header = ["STT", "ASM", "Khu vực", "SL", "Doanh thu"]
            var content = header.joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT)\t \(item.ASM)\t \(item.KhuVuc)\t \(item.SL)\t \(item.DoanhThu)"
            }
            self.writeFile(path: path, content: content, reportName: reportName)
            break
            
        case "VeMayBayShop" :
            let header = ["STT", "ASM", "Shop", "SL", "Doanh thu"]
            var content = header.joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT)\t \(item.ASM)\t \(item.TenShop)\t \(item.SL)\t \(item.DoanhThu)"
            }
            self.writeFile(path: path, content: content, reportName: reportName)
            break
        default:
            break
        }
    }
    
    func writeFile(path: String, content: String, reportName: String) {
        do {
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
        } catch let error as NSError{
            let alertVC = UIAlertController(title: "Xuất báo cáo không thành công!", message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            
            print("Failed to create file")
            print("\(error)")
        }

    }
}

extension VeMayBayReportViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
            } else {
                switch self.type {
                case "VeMayBayVung":
                    if (indexPath.row == 0) || (indexPath.row == 1) {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                    
                case "VeMayBayASM" :
                    if (indexPath.row == 0) || (indexPath.row == 1) || (indexPath.row == 2) {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                    
                case "VeMayBayShop" :
                    if (indexPath.row == 0) || (indexPath.row == 1) || (indexPath.row == 2) {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                default:
                    break
                }
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }
        }
        return cell;
    }
}
