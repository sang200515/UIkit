//
//  BaoHanhSearchListController.swift
//  mPOS
//
//  Created by sumi on 12/15/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit

class BaoHanhSearchListController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var mImei:String?
    var arrTaoPhieuBHResult = [TaoPhieuBH_TimsanphamResult]()
    var arrCheckimei_V2Result = [Checkimei_V2Result]()
    var arrSearchBaoHanh = [String]()
    var countRow:Int = 0
    var baoHanhSearchListView:BaoHanhSearchListView!
    var mValuee:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Tìm Kiếm"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        
        baoHanhSearchListView = BaoHanhSearchListView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(baoHanhSearchListView)
        
        self.baoHanhSearchListView.tableViewSearchBaoHanh.register(ItemSearchBaoHanhTableViewCell.self, forCellReuseIdentifier: "ItemSearchBaoHanhTableViewCell")
        self.baoHanhSearchListView.tableViewSearchBaoHanh.dataSource = self
        self.baoHanhSearchListView.tableViewSearchBaoHanh.delegate = self
        
        GetDataTaoPhieuBH_Timsanpham(p_ItemCode: "",p_ItemName: "\(mValuee!)")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func GetDataTaoPhieuBH_Timsanpham(p_ItemCode: String,p_ItemName: String)
    {
        MPOSAPIManager.TaoPhieuBH_Timsanpham(p_ItemCode: p_ItemCode,p_ItemName: p_ItemName){ (error: Error? , success: Bool,result: [TaoPhieuBH_TimsanphamResult]!) in
            if success
            {
                if(result != nil && result.count > 0 )
                {
                    for i in 0 ..< result.count
                    {
                        self.arrTaoPhieuBHResult.append(result[i])
                    }
                    
                    self.baoHanhSearchListView.tableViewSearchBaoHanh.reloadData()
                    print("arrTaoPhieuBHResult success")
                }
                else
                {
                    
                }
                
            }
            else
            {
                
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countRow = arrTaoPhieuBHResult.count
        print("rowwww \(countRow)")
        return countRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellSearch: ItemSearchBaoHanhTableViewCell?
        cellSearch = ItemSearchBaoHanhTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSearchBaoHanhTableViewCell")
        
        if(arrTaoPhieuBHResult.count > 0 )
        {
            
            cellSearch?.soDH.text = "\(arrTaoPhieuBHResult[indexPath.row].MaSanPham)"
            cellSearch?.TenSP.text = "\(arrTaoPhieuBHResult[indexPath.row].TenNhan)"
            cellSearch?.HanBaoHanh.text = "\(arrTaoPhieuBHResult[indexPath.row].TenLoai)"
            cellSearch?.Imei.text = "\(arrTaoPhieuBHResult[indexPath.row].TenSanPham)"
            cellSearch?.imageCheck.image = #imageLiteral(resourceName: "checkmark50")
            
        }
        return cellSearch!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc is BaoHanhTaoPhieuMainController {
                let newViewController:BaoHanhTaoPhieuMainController = vc as! BaoHanhTaoPhieuMainController
                newViewController.mImeiPush = self.mImei ?? ""
                UserDefaults.standard.set(arrTaoPhieuBHResult[indexPath.row].MaSanPham, forKey : "mMaSanPham")
                UserDefaults.standard.set(arrTaoPhieuBHResult[indexPath.row].TenSanPham, forKey : "mTenSanPham")
                UserDefaults.standard.set(arrTaoPhieuBHResult[indexPath.row].MaNhan, forKey : "mMaNhan")
                UserDefaults.standard.set(arrTaoPhieuBHResult[indexPath.row].MaNhomHangCRM, forKey : "mMaNhomHangCRM")
                UserDefaults.standard.set(arrTaoPhieuBHResult[indexPath.row].MaNhomHangCRM, forKey : "mMaLoai")
                UserDefaults.standard.set(arrTaoPhieuBHResult[indexPath.row].MaNhomHangCRM, forKey : "mMaNganh")
                NotificationCenter.default.post(name: NSNotification.Name.init("searchTaoPhieuBH"), object: nil)
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return (Common.Size(s:18)) * 4 ;
    }
    
}



class ItemSearchBaoHanhTableViewCell: UITableViewCell {
    var soDH: UILabel!
    var Imei: UILabel!
    var TenSP: UILabel!
    var HanBaoHanh:UILabel!
    var imageCheck:UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        Imei = UILabel()
        Imei.textColor = UIColor.black
        Imei.lineBreakMode = .byWordWrapping
        Imei.numberOfLines = 2
        Imei.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        contentView.addSubview(Imei)
        
        soDH = UILabel()
        soDH.textColor = UIColor.gray
        soDH.numberOfLines = 1
        soDH.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(soDH)
        
        
        TenSP = UILabel()
        TenSP.textColor = UIColor.black
        //        label.lineBreakMode = .byWordWrapping
        //        label.numberOfLines = 3
        TenSP.numberOfLines = 1
        TenSP.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        
        contentView.addSubview(TenSP)
        
        HanBaoHanh = UILabel()
        HanBaoHanh.textColor = UIColor.red
        HanBaoHanh.numberOfLines = 1
        HanBaoHanh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(HanBaoHanh)
        
        
        
        
        Imei.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        
        
        soDH.frame = CGRect(x:Imei.frame.origin.x ,y: Imei.frame.origin.y + Imei.frame.size.height +  Common.Size(s:5),width: Imei.frame.size.width ,height: Common.Size(s:13))
        
        
        let line1 = UIView(frame: CGRect(x: soDH.frame.origin.x, y:soDH.frame.origin.y + soDH.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line1)
        
        
        
        TenSP.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: Imei.frame.size.width / 2 ,height:line1.frame.size.height)
        
        let line2 = UIView(frame: CGRect(x: TenSP.frame.origin.x + TenSP.frame.size.width + Common.Size(s:10) , y:soDH.frame.origin.y + soDH.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line2)
        
        HanBaoHanh.frame = CGRect(x:line2.frame.origin.x + Common.Size(s:5),y: line2.frame.origin.y ,width: Imei.frame.size.width / 2 ,height:line2.frame.size.height)
        
        contentView.addSubview(HanBaoHanh)
        
        
        imageCheck = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageCheck.image = #imageLiteral(resourceName: "checkmark50")
        imageCheck.contentMode = UIView.ContentMode.scaleAspectFit
        let viewCheck = UIView()
        viewCheck.addSubview(imageCheck)
        viewCheck.frame = CGRect(x: UIScreen.main.bounds.size.width - 30, y: ((Common.Size(s:16)) * 4 - 30) / 2, width: imageCheck.frame.size.height, height: imageCheck.frame.size.height)
        
        contentView.addSubview(viewCheck)
        
        
    }
    
    
    
}
