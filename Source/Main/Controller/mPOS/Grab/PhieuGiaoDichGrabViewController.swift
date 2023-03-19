//
//  PhieuGiaoDichGrabViewController.swift
//  fptshop
//
//  Created by tan on 5/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class PhieuGiaoDichGrabViewController: UIViewController {
    var scrollView:UIScrollView!
    var lbTitleSDT:UILabel!
    var lbTitleTenKH:UILabel!
  
    var lbTitleNgayGiaoDich:UILabel!
    var lbTitleSoMPOS:UILabel!
    var lbTitleSoPhieu:UILabel!
    var lbTitleTongTienCanThu:UILabel!
    var lbTitleNoiDung:UILabel!
    var btInphieu:UIButton!
    var lbTitleThanhCong:UILabel!
    var lblNguoiGiaoDich:UILabel!
    var lblMaFRT:UILabel!
    var lblMaGiaoDichPY:UILabel!
    var lblTinhTrang:UILabel!
    var lblTongTien:UILabel!
    var lblHinhThucTT:UILabel!
    var lblCuaHang:UILabel!
    var lblBienSoXe:UILabel!
    
    var phone:String?
    var tenKH:String?
    var mafrt:String?
    var ngaygiaodich:String = ""
    var soMpos:String?
    var soPhieu:String?
    var tongtien:String?
    var note:String?
    var maGiaoDich:String?
    var Status:String?
    var DocType:String?
    var tinhtrang:String?
    var mapayoo:String?
    
    var soPhieuThu:String?
    var maKH:String?
    var tongtiencuoc:String?
    var biensoxe:String?
    var tongtienphi:String?
    var tongtienthanhtoan:String?
    var hinhthuctt:String?
    
    var btPending:UIButton!
    var fee:Float?
    var nv:String?
    var isNapTien:Bool?
    var maVoucher:String?
    var hanSuDung:String?
    
    override func viewDidLoad() {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Lịch sử giao dịch"
        
        lbTitleThanhCong = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTitleThanhCong.textAlignment = .center
        lbTitleThanhCong.textColor = UIColor(netHex:0x47B054)
        lbTitleThanhCong.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbTitleThanhCong.text = "THÀNH CÔNG"
        scrollView.addSubview(lbTitleThanhCong)
        
        let lblTenDV =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTitleThanhCong.frame.origin.y + lbTitleThanhCong.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTenDV.textAlignment = .left
        lblTenDV.textColor = UIColor.black
        lblTenDV.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTenDV.text = "Tên Dịch Vụ : Nạp tiền tài xế Grab"
        scrollView.addSubview(lblTenDV)
        
        
        lbTitleSDT =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lblTenDV.frame.origin.y + lblTenDV.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleSDT.textAlignment = .left
        lbTitleSDT.textColor = UIColor.black
        lbTitleSDT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleSDT.text = "Số điện thoại : \(phone!)"
        scrollView.addSubview(lbTitleSDT)
        
        
        lbTitleTenKH =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTitleSDT.frame.origin.y + lbTitleSDT.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleTenKH.textAlignment = .left
        lbTitleTenKH.textColor = UIColor.black
        lbTitleTenKH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleTenKH.text = "Tên Khách Hàng: \(tenKH!)"
        scrollView.addSubview(lbTitleTenKH)
        
        
        lblBienSoXe =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTitleTenKH.frame.origin.y + lbTitleTenKH.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBienSoXe.textAlignment = .left
        lblBienSoXe.textColor = UIColor.black
        lblBienSoXe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBienSoXe.text = " Biển số xe: \(self.biensoxe!)"
        scrollView.addSubview(lblBienSoXe)

        
        lbTitleNgayGiaoDich =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lblBienSoXe.frame.origin.y + lblBienSoXe.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleNgayGiaoDich.textAlignment = .left
        lbTitleNgayGiaoDich.textColor = UIColor.black
        lbTitleNgayGiaoDich.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleNgayGiaoDich.text = "ngay Giao dich"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        lbTitleNgayGiaoDich.text  = "Ngày giao dịch: \(result)"
        scrollView.addSubview(lbTitleNgayGiaoDich)
        
        lblNguoiGiaoDich =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTitleNgayGiaoDich.frame.origin.y + lbTitleNgayGiaoDich.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNguoiGiaoDich.textAlignment = .left
        lblNguoiGiaoDich.textColor = UIColor.black
        lblNguoiGiaoDich.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNguoiGiaoDich.text = "Người giao dịch: \(Cache.user!.EmployeeName)"
        scrollView.addSubview(lblNguoiGiaoDich)
        
        lblCuaHang =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lblNguoiGiaoDich.frame.origin.y + lblNguoiGiaoDich.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCuaHang.textAlignment = .left
        lblCuaHang.textColor = UIColor.black
        lblCuaHang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCuaHang.text = "Cửa hàng: \(Cache.user!.ShopName)"
        scrollView.addSubview(lblCuaHang)
        
        lbTitleSoMPOS =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lblCuaHang.frame.origin.y + lblCuaHang.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleSoMPOS.textAlignment = .left
        lbTitleSoMPOS.textColor = UIColor.black
        lbTitleSoMPOS.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleSoMPOS.text = "Số MPOS: \(soMpos!)"
        scrollView.addSubview(lbTitleSoMPOS)
        
        lbTitleSoPhieu =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTitleSoMPOS.frame.origin.y + lbTitleSoMPOS.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleSoPhieu.textAlignment = .left
        lbTitleSoPhieu.textColor = UIColor.black
        lbTitleSoPhieu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleSoPhieu.text = "Số Hợp Đồng: \(soPhieu!)"
        scrollView.addSubview(lbTitleSoPhieu)
        
        lblMaFRT =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTitleSoPhieu.frame.origin.y + lbTitleSoPhieu.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMaFRT.textAlignment = .left
        lblMaFRT.textColor = UIColor.black
        lblMaFRT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMaFRT.text = "Mã GD FRT: \(mafrt!)"
        scrollView.addSubview(lblMaFRT)
        
        lblMaGiaoDichPY =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lblMaFRT.frame.origin.y + lblMaFRT.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMaGiaoDichPY.textAlignment = .left
        lblMaGiaoDichPY.textColor = UIColor.black
        lblMaGiaoDichPY.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMaGiaoDichPY.text = "Mã GD Payoo: \(mapayoo!)"
        scrollView.addSubview(lblMaGiaoDichPY)
        
        lblTinhTrang =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lblMaGiaoDichPY.frame.origin.y + lblMaGiaoDichPY.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTinhTrang.textAlignment = .left
        lblTinhTrang.textColor = UIColor.black
        lblTinhTrang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTinhTrang.text = "Tình Trạng: \(tinhtrang!)"
        scrollView.addSubview(lblTinhTrang)
        
        
        lblTongTien =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lblTinhTrang.frame.origin.y + lblTinhTrang.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTongTien.textAlignment = .left
        lblTongTien.textColor = UIColor.black
        lblTongTien.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTongTien.text = "Tổng Tiền: \(tongtien!)"
        scrollView.addSubview(lblTongTien)
        

        lblHinhThucTT =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lblTongTien.frame.origin.y + lblTongTien.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblHinhThucTT.textAlignment = .left
        lblHinhThucTT.textColor = UIColor.black
        lblHinhThucTT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblHinhThucTT.text = "Hình thức thanh toán: \(hinhthuctt!)"
        scrollView.addSubview(lblHinhThucTT)
        
        let lbTitleIn =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lblHinhThucTT.frame.origin.y + lblHinhThucTT.frame.size.height + Common.Size(s: 20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleIn.textAlignment = .center
        lbTitleIn.textColor = UIColor.red
        lbTitleIn.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleIn.text = "(Chỉ in phiếu khi cần thiết)"
        scrollView.addSubview(lbTitleIn)
        
        btInphieu = UIButton()
        btInphieu.frame = CGRect(x: lbTitleIn.frame.origin.x, y: lbTitleIn.frame.origin.y + lbTitleIn.frame.size.height + Common.Size(s:5), width:  scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s: 40))
        btInphieu.backgroundColor = UIColor(netHex:0x00955E)
        btInphieu.setTitle("In phiếu", for: .normal)
        btInphieu.addTarget(self, action: #selector(actionInBill), for: .touchUpInside)
        btInphieu.layer.borderWidth = 0.5
        btInphieu.layer.borderColor = UIColor.white.cgColor
        btInphieu.layer.cornerRadius = 3
        scrollView.addSubview(btInphieu)
        btInphieu.clipsToBounds = true
        
        if(self.isNapTien! == true){
            self.lbTitleSoPhieu.frame.size.height = 0
            self.lblMaGiaoDichPY.frame.origin.y = lbTitleSoMPOS.frame.origin.y + lbTitleSoMPOS.frame.size.height + Common.Size(s: 5)
            self.lblMaFRT.frame.size.height = 0
            self.lblTinhTrang.frame.size.height = 0
            self.lblTongTien.frame.origin.y = lblMaGiaoDichPY.frame.origin.y + lblMaGiaoDichPY.frame.size.height + Common.Size(s: 5)
            self.lblHinhThucTT.frame.origin.y = lblTongTien.frame.origin.y + lblTongTien.frame.size.height + Common.Size(s: 5)
            lbTitleIn.frame.origin.y = lblHinhThucTT.frame.origin.y + lblHinhThucTT.frame.size.height + Common.Size(s: 20)
            self.btInphieu.frame.origin.y = lbTitleIn.frame.origin.y + lbTitleIn.frame.size.height + Common.Size(s:5)
            
        }
        

        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btInphieu.frame.origin.y + btInphieu.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 60))
    }
    
    @objc func actionInBill(){
        
        
        let title = "Thông báo"
        let popup = PopupDialog(title: title, message: "Bạn muốn in bill?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
            print("Completed")
        }
        let buttonOne = DefaultButton(title: "In") {
            
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let date = Date()
            let dateString = dateFormatter.string(from: date)
            
            let dateFormatter2 : DateFormatter = DateFormatter()
            dateFormatter2.dateFormat = "MM"
           
            let dateString2 = dateFormatter.string(from: date)
            
            
            let printBillThuHoLC = BillParamGrab(DiaChiShop:Cache.user!.Address
                , SoPhieuThu: "\(self.soPhieu!)"
                , MaGiaoDich: "\(self.soMpos!)"
                , ThoiGianThu: "\(dateString)"
                , DichVu: "Nạp tiền tài khoản"
                , NhaCungCap: "Grab"
                , MaKhachHang: "\(self.maKH!)"
                , TenKhachHang: "\(self.tenKH!)"
                , SoDienThoaiKH: "\(self.phone!)"
                , BIenSoXe: "\(self.biensoxe!)"
                , TongTienCuoc: "\(self.tongtien!)"
                , TongTienPhi: "0"
                , TongTienThanhToan: "\(self.tongtien!)"
                , Createby:  "\(self.nv!)"
                , Thang: dateString2
                , NhanVien: "\(Cache.user!.UserName)"
                , MaVoucher: "\(self.maVoucher!)")
            MPOSAPIManager.pushBillThuHoGrab(printBill: printBillThuHoLC)
            
            let alert = UIAlertController(title: "Thông báo", message: "Đã gửi lệnh in!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
        }
        let buttonTwo = CancelButton(title: "Không"){
            
        }
        popup.addButtons([buttonOne,buttonTwo])
        self.present(popup, animated: true, completion: nil)
        
    }
}
