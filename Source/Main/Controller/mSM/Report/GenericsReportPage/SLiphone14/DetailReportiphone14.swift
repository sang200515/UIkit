//
//  DetailReportiphone14.swift
//  fptshop
//
//  Created by Sang Trương on 12/10/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//


import UIKit
import MessageUI
import DropDown

class DetailReportiphone14: UIViewController, MFMailComposeViewControllerDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
    var listSLiphone: [SLIPHONE14] = []
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

        switchDetail.addTarget(self, action: #selector(setChange), for: .valueChanged)
        self.navigationItem.rightBarButtonItems = [btnExport, btnSearch, UIBarButtonItem.init(customView: switchDetail)]

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = reportSection.caseName;
        mailComposer.mailComposeDelegate = self;

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

        self.SetUpCollectionView()
        self.setChange()
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

        var list:[SLIPHONE14] = []
        switch self.comboPKType {
            
            case "SLIphoneVung":
                list.removeAll()
                if(key.count > 0) {
                    for item in listSLiphone {
                        if ((item.Vung.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDetailSLiphoneVung(list)
                    self.reportCollectionView.reloadData()

                } else {
                    self.generateDetailSLiphoneVung(listSLiphone)
                    self.reportCollectionView.reloadData()
                }
            case "SLIphoneKhuVuc":

                list.removeAll()
                if(key.count > 0) {
                    for item in listSLiphone {
                        if ((item.ASM.lowercased().range(of: key.lowercased())) != nil || (item.KhuVuc.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDetailSLiphoneKhuvuc(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDetailSLiphoneKhuvuc(listSLiphone)
                    self.reportCollectionView.reloadData()
                }

                break
            case "SLIphoneShop":

                list.removeAll()
                if(key.count > 0) {
                    for item in listSLiphone {
                        if ((item.Shop.lowercased().range(of: key.lowercased())) != nil || (item.ASM.lowercased().range(of: key.lowercased())) != nil || (item.Vung.lowercased().range(of: key.lowercased())) != nil) {
                            list.append(item)
                        }
                    }
                    self.generateDetailSLiphoneShop(list)
                    self.reportCollectionView.reloadData()
                } else {
                    self.generateDetailSLiphoneShop(listSLiphone)
                    self.reportCollectionView.reloadData()
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

        /////switch change
    @objc func setChange() {
        debugPrint("set change")

        if switchDetail.isOn == true{
            if self.reportSection.caseName == ReportCase.GetSLiphone14.caseName {
                    //show detail

                switch self.comboPKType {
                    case "SLIphoneVung":
                        self.title = "Tỷ lệ khai thác combo iphone theo vùng"
                        self.listSLiphone.removeAll()
                        self.header = ["Vùng", "SL máy iphone 14 Series","SL Combo 2 món GD","SL Combo 3 món GD", "SL Combo 3 món PKNK", "SL Combo 3 món PK","SL Combo 4 món PKNK","SL Combo 4 món PK","SL Combo 5 món PKNK","SL Combo 5 món PK","SL Combo iFan Apple","SL Combo bảo vệ Toàn Diện","SL Combo 6 món","SL ĐH có GD/PK/PKNK/DV >= 4M","SL Combo BH","Total  Số lượng combo", "Tỉ lệ combo/iPhone 14 series"]
                        self.switchDetail.isEnabled = false
                        self.getSliphoneVung(username: self.username, token: self.token)
                        break

                    case "SLIphoneKhuVuc" :
                        self.title = "Tỷ lệ khai thác combo iphone theo khu vực"
                        self.listSLiphone.removeAll()
                        self.header = ["Khu vực","ASM", "SL máy iphone 14 Series","SL Combo 2 món GD","SL Combo 3 món GD", "SL Combo 3 món PKNK","SL Combo 4 món PKNK","SL Combo 4 món PK","SL Combo 5 món PKNK","SL Combo 5 món PK","SL Combo iFan Apple", "SL Combo bảo vệ Toàn Diện","SL Combo 6 món","SL Combo BH","Total  Số lượng combo", "Tỉ lệ combo/iPhone 14 series"]
                        self.switchDetail.isEnabled = false
                        self.getSliphoneKhuVuc(username: self.username, token: self.token)
                        break

                    case "SLIphoneShop" :
                        self.title = "Tỷ lệ khai thác combo iphone theo shop"
                        self.listSLiphone.removeAll()
                        self.header = ["Khu vực","ASM","Shop", "SL máy iphone 14 Series","SL Combo 2 món GD","SL Combo 3 món GD", "SL Combo 3 món PKNK","SL Combo 4 món PKNK","SL Combo 4 món PK","SL Combo 5 món PKNK","SL Combo 5 món PK","SL Combo iFan Apple",
                                       "SL Combo bảo vệ Toàn Diện","SL Combo 6 món","SL Combo BH","Total  Số lượng combo", "Tỉ lệ combo/iPhone 14 series"]
                        self.switchDetail.isEnabled = false
                        self.getSliphoneShop(username: self.username, token: self.token)
                        break
                    default:
                        break
                }
            }
        } else {
                //show short
            if self.reportSection.caseName == ReportCase.GetSLiphone14.caseName {
                switch self.comboPKType {
                    case "SLIphoneVung":
                        self.title = "Tỷ lệ khai thác combo iphone theo vùng"
                        self.listSLiphone.removeAll()
                        self.header = [ "Vùng","SL máy iphone 14 Series","Total  Số lượng combo", "Tỉ lệ combo/iPhone 14 series"]
                        self.switchDetail.isEnabled = false
                        self.getSliphoneVung(username: self.username, token: self.token)
                        break

                    case "SLIphoneKhuVuc" :
                        self.title = "Tỷ lệ khai thác combo iphone theo khu vực"
                        self.listSLiphone.removeAll()
                        self.header = [ "Khu Vực","ASM","SL máy iphone 14 Series","Total  Số lượng combo", "Tỉ lệ combo/iPhone 14 series"]
                        self.switchDetail.isEnabled = false
                        self.getSliphoneKhuVuc(username: self.username, token: self.token)
                        break

                    case "SLIphoneShop" :
                        self.title = "Tỷ lệ khai thác combo iphone theo shop"
                        self.listSLiphone.removeAll()
                        self.header = [  "Khu Vực","ASM","Shop","SL máy iphone 14 Series","Total  Số lượng combo", "Tỉ lệ combo/iPhone 14 series"]
                        self.switchDetail.isEnabled = false
                        self.getSliphoneShop(username: self.username, token: self.token)
                        break

                    default:
                        break
                }

            }
        }
    }
        ///GET DATA

    func getSliphoneVung(username: String, token: String) {
        cellData = [[String]]()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let data = mSMApiManager.getSL_iphone14_Vung(username: username, token: token).Data
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if data != nil {
                    self.listSLiphone = data ?? []
                    if self.listSLiphone.count > 0 {
                        if self.switchDetail.isOn {
                            self.generateDetailSLiphoneVung(self.listSLiphone)
                        } else {
                            self.generateSLiphoneVung(self.listSLiphone)
                        }
                        self.reportCollectionView.removeFromSuperview()

                        self.SetUpCollectionView()
                        self.switchDetail.isEnabled = true
                    }
                } else {
                    let alertVC = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertVC.addAction(action)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }

    func getSliphoneKhuVuc(username: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getSL_iphone14_khuvuc(username: username, token: token).Data
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if data != nil {
                self.listSLiphone = data ?? []
                if self.listSLiphone.count > 0 {
                    if self.switchDetail.isOn{
                        self.generateDetailSLiphoneKhuvuc(self.listSLiphone)
                    } else {
                        self.generateSLiphoneKhuvuc(self.listSLiphone)
                    }
                    self.reportCollectionView.removeFromSuperview()
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                let alertVC = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }

        }
    }

    func getSliphoneShop(username: String, token: String) {
        cellData = [[String]]()
        let data = mSMApiManager.getSL_iphone14_Shop(username: username, token: token).Data
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if data != nil {
                self.listSLiphone = data ?? []
                if self.listSLiphone.count > 0 {
                    if self.switchDetail.isOn{
                        self.generateDetailSLiphoneShop(self.listSLiphone)
                    } else {
                        self.generateSLiphoneShop(self.listSLiphone)
                    }
                    self.reportCollectionView.removeFromSuperview()
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                let alertVC = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }

  

    func generateSLiphoneVung(_ data:[SLIPHONE14]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(item.SL_may)",
                "\(item.Total_SLcombo)",
                "\(item.TileCombo)"
            ]);
        }
    }

    func generateSLiphoneKhuvuc(_ data:[SLIPHONE14]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.KhuVuc)",
                "\(item.ASM)",
                "\(item.SL_may)",
                "\(item.Total_SLcombo)",
                "\(item.TileCombo)"
            ]);
        }
    }

    func generateSLiphoneShop(_ data:[SLIPHONE14]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.KhuVuc)",
                "\(item.ASM)",
                "\(item.Shop)",
                "\(item.SL_may)",
                "\(item.Total_SLcombo)",
                "\(item.TileCombo)"
            ]);
        }
    }



        ///--GENERATE DETAIL DATA-----------------------
    func generateDetailSLiphoneVung(_ data:[SLIPHONE14]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.Vung)",
                "\(item.SL_may)",
                "\(item.SL_combo2monGD)",
                "\(item.SL_combo3monGD)",
                "\(item.SL_combo3monPKNK)",
                "\(item.SL_combo3monPK)",
                "\(item.SL_combo4monPKNK)",
                "\(item.SL_combo4monPK)",
                "\(item.SL_combo5monPKNK)",
                "\(item.SL_combo5monPK)",
                "\(item.SL_IFanApple)",
                "\(item.SL_BaoVeToanDien)",
                "\(item.SL_combo6mon)",
				"\(item.SLDH_GD_PK_PKNK_DV)",
				"\(item.SL_Combo_BH)",
                "\(item.Total_SLcombo)",
                "\(item.TileCombo)",
            ]);
        }
    }

    func generateDetailSLiphoneKhuvuc(_ data:[SLIPHONE14]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.KhuVuc)",
                "\(item.ASM)",
                "\(item.SL_may)",
                "\(item.SL_combo2monGD)",
                "\(item.SL_combo3monGD)",
                "\(item.SL_combo3monPKNK)",
                "\(item.SL_combo4monPKNK)",
                "\(item.SL_combo4monPK)",
                "\(item.SL_combo5monPKNK)",
                "\(item.SL_combo5monPK)",
                "\(item.SL_IFanApple)",
                "\(item.SL_BaoVeToanDien)",
                "\(item.SL_combo6mon)",
				"\(item.SL_Combo_BH)",
                "\(item.Total_SLcombo)",
                "\(item.TileCombo)",
            ]);
        }
    }

    func generateDetailSLiphoneShop(_ data:[SLIPHONE14]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.KhuVuc)",
                "\(item.ASM)",
                "\(item.Shop)",
                "\(item.SL_may)",
                "\(item.SL_combo2monGD)",
                "\(item.SL_combo3monGD)",
                "\(item.SL_combo3monPKNK)",
                "\(item.SL_combo4monPKNK)",
                "\(item.SL_combo4monPK)",
                "\(item.SL_combo5monPKNK)",
                "\(item.SL_combo5monPK)",
                "\(item.SL_IFanApple)",
                "\(item.SL_BaoVeToanDien)",
                "\(item.SL_combo6mon)",
				"\(item.SL_Combo_BH)",
                "\(item.Total_SLcombo)",
                "\(item.TileCombo)",
            ]);
        }
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
        if self.switchDetail.isOn == false {
            if self.comboPKType == "SLIphoneVung" {
                collectionViewLayout.numberColumnFixed = 1
            }else if self.comboPKType == "SLIphoneKhuVuc" {
                collectionViewLayout.numberColumnFixed = 1
            } else  {
                collectionViewLayout.numberColumnFixed = 1
            }
        }else {
            collectionViewLayout.numberColumnFixed = 1
        }

        self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout);

        self.reportCollectionView.delegate = self;
        self.reportCollectionView.dataSource = self;
        self.reportCollectionView.showsHorizontalScrollIndicator = true;
        self.reportCollectionView.backgroundColor = UIColor.white;
        self.view.bringSubviewToFront(reportCollectionView);
        self.reportCollectionView.register(ReportDataCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        self.view.addSubview(self.reportCollectionView)

        if(cellData.count == 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
            self.view.addSubview(emptyView);
        }
        self.navigationController?.navigationBar.isTranslucent = false;
        self.reportCollectionView.reloadData()
    }
    @objc func ExportFile() {
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        switch self.comboPKType {
                    ///LUY KE DS MAY
            case "SLIphoneVung":
                self.exportReportSLiphoneVung(reportName: "SLIphoneVung")
                break

            case  "SLIphoneKhuVuc":
                self.exportReportSLiphoneKhuvuc(reportName: "SLIphoneVung")
                break

            case "SLIphoneShop":
                self.exportReportSLIMShop(reportName: "SLIphoneVung")
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
    /*
     "SL_BaoVeToanDien": "0",
     "SL_IFanApple": "0",
     "SL_combo3monPKNK": "0",
     "SL_combo4monPK": "0",
     "SL_combo4monPKNK": "0",
     "SL_combo5monPK": "0",
     "SL_combo5monPKNK": "0",
     "SL_may": "0",
     "STT": "1",
     "TileCombo": "0%",
     "Total_SLcombo": "0",
     "Vung": "Hà Nội",
     "flagToken": null


     for item in data {
     self.cellData.append([
     "\(item.Vung)",
     "\(item.SL_may)",
     "\(item.SL_combo3monPKNK)",
     "\(item.SL_combo4monPKNK)",
     "\(item.SL_combo4monPK)",
     "\(item.SL_combo5monPKNK)",
     "\(item.SL_combo5monPK)",
     "\(item.SL_IFanApple)",
     "\(item.SL_BaoVeToanDien)",
     "\(item.Total_SLcombo)",
     "\(item.TileCombo)",
     */

        ///VUNG
    func exportReportSLiphoneVung(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"

            //generate contents of file
        let data = self.listSLiphone
        let header =   ["STT","Vùng", "SL máy iphone 14 Series","SL Combo 2 món GD","SL Combo 3 món GD", "SL Combo 3 món PKNK", "SL Combo 3 món PK","SL Combo 4 món PKNK","SL Combo 4 món PK","SL Combo 5 món PKNK","SL Combo 5 món PK","SL Combo iFan Apple","SL Combo bảo vệ Toàn Diện","SL Combo 6 món","SL ĐH có GD/PK/PKNK/DV >= 4M","SL Combo BH","Total  Số lượng combo", "Tỉ lệ combo/iPhone 14 series"]



        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t\(item.Vung)\t\(item.SL_may)\t\(item.SL_combo2monGD)\t\(item.SL_combo3monGD)\t\(item.SL_combo3monPKNK)\t\(item.SL_combo3monPK)\t\(item.SL_combo4monPKNK)\t\(item.SL_combo4monPK)\t\(item.SL_combo5monPKNK)\t\(item.SL_combo5monPK)\t\(item.SL_IFanApple)\t\(item.SL_BaoVeToanDien)\t\(item.SL_combo6mon)\t\(item.SLDH_GD_PK_PKNK_DV)\t\(item.SL_Combo_BH)\t\(item.Total_SLcombo)\t\(item.TileCombo)"
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }

        ///KHU VUC
    func exportReportSLiphoneKhuvuc(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"

            //generate contents of file
        let data = self.listSLiphone


        let header = ["STT",
                      "ASM", "Khu Vực", "SL máy iphone 14 Series","SL Combo 2 món GD","SL Combo 3 món GD", "SL Combo 3 món PKNK","SL Combo 4 món PKNK","SL Combo 4 món PK","SL Combo 5 món PKNK","SL Combo 5 món PK","SL Combo iFan Apple",
                      "SL Combo bảo vệ Toàn Diện","SL Combo 6 món","SL Combo BH","Total  Số lượng combo", "Tỉ lệ combo/iPhone 14 series"]
        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t\(item.ASM)\t\(item.KhuVuc)\t\(item.SL_may)\t\(item.SL_combo2monGD)\t\(item.SL_combo3monGD)\t\(item.SL_combo3monPKNK)\t\(item.SL_combo4monPKNK)\t\(item.SL_combo4monPK)\t\(item.SL_combo5monPKNK)\t\(item.SL_combo5monPK)\t\(item.SL_IFanApple)\t\(item.SL_BaoVeToanDien)\t\(item.SL_combo6mon)\t\(item.SL_Combo_BH)\t\(item.Total_SLcombo)\t\(item.TileCombo)"

        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }

        ///SHOP
    func exportReportSLIMShop(reportName: String){
        let path = NSTemporaryDirectory() + "\(reportName).csv"

            //generate contents of file
        let data = self.listSLiphone
        let header =  ["STT","Khu vực","ASM","Shop", "SL máy iphone 14 Series","SL Combo 2 món GD","SL Combo 3 món GD", "SL Combo 3 món PKNK","SL Combo 4 món PKNK","SL Combo 4 món PK","SL Combo 5 món PKNK","SL Combo 5 món PK","SL Combo iFan Apple",
                          "SL Combo bảo vệ Toàn Diện","SL Combo 6 món","SL Combo BH","Total  Số lượng combo", "Tỉ lệ combo/iPhone 14 series"]


        var content = header.joined(separator: "\t")
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t\(item.ASM)\t\(item.KhuVuc)\t\(item.Shop)\t\(item.SL_may)\t\(item.SL_combo2monGD)\t\(item.SL_combo3monGD)\t\(item.SL_combo3monPKNK)\t\(item.SL_combo4monPKNK)\t\(item.SL_combo4monPK)\t\(item.SL_combo5monPKNK)\t\(item.SL_combo5monPK)\t\(item.SL_IFanApple)\t\(item.SL_BaoVeToanDien)\t\(item.SL_combo6mon)\t\(item.SL_Combo_BH)\t\(item.Total_SLcombo)\t\(item.TileCombo)"
        }
        self.writeFile(path: path, content: content, reportName: reportName)
    }

        /// export tyle iphone


    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
        print("Mail Compose controller didFinished");
        controller.dismiss(animated: true, completion: nil);
    }

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
                
                    case "SLIphoneVung":
                        if indexPath.row == 0 {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }
                        cell.layer.borderWidth = 0.5;
                        cell.layer.borderColor = UIColor.darkGray.cgColor;
                        break

                    case "SLIphoneKhuVuc":
                        if indexPath.row == 0 || indexPath.row == 1 {
                            cell.setupNameLeft(item: cellData[indexPath.section - 1][indexPath.row])
                        } else {
                            cell.setupName(item: cellData[indexPath.section - 1][indexPath.row]);
                        }

                        cell.layer.borderWidth = 0.5;
                        cell.layer.borderColor = UIColor.darkGray.cgColor;
                        break

                    case "SLIphoneShop":
                        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2{
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
