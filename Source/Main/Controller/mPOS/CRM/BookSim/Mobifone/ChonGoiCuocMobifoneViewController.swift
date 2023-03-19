//
//  ChonGoiCuocMobifoneViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 11/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ChonGoiCuocMobifoneViewController: UIViewController {
    
    var listGoiCuoc = [MobifoneMsalePackage]()
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var arrViewGoiCuoc = [UIView]()
    var arrImgCheck = [UIImageView]()
    var itemMsaleMobifone: Mobifone_Msale_ActiveSim?
    var selectedGoiCuoc:MobifoneMsalePackage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.8)
        self.view.backgroundColor = UIColor.white
        
        self.setUpView()
    }
    
    func setUpView() {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s: 40)))
        headerView.backgroundColor = UIColor(netHex:0x00955E)
        self.view.addSubview(headerView)
        
        let lbTileHeader = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: headerView.frame.width - Common.Size(s: 30), height: headerView.frame.height))
        lbTileHeader.text = "Chọn gói cước"
        lbTileHeader.font = UIFont.boldSystemFont(ofSize: 15)
        lbTileHeader.textAlignment = .center
        lbTileHeader.textColor = UIColor.white
        headerView.addSubview(lbTileHeader)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: headerView.frame.origin.y + headerView.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let viewTitle = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        viewTitle.backgroundColor = .white
        scrollView.addSubview(viewTitle)
        
        let lbTitle = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 5), width: viewTitle.frame.width - Common.Size(s: 20), height: Common.Size(s: 15)))
        lbTitle.text = "Đã kích hoạt thành công sim chưa có gói cước. Bạn tư vấn khách hàng nạp thẻ theo hướng dẫn bên dưới để sử dụng các ưu đãi và tránh sim bị huỷ nhé:"
        lbTitle.textColor = .red
        lbTitle.font = UIFont.boldSystemFont(ofSize: 13)
        lbTitle.numberOfLines = 0
        viewTitle.addSubview(lbTitle)
        
        lbTitle.frame = CGRect(x: lbTitle.frame.origin.x, y: lbTitle.frame.origin.y, width: lbTitle.frame.width, height: lbTitle.optimalHeight)
        
        let line1 = UIView(frame: CGRect(x: 0, y: lbTitle.frame.origin.y + lbTitle.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: Common.Size(s: 1)))
        line1.backgroundColor = .lightGray
        viewTitle.addSubview(line1)

        let lbOption1 = UILabel(frame: CGRect(x: Common.Size(s: 10), y: line1.frame.origin.y + line1.frame.height + Common.Size(s: 5), width: viewTitle.frame.width - Common.Size(s: 20), height: Common.Size(s: 15)))
        lbOption1.text = "1. Dạ, số này đã được kích hoạt thành công, hiện tại cần nạp thẻ để kích hoạt gói cước, giúp anh/chị sử dụng data và các phút gọi tiết kiệm hơn theo KM của gói 70 (hoặc 90 - hoặc 160)."
        lbOption1.font = UIFont.systemFont(ofSize: 13)
        lbOption1.numberOfLines = 0
        viewTitle.addSubview(lbOption1)
        lbOption1.frame = CGRect(x: lbOption1.frame.origin.x, y: lbOption1.frame.origin.y, width: lbOption1.frame.width, height: lbOption1.optimalHeight)
        
        let lbOption2 = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbOption1.frame.origin.y + lbOption1.frame.height + Common.Size(s: 8), width: viewTitle.frame.width - Common.Size(s: 20), height: Common.Size(s: 15)))
        lbOption2.text = "2. Em nạp tiền và đăng ký gói cước giúp anh/chị luôn nhé. Bên em đang có KM nếu nạp thẻ ngay sau khi mua sim thì sẽ được giảm 4%, thay vì chỉ 2% so với mua lẻ ạ."
        lbOption2.font = UIFont.systemFont(ofSize: 13)
        lbOption2.numberOfLines = 0
        viewTitle.addSubview(lbOption2)
        lbOption2.frame = CGRect(x: lbOption2.frame.origin.x, y: lbOption2.frame.origin.y, width: lbOption2.frame.width, height: lbOption2.optimalHeight)
        
        viewTitle.frame = CGRect(x: viewTitle.frame.origin.x, y: viewTitle.frame.origin.y, width: viewTitle.frame.width, height: lbOption2.frame.origin.y + lbOption2.frame.height + Common.Size(s: 8))
        
        let viewChonGoi = UIView(frame: CGRect(x: 0, y: viewTitle.frame.origin.y + viewTitle.frame.height, width: self.view.frame.width, height: Common.Size(s: 15)))
        viewChonGoi.backgroundColor = .white
        scrollView.addSubview(viewChonGoi)
        
        var viewChonGoiHeigh:CGFloat = 0
        
        for i in 0..<listGoiCuoc.count {
            let item = listGoiCuoc[i]
            var view1 = UIView()
            
            if i > 0 {
                view1 = UIView(frame: CGRect(x: Common.Size(s: 15), y: viewChonGoiHeigh, width: scrollView.frame.width - Common.Size(s: 20), height: Common.Size(s: 30)))
            } else {
                view1 = UIView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 3), width: scrollView.frame.width - Common.Size(s: 20), height: Common.Size(s: 30)))
            }
            
            view1.backgroundColor = .white
            viewChonGoi.addSubview(view1)
            
            let imgCheck = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 5), width: Common.Size(s: 20), height: Common.Size(s: 20)))
            imgCheck.image = #imageLiteral(resourceName: "ic_uncheck_circle")
            imgCheck.tag = i + 1
            imgCheck.contentMode = .scaleAspectFill
            view1.addSubview(imgCheck)
            arrImgCheck.append(imgCheck)
            
            let tapChoose = UITapGestureRecognizer(target: self, action: #selector(tapChooseGoiCuoc(sender:)))
            imgCheck.isUserInteractionEnabled = true
            imgCheck.addGestureRecognizer(tapChoose)
            
            let lbGoiCuoc = UILabel(frame: CGRect(x: imgCheck.frame.origin.x + imgCheck.frame.width + Common.Size(s: 10), y: 0, width: view1.frame.width - imgCheck.frame.width - Common.Size(s: 10), height: Common.Size(s: 30)))
            lbGoiCuoc.textColor = .greenSea
            lbGoiCuoc.font = UIFont.boldSystemFont(ofSize: 13)
            lbGoiCuoc.text = "\(item.package_fpt) - \(item.package_name_fpt)"
            view1.addSubview(lbGoiCuoc)
            
            let lbGoiCuocHeight:CGFloat = lbGoiCuoc.optimalHeight < Common.Size(s: 30) ? Common.Size(s: 30) : (lbGoiCuoc.optimalHeight + Common.Size(s: 5))
            lbGoiCuoc.numberOfLines = 0
            lbGoiCuoc.frame = CGRect(x: lbGoiCuoc.frame.origin.x, y: lbGoiCuoc.frame.origin.y, width: lbGoiCuoc.frame.width, height: lbGoiCuocHeight)
            
            let line = UIView(frame: CGRect(x: 0, y: lbGoiCuoc.frame.origin.y + lbGoiCuocHeight + Common.Size(s: 2), width: view1.frame.width, height: Common.Size(s: 0.7)))
            line.backgroundColor = .lightGray
            view1.addSubview(line)
            
            view1.frame = CGRect(x: view1.frame.origin.x, y: view1.frame.origin.y, width: view1.frame.width, height: line.frame.origin.y + line.frame.height)
            arrViewGoiCuoc.append(view1)
            
            viewChonGoiHeigh = view1.frame.origin.y + view1.frame.height
        }
        viewChonGoi.frame = CGRect(x: viewChonGoi.frame.origin.x, y: viewChonGoi.frame.origin.y, width: viewChonGoi.frame.width, height: viewChonGoiHeigh)
        
        let lbNote = UILabel(frame: CGRect(x: Common.Size(s: 10), y: viewChonGoi.frame.origin.y + viewChonGoi.frame.height + Common.Size(s: 8), width: scrollView.frame.width - Common.Size(s: 20), height: Common.Size(s: 15)))
        lbNote.text = "Lưu ý: Anh/chị cần tư vấn kỹ để khách hàng được hưởng KM giảm 4% thẻ nạp vì khi thoát màn hình mua lẻ sẽ không còn ưu đãi!"
        lbNote.textColor = .red
        lbNote.font = UIFont.boldSystemFont(ofSize: 13)
        lbNote.numberOfLines = 0
        viewTitle.addSubview(lbNote)
        lbNote.frame = CGRect(x: lbNote.frame.origin.x, y: lbNote.frame.origin.y, width: lbNote.frame.width, height: lbNote.optimalHeight)
        
        let btnTopUp = UIButton(frame: CGRect(x: Common.Size(s: 10), y: lbNote.frame.origin.y + lbNote.frame.height + Common.Size(s: 10), width: (scrollView.frame.width - Common.Size(s: 20))/2 - Common.Size(s: 5), height: Common.Size(s: 26)))
        btnTopUp.setTitle("TopUp", for: .normal)
        btnTopUp.setTitleColor(UIColor(netHex:0x00955E), for: .normal)
        btnTopUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        btnTopUp.layer.cornerRadius = 3
        btnTopUp.backgroundColor = .white
        btnTopUp.layer.borderWidth = 2
        btnTopUp.layer.borderColor = UIColor(netHex:0x00955E).cgColor
        btnTopUp.layer.cornerRadius = 13
        btnTopUp.tag = 1
        btnTopUp.addTarget(self, action: #selector(clossPopup), for: .touchUpInside)
        scrollView.addSubview(btnTopUp)
        
        let btnConfirm = UIButton(frame: CGRect(x: btnTopUp.frame.origin.x + btnTopUp.frame.width + Common.Size(s: 10), y: btnTopUp.frame.origin.y, width: (scrollView.frame.width - Common.Size(s: 20))/2 - Common.Size(s: 5), height: Common.Size(s: 26)))
        btnConfirm.setTitle("Không TopUp", for: .normal)
        btnConfirm.setTitleColor(UIColor(netHex:0x00955E), for: .normal)
        btnConfirm.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        btnConfirm.layer.cornerRadius = 3
        btnConfirm.backgroundColor = .white
        btnConfirm.layer.borderWidth = 2
        btnConfirm.layer.borderColor = UIColor(netHex:0x00955E).cgColor
        btnConfirm.layer.cornerRadius = 13
        btnConfirm.tag = 0
        btnConfirm.addTarget(self, action: #selector(clossPopup), for: .touchUpInside)
        scrollView.addSubview(btnConfirm)
        
        scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight + Common.Size(s: 30))
    }
    
    @objc func clossPopup(sender: UIButton) {
        debugPrint("Chọn btn is topup: \(sender.tag)")
        if self.selectedGoiCuoc == nil {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa chọn gói cước!", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            self.dismiss(animated: true, completion: nil)
            let totalSum = (self.itemMsaleMobifone?.sub_number_price ?? 0) + (self.selectedGoiCuoc?.package_price ?? 0)
            let dictionaryPackage = ["totalSumNew": totalSum,
                                     "itemMobifoneID": self.itemMsaleMobifone?.id ?? 0,
                                     "package_price": self.selectedGoiCuoc?.package_price ?? 0,
                                     "package_fpt": self.selectedGoiCuoc?.package_fpt ?? "",
                                     "package_name_fpt": self.selectedGoiCuoc?.package_name_fpt ?? "",
                                     "package_code": self.selectedGoiCuoc?.package_code ?? "",
                                     "price_topup": self.selectedGoiCuoc?.price_topup ?? 0,
                                     "is_topup": sender.tag // btn.tag = 0 : (không topup), btn.tag = 1 : (topup)
                                     
            ] as [String : Any]
            NotificationCenter.default.post(name: NSNotification.Name.init("didChoosePackageMsaleMobifone"), object: nil, userInfo: dictionaryPackage)
        }
        
    }
    
    @objc func tapChooseGoiCuoc(sender: UIGestureRecognizer) {
        let view = sender.view ?? UIView()
        for i in 0..<arrImgCheck.count {
            if i == (view.tag - 1) {
                arrImgCheck[i].image = #imageLiteral(resourceName: "ic_checked_circle")
                self.selectedGoiCuoc = self.listGoiCuoc[i]
            } else {
                arrImgCheck[i].image = #imageLiteral(resourceName: "ic_uncheck_circle")
            }
        }
    }
}
