//
//  BaoHanhChiTietLichSuController.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import Alamofire

class BaoHanhChiTietLichSuController: UIViewController {

    var pMaCheckin:String?
    var pDiemBatDau:String?
    var pLoaiDiemDen:String?
    var pLinkChuKi:String?
    var pLinkHinhAnh:String?
    var userGlobal: UserDefaults!
    var baoHanhChiTietLichSuView:BaoHanhChiTietLichSuView!
    
    var pTenDiemBatDau:String?
    var pTenDiemDen:String?
    var pAction:String?
    var pNote:String?
    var pSLGiao:String?
    var pSLNhan:String?
    var pThoiGian:String?
    var pDoDai:String?
    var processView:ProcessView!
    var arrayDiaChiByUser:[AllNhanVienPhanCong_MobileResult] = [AllNhanVienPhanCong_MobileResult]()
    var isHang:Bool = false
    var mMaNoiGN:String = ""
    var mUserCode_XN:String?
    var pLinkChuKiGiaoNhan:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baoHanhChiTietLichSuView = BaoHanhChiTietLichSuView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(baoHanhChiTietLichSuView)
        
        processView = ProcessView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height ))
        self.view.addSubview(processView)
        processView.isHidden = true
        
        
        userGlobal = UserDefaults()
//        let userName = self.userGlobal.object(forKey: "UserName") as? String
//        let employeeName = self.userGlobal.object(forKey: "EmployeeName") as? String
//        let employeeShop = (self.userGlobal.object(forKey: "ShopName") as? String)!
        
        let userName = Cache.user!.UserName
        let employeeName = Cache.user!.EmployeeName
        let employeeShop = Cache.user!.ShopName
        
        baoHanhChiTietLichSuView.txtShop.text = "\(employeeShop)"
        
        
        baoHanhChiTietLichSuView.txtName.text = "\(userName)-\(employeeName)"
        // Do any additional setup after loading the view.
        baoHanhChiTietLichSuView.companyButton.text = "\(pTenDiemBatDau!)"
        baoHanhChiTietLichSuView.company2Button.text = "\(pTenDiemDen!)"
        baoHanhChiTietLichSuView.edtGhiChu.text = "\(pNote!)"
        
        self.baoHanhChiTietLichSuView.txtTongPHBGiao.text = "Tổng số kiện giao  \(pSLGiao!)"
        
        self.baoHanhChiTietLichSuView.txtThoiGian.text = "Thời gian  \(pThoiGian!)"
        
        //        var mDouble = round(Double("\(pDoDai!)")!) / 1000
        //        var mString = "\(mDouble)"
        
        if(pDoDai!.count >= 3)
        {
            let startIndex = pDoDai!.index(pDoDai!.startIndex, offsetBy: 0)
            let endIndex = pDoDai!.index(pDoDai!.startIndex, offsetBy: 2)
            let mSubString = String(pDoDai![startIndex...endIndex])
            self.baoHanhChiTietLichSuView.txtDoDai.text = "Độ dài  \(mSubString) km"
        }
        else
        {
            self.baoHanhChiTietLichSuView.txtDoDai.text = "Độ dài  \(pDoDai!) km"
        }
        
        
        
        //Thời Gian: \(pThoiGian!) Độ dài : \(pDoDai!)
        self.baoHanhChiTietLichSuView.txtTongPHBNhan.text = "Tổng số kiện nhận  \(pSLNhan!)"
        if(pAction == "0")
        {
            baoHanhChiTietLichSuView.radioKhac.isSelected = true
        }
        if(pAction == "1")
        {
            baoHanhChiTietLichSuView.radioCompany.isSelected = true
        }
        if(pAction == "2")
        {
            baoHanhChiTietLichSuView.radioMarket.isSelected = true
        }
        if(pAction == "3")
        {
            baoHanhChiTietLichSuView.radioMarket.isSelected = true
            baoHanhChiTietLichSuView.radioCompany.isSelected = true
        }
        if(pLoaiDiemDen == "3")
        {
            isHang = true
            self.baoHanhChiTietLichSuView.viewThuKho.isHidden = true
           
            
        }
        else if (pLoaiDiemDen != "3")
        {
            self.baoHanhChiTietLichSuView.viewChuKy.isHidden = true
            self.baoHanhChiTietLichSuView.edtThuKhoCode.text = mUserCode_XN!
            self.baoHanhChiTietLichSuView.edtThuKhoCode.isEnabled = false
            self.processView.isHidden = false
            GetHinhAnhChuKiGiaoNhan(mUrl: "\(pLinkChuKiGiaoNhan!)")
        }
        
        if(pLinkChuKi == "" && pLinkHinhAnh == "" && pLinkChuKiGiaoNhan != "")
        {
            baoHanhChiTietLichSuView.viewChuKy.isHidden = true
            baoHanhChiTietLichSuView.txtGhiChu.frame.origin.y = baoHanhChiTietLichSuView.viewThuKho.frame.origin.y + baoHanhChiTietLichSuView.viewThuKho.frame.size.height + Common.Size(s:20)
            baoHanhChiTietLichSuView.edtGhiChu.frame.origin.y = baoHanhChiTietLichSuView.txtGhiChu.frame.origin.y + Common.Size(s:20)
            
        }
        else if(pLinkChuKiGiaoNhan == "" && pLinkHinhAnh != "" && pLinkChuKi != "")
        {
            baoHanhChiTietLichSuView.viewThuKho.isHidden = true
            baoHanhChiTietLichSuView.viewChuKy.isHidden = false
            if(pLinkChuKi != "")
            {
                print("\(String(describing: pLinkChuKi))")
                self.processView.isHidden = false
                GetHinhAnhChuKi(mUrl: "\(pLinkChuKi!)")
            }
            
            if(pLinkHinhAnh != "")
            {
                print("\(String(describing: pLinkHinhAnh))")
                GetHinhAnhXacNhan(mUrl: "\(pLinkHinhAnh!)")
            }
        }
        else
        {
            baoHanhChiTietLichSuView.viewThuKho.isHidden = true
            baoHanhChiTietLichSuView.viewChuKy.isHidden = true
            baoHanhChiTietLichSuView.txtGhiChu.frame.origin.y = baoHanhChiTietLichSuView.viewLine2.frame.origin.y + Common.Size(s:20)
            baoHanhChiTietLichSuView.edtGhiChu.frame.origin.y = baoHanhChiTietLichSuView.txtGhiChu.frame.origin.y + Common.Size(s:20)
        }
        //GetDataLocationByUser(p_User: "\(userName!)",p_Loai : "-1")
        
        
        let TapXemChiTietGiao = UITapGestureRecognizer(target: self, action: #selector(tapXemChiTietPBHGiao))
        baoHanhChiTietLichSuView.txtChiTietPHBGiao.isUserInteractionEnabled = true
        baoHanhChiTietLichSuView.txtChiTietPHBGiao.addGestureRecognizer(TapXemChiTietGiao)
        
        let TapXemChiTietNhan = UITapGestureRecognizer(target: self, action: #selector(tapXemChiTietPBHNhan))
        baoHanhChiTietLichSuView.txtChiTietPHBNhan.isUserInteractionEnabled = true
        baoHanhChiTietLichSuView.txtChiTietPHBNhan.addGestureRecognizer(TapXemChiTietNhan)
    }
    
    
    func GetHinhAnhChuKi(mUrl: String)
    {
        AF.request(mUrl).responseData { response in
            if let data = response.data {
                let image = UIImage(data: data)
                self.baoHanhChiTietLichSuView.viewImageSign.image = image
                self.processView.isHidden = true
            }
        }
    }
    
    func GetHinhAnhXacNhan(mUrl: String)
    {
        AF.request(mUrl).responseData { response in
            if let data = response.data {
                let image = UIImage(data: data)
                self.baoHanhChiTietLichSuView.viewCMNDTruocButton3.image = image
                
            }
        }
    }
    
    func GetHinhAnhChuKiGiaoNhan(mUrl: String)
    {
        AF.request(mUrl).responseData { response in
            if let data = response.data {
                let image = UIImage(data: data)
                self.baoHanhChiTietLichSuView.imageSingingThuKho.image = image
                self.processView.isHidden = true
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func tapXemChiTietPBHGiao()
    {
        
        if(self.isHang == true)
        {
            let newViewController = BaoHanhChiTietPhieuHangController()
            newViewController.mIsViewPush = "notmain"
            newViewController.isType = "giao"
            newViewController.mIsHang = "true"
            newViewController.mMaCheckin = "\(pMaCheckin!)"
            
            if(self.baoHanhChiTietLichSuView.company2Button.text != "")
            {
                newViewController.mNameLocation = self.baoHanhChiTietLichSuView.company2Button.text
                newViewController.pMaNoiGN = self.pMaCheckin!
            }
            else
            {
                newViewController.mNameLocation = ""
                newViewController.pMaNoiGN = ""
            }
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
        else
        {
            let newViewController = BaoHanhChiTietPhieuHangController()
            newViewController.mIsViewPush = "notmain"
            newViewController.isType = "giao"
            newViewController.mIsHang = "false"
            if(self.baoHanhChiTietLichSuView.company2Button.text != "")
            {
                newViewController.mNameLocation = self.baoHanhChiTietLichSuView.company2Button.text
                newViewController.mMaCheckin = self.pMaCheckin!
            }
            else
            {
                newViewController.mNameLocation = ""
                newViewController.mMaCheckin = ""
            }
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    @objc func tapXemChiTietPBHNhan()
    {
        
        if(self.isHang == true)
        {
            let newViewController = BaoHanhChiTietPhieuHangController()
            newViewController.mIsViewPush = "notmain"
            newViewController.isType = "nhan"
            newViewController.mIsHang = "true"
            newViewController.mMaCheckin = "\(pMaCheckin!)"
            
            if(self.baoHanhChiTietLichSuView.company2Button.text != "")
            {
                newViewController.mNameLocation = self.baoHanhChiTietLichSuView.company2Button.text
                newViewController.pMaNoiGN = self.pMaCheckin!
            }
            else
            {
                newViewController.mNameLocation = ""
                newViewController.pMaNoiGN = ""
            }
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }else
        {
            let newViewController = BaoHanhChiTietPhieuHangController()
            newViewController.mIsViewPush = "notmain"
            newViewController.isType = "nhan"
            newViewController.mIsHang = "false"
            if(self.baoHanhChiTietLichSuView.company2Button.text != "")
            {
                newViewController.mNameLocation = self.baoHanhChiTietLichSuView.company2Button.text
                newViewController.mMaCheckin = self.pMaCheckin!
            }
            else
            {
                newViewController.mNameLocation = ""
                newViewController.mMaCheckin = ""
            }
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    
    
    
    
    
    
    
}
