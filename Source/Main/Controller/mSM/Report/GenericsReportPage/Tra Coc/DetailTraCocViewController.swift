//
//  DetailTraCocViewController.swift
//  fptshop
//
//  Created by Apple on 5/16/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI

class DetailTraCocViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var reportCollectionView: UICollectionView!;
    var header: [String] = [];
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    var reportSection: ReportCase!;
    var mailComposer = MFMailComposeViewController();
    var btnExport: UIBarButtonItem!
    var listSoCoc: [SoCoc] = []
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
        self.navigationItem.rightBarButtonItem = btnExport
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = reportSection.caseName;
        mailComposer.mailComposeDelegate = self;
        self.view.backgroundColor = UIColor.white
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            switch self.comboPKType {
            case "TraCocVung":
                self.title = "BC Theo Dõi Số Cọc Vùng"
                self.listSoCoc.removeAll()
                self.header = ["Vùng", "Target Cọc", "SL Cọc MTD", "% HT Target Cọc"]
                self.getDSCoc(tableData: "table1")
                break
            case "TraCocKhuVuc" :
                self.title = "BC Theo Dõi Số Cọc Khu vực"
                self.listSoCoc.removeAll()
                self.header = ["ASM", "Khu Vực", "Target Cọc", "SL Cọc MTD", "% HT Target Cọc"]
                self.getDSCoc(tableData: "table2")
                break
            case "TraCocShop":
                self.title = "BC Theo Dõi Số Cọc Shop"
                self.listSoCoc.removeAll()
                self.header = ["Shop", "ASM", "Target Cọc", "SL Cọc MTD", "% HT Target Cọc"]
                self.getDSCoc(tableData: "table3")
                break
            default:
                break
            }
            
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.SetUpCollectionView()
            }
        }
    }
    
    
    /////GET DATA
    func getDSCoc(tableData: String){
        cellData = [[String]]()
        
        mSMApiManager.getSoCoc(tableData: tableData) { (arrSoCocResults, err) in
            if arrSoCocResults.count > 0 {
                for item in arrSoCocResults {
                    self.listSoCoc.append(item)
                }
            }
            
            if self.listSoCoc.count > 0 {
                if tableData == "table1" {
                    self.generateDSTraCocVung(self.listSoCoc)
                } else if tableData == "table2" {
                    self.generateDSTraCocKhuVuc(self.listSoCoc)
                } else if tableData == "table3" {
                    self.generateDSTraCocShop(self.listSoCoc)
                } else {
                    debugPrint("khong co data Tra Coc!")
                }
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    self.SetUpCollectionView()
                    
                })
            } else {
                debugPrint("Không lấy được data!")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    self.SetUpCollectionView()
                    
                })
            }
        }
        
    }
    
    
    ///--GENERATE DATA-----------------------
    //VUNG
    func generateDSTraCocVung(_ data:[SoCoc]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(item.Target)",
                "\(item.SLcocMTD)",
                "\(item.Phantram)"
                ]);
        }
    }
    
    //KHUVUC
    func generateDSTraCocKhuVuc(_ data:[SoCoc]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.TenASM)",
                "\(item.TenKhuvuc)",
                "\(item.Target)",
                "\(item.SLcocMTD)",
                "\(item.Phantram)"
                ]);
            
        }
    }
    
    //SHOP
    func generateDSTraCocShop(_ data:[SoCoc]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Shop)",
                "\(item.TenASM)",
                "\(item.Target)",
                "\(item.SLcocMTD)",
                "\(item.Phantram)"
                ]);
            
        }
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
    
    //////-------------EXPORT FILE------------------------
    @objc func ExportFile() {
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        switch self.comboPKType {
        case "TraCocVung":
            self.exportReportTheoDoiSoCocVung()
            break
            
        case "TraCocKhuVuc" :
            self.exportReportTheoDoiSoCocKhuVuc()
            break
            
        case "TraCocShop" :
            self.exportReportTheoDoiSoCocShop()
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
    
    func exportReportTheoDoiSoCocVung() {
        let path = NSTemporaryDirectory() + "TheoDoiSoCocVung.csv"
        
        //generate contents of file
        let data = self.listSoCoc
        let header = ["Vùng", "Target Cọc", "SL Cọc MTD", "% HT Target Cọc"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.Vung)\t \(item.Target)\t \(item.SLcocMTD)\t \(item.Phantram)"
        }
        self.writeFile(path: path, content: content, reportName: "TheoDoiSoCocVung")
    }
    
    func exportReportTheoDoiSoCocKhuVuc() {
        let path = NSTemporaryDirectory() + "TheoDoiSoCocKhuVuc.csv"
        
        //generate contents of file
        let data = self.listSoCoc
        let header = ["ASM", "Khu Vực", "Target Cọc", "SL Cọc MTD", "% HT Target Cọc"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.TenASM)\t \(item.TenKhuvuc)\t \(item.Target)\t \(item.SLcocMTD)\t \(item.Phantram)"
        }
        self.writeFile(path: path, content: content, reportName: "TheoDoiSoCocKhuVuc")
    }
    
    func exportReportTheoDoiSoCocShop() {
        let path = NSTemporaryDirectory() + "TheoDoiSoCocShop.csv"
        
        //generate contents of file
        let data = self.listSoCoc
        let header = ["Shop", "ASM", "Target Cọc", "SL Cọc MTD", "% HT Target Cọc"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.Shop)\t \(item.TenASM)\t \(item.Target)\t \(item.SLcocMTD)\t \(item.Phantram)"
        }
        self.writeFile(path: path, content: content, reportName: "TheoDoiSoCocShop")
    }
    
}

extension DetailTraCocViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
                case "TraCocVung":
                    if indexPath.row == 0 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                    
                case "TraCocKhuVuc" :
                    if indexPath.row == 0 || indexPath.row == 1 {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    
                    cell.layer.borderWidth = 0.5;
                    cell.layer.borderColor = UIColor.darkGray.cgColor;
                    break
                    
                case "TraCocShop" :
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
