//
//  BaoHanhLichSuGiaoNhanController.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaoHanhLichSuGiaoNhanController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    let datePicker = UIDatePicker()
    var userGlobal: UserDefaults!
    var cellRow: BaoHanhLichSuGiaoNhanTableViewCell?
    var countRow:Int = 0
    var baoHanhLichSuGiaoNhanView:BaoHanhLichSuGiaoNhanView!
    var arrLichSuGiaoNhan = [GiaoNhan_LichSuGiaoNhan]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.tintColor  = UIColor.white
        baoHanhLichSuGiaoNhanView = BaoHanhLichSuGiaoNhanView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(baoHanhLichSuGiaoNhanView)
        
        
        baoHanhLichSuGiaoNhanView.tableView.dataSource = self
        baoHanhLichSuGiaoNhanView.tableView.delegate = self
        baoHanhLichSuGiaoNhanView.tableView.register(BaoHanhLichSuGiaoNhanTableViewCell.self, forCellReuseIdentifier: "BaoHanhLichSuGiaoNhanTableViewCell")
        userGlobal = UserDefaults()
        let userName = Cache.user!.UserName
        let employeeName = Cache.user!.EmployeeName
        baoHanhLichSuGiaoNhanView.txtName.text = "\(userName)-\(employeeName)"
        
        let mDate = Date()
        let mFormatter = DateFormatter()
        mFormatter.dateFormat = "dd/MM/yyyy"
        let mResult = mFormatter.string(from: mDate)
        baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.text = "\(mResult)"
        baoHanhLichSuGiaoNhanView.btnNgayLoTrinh.setTitle("\(mResult)",for: .normal)
        GetDataLichSuGiaoNhan(p_MaNhanVien: "\(userName)", p_NgayChon: "\(mResult)")
        //baoHanhLichSuGiaoNhanView.btnNgayLoTrinh.addTarget(self, action: #selector(self.PickDateAction), for: .touchUpInside)
        
        //baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.isHidden = true
        baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.addTarget(self, action: #selector(BaoHanhLichSuGiaoNhanController.PickDateAction), for: .touchUpInside)
     
        
        
        let TapPickDate = UITapGestureRecognizer(target: self, action: #selector(BaoHanhLichSuGiaoNhanController.PickDateAction))
        baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.isUserInteractionEnabled = true
        baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.addGestureRecognizer(TapPickDate)
        
        
     
        
        
        //        let TapPickDate = UITapGestureRecognizer(target: self, action: #selector(BaoHanhLichSuGiaoNhanController.PickDateAction))
        //        baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.isUserInteractionEnabled = true
        //        baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.addGestureRecognizer(TapPickDate)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   @objc func DoneDatePicker()
    {
        print("asdsadsa\(datePicker.date)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.text = dateFormatter.string(from: datePicker.date)
        baoHanhLichSuGiaoNhanView.btnNgayLoTrinh.setTitle("\(dateFormatter.string(from: datePicker.date))",for: .normal)
        self.view.endEditing(true)
        let userName = Cache.user!.UserName
        GetDataLichSuGiaoNhan(p_MaNhanVien: "\(userName)", p_NgayChon: "\(dateFormatter.string(from: datePicker.date))")
    }
    
    @objc func CancelDatePicker()
    {
        self.view.endEditing(true)
    }
    
    
    
    
    @objc func PickDateAction()
    {
        print("asdsadsa)")
        
        //Formate Date
        datePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(DoneDatePicker))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        // add toolbar to textField
        baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.inputAccessoryView = toolbar
        // add datepicker to textField
        baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.inputView = datePicker
        baoHanhLichSuGiaoNhanView.valueNgayLoTrinh.becomeFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        countRow = arrLichSuGiaoNhan.count
        print("rowwww \(countRow)")
        return countRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellRow = BaoHanhLichSuGiaoNhanTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "BaoHanhLichSuGiaoNhanTableViewCell")
        cellRow?.cellKHGiao.text = "\(indexPath.row + 1)"
        cellRow?.cellTenPhuKien.text = "\(arrLichSuGiaoNhan[indexPath.row].TenDiemDen)";
        cellRow?.cellSeriNo.text = "\(arrLichSuGiaoNhan[indexPath.row].SLGiao)";
        cellRow?.cellSLNhan.text = "\(arrLichSuGiaoNhan[indexPath.row].SLNhan)";
        cellRow?.cellXem.text = "Xem";
        cellRow?.cellNgay.text = "\(arrLichSuGiaoNhan[indexPath.row].TimeCheckIn)";
        
        
        var mDouble = 0.0
        if(arrLichSuGiaoNhan[indexPath.row].DoDai.count >= 5)
        {
            
            mDouble = round(Double("\(arrLichSuGiaoNhan[indexPath.row].DoDai)")! * 100) / 100
            cellRow?.cellKm.text = "\(mDouble)";
            
        }
        else
        {
            cellRow?.cellKm.text = "\(arrLichSuGiaoNhan[indexPath.row].DoDai)";
        }
       
        
        
        
        if(arrLichSuGiaoNhan[indexPath.row].U_Action == "0")
        {
            cellRow?.cellLoai.text = "Khác";
        }
        else if(arrLichSuGiaoNhan[indexPath.row].U_Action == "1")
        {
            cellRow?.cellLoai.text = "Nhận";
        }
        else if(arrLichSuGiaoNhan[indexPath.row].U_Action == "2")
        {
            cellRow?.cellLoai.text = "Giao";
        }
        else if(arrLichSuGiaoNhan[indexPath.row].U_Action == "3")
        {
            cellRow?.cellLoai.text = "Giao-Nhận";
        }
        
        return cellRow!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:30) * 2;
        
        
    }
    
    func GetDataLichSuGiaoNhan(p_MaNhanVien: String,p_NgayChon: String)
    {
        self.baoHanhLichSuGiaoNhanView.loadingView.startAnimating()
        MDeliveryAPIService.GetLichSuGiaoNhan(p_MaNhanVien: p_MaNhanVien,p_NgayChon: p_NgayChon){ (error: Error? , success: Bool,result: [GiaoNhan_LichSuGiaoNhan]!) in
            if success
            {
                self.baoHanhLichSuGiaoNhanView.loadingView.stopAnimating()
                if(result.count > 0)
                {
                    self.arrLichSuGiaoNhan = result
                    self.baoHanhLichSuGiaoNhanView.tableView.reloadData()
                    
                    
                    var mSumSLGiao:Int = 0
                    var mSumSLNhan:Int = 0
                    var mSumDistance:Double = 0.0
                    for i in 0 ..< result.count
                    {
                        let mVarible = round(Double("\(result[i].DoDai)")! * 100) / 100
                        mSumDistance = mSumDistance + mVarible
                        mSumSLGiao = mSumSLGiao + (Int(result[i].SLGiao))!
                        mSumSLNhan = mSumSLNhan + (Int(result[i].SLNhan))!
                        print("mVarible \(mVarible) \(mSumDistance)")
                        
                    }
                    print("sadsadsadsadas \(mSumDistance)")
                    let fullString : String = "\(mSumDistance)"
                    let fullStringArr : [String] = fullString.components(separatedBy: ".")
                    let firstString : String = fullStringArr[0]
                    let lastString : String = fullStringArr[1]
                    let result = String(lastString.prefix(1))
                    self.baoHanhLichSuGiaoNhanView.lbViewBot3.text = "\(firstString).\(result)"
                    self.baoHanhLichSuGiaoNhanView.lbViewBot2.text = "\(mSumSLGiao)"
                    self.baoHanhLichSuGiaoNhanView.lbViewBot5.text = "\(mSumSLNhan)"
                    
                }
                else
                {
                    self.arrLichSuGiaoNhan.removeAll()
                    self.baoHanhLichSuGiaoNhanView.tableView.reloadData()
                }
                
            }
            else
            {
                 self.baoHanhLichSuGiaoNhanView.loadingView.stopAnimating()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let mObject:GiaoNhan_LichSuGiaoNhan = arrLichSuGiaoNhan[indexPath.row]
        let newViewController = BaoHanhChiTietLichSuController()
        newViewController.pMaCheckin = mObject.MaCheckIn
        newViewController.pLoaiDiemDen = mObject.LoaiDiemDen
        newViewController.pNote = mObject.Note
        newViewController.pDiemBatDau = mObject.DiemBatDau
        newViewController.pTenDiemDen = mObject.TenDiemDen
        newViewController.pTenDiemBatDau = mObject.TenDiemBatDau
        newViewController.pAction = mObject.U_Action
        newViewController.pSLNhan = mObject.SLNhan
        newViewController.pSLGiao = mObject.SLGiao
        newViewController.pThoiGian = mObject.TimeCheckIn
        newViewController.pDoDai = mObject.DoDai
        newViewController.pLinkChuKi = mObject.LinkHinhAnhChuKy
        newViewController.pLinkHinhAnh = mObject.LinkHinhAnhXacNhan
        newViewController.mUserCode_XN = mObject.UserCode_XN
        newViewController.pLinkChuKiGiaoNhan = mObject.LinkHinhAnhChuKyGiaoNhan
       
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    
    
    
}

