//
//  MyPhamSalemanViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 2/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI

class MyPhamSalemanViewController: UIViewController, MFMailComposeViewControllerDelegate, UISearchBarDelegate {

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
    var listMPSaleman: [MyPhamSalemanItem2] = []
    
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
        
        self.title = "BC DS Mỹ Phẩm Theo Nhân Viên"
        self.listMPSaleman.removeAll()
        self.header = ["Tên Shop", "Tên Nhân viên", "Tổng DS", "Tổng SL", "SLTB", "SL Cơ thể", "SL Da", "SL Nước hoa", "SL Tóc", "SL Trang điểm", "Khác", "SO", "DS TB/Bill"]
        self.getData()
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
        var list:[MyPhamSalemanItem2] = []
        list.removeAll()
        if listMPSaleman.count > 0 {
            if(key.count > 0) {
                for item in listMPSaleman {
                    if ((item.ShopName.lowercased().range(of: key.lowercased())) != nil) || ((item.EmployeeName.lowercased().range(of: key.lowercased())) != nil) {
                        list.append(item)
                    }
                }
                self.generateData(list)
                self.reportCollectionView.reloadData()
            } else {
                self.generateData(listMPSaleman)
                self.reportCollectionView.reloadData()
            }
        } else {
            debugPrint("Không lấy được data!")
        }
    }
    
    func getData() {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listMPSaleman = mSMApiManager.DoanhSoShop_MyPhamSaleman_View().Data ?? []
            if self.listMPSaleman.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.generateData(self.listMPSaleman)
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
    
    func generateData(_ data:[MyPhamSalemanItem2]) {
        
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.ShopName)",
                "\(item.EmployeeName)",
                "\(Common.convertCurrencyDouble(value: item.TongDS))",
                "\(Common.convertCurrencyDouble(value: item.TongSL))",
                "\(Common.convertCurrencyDouble(value: item.SLTB))",
                "\(Common.convertCurrencyDouble(value: item.CoThe))",
                "\(Common.convertCurrencyDouble(value: item.Da))",
                "\(Common.convertCurrencyDouble(value: item.NuocHoa))",
                "\(Common.convertCurrencyDouble(value: item.Toc))",
                "\(Common.convertCurrencyDouble(value: item.TrangDiem))",
                "\(Common.convertCurrencyDouble(value: item.Khac))",
                "\(Common.convertCurrencyDouble(value: item.SLSO))",
                "\(Common.convertCurrencyDouble(value: item.DS_TBBill))"
            ]);
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
        let path = NSTemporaryDirectory() + "DSMyPhamTheoNhanVien.csv"
        
        //generate contents of file
        let data = self.listMPSaleman
        var content = self.header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.ShopName)\t \(item.EmployeeName)\t \(item.TongDS)\t \(item.TongSL)\t \(item.SLTB)\t \(item.CoThe)\t \(item.Da)\t \(item.NuocHoa)\t \(item.Toc)\t \(item.TrangDiem)\t \(item.Khac)\t \(item.SLSO)\t \(item.DS_TBBill)"
        }
        //write file
        do {
            if #available(iOS 15.2, *) {
                let filName = "DSMyPhamTheoNhanVien.csv"
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
                        
                        self.mailComposer.setSubject("mSM - DSMyPhamTheoNhanVien \(currentDateString)")
                        self.mailComposer.setMessageBody("DSMyPhamTheoNhanVien xuat tu ung dung mSM ngay \(currentDateString)", isHTML: false)
                        
                        if let fileData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                            print("File data loaded.")
                            self.mailComposer.addAttachmentData(fileData, mimeType: "text/csv", fileName: "DSMyPhamTheoNhanVien \(currentDateString).csv")
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
extension MyPhamSalemanViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
