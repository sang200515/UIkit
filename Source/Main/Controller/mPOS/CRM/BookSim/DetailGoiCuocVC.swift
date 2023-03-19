//
//  DetailGoiCuocVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 11/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailGoiCuocVC: UIViewController {
    
    @IBOutlet weak var lblData:UILabel!
    @IBOutlet weak var lblGoi:UILabel!
    @IBOutlet weak var lblThoiGianKM:UILabel!
    @IBOutlet weak var lblChuKy:UILabel!
    @IBOutlet weak var lblPhiGoi:UILabel!
    @IBOutlet weak var lblCuPhap:UILabel!
    @IBOutlet weak var lblKhac:UILabel!

    var goiCuocEcom:GoiCuocEcom?
    var telecom:ProviderName?
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.title = "\(self.goiCuocEcom?.Name ?? "")"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        lblData.text = "Data: \(self.goiCuocEcom?.Data ?? "")"
        lblGoi.text = "Gọi: \(self.goiCuocEcom?.pCall ?? "")"
        lblThoiGianKM.text = "Thời gian khuyến mãi: \(self.goiCuocEcom?.PromotionTime ?? "")"
        lblChuKy.text = "Chu kỳ (tháng): \(self.goiCuocEcom?.PeriodPromotion ?? "")"
        
        lblPhiGoi.text = "Phí gói: \(self.goiCuocEcom?.FeePack ?? "")"
        lblCuPhap.text = "Cú pháp: \(self.goiCuocEcom?.SysTax ?? "")"
        lblKhac.text = "\(self.goiCuocEcom?.Note ?? "")"
    }
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionBookSim(){
        let newViewController = ChonSoV2ViewController()
        let goiCuoc:GoiCuocBookSimV2 = GoiCuocBookSimV2(MaSP:"",TenSP:"",GiaCuoc:0,DanhDauSS:false,isRule:false,tenKH:"")
        goiCuoc.TenSP = self.goiCuocEcom?.Name  ?? ""
        goiCuoc.GiaCuoc = self.goiCuocEcom?.Price ?? 0
        goiCuoc.MaSP = self.goiCuocEcom?.Code ?? ""
        
        
        newViewController.telecom = self.telecom
        newViewController.goiCuoc = goiCuoc
        newViewController.itemGoiCuocEcom = goiCuocEcom
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    


}
