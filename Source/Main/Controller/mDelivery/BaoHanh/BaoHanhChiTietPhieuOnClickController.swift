//
//  BaoHanhChiTietPhieuOnClickController.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class BaoHanhChiTietPhieuOnClickController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    
    var isType:String?
    var mNameLocation:String?
    var willUsed:String = ""
    var pMaNoiGN:String?
    
    var arrChiTietPhieuNhan = [GiaoNhan_LoadChiTietPhieu_HangResult]()
    var cellRow: BaoHanhChiTietPhieuOnClickTableViewCell?
    var countRow:Int = 0
    var baoHanhChiTietPhieuView:BaoHanhChiTietOnClickView!
    var userGlobal: UserDefaults!
    var mMaBBBG:String?
    // file nay bi loi
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baoHanhChiTietPhieuView = BaoHanhChiTietOnClickView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(baoHanhChiTietPhieuView)
        
        
        baoHanhChiTietPhieuView.tableView.dataSource = self
        baoHanhChiTietPhieuView.tableView.delegate = self
        baoHanhChiTietPhieuView.tableView.register(BaoHanhChiTietPhieuOnClickTableViewCell.self, forCellReuseIdentifier: "BaoHanhChiTietPhieuOnClickTableViewCell")
        baoHanhChiTietPhieuView.lbKHGiao.text = "Số phiếu"
        baoHanhChiTietPhieuView.lbTenPhuKien.text = "Tên sản phẩm"
        baoHanhChiTietPhieuView.lbSeriNo.text = "Imei"
        
        userGlobal = UserDefaults()
//        let userName = self.userGlobal.object(forKey: "UserName") as? String
//        let employeeName = self.userGlobal.object(forKey: "EmployeeName") as? String
        let userName = Cache.user!.UserName
        let employeeName = Cache.user!.EmployeeName
        baoHanhChiTietPhieuView.txtName.text = "\(userName)-\(employeeName)"
//        let employeeShop = (self.userGlobal.object(forKey: "ShopName") as? String)!

        baoHanhChiTietPhieuView.txtShop.text = "\(mNameLocation!)"
        self.GetListChiTietPhieuNhanOnClick(p_MaBBBG: "\(mMaBBBG!)")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("willUsed \(willUsed)")
        countRow = arrChiTietPhieuNhan.count
        
        return countRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        cellRow = BaoHanhChiTietPhieuOnClickTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "BaoHanhChiTietPhieuTableViewCell")
        cellRow?.cellKHGiao.text = "\(arrChiTietPhieuNhan[indexPath.row].SoPhieuBH)";
        cellRow?.cellTenPhuKien.text = "\(arrChiTietPhieuNhan[indexPath.row].TenSanPham)";
        cellRow?.cellSeriNo.text = "\(arrChiTietPhieuNhan[indexPath.row].Imei)";
        
        if((arrChiTietPhieuNhan[indexPath.row].TenSanPham.count) > 13 )
        {
            cellRow?.cellKHGiao.frame.size.height = Common.Size(s:50)
            cellRow?.cellTenPhuKien.frame.size.height = Common.Size(s:50)
            cellRow?.cellSeriNo.frame.size.height = Common.Size(s:50)
        }
        else if((arrChiTietPhieuNhan[indexPath.row].TenSanPham.count) > 26 )
        {
            cellRow?.cellKHGiao.frame.size.height = Common.Size(s:100)
            cellRow?.cellTenPhuKien.frame.size.height = Common.Size(s:100)
            cellRow?.cellSeriNo.frame.size.height = Common.Size(s:100)
        }
        else
        {
            cellRow?.cellKHGiao.frame.size.height = Common.Size(s:20)
            cellRow?.cellTenPhuKien.frame.size.height = Common.Size(s:20)
            cellRow?.cellSeriNo.frame.size.height = Common.Size(s:20)
        }
        
        return cellRow!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if((arrChiTietPhieuNhan[indexPath.row].TenSanPham.count) > 13 )
        {
            return Common.Size(s:50);
        }
        else if((arrChiTietPhieuNhan[indexPath.row].TenSanPham.count) > 26 )
        {
            return Common.Size(s:100);
        }
        else
        {
            return Common.Size(s:20);
        }
        
        
        
    }
    
    
    
    func GetListChiTietPhieuNhanOnClick(p_MaBBBG:String)
    {
        MDeliveryAPIService.GetLoadChiTietPhieuOnClick(p_MaBBBG: p_MaBBBG){ (error: Error? , success: Bool,result: [GiaoNhan_LoadChiTietPhieu_HangResult]!) in
            if success
            {
                if(result.count > 0)
                {
                    self.arrChiTietPhieuNhan = result
                    
                    self.baoHanhChiTietPhieuView.tableView.reloadData()
                    
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
}


