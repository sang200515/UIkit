//
//  BaoHiemThanhToanThanhCongViewController.swift
//  mPOS
//
//  Created by sumi on 8/2/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
class BaoHiemThanhToanThanhCongViewController: UIViewController {
    
    var thuHoThanhCongView:ThuHoThanhCongView!
    var mSoHopDong:String?
    var mLoaiGD:String?
    var mNCC:String?
    var mSoPos:String?
    var mTenKH:String?
    var mSoDT:String?
    var mTienMat:String?
    var mTienThe:String?
    var mPhiCaThe:String?
    
    var mObjectPrint:BaoHiem_PrintObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Thanh Toán"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        thuHoThanhCongView = ThuHoThanhCongView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(thuHoThanhCongView)

        //thuHoThanhCongView.lbPhiCaThe.text = "Phí cà thẻ: \(mPhiCaThe!)"
        thuHoThanhCongView.lbPhiThuHo.text = "Tiền thẻ thanh toán: \(mTienThe!)"
        thuHoThanhCongView.lbTenKH.text = "Tên khách hàng : \(mTenKH!)"
        thuHoThanhCongView.lbSdtKH.text = "Số điện thoại : \(mSoDT!)"
       // thuHoThanhCongView.lbLoaiGD.text = "Loại giao dịch : \(mLoaiGD!)"
        //thuHoThanhCongView.lbNhaCC.text = "Nhà cung cấp : Công ty bảo hiểm dầu khí (PVI)"
        thuHoThanhCongView.lbMaGD.text = "Số mPos : \(mSoHopDong!)"
        thuHoThanhCongView.lbTienCuoc.text = "Tiền mặt thanh toán : \(mTienMat!)"
        thuHoThanhCongView.lbSoPOS.text = "Số mPOS :\(mSoPos!)"
        thuHoThanhCongView.lbSoPOS.isHidden = true
        thuHoThanhCongView.btnPrint.setTitle("In", for: .normal)
        thuHoThanhCongView.lbTongTien.text = "Tổng tiền phải thanh toán :\(Int(mTienMat!)!+Int(mTienThe!)!)"
        //PrintClick()
        
        thuHoThanhCongView.btnPrint.addTarget(self, action: #selector(self.PrintClick), for: UIControl.Event.touchDown)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    @objc func PrintClick()
    {
        MPOSAPIManager.pushPrintBaoHiem(printBH: mObjectPrint!)

        let alert = UIAlertController(title: "Thông báo", message: "Đã gửi lệnh in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            _ = self.navigationController?.popToRootViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true)
    }
}
