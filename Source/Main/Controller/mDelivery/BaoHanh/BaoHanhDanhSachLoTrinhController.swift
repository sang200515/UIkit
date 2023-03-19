//
//  BaoHanhDanhSachLoTrinhController.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaoHanhDanhSachLoTrinhController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    let datePicker = UIDatePicker()
    var userGlobal: UserDefaults!
    var arrLichSuGiaoNhan = [GiaoNhan_DanhSachLoTrinh]()
    var cellRow: BaoHanhDSLoTrinhTableViewCell?
    var countRow:Int = 0
    var baoHanhDanhSachLoTrinhView:BaoHanhDanhSachLoTrinhView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor  = UIColor.white
        baoHanhDanhSachLoTrinhView = BaoHanhDanhSachLoTrinhView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(baoHanhDanhSachLoTrinhView)
        
        
        baoHanhDanhSachLoTrinhView.tableView.dataSource = self
        baoHanhDanhSachLoTrinhView.tableView.delegate = self
        baoHanhDanhSachLoTrinhView.tableView.register(BaoHanhDSLoTrinhTableViewCell.self, forCellReuseIdentifier: "BaoHanhDSLoTrinhTableViewCell")
        
        
        userGlobal = UserDefaults()
        let userName = Cache.user!.UserName
        let employeeName = Cache.user!.EmployeeName
        baoHanhDanhSachLoTrinhView.txtName.text = "\(userName)-\(employeeName)"
        let employeeShop = Cache.user!.ShopName
        baoHanhDanhSachLoTrinhView.txtShop.text = "\(employeeShop)"
        
        
        
        let mDate = Date()
        let mFormatter = DateFormatter()
        mFormatter.dateFormat = "dd/MM/yyyy"
        let mResult = mFormatter.string(from: mDate)
        baoHanhDanhSachLoTrinhView.valueNgayLoTrinh.text = "\(mResult)"
        
         //self.baoHanhDanhSachLoTrinhView.loadingView.startAnimating()
        
        GetDataDSLoTrinh(p_MaNhanVien: "\(userName)",p_NgayChon: "\(mResult)")
        
        baoHanhDanhSachLoTrinhView.valueNgayLoTrinh.addTarget(self, action: #selector(BaoHanhDanhSachLoTrinhController.PickDateAction), for: UIControl.Event.editingDidBegin)
        
        
        let TapPickDate = UITapGestureRecognizer(target: self, action: #selector(BaoHanhDanhSachLoTrinhController.PickDateAction))
        baoHanhDanhSachLoTrinhView.valueNgayLoTrinh.isUserInteractionEnabled = true
        baoHanhDanhSachLoTrinhView.valueNgayLoTrinh.addGestureRecognizer(TapPickDate)
        
        
    }
    
    @objc func DoneDatePicker()
    {
        print("asdsadsa\(datePicker.date)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        baoHanhDanhSachLoTrinhView.valueNgayLoTrinh.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func CancelDatePicker()
    {
        self.view.endEditing(true)
    }
    
    @objc func PickDateAction()
    {
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
        baoHanhDanhSachLoTrinhView.valueNgayLoTrinh.inputAccessoryView = toolbar
        // add datepicker to textField
        baoHanhDanhSachLoTrinhView.valueNgayLoTrinh.inputView = datePicker
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countRow = arrLichSuGiaoNhan.count
        print("rowwww \(countRow)")
        return countRow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:30) * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellRow = BaoHanhDSLoTrinhTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "BaoHanhDSLoTrinhTableViewCell")
        cellRow?.cellKHGiao.text = "\(indexPath.row + 1)"
        cellRow?.cellTenPhuKien.text = "\(arrLichSuGiaoNhan[indexPath.row].Ten)";
        
        cellRow?.cellSLGiao.text = "\(arrLichSuGiaoNhan[indexPath.row].SLGiao)";
        cellRow?.cellSLNhan.text = "\(arrLichSuGiaoNhan[indexPath.row].SLNhan)";
        
        //var mSubString = arrLichSuGiaoNhan[indexPath.row].LengthOfRoad
        var mDouble = 0.0
        if(arrLichSuGiaoNhan[indexPath.row].LengthOfRoad.count >= 5)
        {

            mDouble = round(Double("\(arrLichSuGiaoNhan[indexPath.row].LengthOfRoad)")! * 100) / 100
              cellRow?.cellSeriNo.text = "\(mDouble)";
        }
        else
        {
            cellRow?.cellSeriNo.text = "\(arrLichSuGiaoNhan[indexPath.row].LengthOfRoad)";
        }
        
        
        
        cellRow?.cellCheckin.text = "\(arrLichSuGiaoNhan[indexPath.row].TimeCheckIn)";
        
        if(arrLichSuGiaoNhan[indexPath.row].IsCheckIn == "1")
        {
            cellRow?.cellKHGiao.backgroundColor = UIColor(netHex:0x8ae4ff)
            cellRow?.cellTenPhuKien.backgroundColor = UIColor(netHex:0x8ae4ff)
            cellRow?.cellSeriNo.backgroundColor = UIColor(netHex:0x8ae4ff)
            cellRow?.cellCheckin.backgroundColor = UIColor(netHex:0x8ae4ff)
            
            cellRow?.cellSLGiao.backgroundColor = UIColor(netHex:0x8ae4ff)
            cellRow?.cellSLNhan.backgroundColor = UIColor(netHex:0x8ae4ff)
        }
        return cellRow!
    }
    
    
    
    func GetDataDSLoTrinh(p_MaNhanVien: String,p_NgayChon: String)
    {
        self.baoHanhDanhSachLoTrinhView.loadingView.startAnimating()
        MDeliveryAPIService.GetDsLoTrinh(p_MaNhanVien: p_MaNhanVien,p_NgayChon: p_NgayChon){ (error: Error? , success: Bool,result: [GiaoNhan_DanhSachLoTrinh]!) in
            if success
            {
                self.baoHanhDanhSachLoTrinhView.loadingView.stopAnimating()
                if(result.count > 0)
                {
                    self.arrLichSuGiaoNhan = result
                    self.baoHanhDanhSachLoTrinhView.tableView.reloadData()
                    
                    var mSumSLGiao:Int = 0
                    var mSumSLNhan:Int = 0
                    var mSumDistance:Double = 0.0
                    for i in 0 ..< result.count
                    {
                        let mVarible = round(Double("\(result[i].LengthOfRoad)")! * 100) / 100
                       
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
                    self.baoHanhDanhSachLoTrinhView.lbViewBot3.text = "\(firstString).\(result)"
                    self.baoHanhDanhSachLoTrinhView.lbViewBot5.text = "\(mSumSLGiao)"
                    self.baoHanhDanhSachLoTrinhView.lbViewBot6.text = "\(mSumSLNhan)"
                }
                else
                {
                    
                }
                
            }
            else
            {
                 self.baoHanhDanhSachLoTrinhView.loadingView.stopAnimating()
            }
        }
    }
    
}


