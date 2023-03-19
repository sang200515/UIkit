//
//  DoanhSoPK_IPhoneRealtimeViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 6/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI

class DoanhSoPK_IPhoneRealtimeViewController: UIViewController, MFMailComposeViewControllerDelegate, UISearchBarDelegate {

    var reportCollectionView: UICollectionView!;
    var header: [String] = [];
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    var mailComposer = MFMailComposeViewController();
    var isDetailsOn: Bool = false;
    var btnSearch: UIBarButtonItem!
    var btnExport: UIBarButtonItem!
    var btnBack:UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    var listSP: [PK_IPhoneRealtime] = []
    var type = ""
    
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
        case "PKIPhone_Vung":
            self.title = "Báo cáo Realtime Non IPhone Vùng"
            self.listSP.removeAll()
            self.header = ["Vùng", "Doanh Số", "Phụ Kiện", "Tỉ Trọng", "DS IPhone", "PKNK", "TT IPhone"]
            self.getDataVung()
            break
        case "PKIPhone_KV":
            self.title = "Báo cáo Realtime Non IPhone Khu vực"
            self.listSP.removeAll()
            self.header = ["Tên KV", "Tên ASM", "Doanh Số", "Phụ Kiện", "Tỉ Trọng", "DS IPhone", "PKNK", "TT IPhone"]
            self.getDataKV()
            break
        default:
            break
        }
    }
    
    func getDataVung() {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listSP = mSMApiManager.DoanhSo_PhuKien_Iphone_Realtime_Vung_View().Data ?? []
            if self.listSP.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.generateDataVung(self.listSP)
                    if self.reportCollectionView != nil {
                        self.reportCollectionView.removeFromSuperview()
                    }
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.SetUpCollectionView()
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let alert = UIAlertController(title: "Thông báo", message: "Không có data báo cáo !", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (_) in
                        self.SetUpCollectionView()
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func getDataKV() {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listSP = mSMApiManager.DoanhSo_PhuKien_Iphone_Realtime_KhuVuc_View().Data ?? []
            if self.listSP.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.generateDataKV(self.listSP)
                    if self.reportCollectionView != nil {
                        self.reportCollectionView.removeFromSuperview()
                    }
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.SetUpCollectionView()
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let alert = UIAlertController(title: "Thông báo", message: "Không có data báo cáo !", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (_) in
                        self.SetUpCollectionView()
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func generateDataVung(_ data:[PK_IPhoneRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(item.DoanhSo_None_Iphone)",
                "\(item.DoanhSo_PK)",
                "\(item.TyLe_PhuKien_ALL)",
                "\(item.DoanhSo_Iphone)",
                "\(item.DoanhSo_PKNK)",
                "\(item.TyLe_PhuKien_IPhone)"
            ]);
        }
    }
    func generateDataKV(_ data:[PK_IPhoneRealtime]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.TenKV)",
                "\(item.TenASM)",
                "\(item.DoanhSo_None_Iphone)",
                "\(item.DoanhSo_PK)",
                "\(item.TyLe_PhuKien_ALL)",
                "\(item.DoanhSo_Iphone)",
                "\(item.DoanhSo_PKNK)",
                "\(item.TyLe_PhuKien_IPhone)"
            ]);
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
        var list:[PK_IPhoneRealtime] = []
        list.removeAll()
        switch self.type {
        case "PKIPhone_Vung":
            if listSP.count > 0 {
                if(key.count > 0) {
                    for item in listSP {
                        if ((item.Vung.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDataVung(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDataVung(listSP)
                    self.reportCollectionView.reloadData()
                }
            } else {
                debugPrint("Không lấy được data!")
            }
            break
        case "PKIPhone_KV":
            if listSP.count > 0 {
                if(key.count > 0) {
                    for item in listSP {
                        if ((item.TenKV.lowercased().range(of: key.lowercased())) != nil) || ((item.TenASM.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDataKV(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDataKV(listSP)
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
        let path = NSTemporaryDirectory() + "\(self.type).csv"
        let data = self.listSP
        switch self.type {
        case "PKIPhone_Vung":
            let header = ["Vùng", "Doanh Số", "Phụ Kiện", "Tỉ Trọng", "DS IPhone", "PKNK", "TT IPhone"]
            var content = header.joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.Vung)\t \(item.DoanhSo_None_Iphone)\t \(item.DoanhSo_PK)\t \(item.TyLe_PhuKien_ALL)\t \(item.DoanhSo_Iphone)\t \(item.DoanhSo_PKNK)\t \(item.TyLe_PhuKien_IPhone)"
            }
            self.writeFile(path: path, content: content, reportName: "BCRealtimeNonIPhone_Vung")
            break
        case "PKIPhone_KV":
            let header = ["Tên KV", "Tên ASM", "Doanh Số", "Phụ Kiện", "Tỉ Trọng", "DS IPhone", "PKNK", "TT IPhone"]
            var content = header.joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.TenKV)\t \(item.TenASM)\t \(item.DoanhSo_None_Iphone)\t \(item.DoanhSo_PK)\t \(item.TyLe_PhuKien_ALL)\t \(item.DoanhSo_Iphone)\t \(item.DoanhSo_PKNK)\t \(item.TyLe_PhuKien_IPhone)"
            }
            self.writeFile(path: path, content: content, reportName: "BCRealtimeNonIPhone_KV")
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
}

extension DoanhSoPK_IPhoneRealtimeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
                if (indexPath.row == 0) || (indexPath.row == 1) {
                    cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                } else {
                    cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                }
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }
        }
        return cell;
    }
}
