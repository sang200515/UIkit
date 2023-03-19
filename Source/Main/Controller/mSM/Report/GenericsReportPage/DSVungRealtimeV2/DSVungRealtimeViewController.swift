//
//  DSVungRealtimeViewController.swift
//  fptshop
//
//  Created by Apple on 9/30/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import MessageUI
import DLRadioButton

class DSVungRealtimeViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var reportCollectionView: UICollectionView!;
    
    var header: [String] = [];
    var cellData: [[String]] = [];
    var tempHeaderForSize: [String] = [];
    var mailComposer = MFMailComposeViewController();
    var switchDetail = UISwitch()
    var btnExport: UIBarButtonItem!
    var btnBack:UIBarButtonItem!
    let username = (Cache.user?.UserName)!;
    let token = (Cache.user?.Token)!
    var listDSVungRealtime = [RealtimeReport]()
    var listDoanhSo_Realtime_Vung_NotDA = [RealtimeReport]()
    var listDSVungRealtimeCungKy = [RealtimeVungCungKyFinal]()
    
    var radioVungRealtime:DLRadioButton!
    var radioVungRealtime_NotDA:DLRadioButton!
    var radioVungRealtime_NotDACungKy:DLRadioButton!
    static var radioType = 1
    
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
        let synchronizeButton = UIBarButtonItem(image: UIImage(named: "ic_sync"), style: .plain, target: self, action: #selector(ReloadData));
        switchDetail.addTarget(self, action: #selector(setChange), for: .valueChanged)
        self.navigationItem.rightBarButtonItems = [btnExport, synchronizeButton, UIBarButtonItem.init(customView: switchDetail)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Doanh số vùng realtime";
        self.view.backgroundColor = .white
        mailComposer.mailComposeDelegate = self;
        
        //radio btn
        radioVungRealtime = createRadioButtonGender(CGRect(x: 15,y: 15, width: (self.view.frame.size.width - 30)/2, height: 15), title: "DS Vùng Realtime", color: UIColor.black);
        radioVungRealtime.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(radioVungRealtime)
        
        radioVungRealtime_NotDA = createRadioButtonGender(CGRect(x: radioVungRealtime.frame.origin.x + radioVungRealtime.frame.size.width ,y:radioVungRealtime.frame.origin.y, width: radioVungRealtime.frame.size.width, height: radioVungRealtime.frame.size.height), title: "DS Vùng Không Shop DA", color:UIColor.black);
        radioVungRealtime_NotDA.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(radioVungRealtime_NotDA)
        
        radioVungRealtime_NotDACungKy = createRadioButtonGender(CGRect(x: radioVungRealtime.frame.origin.x, y:radioVungRealtime_NotDA.frame.origin.y + radioVungRealtime_NotDA.frame.height + 10, width: (self.view.frame.size.width - 30), height: radioVungRealtime.frame.size.height), title: "DS Vùng Realtime Cùng Kỳ", color:UIColor.black);
        radioVungRealtime_NotDACungKy.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(radioVungRealtime_NotDACungKy)
        
        
        if DSVungRealtimeViewController.radioType == 1 {
            radioVungRealtime.isSelected = true
            radioVungRealtime_NotDA.isSelected = false
            radioVungRealtime_NotDACungKy.isSelected = false
            
        } else if DSVungRealtimeViewController.radioType == 2 {
            radioVungRealtime.isSelected = false
            radioVungRealtime_NotDA.isSelected = true
            radioVungRealtime_NotDACungKy.isSelected = false
            
        } else {
            radioVungRealtime.isSelected = false
            radioVungRealtime_NotDA.isSelected = false
            radioVungRealtime_NotDACungKy.isSelected = true
        }
        
        self.setChange()
    }
    
    @objc func setChange() {
        self.listDSVungRealtime.removeAll()
        self.listDoanhSo_Realtime_Vung_NotDA.removeAll()
        self.listDSVungRealtimeCungKy.removeAll()
        
        if DSVungRealtimeViewController.radioType == 1 {
            if switchDetail.isOn == true {
                self.header = ["STT", "Vùng", "DS Shop", "DS E-com" , "DSTG", "DSPK", "DSPK Thường", "DSPKNK", "TTPK", "Tổng"]
            } else {
                self.header = ["STT", "Vùng", "DSPK", "TTPK", "Tổng"]
            }
            self.switchDetail.isEnabled = false
            self.getDSVungRealtime(username: self.username, token: self.token)
            
        } else if DSVungRealtimeViewController.radioType == 2 {
            if switchDetail.isOn == true{
                self.header = ["STT", "Vùng", "DS Shop", "DS E-com" , "DSTG", "DSPK", "DSPK Thường", "DSPKNK", "TTPK", "Tổng"]
            } else {
                self.header = ["STT", "Vùng", "DSPK", "TTPK", "Tổng"]
            }
            self.switchDetail.isEnabled = false
            self.getDS_Realtime_Vung_NotDA()
            
        } else {
            if switchDetail.isOn == true {
                self.header = ["STT", "Vùng", "DS Shop", "DS Shop D-1", "DS Shop D-7", "DS Ecom", "DS Ecom D-1", "DS Ecom D-7", "Tổng DS", "Tổng DS D-1", "Tổng DS D-7"]
            } else {
                self.header = ["STT", "Vùng", "DS Shop", "DS Shop D-1", "DS Shop D-7", "DS Ecom", "DS Ecom D-1", "DS Ecom D-7", "Tổng DS", "Tổng DS D-1", "Tổng DS D-7"]
            }
            self.switchDetail.isEnabled = false
            self.getDataRaltimeCungKy()
        }
    }
    
    @objc func ExportFile() {
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        switch DSVungRealtimeViewController.radioType {
        case 1:
            exportData(reportName: "DoanhSoVungRealtime", list: self.listDSVungRealtime)
            break
        case 2:
            exportData(reportName: "DoanhSoVungKhongShopDA", list: self.listDoanhSo_Realtime_Vung_NotDA)
            break
        case 3:
            exportRealtieCungKy(list: self.listDSVungRealtimeCungKy)
            break
        default:
            break
        }
    }
    
    func exportData(reportName: String, list: [RealtimeReport]) {
        let path = NSTemporaryDirectory() + "\(reportName).csv"
        
        //generate contents of file
        let data = list
        var content = "STT\t Vung\t DS Shop\t DS E-com\t DSTG\t DSPK\t DSPK Thường\t DSPKNK\t TTPK\t Tổng"
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT!)\t\(item.Vung!)\t \(item.DoanhSoNgay!)\t \(item.DS_ECOM!)\t \(item.DSDV!)\t \(item.DSPK!)\t \(item.DSPKThuong!)\t \(item.DSPKNK!)\t \(item.PT!)\t \(item.Tong!)"
        }
        self.writeFileExport(path: path, content: content, reportName: reportName)
        
    }
    
    func exportRealtieCungKy(list: [RealtimeVungCungKyFinal]) {
        let path = NSTemporaryDirectory() + "DSVungNotDARealtimeCungKy.csv"
        //generate contents of file
        let data = list
        var content = "STT\t Vung\t DoanhSoNgay\t DoanhSoNgay_1\t DoanhSoNgay_6\t DS_ECOM\t DS_ECOM_1\t DS_ECOM_6\t Tong\t Tong_1\t Tong_6"
        for index in 0...data.count - 1 {
            let item = data[index]
            content += "\n\(item.STT)\t\(item.Vung)\t \(item.DoanhSoNgay)\t \(item.DoanhSoNgay_1)\t \(item.DoanhSoNgay_6)\t \(item.DS_ECOM)\t \(item.DS_ECOM_1)\t \(item.DS_ECOM_6)\t \(item.Tong)\t \(item.Tong_1)\t \(item.Tong_6)"
        }
        self.writeFileExport(path: path, content: content, reportName: "DSVungNotDARealtimeCungKy")
    }
    
    func writeFileExport(path: String, content: String, reportName: String) {
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
                            self.mailComposer.addAttachmentData(fileData, mimeType: "text/csv", fileName: "\(reportName)\(currentDateString).csv")
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
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil);
    }
    
    @objc func ReloadData() {
        self.listDSVungRealtime.removeAll()
        self.listDoanhSo_Realtime_Vung_NotDA.removeAll()
        self.listDSVungRealtimeCungKy.removeAll()
        
        if DSVungRealtimeViewController.radioType == 1 {
            if switchDetail.isOn == true {
                self.header = ["STT", "Vùng", "DS Shop", "DS E-com" , "DSTG", "DSPK", "DSPK Thường", "DSPKNK", "TTPK", "Tổng"]
            } else {
                self.header = ["STT", "Vùng", "DSPK", "TTPK", "Tổng"]
            }
            self.switchDetail.isEnabled = false
            self.getDSVungRealtime(username: self.username, token: self.token)
            
        } else if DSVungRealtimeViewController.radioType == 2 {
            if switchDetail.isOn == true{
                self.header = ["STT", "Vùng", "DS Shop", "DS E-com" , "DSTG", "DSPK", "DSPK Thường", "DSPKNK", "TTPK", "Tổng"]
            } else {
                self.header = ["STT", "Vùng", "DSPK", "TTPK", "Tổng"]
            }
            self.switchDetail.isEnabled = false
            self.getDS_Realtime_Vung_NotDA()
            
        } else {
            if switchDetail.isOn == true {
                self.header = ["STT", "Vùng", "DS Shop", "DS Shop D-1", "DS Shop D-7", "DS Ecom", "DS Ecom D-1", "DS Ecom D-7", "Tổng DS", "Tổng DS D-1", "Tổng DS D-7"]
            } else {
                self.header = ["STT", "Vùng", "DS Shop", "DS Shop D-1", "DS Shop D-7", "DS Ecom", "DS Ecom D-1", "DS Ecom D-7", "Tổng DS", "Tổng DS D-1", "Tổng DS D-7"]
            }
            self.switchDetail.isEnabled = false
            self.getDataRaltimeCungKy()
        }
    }
    
    func getDSVungRealtime(username: String, token: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listDSVungRealtime = mSMApiManager.GetZoneSalesRealtime(username: username, token: token).Data ?? []
            
            if self.listDSVungRealtime.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if self.switchDetail.isOn {
                        self.generateDetailDSVungRealtime(self.listDSVungRealtime)
                    } else {
                        self.generateDSVungRealtime(self.listDSVungRealtime)
                    }
                    if self.reportCollectionView != nil {
                        self.reportCollectionView.removeFromSuperview()
                    }
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let alert = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (_) in
                        if self.reportCollectionView != nil {
                            self.reportCollectionView.removeFromSuperview()
                        }
                        self.switchDetail.isEnabled = true
                        self.header = []
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func getDS_Realtime_Vung_NotDA() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listDoanhSo_Realtime_Vung_NotDA = mSMApiManager.ListDoanhSo_Realtime_Vung_NotDA().Data ?? []
            
            if self.listDoanhSo_Realtime_Vung_NotDA.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if self.switchDetail.isOn {
                        self.generateDetailDSVungRealtime(self.listDoanhSo_Realtime_Vung_NotDA)
                    } else {
                        self.generateDSVungRealtime(self.listDoanhSo_Realtime_Vung_NotDA)
                    }
                    if self.reportCollectionView != nil {
                        self.reportCollectionView.removeFromSuperview()
                    }
                    self.SetUpCollectionView()
                    self.switchDetail.isEnabled = true
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let alert = UIAlertController(title: "Thông báo", message: "Không lấy được data!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (_) in
                        if self.reportCollectionView != nil {
                            self.reportCollectionView.removeFromSuperview()
                        }
                        self.switchDetail.isEnabled = true
                        self.header = []
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func getDataRaltimeCungKy() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.listDSVungRealtimeCungKy = mSMApiManager.ListDoanhSo_Realtime_Vung_NotDA_CungKy_View_Final().Data ?? []
            if self.listDSVungRealtimeCungKy.count > 0 {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.generateDSVungRealtimeCungky(self.listDSVungRealtimeCungKy)
                    if self.reportCollectionView != nil {
                        self.reportCollectionView.removeFromSuperview()
                    }
                    self.SetUpCollectionView()
                }
            } else {
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let alert = UIAlertController(title: "Thông báo", message: "Hiện đang ngoài giờ xem BC: (12h,15h,18h,20h,22h,23h30)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (_) in
                        if self.reportCollectionView != nil {
                            self.reportCollectionView.removeFromSuperview()
                        }
                        self.switchDetail.isEnabled = true
                        self.header = []
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
            case .portrait:
                if self.reportCollectionView != nil {
                    self.reportCollectionView.removeFromSuperview()
                }
                self.SetUpCollectionView()
            case .landscapeLeft,.landscapeRight :
                if self.reportCollectionView != nil {
                    self.reportCollectionView.removeFromSuperview()
                }
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
        
//        let collectionViewLayout = ReportCollectionViewLayout();
        let collectionViewLayout = ReportLayout()
        collectionViewLayout.numberOfColumns = header.count;
        collectionViewLayout.titleArray = self.tempHeaderForSize;
        if self.switchDetail.isOn {
            collectionViewLayout.numberColumnFixed = 2
        } else {
            collectionViewLayout.numberColumnFixed = 0
        }
        
        let reportCollectionViewY: CGFloat = radioVungRealtime_NotDACungKy.frame.origin.y + radioVungRealtime_NotDACungKy.frame.height + Common.Size(s: 15)
        self.reportCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: reportCollectionViewY, width: self.view.frame.size.width, height: self.view.frame.size.height - reportCollectionViewY - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: collectionViewLayout);
        
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
    
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioVungRealtime.isSelected = false
            radioVungRealtime_NotDA.isSelected = false
            radioVungRealtime_NotDACungKy.isSelected = false
            switch temp {
            case "DS Vùng Realtime":
                radioVungRealtime.isSelected = true
                DSVungRealtimeViewController.radioType = 1
                if switchDetail.isOn == true{
                    self.header = ["STT", "Vùng", "DS Shop", "DS E-com" , "DSTG", "DSPK", "DSPK Thường", "DSPKNK", "TTPK", "Tổng"]
                } else {
                    self.header = ["STT", "Vùng", "DSPK", "TTPK", "Tổng"]
                }
                self.getDSVungRealtime(username: self.username, token: self.token)
                break
                
            case "DS Vùng Không Shop DA":
                radioVungRealtime_NotDA.isSelected = true
                DSVungRealtimeViewController.radioType = 2
                if switchDetail.isOn == true{
                    self.header = ["STT", "Vùng", "DS Shop", "DS E-com" , "DSTG", "DSPK", "DSPK Thường", "DSPKNK", "TTPK", "Tổng"]
                } else {
                    self.header = ["STT", "Vùng", "DSPK", "TTPK", "Tổng"]
                }
                self.getDS_Realtime_Vung_NotDA()
                break
                
            case "DS Vùng Realtime Cùng Kỳ":
                radioVungRealtime_NotDACungKy.isSelected = true
                DSVungRealtimeViewController.radioType = 3
                if switchDetail.isOn {
                    self.header = ["STT", "Vùng", "DS Shop", "DS Shop D-1", "DS Shop D-7", "DS Ecom", "DS Ecom D-1", "DS Ecom D-7", "Tổng DS", "Tổng DS D-1", "Tổng DS D-7"]
                } else {
                    self.header = ["STT", "Vùng", "DS Shop", "DS Shop D-1", "DS Shop D-7", "DS Ecom", "DS Ecom D-1", "DS Ecom D-7", "Tổng DS", "Tổng DS D-1", "Tổng DS D-7"]
                }
                self.getDataRaltimeCungKy()
                break
            default:
                break
            }
        }
    }
    
    //GENERATE DATA
    func generateDSVungRealtime(_ data:[RealtimeReport]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT!)",
                "\(item.Vung!)",
                "\(Common.convertCurrencyDouble(value: item.DSPK!))",
                "\(item.PT!)",
                "\(Common.convertCurrencyDouble(value: item.Tong!))"
            ]);
        }
    }
    
    //GENERATE DETAIL DATA
    func generateDetailDSVungRealtime(_ data:[RealtimeReport]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT!)",
                "\(item.Vung!)",
                "\(Common.convertCurrencyDouble(value:  item.DoanhSoNgay!))",
                "\(Common.convertCurrencyDouble(value:  item.DS_ECOM!))",
                "\(Common.convertCurrencyDouble(value:  item.DSDV!))",
                "\(Common.convertCurrencyDouble(value:  item.DSPK!))",
                "\(Common.convertCurrencyDouble(value:  item.DSPKThuong!))",
                "\(Common.convertCurrencyDouble(value:  item.DSPKNK!))",
                "\(item.PT!)",
                "\(Common.convertCurrencyDouble(value:  item.Tong!))"
            ]);
        }
    }
    
    func generateDSVungRealtimeCungky(_ data:[RealtimeVungCungKyFinal]) {
        cellData = [[String]]()
        for item in data {
            self.cellData.append([
                "\(item.STT)",
                "\(item.Vung)",
                "\(Common.convertCurrencyDouble(value:  item.DoanhSoNgay))",
                "\(Common.convertCurrencyDouble(value:  item.DoanhSoNgay_1))",
                "\(Common.convertCurrencyDouble(value:  item.DoanhSoNgay_6))",
                "\(Common.convertCurrencyDouble(value:  item.DS_ECOM))",
                "\(Common.convertCurrencyDouble(value:  item.DS_ECOM_1))",
                "\(Common.convertCurrencyDouble(value:  item.DS_ECOM_6))",
                "\(Common.convertCurrencyDouble(value:  item.Tong))",
                "\(Common.convertCurrencyDouble(value:  item.Tong_1))",
                "\(Common.convertCurrencyDouble(value:  item.Tong_6))",
            ]);
        }
    }
}

extension DSVungRealtimeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
                guard indexPath.row < header.count else { return UICollectionViewCell() }
                cell.setupHeader(item: header[indexPath.row]);
                cell.backgroundColor = UIColor.lightGray;
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }else{
                if indexPath.row == 1 {
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

