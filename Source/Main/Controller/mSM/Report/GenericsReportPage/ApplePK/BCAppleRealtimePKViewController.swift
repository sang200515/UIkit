//
//  BCAppleRealtimePKViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 1/26/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI

class BCAppleRealtimePKViewController: UIViewController, MFMailComposeViewControllerDelegate, UISearchBarDelegate {
    
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
    var listSP: [AppleRealtimePK] = []
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
        //add khoảng cách để lên header cho báo cáo, đừng xoá nhé!!!
        switch self.type {
        //add khoảng cách để view lên theo yêu cầu, đừng xoá nhé
        case "Apple_Model":
            self.title = "Báo cáo theo Model"
            self.listSP.removeAll()
            self.header = ["STT", "Model", "SL Máy", "SL Combo 1        \n(Sạc + SDP + KCL)", "SL Combo 2          \n(Tai nghe + SDP + KCL)", "SL Combo 3                  \n(Sạc + Tai nghe + SDP + KCL)", "Tỷ lệ khai thác\nCombo1", "Tỷ lệ khai thác\nCombo2", "Tỷ lệ khai thác\nCombo3"]
            self.getDataModel()
            break
        case "Apple_Vung":
            self.title = "Báo cáo theo vùng"
            self.listSP.removeAll()
            self.header = ["STT", "Vùng", "SL Máy", "SL Combo 1        \n(Sạc + SDP + KCL)", "SL Combo 2          \n(Tai nghe + SDP + KCL)", "SL Combo 3                  \n(Sạc + Tai nghe + SDP + KCL)", "Tỷ lệ khai thác\nCombo1", "Tỷ lệ khai thác\nCombo2", "Tỷ lệ khai thác\nCombo3"]
            self.getDataVung()
            break
        case "Apple_KV":
            self.title = "Báo cáo theo khu vực"
            self.listSP.removeAll()
            self.header = ["STT", "Vùng", "ASM", "Khu vực", "SL Máy", "SL Combo 1        \n(Sạc + SDP + KCL)", "SL Combo 2          \n(Tai nghe + SDP + KCL)", "SL Combo 3                  \n(Sạc + Tai nghe + SDP + KCL)", "Tỷ lệ khai thác\nCombo1", "Tỷ lệ khai thác\nCombo2", "Tỷ lệ khai thác\nCombo3"]
            self.getDataKV()
            break
        default:
            break
        }
    }
    
    func getDataModel() {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listSP = mSMApiManager.DoanhSo_Iphone_ComboPK_Realtime_GetData_Model().Data ?? []
            if self.listSP.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.generateDataModel(self.listSP)
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
    
    func getDataVung() {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listSP = mSMApiManager.DoanhSo_Iphone_ComboPK_Realtime_GetData_Vung().Data ?? []
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
            self.listSP = mSMApiManager.DoanhSo_Iphone_ComboPK_Realtime_GetData_ASM().Data ?? []
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
    
    func generateDataModel(_ data:[AppleRealtimePK]) {
//        ["STT", "Model", "SL Máy", "SL Combo 1\n(Củ sạc+KCL+SDP)\nkèm máy", "SL Combo 2\n(Tai nghe+KCL+SDP)\nkèm máy", "SL Combo 3\n(Củ sạc+Tai nghe+KCL+SDP)\nkèm máy", "Tỷ lệ khai thác\nCombo1", "Tỷ lệ khai thác\nCombo2", "Tỷ lệ khai thác\nCombo3"]
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.Model)",
                "\(Common.convertCurrencyDoubleV2(value: item.SLMay))",
                "\(Common.convertCurrencyV2(value: item.Combo1))",
                "\(Common.convertCurrencyV2(value: item.Combo2))",
                "\(Common.convertCurrencyV2(value: item.Combo3))",
                "\(Common.convertCurrencyDoubleV2(value: item.TyLeCombo1))%",
                "\(Common.convertCurrencyDoubleV2(value: item.TyLeCombo2))%",
                "\(Common.convertCurrencyDoubleV2(value: item.TyLeCombo3))%"
            ]);
        }
    }
    
    func generateDataVung(_ data:[AppleRealtimePK]) {
//        ["STT", "Vùng", "SL Máy", "SL Combo 1\n(Củ sạc+KCL+SDP)\nkèm máy", "SL Combo 2\n(Tai nghe+KCL+SDP)\nkèm máy", "SL Combo 3\n(Củ sạc+Tai nghe+KCL+SDP)\nkèm máy", "Tỷ lệ khai thác\nCombo1", "Tỷ lệ khai thác\nCombo2", "Tỷ lệ khai thác\nCombo3"]
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.Vung)",
                "\(Common.convertCurrencyDoubleV2(value: item.SLMay))",
                "\(Common.convertCurrencyV2(value: item.Combo1))",
                "\(Common.convertCurrencyV2(value: item.Combo2))",
                "\(Common.convertCurrencyV2(value: item.Combo3))",
                "\(Common.convertCurrencyDoubleV2(value: item.TyLeCombo1))%",
                "\(Common.convertCurrencyDoubleV2(value: item.TyLeCombo2))%",
                "\(Common.convertCurrencyDoubleV2(value: item.TyLeCombo3))%"
            ]);
        }
    }
    func generateDataKV(_ data:[AppleRealtimePK]) {
//        ["STT", "Vùng", "ASM", "Khu vực", "SL Máy", "SL Combo 1\n(Củ sạc+KCL+SDP)\nkèm máy", "SL Combo 2\n(Tai nghe+KCL+SDP)\nkèm máy", "SL Combo 3\n(Củ sạc+Tai nghe+KCL+SDP)\nkèm máy", "Tỷ lệ khai thác\nCombo1", "Tỷ lệ khai thác\nCombo2", "Tỷ lệ khai thác\nCombo3"]
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.Vung)",
                "\(item.ASM)",
                "\(item.KhuVuc)",
                "\(Common.convertCurrencyDoubleV2(value: item.SLMay))",
                "\(Common.convertCurrencyV2(value: item.Combo1))",
                "\(Common.convertCurrencyV2(value: item.Combo2))",
                "\(Common.convertCurrencyV2(value: item.Combo3))",
                "\(Common.convertCurrencyDoubleV2(value: item.TyLeCombo1))%",
                "\(Common.convertCurrencyDoubleV2(value: item.TyLeCombo2))%",
                "\(Common.convertCurrencyDoubleV2(value: item.TyLeCombo3))%"
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
        var list:[AppleRealtimePK] = []
        list.removeAll()
        switch self.type {
        case "Apple_Model":
            if listSP.count > 0 {
                if(key.count > 0) {
                    for item in listSP {
                        if ((item.Model.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDataModel(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDataModel(listSP)
                    self.reportCollectionView.reloadData()
                }
            } else {
                debugPrint("Không lấy được data!")
            }
            break
        case "Apple_Vung":
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
        case "Apple_KV":
            if listSP.count > 0 {
                if(key.count > 0) {
                    for item in listSP {
                        if ((item.Vung.lowercased().range(of: key.lowercased())) != nil) || ((item.ASM.lowercased().range(of: key.lowercased())) != nil) || ((item.KhuVuc.lowercased().range(of: key.lowercased())) != nil){
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
        case "Apple_Model":
            let header = ["STT", "Model", "SL Máy", "SL Combo 1 (Củ sạc+KCL+SDP) kèm máy", "SL Combo 2 (Tai nghe+KCL+SDP) kèm máy", "SL Combo 3 (Củ sạc+Tai nghe+KCL+SDP) kèm máy", "Tỷ lệ khai thác Combo1", "Tỷ lệ khai thác Combo2", "Tỷ lệ khai thác Combo3"]
            var content = header.joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT)\t \(item.Model)\t \(item.SLMay)\t \(item.Combo1)\t \(item.Combo2)\t \(item.Combo3)\t \(item.TyLeCombo1)\t \(item.TyLeCombo2)\t \(item.TyLeCombo3)"
            }
            self.writeFile(path: path, content: content, reportName: "BCAppleRealtimePK_Model")
            break
        case "Apple_Vung":
            let header = ["STT", "Vùng", "SL Máy", "SL Combo 1 (Củ sạc+KCL+SDP) kèm máy", "SL Combo 2 (Tai nghe+KCL+SDP) kèm máy", "SL Combo 3 (Củ sạc+Tai nghe+KCL+SDP) kèm máy", "Tỷ lệ khai thác Combo1", "Tỷ lệ khai thác Combo2", "Tỷ lệ khai thác Combo3"]
            var content = header.joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT)\t \(item.Vung)\t \(item.SLMay)\t \(item.Combo1)\t \(item.Combo2)\t \(item.Combo3)\t \(item.TyLeCombo1)\t \(item.TyLeCombo2)\t \(item.TyLeCombo3)"
            }
            self.writeFile(path: path, content: content, reportName: "BCAppleRealtimePK_Vung")
            break
        case "Apple_KV":
            let header = ["STT", "Vùng", "ASM", "Khu vực", "SL Máy", "SL Combo 1 (Củ sạc+KCL+SDP) kèm máy", "SL Combo 2 (Tai nghe+KCL+SDP) kèm máy", "SL Combo 3 (Củ sạc+Tai nghe+KCL+SDP) kèm máy", "Tỷ lệ khai thác Combo1", "Tỷ lệ khai thác Combo2", "Tỷ lệ khai thác Combo3"]
            var content = header.joined(separator: "\t")
            for index in 0...data.count - 1 {
                let item = data[index]
                content += "\n\(item.STT)\t \(item.Vung)\t \(item.ASM)\t \(item.KhuVuc)\t \(item.SLMay)\t \(item.Combo1)\t \(item.Combo2)\t \(item.Combo3)\t \(item.TyLeCombo1)\t \(item.TyLeCombo2)\t \(item.TyLeCombo3)"
            }
            self.writeFile(path: path, content: content, reportName: "BCAppleRealtimePK_KhuVuc")
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

extension BCAppleRealtimePKViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
                
            } else if indexPath.section == cellData.count {
                switch self.type {
                case "Apple_Model":
                    if (indexPath.row == 1) {
                        cell.setupNameBold(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupBold(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                case "Apple_Vung":
                    if (indexPath.row == 1) {
                        cell.setupNameBold(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupBold(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                case "Apple_KV":
                    if (indexPath.row == 1) || (indexPath.row == 2) || (indexPath.row == 3) {
                        cell.setupNameBold(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupBold(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                default:
                    break
                }
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
                
            } else {
                switch self.type {
                case "Apple_Model":
                    if (indexPath.row == 1) {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                case "Apple_Vung":
                    if (indexPath.row == 1) {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                case "Apple_KV":
                    if (indexPath.row == 1) || (indexPath.row == 2) || (indexPath.row == 3) {
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
