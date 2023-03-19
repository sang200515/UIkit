//
//  BaoHanhSearchV2ListController.swift
//  mPOS
//
//  Created by sumi on 1/10/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import PopupDialog

class BaoHanhSearchV2ListController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    
    var arrCheckimei_V2_MoreResult = [Checkimei_V2_MoreResult]()
    
    var baoHanhSearchListView:BaoHanhSearchListView!
    var p_PhoneNumber:String?
    var p_Imei:String?
    var p_BILL:String?
    var p_SO_DocNum:String?
    var processView:ProcessView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Tìm Kiếm"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        
        baoHanhSearchListView = BaoHanhSearchListView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(baoHanhSearchListView)
        
        processView = ProcessView.init(frame: CGRect(x: 0, y: -50, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - baoHanhSearchListView.frame.size.height + 50 ))
        
        
        processView.isHidden = false
        
        self.view.addSubview(processView)
        
        
        
        self.baoHanhSearchListView.tableViewSearchBaoHanh.register(ItemSearchBaoHanhTableViewCell.self, forCellReuseIdentifier: "ItemSearchBaoHanhTableViewCell")
        self.baoHanhSearchListView.tableViewSearchBaoHanh.dataSource = self
        self.baoHanhSearchListView.tableViewSearchBaoHanh.delegate = self
        
        if(self.p_PhoneNumber == nil )
        {
            self.p_PhoneNumber = ""
        }
        if(self.p_Imei == nil )
        {
            self.p_Imei = ""
        }
        if(self.p_BILL == nil )
        {
            self.p_BILL = ""
        }
        if(self.p_SO_DocNum == nil )
        {
            self.p_SO_DocNum = ""
        }
        GetDataCheckimei_V2_More(p_Imei: "\(self.p_Imei!)",p_BILL: "\(self.p_BILL!)",p_SO_DocNum: "\(self.p_SO_DocNum!)",p_PhoneNumber: "\(self.p_PhoneNumber!)",p_Type: "0")
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func GetDataCheckimei_V2_More(p_Imei: String,p_BILL: String,p_SO_DocNum: String,p_PhoneNumber: String,p_Type: String)
    {
        
        MPOSAPIManager.Checkimei_V2_More(p_Imei: p_Imei,p_BILL: p_BILL,p_SO_DocNum: p_SO_DocNum,p_PhoneNumber: p_PhoneNumber,p_Type: p_Type){ (error: Error? , success: Bool,result: [Checkimei_V2_MoreResult]!) in
            if success
            {
                self.processView.isHidden = true
                if(result != nil && result.count > 0 )
                {
                    
                    self.arrCheckimei_V2_MoreResult = result
                    
                    
                    self.baoHanhSearchListView.tableViewSearchBaoHanh.reloadData()
                }
                else
                {
                    let title = "THÔNG BÁO"
                    let message = "Không tìm thấy kết quả"
                 
                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = DefaultButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
                
            }
            else
            {
                self.processView.isHidden = true
                let title = "THÔNG BÁO"
                let message = "Lỗi kết nối"
                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = DefaultButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }
    }
    
    /////
    func GetDataLoadThongTinTimKiemThem_Mobile(p_BienTruyenVao: String,p_LineChon: String,p_SoDonHang: String)
    {
        
        MPOSAPIManager.LoadThongTinTimKiemThem_Mobile(p_BienTruyenVao: p_BienTruyenVao,p_LineChon: p_LineChon,p_SoDonHang: p_SoDonHang){ (error: Error? , success: Bool,result: [Checkimei_V2Result]!,result2: Checkimei_V2_ImeiInfoServices_Result! ,result3: [Checkimei_V2_LoadHTBH_Result]!) in
            if success
            {
                self.processView.isHidden = true
                if(result != nil && result.count > 0 )
                {
                    
                    print("\(result[0].imei)")
                    UserDefaults.standard.set("arrCheckimei_V2Result[indexPath.row].DiaChiKH", forKey : "mSearchByV2")
                    let newViewController = BaoHanhTaoPhieuMainController()
                    
                    newViewController.arrCheckimei_V2Result = result[0]
                    newViewController.arrCheckimei_V2Result2 = result2
                    newViewController.arrCheckimei_V2Result3 = result3
                    
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                else
                {
                    let title = "THÔNG BÁO"
                    let message = "Không tìm thấy kết quả"
                 
                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = DefaultButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
                
            }
            else
            {
                self.processView.isHidden = true
                let title = "THÔNG BÁO"
                let message = "Lỗi kết nối"
               
                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = DefaultButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }
    }
    ////
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCheckimei_V2_MoreResult.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mObject:Checkimei_V2_MoreResult = arrCheckimei_V2_MoreResult[indexPath.row]
        GetDataLoadThongTinTimKiemThem_Mobile(p_BienTruyenVao: mObject.imei,p_LineChon: mObject.LINE,p_SoDonHang: mObject.SoDonHang)
        
        
    }
    
    
   
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellSearch: ItemSearchBaoHanhTableViewCell?
        cellSearch = ItemSearchBaoHanhTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSearchBaoHanhTableViewCell")
        
        if(arrCheckimei_V2_MoreResult.count > 0 )
        {
            
            cellSearch?.soDH.text = "\(arrCheckimei_V2_MoreResult[indexPath.row].imei)"
            cellSearch?.TenSP.text = "\(arrCheckimei_V2_MoreResult[indexPath.row].SoDonHang)"
            cellSearch?.HanBaoHanh.text = "\(arrCheckimei_V2_MoreResult[indexPath.row].NgayBaoHanh)"
            cellSearch?.Imei.text = "\(arrCheckimei_V2_MoreResult[indexPath.row].TenSanPham)"
            cellSearch?.imageCheck.image = #imageLiteral(resourceName: "checkmark50")
            
        }
        return cellSearch!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return (Common.Size(s:18)) * 4 ;
        
    }
}



