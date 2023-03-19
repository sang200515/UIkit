//
//  ResultCheckSubsidyViewController.swift
//  mPOS
//
//  Created by MinhDH on 4/6/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ResultCheckSubsidyViewController: UIViewController,UITextFieldDelegate{
    var scrollView:UIScrollView!
    var tfCMND:UITextField!
    var tfStatus:UITextField!
    var buttonSaveAction:Bool = false
    var infoSubsidy:InfoSubsidy!
    var token:String?
    override func viewDidLoad() {
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(CheckInfoSubsidyViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "KT FNOX"
        navigationController?.navigationBar.isTranslucent = false
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")
        
        let soViewSubsidy = UIView()
        soViewSubsidy.clipsToBounds = true
        scrollView.addSubview(soViewSubsidy)
        soViewSubsidy.frame = CGRect(x: Common.Size(s:15), y: Common.Size(s:15), width: UIScreen.main.bounds.size.width - Common.Size(s:30), height: 100)
        
        let lbInfoSubsidy = UILabel(frame: CGRect(x: 0, y: 0, width: soViewSubsidy.frame.size.width, height: Common.Size(s:20)))
        lbInfoSubsidy.textAlignment = .left
        lbInfoSubsidy.textColor = UIColor(netHex:0x47B054)
        lbInfoSubsidy.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbInfoSubsidy.text = "THÔNG TIN SUBSIDY"
        soViewSubsidy.addSubview(lbInfoSubsidy)
        
        let line1 = UIView(frame: CGRect(x: soViewSubsidy.frame.size.width * 1.3/10, y: lbInfoSubsidy.frame.origin.y + lbInfoSubsidy.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        soViewSubsidy.addSubview(line1)
        let line2 = UIView(frame: CGRect(x: 0, y:line1.frame.origin.y + line1.frame.size.height, width: soViewSubsidy.frame.size.width, height: 1))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        soViewSubsidy.addSubview(line2)
        
        let lbStt = UILabel(frame: CGRect(x: 0, y: line1.frame.origin.y, width: line1.frame.origin.x, height: line1.frame.size.height))
        lbStt.textAlignment = .center
        lbStt.textColor = UIColor(netHex:0x47B054)
        lbStt.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbStt.text = "STT"
        soViewSubsidy.addSubview(lbStt)
        
        let lbInfo = UILabel(frame: CGRect(x: line1.frame.origin.x, y: line1.frame.origin.y, width: lbInfoSubsidy.frame.size.width - line1.frame.origin.x, height: line1.frame.size.height))
        lbInfo.textAlignment = .center
        lbInfo.textColor = UIColor(netHex:0x47B054)
        lbInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfo.text = "Thông tin"
        soViewSubsidy.addSubview(lbInfo)
        
        var indexY = line2.frame.origin.y
        var indexHeight: CGFloat = line2.frame.origin.y + line2.frame.size.height
        
        var num = 0
        for item in infoSubsidy.listThongTinSubsidy{
            num = num + 1
            let soViewLine = UIView()
            soViewSubsidy.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexY, width: soViewSubsidy.frame.size.width, height: 50)
            let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line3)
            
            let nameProduct = "CMND: \(item.CMND)"
            let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewSubsidy.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 3, width: soViewSubsidy.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
            soViewLine.addSubview(lbNameProduct)
            
            let nameKH = "\(item.TenKH)"
            let sizeNameKH = nameKH.height(withConstrainedWidth: soViewSubsidy.frame.size.width - line3.frame.origin.x, font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            let lbNameKH = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: soViewSubsidy.frame.size.width - line3.frame.origin.x, height: sizeNameKH))
            lbNameKH.textAlignment = .left
            lbNameKH.textColor = UIColor.black
            lbNameKH.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbNameKH.text = nameKH
            lbNameKH.numberOfLines = 3
            soViewLine.addSubview(lbNameKH)
            
            let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewSubsidy.frame.size.width - line3.frame.origin.x - 1, height: 1))
            line4.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line4)
            
            let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameKH.frame.origin.y + lbNameKH.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:15)))
            lbQuantityProduct.textAlignment = .left
            lbQuantityProduct.textColor = UIColor.black
            lbQuantityProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbQuantityProduct.text = "SĐT: \((item.SDT))"
            soViewLine.addSubview(lbQuantityProduct)
            
            let lbPriceProduct = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height: Common.Size(s:16)))
            lbPriceProduct.textAlignment = .left
            lbPriceProduct.textColor = UIColor.black
            lbPriceProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbPriceProduct.text = "Ngày KH: \(item.NgayKichHoat)"
            lbPriceProduct.numberOfLines = 1
            soViewLine.addSubview(lbPriceProduct)
            
            let lbStatus = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height: Common.Size(s:15)))
            lbStatus.textAlignment = .left
            lbStatus.textColor = UIColor(netHex:0xEF4A40)
            lbStatus.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbStatus.text = "TT: \(item.TTCaifKnox)"
            lbStatus.numberOfLines = 1
            soViewLine.addSubview(lbStatus)
            
            let price = NSDecimalNumber(string: "\(String(format:"%.6f", item.TongNo))") as NSNumber
            
            let lbSum = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbStatus.frame.origin.y + lbStatus.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height: Common.Size(s:18)))
            lbSum.textAlignment = .left
            lbSum.textColor = UIColor(netHex:0xEF4A40)
            lbSum.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbSum.text = "Tổng nợ: \(formatter.string(from: price)!) đ"
            lbSum.numberOfLines = 1
            soViewLine.addSubview(lbSum)
            
            
            let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
            lbSttValue.textAlignment = .center
            lbSttValue.textColor = UIColor.black
            lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbSttValue.text = "\(num)"
            soViewLine.addSubview(lbSttValue)
            
            soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbSum.frame.origin.y + lbSum.frame.size.height + Common.Size(s:5))
            line3.frame.size.height = soViewLine.frame.size.height
            
            indexHeight = indexHeight + soViewLine.frame.size.height
            indexY = indexY + soViewLine.frame.size.height + soViewLine.frame.origin.x
            
        }
        
        soViewSubsidy.frame.size.height = indexHeight
        
        if(infoSubsidy.listThongTinSubsidy.count == 0){
            soViewSubsidy.frame.origin.y = 0
            soViewSubsidy.frame.size.height = 0
        }
        
        let soViewLogRequest = UIView()
        soViewLogRequest.clipsToBounds = true
        scrollView.addSubview(soViewLogRequest)
        soViewLogRequest.frame = CGRect(x: Common.Size(s:15), y: soViewSubsidy.frame.size.height + soViewSubsidy.frame.origin.y + Common.Size(s:15), width: UIScreen.main.bounds.size.width - Common.Size(s:30), height: 100)
        
        let lbLogRequest = UILabel(frame: CGRect(x: 0, y: 0, width: soViewLogRequest.frame.size.width, height: Common.Size(s:20)))
        lbLogRequest.textAlignment = .left
        lbLogRequest.textColor = UIColor(netHex:0x47B054)
        lbLogRequest.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbLogRequest.text = "THÔNG TIN FKNOX"
        soViewLogRequest.addSubview(lbLogRequest)
        
        let line11 = UIView(frame: CGRect(x: soViewLogRequest.frame.size.width * 1.3/10, y: lbLogRequest.frame.origin.y + lbLogRequest.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
        line11.backgroundColor = UIColor(netHex:0x47B054)
        soViewLogRequest.addSubview(line11)
        let line22 = UIView(frame: CGRect(x: 0, y:line11.frame.origin.y + line11.frame.size.height, width: soViewLogRequest.frame.size.width, height: 1))
        line22.backgroundColor = UIColor(netHex:0x47B054)
        soViewLogRequest.addSubview(line22)
        
        let lbStt2 = UILabel(frame: CGRect(x: 0, y: line11.frame.origin.y, width: line11.frame.origin.x, height: line11.frame.size.height))
        lbStt2.textAlignment = .center
        lbStt2.textColor = UIColor(netHex:0x47B054)
        lbStt2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbStt2.text = "STT"
        soViewLogRequest.addSubview(lbStt2)
        
        let lbInfo2 = UILabel(frame: CGRect(x: line11.frame.origin.x, y: line11.frame.origin.y, width: lbLogRequest.frame.size.width - line11.frame.origin.x, height: line11.frame.size.height))
        lbInfo2.textAlignment = .center
        lbInfo2.textColor = UIColor(netHex:0x47B054)
        lbInfo2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfo2.text = "Thông tin"
        soViewLogRequest.addSubview(lbInfo2)
        
        var indexY2 = line22.frame.origin.y
        var indexHeight2: CGFloat = line22.frame.origin.y + line22.frame.size.height
        var num2 = 0
        
        for item in infoSubsidy.listLogRequestImei{
            num2 = num2 + 1
            let soViewLine = UIView()
            soViewLogRequest.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexY2, width: soViewLogRequest.frame.size.width, height: 50)
            let line3 = UIView(frame: CGRect(x: line11.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line3)
            
            let nameProduct = "IMEI: \(item.Imei)"
            let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewLogRequest.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 3, width: soViewLogRequest.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
            soViewLine.addSubview(lbNameProduct)
            
            let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewLogRequest.frame.size.width - line3.frame.origin.x - 1, height: 1))
            line4.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line4)
            
            let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:15)))
            lbQuantityProduct.textAlignment = .left
            lbQuantityProduct.textColor = UIColor.black
            lbQuantityProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbQuantityProduct.text = "TG: \((item.LanCuoigoiServer))"
            soViewLine.addSubview(lbQuantityProduct)
            
            let lbPriceProduct = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height: Common.Size(s:16)))
            lbPriceProduct.textAlignment = .left
            lbPriceProduct.textColor = UIColor(netHex:0xEF4A40)
            lbPriceProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbPriceProduct.text = "TT: \(item.TTFKnox)"
            lbPriceProduct.numberOfLines = 1
            soViewLine.addSubview(lbPriceProduct)
            
            let lbStatus = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height: Common.Size(s:15)))
            lbStatus.textAlignment = .left
            lbStatus.textColor = UIColor.black
            lbStatus.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbStatus.text = "Passcode: \(item.passcode)"
            lbStatus.numberOfLines = 1
            //
            if(item.passcode == "" && item.tokenapi != ""){
                lbStatus.text = "Passcode: Bấm vào để lấy Passcode"
                lbStatus.textColor = UIColor.blue
                print(item.tokenapi)
                self.token = item.tokenapi
            }
            let tapCheckPasscode = UITapGestureRecognizer(target: self, action: #selector(checkPassCode))
            lbStatus.isUserInteractionEnabled = true
            lbStatus.addGestureRecognizer(tapCheckPasscode)
            
            soViewLine.addSubview(lbStatus)
            
            
            let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
            lbSttValue.textAlignment = .center
            lbSttValue.textColor = UIColor.black
            lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbSttValue.text = "\(num2)"
            soViewLine.addSubview(lbSttValue)
            
            soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbStatus.frame.origin.y + lbStatus.frame.size.height + Common.Size(s:5))
            line3.frame.size.height = soViewLine.frame.size.height
            
            indexHeight2 = indexHeight2 + soViewLine.frame.size.height
            indexY2 = indexY2 + soViewLine.frame.size.height + soViewLine.frame.origin.x
            
        }
        soViewLogRequest.frame.size.height = indexHeight2
        if(infoSubsidy.listLogRequestImei.count == 0){
            soViewLogRequest.frame.origin.y = soViewSubsidy.frame.size.height + soViewSubsidy.frame.origin.y
            soViewLogRequest.frame.size.height = 0
        }
        let soViewCongNo = UIView()
        soViewCongNo.clipsToBounds = true
        scrollView.addSubview(soViewCongNo)
        soViewCongNo.frame = CGRect(x: Common.Size(s:15), y: soViewLogRequest.frame.size.height + soViewLogRequest.frame.origin.y + Common.Size(s:15), width: UIScreen.main.bounds.size.width - Common.Size(s:30), height: 100)
        
        let lbCongNo = UILabel(frame: CGRect(x: 0, y: 0, width: soViewCongNo.frame.size.width, height: Common.Size(s:20)))
        lbCongNo.textAlignment = .left
        lbCongNo.textColor = UIColor(netHex:0x47B054)
        lbCongNo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbCongNo.text = "THÔNG TIN CÔNG NỢ"
        soViewCongNo.addSubview(lbCongNo)
        
        let line111 = UIView(frame: CGRect(x: soViewCongNo.frame.size.width * 1.3/10, y: lbCongNo.frame.origin.y + lbCongNo.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
        line111.backgroundColor = UIColor(netHex:0x47B054)
        soViewCongNo.addSubview(line111)
        let line222 = UIView(frame: CGRect(x: 0, y:line111.frame.origin.y + line111.frame.size.height, width: soViewCongNo.frame.size.width, height: 1))
        line222.backgroundColor = UIColor(netHex:0x47B054)
        soViewCongNo.addSubview(line222)
        
        let lbStt3 = UILabel(frame: CGRect(x: 0, y: line111.frame.origin.y, width: line111.frame.origin.x, height: line111.frame.size.height))
        lbStt3.textAlignment = .center
        lbStt3.textColor = UIColor(netHex:0x47B054)
        lbStt3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbStt3.text = "STT"
        soViewCongNo.addSubview(lbStt3)
        
        let lbInfo3 = UILabel(frame: CGRect(x: line111.frame.origin.x, y: line111.frame.origin.y, width: lbCongNo.frame.size.width - line11.frame.origin.x, height: line111.frame.size.height))
        lbInfo3.textAlignment = .center
        lbInfo3.textColor = UIColor(netHex:0x47B054)
        lbInfo3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfo3.text = "Thông tin"
        soViewCongNo.addSubview(lbInfo3)
        
        var indexY3 = line222.frame.origin.y
        var indexHeight3: CGFloat = line222.frame.origin.y + line222.frame.size.height
        var num3 = 0
        
        
        
        
        
        for item in infoSubsidy.listThongTinCongNo{
            num3 = num3 + 1
            let soViewLine = UIView()
            soViewCongNo.addSubview(soViewLine)
            soViewLine.frame = CGRect(x: 0, y: indexY3, width: soViewCongNo.frame.size.width, height: 50)
            let line3 = UIView(frame: CGRect(x: line111.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
            line3.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line3)
            
            let price = NSDecimalNumber(string: "\(String(format:"%.6f", item.DNSoTienKyHan))") as NSNumber
            let nameProduct = "Tiền: \(formatter.string(from: price)!) đ"
            let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewCongNo.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 3, width: soViewCongNo.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
            lbNameProduct.textAlignment = .left
            lbNameProduct.textColor = UIColor.black
            lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbNameProduct.text = nameProduct
            lbNameProduct.numberOfLines = 3
            soViewLine.addSubview(lbNameProduct)
            
            let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewCongNo.frame.size.width - line3.frame.origin.x - 1, height: 1))
            line4.backgroundColor = UIColor(netHex:0x47B054)
            soViewLine.addSubview(line4)
            
            let lbQuantityProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:15)))
            lbQuantityProduct.textAlignment = .left
            lbQuantityProduct.textColor = UIColor.black
            lbQuantityProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbQuantityProduct.text = "Kỳ: \((item.Ky))"
            soViewLine.addSubview(lbQuantityProduct)
            
            let lbPriceProduct = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbQuantityProduct.frame.origin.y + lbQuantityProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height: Common.Size(s:16)))
            lbPriceProduct.textAlignment = .left
            lbPriceProduct.textColor = UIColor.black
            lbPriceProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbPriceProduct.text = "Ngày kỳ hạn: \(item.NgayKyHan)"
            lbPriceProduct.numberOfLines = 1
            soViewLine.addSubview(lbPriceProduct)
            
            let lbStatus = UILabel(frame: CGRect(x: lbQuantityProduct.frame.origin.x , y: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height + Common.Size(s:5), width: lbQuantityProduct.frame.size.width, height: Common.Size(s:15)))
            lbStatus.textAlignment = .left
            
            lbStatus.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            if(item.TTThanhToan == "X"){
                lbStatus.textColor = UIColor.blue
                lbStatus.text = "Đã thanh toán"
            }else{
                lbStatus.textColor = UIColor(netHex:0xEF4A40)
                lbStatus.text = "Chưa thanh toán"
            }
            lbStatus.numberOfLines = 1
            soViewLine.addSubview(lbStatus)
            
            
            let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
            lbSttValue.textAlignment = .center
            lbSttValue.textColor = UIColor.black
            lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbSttValue.text = "\(num3)"
            soViewLine.addSubview(lbSttValue)
            
            soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbStatus.frame.origin.y + lbStatus.frame.size.height + Common.Size(s:5))
            line3.frame.size.height = soViewLine.frame.size.height
            
            indexHeight3 = indexHeight3 + soViewLine.frame.size.height
            indexY3 = indexY3 + soViewLine.frame.size.height + soViewLine.frame.origin.x
            
        }
        soViewCongNo.frame.size.height = indexHeight3
        
        if(infoSubsidy.listThongTinCongNo.count == 0){
            soViewCongNo.frame.origin.y = soViewLogRequest.frame.size.height + soViewLogRequest.frame.origin.y
            soViewCongNo.frame.size.height = 0
        }
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: soViewCongNo.frame.origin.y + soViewCongNo.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
    }
    
    @objc func checkPassCode(){
        showInputDialog(title: "Chuỗi key khoá",
                        subtitle: "Vui lòng nhập chuỗi key vào.",
                        actionTitle: "OK",
                        cancelTitle: "Cancel",
                        inputPlaceholder: "New number",
                        inputKeyboardType: .numberPad, actionHandler:
                            { (input:String?) in
                                print("The pass input is \(input ?? "")")
                                // call api
                                self.checkAPIPassCode(pass: input!)
                            })
    }
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkAPIPassCode(pass:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi lấy key..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.GetPasscode_Form2Key(tokenapi: self.token ?? "",pass: pass) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if (results != ""){
                    if(results != ""){
                        let popup = PopupDialog(title: "Thông báo", message: results, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }else{
                        let popup = PopupDialog(title: "Thông báo", message: "Không lấy được key!!!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                    
                }else{
                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
                
            }
        }
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
