//
//  KhaiBaoViewController.swift
//  fptshop
//
//  Created by Apple on 5/30/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class KhaiBaoViewController: UIViewController {
    
    var doiTuongKhaiBaoView: UIView!
    var nhomHangMucView: UIView!
    var hangMucKhaiBaoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "KHAI BÁO"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        //--
        doiTuongKhaiBaoView = UIView(frame: CGRect(x: Common.Size(s: 20), y: Common.Size(s: 30), width: self.view.frame.width - Common.Size(s: 40), height: Common.Size(s: 50)))
        doiTuongKhaiBaoView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        doiTuongKhaiBaoView.layer.cornerRadius = 10
        self.view.addSubview(doiTuongKhaiBaoView)
        
        let tapKhaiBaoDoiTuong = UITapGestureRecognizer(target: self, action: #selector(khaiBaoDoiTuong))
        doiTuongKhaiBaoView.isUserInteractionEnabled = true
        doiTuongKhaiBaoView.addGestureRecognizer(tapKhaiBaoDoiTuong)
        
        let img1 = UIImageView(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 10), width: Common.Size(s: 30), height: Common.Size(s: 30)))
        img1.image = #imageLiteral(resourceName: "doituong")
        doiTuongKhaiBaoView.addSubview(img1)
        
        let lbView1Text = UILabel(frame: CGRect(x: img1.frame.origin.x + img1.frame.width + Common.Size(s: 10), y: 0, width: doiTuongKhaiBaoView.frame.width - img1.frame.width - Common.Size(s: 20), height: doiTuongKhaiBaoView.frame.height))
        lbView1Text.text = "Khai báo đối tượng được chấm điểm"
        lbView1Text.font = UIFont.systemFont(ofSize: 14)
        doiTuongKhaiBaoView.addSubview(lbView1Text)
        
        //--
        nhomHangMucView = UIView(frame: CGRect(x: Common.Size(s: 20), y: doiTuongKhaiBaoView.frame.origin.y + doiTuongKhaiBaoView.frame.height + Common.Size(s: 10), width: doiTuongKhaiBaoView.frame.width, height: doiTuongKhaiBaoView.frame.height))
        nhomHangMucView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        nhomHangMucView.layer.cornerRadius = 10
        self.view.addSubview(nhomHangMucView)
        
        let tapShowNhomHangMuc = UITapGestureRecognizer(target: self, action: #selector(showDanhSachHangMuc))
        nhomHangMucView.isUserInteractionEnabled = true
        nhomHangMucView.addGestureRecognizer(tapShowNhomHangMuc)
        
        let img2 = UIImageView(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 10), width: Common.Size(s: 30), height: Common.Size(s: 30)))
        img2.image = #imageLiteral(resourceName: "nhomhangmuc")
        nhomHangMucView.addSubview(img2)
        
        let lbView2Text = UILabel(frame: CGRect(x: lbView1Text.frame.origin.x, y: 0, width: lbView1Text.frame.width, height: lbView1Text.frame.height))
        lbView2Text.text = "Nhóm hạng mục được chấm điểm"
        lbView2Text.font = UIFont.systemFont(ofSize: 14)
        nhomHangMucView.addSubview(lbView2Text)
        
        //--
        hangMucKhaiBaoView = UIView(frame: CGRect(x: Common.Size(s: 20), y: nhomHangMucView.frame.origin.y + nhomHangMucView.frame.height + Common.Size(s: 10), width: doiTuongKhaiBaoView.frame.width, height: doiTuongKhaiBaoView.frame.height))
        hangMucKhaiBaoView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        hangMucKhaiBaoView.layer.cornerRadius = 10
        self.view.addSubview(hangMucKhaiBaoView)
        
        let tapKhaiBaoHangMuc = UITapGestureRecognizer(target: self, action: #selector(khaiBaoHangMuc))
        hangMucKhaiBaoView.isUserInteractionEnabled = true
        hangMucKhaiBaoView.addGestureRecognizer(tapKhaiBaoHangMuc)
        
        let img3 = UIImageView(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 10), width: Common.Size(s: 30), height: Common.Size(s: 30)))
        img3.image = #imageLiteral(resourceName: "hangmuc")
        hangMucKhaiBaoView.addSubview(img3)
        
        let lbView3Text = UILabel(frame: CGRect(x: lbView1Text.frame.origin.x, y: 0, width: lbView1Text.frame.width, height: lbView1Text.frame.height))
        lbView3Text.text = "Khai báo hạng mục được chấm điểm"
        lbView3Text.font = UIFont.systemFont(ofSize: 13)
        hangMucKhaiBaoView.addSubview(lbView3Text)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func khaiBaoDoiTuong(){
        debugPrint("khaiBaoDoiTuong")
        let newViewController = ListDoiTuongCDViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func showDanhSachHangMuc(){
        debugPrint("showDanhSachHangMuc")
        let newViewController = ListNhomHangMucViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    @objc func khaiBaoHangMuc(){
        debugPrint("KhaiBaoHangMuc")
        let newViewController = ListHangMucViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
