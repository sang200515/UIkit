//
//  GiaDungReportViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import MessageUI

enum GiaDungType {
    case realtimeVung
    case realtimeShop
    case realtimeKhuvuc
    case dailyVung
    case dailyShop
    case dailyKhuvuc
    case none
}

class GiaDungReportViewController: UIViewController, MFMailComposeViewControllerDelegate, UISearchBarDelegate {

    var reportCollectionView: UICollectionView!
    var header: [String] = []
    var cellData: [[String]] = []
    var tempHeaderForSize: [String] = []
    var mailComposer = MFMailComposeViewController()
    var btnSearch: UIBarButtonItem!
    var btnExport: UIBarButtonItem!
    var btnBack: UIBarButtonItem!
    var searchBarContainer: SearchBarContainerView!
    var listReport: [GiaDungResult] = []
    var type: GiaDungType = .none
    var leftRadio: RadioCustom {
        let radio = RadioCustom()
        radio.titleLabel.text = "DS Vùng Realtime"
        radio.setSelect(isSelect: p_Type == 0)
        radio.tagView = 0
        radio.delegate = self
        return radio
    }
    
    var rightRadio: RadioCustom {
        let radio = RadioCustom()
        radio.titleLabel.text = "DS Vùng không shop DA"
        radio.setSelect(isSelect: p_Type == 1)
        radio.tagView = 1
        radio.delegate = self
        return radio
    }
    var radioHeight: CGFloat = 40
    var p_Type = 0
    
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
        } else {
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
        
        self.listReport.removeAll()
        setupHeader()
        self.getData()
    }
    
    func setupHeader() {
        if type == .dailyShop {
            self.title = "Báo cáo luỹ kế gia dụng theo shop"
            self.header = ["STT", "Tên Shop", "Target Gia Dụng", "Total", "% Hoàn Thành", "% Hoàn Thành Dự Kiến", "M-1", "Tăng Giảm Cùng Kỳ"]
        } else if type == .dailyVung {
            self.title = "Báo cáo luỹ kế gia dụng theo vùng"
            self.header = ["STT", "Tên Vùng", "Target Gia Dụng", "Total", "% Hoàn Thành", "% Hoàn Thành Dự Kiến", "M-1", "Tăng Giảm Cùng Kỳ"]
        }  else if type == .dailyKhuvuc {
            self.title = "Báo cáo luỹ kế gia dụng theo khu vực"
            self.header = ["STT", "Tên ASM", "Target Gia Dụng", "Total", "% Hoàn Thành", "% Hoàn Thành Dự Kiến", "M-1", "Tăng Giảm Cùng Kỳ"]
        }  else if type == .realtimeShop {
            self.title = "Báo cáo realtime gia dụng theo shop"
            self.header = ["STT", "Tên Shop", "Total"]
        }  else if type == .realtimeVung {
            self.title = "Báo cáo realtime gia dụng theo vùng"
            self.header = ["STT", "Tên Vùng","Realtime Gia Dụng", "Realtime Gia Dụng Xiaomi", "Total"]
        }  else if type == .realtimeKhuvuc {
            self.title = "Báo cáo realtime gia dụng theo khu vực"
            self.header = ["STT", "Tên ASM", "Total"]
        } else {
            self.header = []
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
    
    func search(key: String) {
        var list: [GiaDungResult] = []
        list.removeAll()
        if listReport.count > 0 {
            if(key.count > 0) {
                for item in listReport {
                    if ((item.tenShop.lowercased().range(of: key.lowercased())) != nil) || ((item.khuVuc.lowercased().range(of: key.lowercased())) != nil) || ((item.tenVung.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateData(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateData(listReport)
                self.reportCollectionView.reloadData()
            }
        } else {
            debugPrint("Không lấy được data!")
        }
    }
    
    func getData() {
        self.listReport = []
        cellData = [[String]]()
        Provider.shared.giaDungApiService.getGiaDungData(type: type,pType: p_Type, success: { [weak self] result in
            guard let self = self, let dataReturn = result  else { return }
            self.listReport = dataReturn.result
            if self.listReport.count > 0 {
                self.generateData(self.listReport)
                if self.reportCollectionView != nil {
                    self.reportCollectionView.removeFromSuperview()
                }
                self.SetUpCollectionView()
            } else {
                debugPrint("Không lấy được data!")
                self.SetUpCollectionView()
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    func generateData(_ data: [GiaDungResult]) {
        cellData = [[String]]()
        for item in data {
            switch type {
            case .dailyVung:
                self.cellData.append([
                    "\(item.stt)",
                    "\(item.tenVung)",
                    "\(item.targetGiaDung)",
                    "\(item.total)",
                    "\(item.phanTramHoanThanh)%",
                    "\(item.phanTramHoanThanhDuKien)%",
                    "\(item.m1)",
                    "\(item.cungKy)"
                ]);
                break
            case .dailyShop:
                self.cellData.append([
                    "\(item.stt)",
                    "\(item.tenShop)",
                    "\(item.targetGiaDung)",
                    "\(item.total)",
                    "\(item.phanTramHoanThanh)%",
                    "\(item.phanTramHoanThanhDuKien)%",
                    "\(item.m1)",
                    "\(item.cungKy)"
                ]);
                break
            case .dailyKhuvuc:
                self.cellData.append([
                    "\(item.stt)",
                    "\(item.khuVuc)",
                    "\(item.targetGiaDung)",
                    "\(item.total)",
                    "\(item.phanTramHoanThanh)%",
                    "\(item.phanTramHoanThanhDuKien)%",
                    "\(item.m1)",
                    "\(item.cungKy)"
                ]);
                break
            case .realtimeVung:
                self.cellData.append([
                    "\(item.stt)",
                    "\(item.tenVung)",
                    "\(item.realtimeGiaDung)",
                    "\(item.realtimeGiaDungXiaomi)",
                    "\(item.total)"
                ]);
                break
            case .realtimeShop:
                self.cellData.append([
                    "\(item.stt)",
                    "\(item.tenShop)",
                    "\(item.total)"
                ]);
                break
            case .realtimeKhuvuc:
                self.cellData.append([
                    "\(item.stt)",
                    "\(item.khuVuc)",
                    "\(item.total)"
                ]);
                break
            case .none:
                break
            }
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
    
    ///-------setUpCollectionView-------
    func SetUpCollectionView(){
        for item in self.view.subviews {
            item.removeFromSuperview()
        }
        radioHeight = type == GiaDungType.realtimeVung ? 30 : 0
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
        if type == GiaDungType.realtimeVung {
            let stackView   = UIStackView(frame: CGRect(x: self.view.safeAreaInsets.left, y: 0, width: UIScreen.main.bounds.width, height: radioHeight))
            stackView.axis  = NSLayoutConstraint.Axis.horizontal
            stackView.distribution  = UIStackView.Distribution.equalSpacing
            stackView.alignment = UIStackView.Alignment.center
            stackView.spacing   = 16.0
            stackView.addArrangedSubview(leftRadio)
            stackView.addArrangedSubview(rightRadio)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(stackView)
            leftRadio.setSelect(isSelect: p_Type == 0)
            rightRadio.setSelect(isSelect: p_Type == 1)
        }
        
        self.reportCollectionView = UICollectionView.init(frame: CGRect(x: self.view.safeAreaInsets.left, y: radioHeight + 10, width: self.view.frame.size.width - self.view.safeAreaInsets.right, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height - (radioHeight + 10))), collectionViewLayout: collectionViewLayout)
        
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
        var name = ""
        let path = NSTemporaryDirectory() + "BaoCaoGiaDung.csv"
        //generate contents of file
        let data = self.listReport
        var content = self.header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            var cateGory = ""
            switch type {
            case .dailyVung:
                cateGory = item.tenVung
                name = "BaoCaoLuyKeGiaDungVung"
                content += "\n\(item.stt)\t\(item.tenVung)\t\(item.targetGiaDung)\t\(item.total)\t\(item.phanTramHoanThanh)\t\(item.phanTramHoanThanhDuKien)\t\(item.m1)\t\(item.cungKy)"
            case .dailyShop:
                cateGory = item.tenShop
                name = "BaoCaoLuyKeGiaDungShop"
                content += "\n\(item.stt)\t\(item.tenShop)\t\(item.targetGiaDung)\t\(item.total)\t\(item.phanTramHoanThanh)\t\(item.phanTramHoanThanhDuKien)\t\(item.m1)\t\(item.cungKy)"
            case .dailyKhuvuc:
                cateGory = item.khuVuc
                name = "BaoCaoLuyKeGiaDungKhuvuc"
                content += "\n\(item.stt)\t\(item.khuVuc)\t\(item.targetGiaDung)\t\(item.total)\t\(item.phanTramHoanThanh)\t\(item.phanTramHoanThanhDuKien)\t\(item.m1)\t\(item.cungKy)"
            case .realtimeShop:
                cateGory = item.tenShop
                name = "BaoCaoRealtimeGiaDungShop"
                content += "\n\(item.stt)\t\(item.tenShop)\t\(item.total)"
            case .realtimeVung:
                cateGory = item.tenVung
                name = "BaoCaoRealtimeGiaDungVung"
                content += "\n\(item.stt)\t\(item.tenVung)\t\(item.realtimeGiaDung)\t\(item.realtimeGiaDungXiaomi)\t\(item.total)"
            case .realtimeKhuvuc:
                cateGory = item.khuVuc
                name = "BaoCaoRealtimeGiaDungKhuvuc"
                content += "\n\(item.stt)\t\(item.khuVuc)\t\(item.total)"
            case .none:
                break
            }
        }
        
        do {
            if #available(iOS 15.2, *) {
                let filName = "\(name).csv"
                let newPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(filName)
                try content.write(to: newPath!, atomically: true, encoding: .utf16)
                let exportSheet = UIActivityViewController(activityItems: [newPath!] as [Any], applicationActivities: nil)
                self.present(exportSheet, animated: true, completion: nil)
            } else {
                //write file
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
                        
                        self.mailComposer.setSubject("mSM - BCGiaDung \(currentDateString)")
                        self.mailComposer.setMessageBody("BCGiaDung xuat tu ung dung mSM ngay \(currentDateString)", isHTML: false)
                        
                        if let fileData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                            print("File data loaded.")
                            self.mailComposer.addAttachmentData(fileData, mimeType: "text/csv", fileName: "BCGiaDung \(currentDateString).csv")
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

extension GiaDungReportViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension GiaDungReportViewController: RadioCustomDelegate {
    func onClickRadio(radioView: UIView, tag: Int) {
        print(tag)
        p_Type = tag
        self.getData()
    }
}
