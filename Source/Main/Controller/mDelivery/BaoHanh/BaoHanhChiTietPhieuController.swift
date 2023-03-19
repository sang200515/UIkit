//
//  BaoHanhChiTietPhieuController.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class BaoHanhChiTietPhieuController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    
    var isType:String?
    var mNameLocation:String?
    var willUsed:String = ""
    var pMaNoiGN:String?
    var arrChiTietPhieuGiao = [GiaoNhan_LoadChiTietPhieuGiao]()
    var arrChiTietPhieuNhan = [GiaoNhan_LoadChiTietPhieuNhan]()
    var cellRow: BaoHanhChiTietPhieuTableViewCell?
    var countRow:Int = 0
    var baoHanhChiTietPhieuView:BaoHanhChiTietPhieuView!
    var userGlobal: UserDefaults!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baoHanhChiTietPhieuView = BaoHanhChiTietPhieuView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(baoHanhChiTietPhieuView)
        
        
        baoHanhChiTietPhieuView.tableView.dataSource = self
        baoHanhChiTietPhieuView.tableView.delegate = self
        baoHanhChiTietPhieuView.tableView.register(BaoHanhChiTietPhieuTableViewCell.self, forCellReuseIdentifier: "BaoHanhChiTietPhieuTableViewCell")
        
        
        userGlobal = UserDefaults()
        let userName = Cache.user!.UserName
        let employeeName = Cache.user!.EmployeeName
        baoHanhChiTietPhieuView.txtName.text = "\(userName)-\(employeeName)"
        
        baoHanhChiTietPhieuView.txtShop.text = "\(mNameLocation!)"
        if(isType == "1")
        {
            if(pMaNoiGN != "")
            {
                var mUserPhanCong:String = ""
                if(pMaNoiGN! == "5" || pMaNoiGN! == "6" || pMaNoiGN! == "7")
                {
                    mUserPhanCong = Cache.user!.UserName
                }
                self.GetListChiTietPhieuGiao(p_MaNoiGN: "\(pMaNoiGN!)", p_UserPhanCong: "\(mUserPhanCong)")
                //baoHanhChiTietPhieuView.txtLoTrinh.text = "Điểm Giao : \(mNameLocation!)"
            }
        }
        if(isType == "2")
        {
            if(pMaNoiGN != "")
            {
                var mUserPhanCong:String = ""
                if(pMaNoiGN! == "5" || pMaNoiGN! == "6" || pMaNoiGN! == "7")
                {
                    mUserPhanCong = Cache.user!.UserName
                }
                self.GetListChiTietPhieuNhan(p_MaNoiGN: "\(pMaNoiGN!)", p_UserPhanCong: "\(mUserPhanCong)")
                baoHanhChiTietPhieuView.txtLoTrinh.text = "Điểm Nhận : \(mNameLocation!)"
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("willUsed \(willUsed)")
        if(willUsed == "1")
        {
            countRow = arrChiTietPhieuGiao.count
        }
        else if(willUsed == "2")
        {
            countRow = arrChiTietPhieuNhan.count
        }
        else
        {
            countRow = 0
        }
        print("willUsed \(willUsed)")
        print("willUsed \(arrChiTietPhieuGiao.count)")
        print("rowwww \(countRow)")
        return countRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellRow = BaoHanhChiTietPhieuTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "BaoHanhChiTietPhieuTableViewCell")
        if(self.willUsed == "1")
        {
            cellRow?.cellKHGiao.text = "\(indexPath.row + 1)"
            cellRow?.cellTenPhuKien.text = "\(arrChiTietPhieuGiao[indexPath.row].MaBBBG)";
            cellRow?.cellSeriNo.text = "\(arrChiTietPhieuGiao[indexPath.row].SoLuong)";
        }
        if(self.willUsed == "2")
        {
            cellRow?.cellKHGiao.text = "\(indexPath.row + 1)"
            cellRow?.cellTenPhuKien.text = "\(arrChiTietPhieuNhan[indexPath.row].MaBBBG)";
            cellRow?.cellSeriNo.text = "\(arrChiTietPhieuNhan[indexPath.row].SoLuong)";
        }
        
        return cellRow!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:30);
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(isType == "1")
        {
            let newViewController = BaoHanhChiTietPhieuOnClickController()
            newViewController.mMaBBBG = "\(arrChiTietPhieuGiao[indexPath.row].MaBBBG)"
            newViewController.mNameLocation = "\(mNameLocation!)"
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        if(isType == "2")
        {
            let newViewController = BaoHanhChiTietPhieuOnClickController()
            newViewController.mMaBBBG = "\(arrChiTietPhieuNhan[indexPath.row].MaBBBG)"
            newViewController.mNameLocation = "\(mNameLocation!)"
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
        
    }
    
    
    func GetListChiTietPhieuGiao(p_MaNoiGN:String,p_UserPhanCong:String)
    {
        MDeliveryAPIService.GetLoadChiTietPhieuGiao(p_MaNoiGN: p_MaNoiGN, p_UserPhanCong: p_UserPhanCong){ (error: Error? , success: Bool,result: [GiaoNhan_LoadChiTietPhieuGiao]!) in
            if success
            {
                if(result.count > 0)
                {
                    
                    self.arrChiTietPhieuGiao = result
                    
                    for i in 0 ..< self.arrChiTietPhieuGiao.count
                    {
                        print("\(self.arrChiTietPhieuGiao[i].MaBBBG)")
                    }
                    self.willUsed = "1"
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
    
    
    
    func GetListChiTietPhieuNhan(p_MaNoiGN:String,p_UserPhanCong:String)
    {
        MDeliveryAPIService.GetLoadChiTietPhieuNhan(p_MaNoiGN: p_MaNoiGN, p_UserPhanCong: p_UserPhanCong){ (error: Error? , success: Bool,result: [GiaoNhan_LoadChiTietPhieuNhan]!) in
            if success
            {
                if(result.count > 0)
                {
                    self.arrChiTietPhieuNhan = result
                    self.willUsed = "2"
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
}

