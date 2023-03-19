//
//  BaoHanhChiTietPhieuHangController.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class BaoHanhChiTietPhieuHangController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    var mIsViewPush:String?
    var mIsHang:String?
    var mMaCheckin:String?
    var isType:String?
    var mNameLocation:String?
    var willUsed:String = ""
    var pMaNoiGN:String?
    
    var arrLoadChiTietPhieu_Not_Hang = [GiaoNhan_LoadChiTietPhieuGiao]()
    var arrChiTietPhieuNhan = [GiaoNhan_LoadChiTietPhieu_HangResult]()
    var cellRow: BaoHanhChiTietPhieuOnClickTableViewCell?
    var countRow:Int = 0
    var baoHanhChiTietPhieuView:BaoHanhChiTietPhieuView!
    var userGlobal: UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baoHanhChiTietPhieuView = BaoHanhChiTietPhieuView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
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
        _ = Cache.user!.ShopName
        baoHanhChiTietPhieuView.txtShop.text = "\(mNameLocation!)"
        if(isType! == "nhan")
        {
            if(mIsHang == "true")
            {
                if(self.mIsViewPush == "main")
                {
                    
                    self.GetListChiTietPhieuNhan_HangMain(p_MaHang:  mMaCheckin!)
                }
                else
                {
                    self.GetListChiTietPhieuNhan_HangLichSu(p_MaCheckIn: mMaCheckin!,p_Type:"2")
                }
                
            }
            else
            {
                self.GetListChiTietPhieuNhan_HangLichSu_Not_Hang(p_MaCheckIn: mMaCheckin!,p_Type:"2")
                baoHanhChiTietPhieuView.lbKHGiao.text = "STT"
                baoHanhChiTietPhieuView.lbTenPhuKien.text = "Số kiện"
                baoHanhChiTietPhieuView.lbSeriNo.text = "Tổng SPBH"
            }
            baoHanhChiTietPhieuView.txtLoTrinh.text = "Điểm Nhận : \(mNameLocation!)"
            
        }
        else
        {
            baoHanhChiTietPhieuView.lbKHGiao.text = "STT"
            baoHanhChiTietPhieuView.lbTenPhuKien.text = "Số kiện"
            baoHanhChiTietPhieuView.lbSeriNo.text = "Tổng SPBH"
            self.GetListChiTietPhieuNhan_HangLichSu_Not_Hang(p_MaCheckIn: mMaCheckin!,p_Type:"1")
            //baoHanhChiTietPhieuView.txtLoTrinh.text = "Điểm Giao : \(mNameLocation!)"
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.arrLoadChiTietPhieu_Not_Hang.count > 0 )
        {
            let newViewController = BaoHanhChiTietPhieuOnClickController()
            newViewController.mMaBBBG = "\(arrLoadChiTietPhieu_Not_Hang[indexPath.row].MaBBBG)"
            newViewController.mNameLocation = "\(baoHanhChiTietPhieuView.txtShop.text!)"
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("willUsed \(willUsed)")
        
        if(isType! == "nhan")
        {
            if(mIsHang == "true")
            {
                countRow = arrChiTietPhieuNhan.count
            }
            else
            {
                countRow = arrLoadChiTietPhieu_Not_Hang.count
            }
            
            
        }
        else
        {
            countRow = arrLoadChiTietPhieu_Not_Hang.count
        }
        
        return countRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if(isType! == "nhan")
        {
            
            
            
            
            if(mIsHang == "true")
            {
                
                
                
                cellRow = BaoHanhChiTietPhieuOnClickTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "BaoHanhChiTietPhieuOnClickTableViewCell")
                cellRow?.cellKHGiao.text = "\(arrChiTietPhieuNhan[indexPath.row].SoPhieuBH)";
                cellRow?.cellTenPhuKien.text = "\(arrChiTietPhieuNhan[indexPath.row].TenSanPham)";
                cellRow?.cellSeriNo.text = "\(arrChiTietPhieuNhan[indexPath.row].Imei)";
                
                
                if((arrChiTietPhieuNhan[indexPath.row].TenSanPham.count) > 13 )
                {
                    cellRow?.cellKHGiao.frame.size.height =  Common.Size(s:50);
                    cellRow?.cellTenPhuKien.frame.size.height = Common.Size(s:50);
                    cellRow?.cellSeriNo.frame.size.height = Common.Size(s:50);
                }
                else if((arrChiTietPhieuNhan[indexPath.row].TenSanPham.count) > 26 )
                {
                    cellRow?.cellKHGiao.frame.size.height = Common.Size(s:100);
                    cellRow?.cellTenPhuKien.frame.size.height = Common.Size(s:100);
                    cellRow?.cellSeriNo.frame.size.height = Common.Size(s:100);
                }
                else
                {
                    cellRow?.cellKHGiao.frame.size.height = Common.Size(s:20);
                    cellRow?.cellTenPhuKien.frame.size.height = Common.Size(s:20);
                    cellRow?.cellSeriNo.frame.size.height = Common.Size(s:20);
                }
            }
            else
            {
                
                
                
                cellRow = BaoHanhChiTietPhieuOnClickTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "BaoHanhChiTietPhieuOnClickTableViewCell")
                cellRow?.cellKHGiao.text = "\(indexPath.row + 1)";
                cellRow?.cellTenPhuKien.text = "\(arrLoadChiTietPhieu_Not_Hang[indexPath.row].MaBBBG)";
                cellRow?.cellSeriNo.text = "\(arrLoadChiTietPhieu_Not_Hang[indexPath.row].SoLuong)";
                
                cellRow?.cellKHGiao.frame.size.height = Common.Size(s:20);
                cellRow?.cellTenPhuKien.frame.size.height = Common.Size(s:20);
                cellRow?.cellSeriNo.frame.size.height = Common.Size(s:20);
            }
            
            
        }
        else
        {
            
            
            cellRow = BaoHanhChiTietPhieuOnClickTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "BaoHanhChiTietPhieuOnClickTableViewCell")
            cellRow?.cellKHGiao.text = "\(indexPath.row + 1)";
            cellRow?.cellTenPhuKien.text = "\(arrLoadChiTietPhieu_Not_Hang[indexPath.row].MaBBBG)";
            cellRow?.cellSeriNo.text = "\(arrLoadChiTietPhieu_Not_Hang[indexPath.row].SoLuong)";
            
            
            cellRow?.cellKHGiao.frame.size.height = Common.Size(s:20);
            cellRow?.cellTenPhuKien.frame.size.height = Common.Size(s:20);
            cellRow?.cellSeriNo.frame.size.height = Common.Size(s:20);
        }
        
        
        
        
        return cellRow!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        
        if(isType! == "nhan")
        {
            if(mIsHang == "true")
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
            else
            {
                return Common.Size(s:20);
            }
            
            
        }
        else
        {
            return Common.Size(s:20);
        }
        
        
        
        
        
    }
    
    
    
    func GetListChiTietPhieuNhan_HangLichSu_Not_Hang(p_MaCheckIn:String,p_Type:String)
    {
        MDeliveryAPIService.GetLoadChiTietPhieuNhan_HangLichSu_Not_Hang(p_MaCheckIn: p_MaCheckIn,p_Type:p_Type){ (error: Error? , success: Bool,result: [GiaoNhan_LoadChiTietPhieuGiao]!) in
            if success
            {
                if(result.count > 0)
                {
                    self.arrLoadChiTietPhieu_Not_Hang = result
                    
                    self.baoHanhChiTietPhieuView.tableView.reloadData()
                    var mSumPhieu:Int = 0
                    for i in 0 ..< result.count
                    {
                        mSumPhieu = mSumPhieu + (Int("\(result[i].SoLuong)")!)
                    }
                    self.baoHanhChiTietPhieuView.lbBot3.text = "\(mSumPhieu)"
                    
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
    
    
    func GetListChiTietPhieuNhan_HangLichSu(p_MaCheckIn:String,p_Type:String)
    {
        MDeliveryAPIService.GetLoadChiTietPhieuNhan_HangLichSu(p_MaCheckIn: p_MaCheckIn,p_Type:p_Type){ (error: Error? , success: Bool,result: [GiaoNhan_LoadChiTietPhieu_HangResult]!) in
            if success
            {
                if(result.count > 0)
                {
                    self.arrChiTietPhieuNhan = result
                    
                    self.baoHanhChiTietPhieuView.tableView.reloadData()
                    self.baoHanhChiTietPhieuView.lbBot3.isHidden = true
                    self.baoHanhChiTietPhieuView.lbBot1.isHidden = true
                    self.baoHanhChiTietPhieuView.lbBot2.isHidden = true
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
    
    
    func GetListChiTietPhieuNhan_HangMain(p_MaHang:String)
    {
        MDeliveryAPIService.GetLoadChiTietPhieuNhan_Hang(p_MaHang: p_MaHang){ (error: Error? , success: Bool,result: [GiaoNhan_LoadChiTietPhieu_HangResult]!) in
            if success
            {
                if(result.count > 0)
                {
                    self.arrChiTietPhieuNhan = result
                    
                    self.baoHanhChiTietPhieuView.tableView.reloadData()
                   
                    self.baoHanhChiTietPhieuView.lbBot3.isHidden = true
                    self.baoHanhChiTietPhieuView.lbBot1.isHidden = true
                    self.baoHanhChiTietPhieuView.lbBot2.isHidden = true
                    
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

