//
//  ChooseCancelTripiServiceViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 2/19/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol ChooseCancelTripiServiceViewControllerDelegate: AnyObject {
    func getCancelTripiServiceType(type: Int, typeName: String)
}

class ChooseCancelTripiServiceViewController: UIViewController {
    
    weak var delegate: ChooseCancelTripiServiceViewControllerDelegate?
    var detailTribi:DetailFlightTribi?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
        self.view.backgroundColor = UIColor.white
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s: 40)))
        headerView.backgroundColor = UIColor(netHex:0x00955E)
        self.view.addSubview(headerView)
        
        let lbTile = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: headerView.frame.width - Common.Size(s: 30), height: headerView.frame.height))
        lbTile.text = "Chọn 1 trong các hình thức sau"
        lbTile.font = UIFont.boldSystemFont(ofSize: 15)
        lbTile.textAlignment = .center
        lbTile.textColor = UIColor.white
        headerView.addSubview(lbTile)
        
        let btnHuy = UIButton(frame: CGRect(x: Common.Size(s: 10), y: headerView.frame.origin.y + headerView.frame.height + Common.Size(s: 20), width: ((self.view.frame.width - Common.Size(s: 20))/2) - Common.Size(s: 5), height: Common.Size(s: 35)))
        btnHuy.setTitle("Huỷ", for: .normal)
        btnHuy.backgroundColor = UIColor(netHex:0x00955E)
        btnHuy.layer.cornerRadius = 5
        if (self.detailTribi?.inbound.isEmpty)! {
            btnHuy.tag = 1
        } else {//huy 1 chieu ve khu hoi
            btnHuy.tag = 5
        }
        btnHuy.addTarget(self, action: #selector(actionChooseCancel(sender:)), for: .touchUpInside)
        self.view.addSubview(btnHuy)
        
//        let btnDoiChang = UIButton(frame: CGRect(x: btnHuy.frame.origin.x + btnHuy.frame.width + Common.Size(s: 10), y: btnHuy.frame.origin.y, width: btnHuy.frame.width, height: Common.Size(s: 35)))
//        btnDoiChang.setTitle("Đổi chặng", for: .normal)
//        btnDoiChang.backgroundColor = UIColor(netHex:0x00955E)
//        btnDoiChang.layer.cornerRadius = 5
//        btnDoiChang.tag = 2
//        btnDoiChang.addTarget(self, action: #selector(actionChooseCancel(sender:)), for: .touchUpInside)
//        self.view.addSubview(btnDoiChang)
//
//        let btnDoiChuyen = UIButton(frame: CGRect(x: Common.Size(s: 10), y: btnDoiChang.frame.origin.y + btnDoiChang.frame.height + Common.Size(s: 5), width: btnHuy.frame.width, height: Common.Size(s: 35)))
//        btnDoiChuyen.setTitle("Đổi chuyến", for: .normal)
//        btnDoiChuyen.backgroundColor = UIColor(netHex:0x00955E)
//        btnDoiChuyen.layer.cornerRadius = 5
//        btnDoiChuyen.tag = 3
//        btnDoiChuyen.addTarget(self, action: #selector(actionChooseCancel(sender:)), for: .touchUpInside)
//        self.view.addSubview(btnDoiChuyen)
        
        let btnTachVe = UIButton(frame: CGRect(x: btnHuy.frame.origin.x + btnHuy.frame.width + Common.Size(s: 10), y: btnHuy.frame.origin.y, width: btnHuy.frame.width, height: Common.Size(s: 35)))
        btnTachVe.setTitle("Tách vé", for: .normal)
        btnTachVe.backgroundColor = UIColor(netHex:0x00955E)
        btnTachVe.layer.cornerRadius = 5
        btnTachVe.tag = 4
        btnTachVe.addTarget(self, action: #selector(actionChooseCancel(sender:)), for: .touchUpInside)
        self.view.addSubview(btnTachVe)
        
        let btnDVThem = UIButton(frame: CGRect(x: Common.Size(s: 10), y: btnTachVe.frame.origin.y + btnTachVe.frame.height + Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 20), height: Common.Size(s: 35)))
        btnDVThem.setTitle("Dịch vụ thêm", for: .normal)
        btnDVThem.backgroundColor = UIColor(netHex:0x00955E)
        btnDVThem.layer.cornerRadius = 5
        btnDVThem.tag = 6
        btnDVThem.addTarget(self, action: #selector(actionChooseCancel(sender:)), for: .touchUpInside)
        self.view.addSubview(btnDVThem)
        
//        let btnHuy1ChieuVeKhuHoi = UIButton(frame: CGRect(x: Common.Size(s: 10), y: btnDVThem.frame.origin.y + btnDVThem.frame.height + Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 20), height: Common.Size(s: 35)))
//        btnHuy1ChieuVeKhuHoi.setTitle("Huỷ 1 chiều vé khứ hồi", for: .normal)
//        btnHuy1ChieuVeKhuHoi.backgroundColor = UIColor(netHex:0x00955E)
//        btnHuy1ChieuVeKhuHoi.layer.cornerRadius = 5
//        btnHuy1ChieuVeKhuHoi.tag = 6
//        btnHuy1ChieuVeKhuHoi.addTarget(self, action: #selector(actionChooseCancel(sender:)), for: .touchUpInside)
//        self.view.addSubview(btnHuy1ChieuVeKhuHoi)
    }
    
    @objc func actionChooseCancel(sender: UIButton) {
        let btnTag = sender.tag
        let btnName = sender.titleLabel!.text ?? "Huỷ Calllog Tripi"
        debugPrint("btn: \(btnTag)-\(btnName)")
        self.delegate?.getCancelTripiServiceType(type: btnTag, typeName: btnName)
        self.dismiss(animated: true, completion: nil)
    }
}
