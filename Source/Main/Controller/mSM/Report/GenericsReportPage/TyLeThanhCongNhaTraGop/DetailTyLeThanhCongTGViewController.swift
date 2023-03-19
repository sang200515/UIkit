//
//  DetailTyLeThanhCongTGViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 4/11/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI

class DetailTyLeThanhCongTGViewController: UIViewController, MFMailComposeViewControllerDelegate {
    var reportCollectionView: UICollectionView!;
    var header: [String] = [];
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    var reportSection: ReportCase!;
    var mailComposer = MFMailComposeViewController();
    var btnBack:UIBarButtonItem!
    var listInstallmentRate: [InstallmentRate] = []
    var type = "" //1:vung, 2:shop, 3:nhatragop
    
    override func viewWillAppear(_ animated: Bool) {
        
        let btnExport = UIBarButtonItem(image: UIImage(named: "ic_export"), style: .plain, target: self, action: #selector(ExportFile))
        let synchronizeButton = UIBarButtonItem(image: UIImage(named: "ic_sync"), style: .plain, target: self, action: #selector(self.ReloadData));
        self.navigationItem.rightBarButtonItems = [btnExport, synchronizeButton]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailComposer.mailComposeDelegate = self;
        self.view.backgroundColor = UIColor.white
        
        switch self.type {
        case "1":
            self.title = "BC tỷ lệ thành công theo vùng"
            self.listInstallmentRate.removeAll()
            self.header = ["Vùng", "Nhà trả góp", "Huỷ", "Phê duyệt", "Từ chối", "Tổng", "Tỷ lệ thành công"]
            self.getData(type: "1")
            break
            
        case "2" :
            self.title = "BC tỷ lệ thành công theo shop"
            self.listInstallmentRate.removeAll()
            self.header = ["Tên shop", "Huỷ", "Phê duyệt", "Từ chối", "Tổng", "Tỷ lệ thành công"];
            self.getData(type: "2")
            break
            
        case "3" :
            self.title = "BC tỷ lệ thành công theo nhà trả góp"
            self.listInstallmentRate.removeAll()
            self.header = ["Nhà trả góp", "Huỷ", "Phê duyệt", "Từ chối", "Tổng", "Tỷ lệ thành công"];
            self.getData(type: "3")
            break
            
        default:
            break
        }
    }
    
    func getData(type: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listInstallmentRate = mSMApiManager.GetInstallmentRate(username: "\(Cache.user!.UserName)", type: type).Data ?? []
            if self.listInstallmentRate.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    switch type {
                    case "1":
                        self.generateDataVung(self.listInstallmentRate)
                        break
                    case "2":
                        self.generateDataShop(self.listInstallmentRate)
                        break
                    case "3":
                        self.generateDataNhaTraGop(self.listInstallmentRate)
                        break
                    default:
                        break
                    }
                    
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
    
    func generateDataVung(_ data:[InstallmentRate]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.VungMien!)",
                "\(item.LoaiTraGop!)",
                "\(item.Huy!)",
                "\(item.PheDuyet!)",
                "\(item.TuChoi!)",
                "\(item.Tong!)",
                "\(item.TyLe!)"
            ]);
        }
    }
    
    func generateDataShop(_ data:[InstallmentRate]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.TenShop!)",
                "\(item.Huy!)",
                "\(item.PheDuyet!)",
                "\(item.TuChoi!)",
                "\(item.Tong!)",
                "\(item.TyLe!)"
            ]);
        }
    }
    func generateDataNhaTraGop(_ data:[InstallmentRate]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.NhaTraGop!)",
                "\(item.Huy!)",
                "\(item.PheDuyet!)",
                "\(item.TuChoi!)",
                "\(item.Tong!)",
                "\(item.TyLe!)"
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
    
    @objc func ReloadData() {
        self.getData(type: self.type)
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
        switch self.type {
        case "1":
            self.exportVung()
            break
            
        case "2":
            self.exportShop()
            break
            
        case "3":
            self.exportNhaTraGop()
            break
        default:
            break
        }
    }
    func exportVung() {
        let path = NSTemporaryDirectory() + "ReportTyLeThanhCongTheoVung.csv"
        
        //generate contents of file
        let data = self.listInstallmentRate
        let header =  ["Vùng", "Nhà trả góp", "Huỷ", "Phê duyệt", "Từ chối", "Tổng", "Tỷ lệ thành công"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.VungMien!)\t \(item.NhaTraGop!)\t \(item.Huy!)\t \(item.PheDuyet!)\t \(item.TuChoi!)\t \(item.Tong!)\t \(item.TyLe!)"
        }
        //write file
        self.writeFile(path: path, content: content, reportName: "ReportTyLeThanhCongTheoVung")
    }
    
    func exportShop() {
        let path = NSTemporaryDirectory() + "ReportTyLeThanhCongTheoShop.csv"
        
        //generate contents of file
        let data = self.listInstallmentRate
        let header =  ["Tên shop", "Huỷ", "Phê duyệt", "Từ chối", "Tổng", "Tỷ lệ thành công"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.TenShop!)\t \(item.Huy!)\t \(item.PheDuyet!)\t \(item.TuChoi!)\t \(item.Tong!)\t \(item.TyLe!)"
        }
        //write file
        self.writeFile(path: path, content: content, reportName: "ReportTyLeThanhCongTheoShop")
    }
    func exportNhaTraGop() {
        let path = NSTemporaryDirectory() + "ReportTyLeThanhCongTheoNhaTraGop.csv"
        
        //generate contents of file
        let data = self.listInstallmentRate
        let header = ["Nhà trả góp", "Huỷ", "Phê duyệt", "Từ chối", "Tổng", "Tỷ lệ thành công"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.NhaTraGop!)\t \(item.Huy!)\t \(item.PheDuyet!)\t \(item.TuChoi!)\t \(item.Tong!)\t \(item.TyLe!)"
        }
        //write file
        self.writeFile(path: path, content: content, reportName: "ReportTyLeThanhCongTheoNhaTraGop")
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
                        }
                        else {
                            let alertVC = UIAlertController(title: "Thông báo", message: "Không thể nạp nội dung file báo cáo!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        }
                        self.present(self.mailComposer, animated: true, completion: nil)
                    }
                    else  {
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

extension DetailTyLeThanhCongTGViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
                case "1":
                    if (indexPath.row == 0) || (indexPath.row == 1) {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                    
                case "2" :
                    if (indexPath.row == 0) || (indexPath.row == 1) || (indexPath.row == 2) {
                        cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                    } else {
                        cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                    }
                    break
                    
                case "3" :
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
