//
//  PackageSubsidyViewController.swift
//  mPOS
//
//  Created by MinhDH on 4/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import Toaster
class PackageSubsidyViewController: UIViewController,UITextFieldDelegate{
    var scrollView:UIScrollView!
    var listSSD: [SSDGoiCuoc] = []
    
    var groupView: [String:NSMutableArray] = [:]
    var groupName: [String] = []
    
    var listSSDSelect:[SSDGoiCuoc] = []
    var listViewHeader: [UIView] = []
    var money:Float = 0
    
    var yBody:CGFloat = 0.0
    override func viewDidLoad() {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Tư vấn Subsidy"
        listSSDSelect = []
        listViewHeader = []
        for item in listSSD {
            if let val:NSMutableArray = self.groupView["\(item.NhaMang)"] {
                val.add(item)
                self.groupView.updateValue(val, forKey: "\(item.NhaMang)")
            } else {
                let arr: NSMutableArray = NSMutableArray()
                arr.add(item)
                self.groupView.updateValue(arr, forKey: "\(item.NhaMang)")
            }
        }
        
        let lbInfoSum = UILabel(frame: CGRect(x: 0, y: Common.Size(s: 5), width: scrollView.frame.size.width, height: Common.Size(s:30)))
        lbInfoSum.textAlignment = .center
        lbInfoSum.textColor = UIColor.red
        lbInfoSum.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbInfoSum.text = "\(Common.convertCurrencyFloatV2(value: money)) x 12 kỳ = \(Common.convertCurrencyFloatV2(value: money * 12))"
        scrollView.addSubview(lbInfoSum)
        
        var ySSDView:CGFloat = lbInfoSum.frame.size.height + lbInfoSum.frame.origin.y + Common.Size(s: 5)
        var countItem: Int = 0
        var countItemSSD: Int = 0
        var countItemHeader: Int = 0
        yBody = 0.0
        for item in self.groupView {
            countItem = countItem + 1
            let ssdView = UIView(frame:CGRect(x:0,y:ySSDView,width:scrollView.frame.size.width,height:100))
            scrollView.addSubview(ssdView)
            
            //header
            let ssdViewHeader = UIView(frame:CGRect(x:0,y:0,width: ssdView.frame.size.width,height:Common.Size(s: 40)))
            ssdViewHeader.backgroundColor = .white
            ssdView.addSubview(ssdViewHeader)
            
            let ssdViewLine = UIView(frame:CGRect(x:0,y:0,width: ssdView.frame.size.width,height:Common.Size(s: 0.5)))
            ssdViewLine.backgroundColor = .gray
            ssdView.addSubview(ssdViewLine)
            ssdView.frame.size.height = ssdViewLine.frame.size.height + ssdViewLine.frame.origin.y
            
            let logo = UIImageView(frame:CGRect(x:Common.Size(s: 10),y:Common.Size(s: 5),width:ssdViewHeader.frame.size.width/2,height:ssdViewHeader.frame.size.height - Common.Size(s: 10)))
            if(item.key == "Vietnamobile"){
                logo.image = #imageLiteral(resourceName: "VNM-1")
            }else if(item.key == "Mobifone"){
                logo.image = #imageLiteral(resourceName: "MOBI-1")
            }
            logo.contentMode = .scaleAspectFit
            ssdViewHeader.addSubview(logo)
            
            let logoArrow = UIImageView(frame:CGRect(x:ssdViewHeader.frame.size.width - ssdViewHeader.frame.size.height,y:Common.Size(s: 10),width:ssdViewHeader.frame.size.height - Common.Size(s: 20),height:ssdViewHeader.frame.size.height - Common.Size(s: 20)))
            logoArrow.image = #imageLiteral(resourceName: "ic_arrow")
            logoArrow.contentMode = .scaleAspectFit
            ssdViewHeader.addSubview(logoArrow)
            
            ssdViewHeader.tag = countItemHeader
            listViewHeader.append(ssdView)
            
            let gestureHeader = UITapGestureRecognizer(target: self, action:  #selector (self.someActionHeader (_:)))
            ssdViewHeader.addGestureRecognizer(gestureHeader)
            countItemHeader = countItemHeader + 1
            
            //body
            let ssdViewBody = UIView(frame:CGRect(x:0,y:ssdViewHeader.frame.size.height + ssdViewHeader.frame.origin.y,width: ssdView.frame.size.width,height:Common.Size(s: 100)))
            ssdView.addSubview(ssdViewBody)
            
            var ySSDItemView:CGFloat = 0.0
            for itm in item.value {
                let ssd = itm as! SSDGoiCuoc
                ///
                listSSDSelect.append(ssd)
                countItemSSD = countItemSSD + 1
                ///
                let ssdItemView = UIView(frame:CGRect(x:Common.Size(s: 5),y:ySSDItemView,width: ssdView.frame.size.width - Common.Size(s: 10),height:Common.Size(s: 50)))
                ssdViewBody.addSubview(ssdItemView)
                ssdItemView.layer.borderWidth = 0.5
                ssdItemView.layer.borderColor = UIColor.gray.cgColor
                ssdItemView.layer.cornerRadius = 3.0
                ssdItemView.tag = (countItemSSD - 1)
                
                let gestureSwift2AndHigher = UITapGestureRecognizer(target: self, action:  #selector (self.someActionSSD (_:)))
                ssdItemView.addGestureRecognizer(gestureSwift2AndHigher)
                
                
                
                
                let lbInfo = UILabel(frame: CGRect(x: 0, y: Common.Size(s: 5), width: ssdItemView.frame.size.width, height: Common.Size(s:20)))
                lbInfo.textAlignment = .center
                lbInfo.textColor = UIColor(netHex:0x47B054)
                lbInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                lbInfo.text = "\(ssd.TenGoiCuoc)"
                ssdItemView.addSubview(lbInfo)
                
                let lbInfoDec = UILabel(frame: CGRect(x: 0, y: lbInfo.frame.size.height + lbInfo.frame.origin.y + Common.Size(s: 2), width: ssdItemView.frame.size.width, height: Common.Size(s:16)))
                lbInfoDec.textAlignment = .center
                lbInfoDec.textColor = UIColor.black
                lbInfoDec.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfoDec.text = "Gói cước trả trước \(Common.convertCurrency(value: ssd.GiaGoi))/tháng duy trì \(ssd.SothangCamKet) tháng"
                ssdItemView.addSubview(lbInfoDec)
                
                let lbInfoNoiMang = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbInfoDec.frame.size.height + lbInfoDec.frame.origin.y + Common.Size(s: 10), width: ssdItemView.frame.size.width/2, height: Common.Size(s:16)))
                lbInfoNoiMang.textAlignment = .left
                lbInfoNoiMang.textColor = UIColor.gray
                lbInfoNoiMang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfoNoiMang.text = "Gọi nội mạng miễn phí"
                ssdItemView.addSubview(lbInfoNoiMang)
                
                let lbValueNoiMang = UILabel(frame: CGRect(x: lbInfoNoiMang.frame.size.width + lbInfoNoiMang.frame.origin.x, y:lbInfoNoiMang.frame.origin.y, width: ssdItemView.frame.size.width/2, height: Common.Size(s:16)))
                lbValueNoiMang.textAlignment = .left
                lbValueNoiMang.textColor = UIColor.black
                lbValueNoiMang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbValueNoiMang.text = "\(ssd.ThoaiNoiMang)"
                ssdItemView.addSubview(lbValueNoiMang)
                
                let lbInfoNgoaiMang = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbInfoNoiMang.frame.size.height + lbInfoNoiMang.frame.origin.y + Common.Size(s: 5), width: ssdItemView.frame.size.width/2, height: Common.Size(s:16)))
                lbInfoNgoaiMang.textAlignment = .left
                lbInfoNgoaiMang.textColor = UIColor.gray
                lbInfoNgoaiMang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfoNgoaiMang.text = "Gọi ngoại mạng miễn phí"
                ssdItemView.addSubview(lbInfoNgoaiMang)
                
                let lbValueNgoaiMang = UILabel(frame: CGRect(x: lbInfoNgoaiMang.frame.size.width + lbInfoNgoaiMang.frame.origin.x, y:lbInfoNgoaiMang.frame.origin.y, width: ssdItemView.frame.size.width/2, height: Common.Size(s:16)))
                lbValueNgoaiMang.textAlignment = .left
                lbValueNgoaiMang.textColor = UIColor.black
                lbValueNgoaiMang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbValueNgoaiMang.text = "\(ssd.ThoaiLienMang)"
                ssdItemView.addSubview(lbValueNgoaiMang)
                
                let lbInfoData = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbInfoNgoaiMang.frame.size.height + lbInfoNgoaiMang.frame.origin.y + Common.Size(s: 5), width: ssdItemView.frame.size.width/2, height: Common.Size(s:16)))
                lbInfoData.textAlignment = .left
                lbInfoData.textColor = UIColor.gray
                lbInfoData.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfoData.text = "Data miễn phí (3G/4G)"
                ssdItemView.addSubview(lbInfoData)
                
                let lbValueData = UILabel(frame: CGRect(x: lbInfoData.frame.size.width + lbInfoData.frame.origin.x, y:lbInfoData.frame.origin.y, width: ssdItemView.frame.size.width/2, height: Common.Size(s:16)))
                lbValueData.textAlignment = .left
                lbValueData.textColor = UIColor.black
                lbValueData.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbValueData.text = "\(ssd.Data)"
                ssdItemView.addSubview(lbValueData)
                
                let lbInfoSMSNoiMang = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbInfoData.frame.size.height + lbInfoData.frame.origin.y + Common.Size(s: 5), width: ssdItemView.frame.size.width/2, height: Common.Size(s:16)))
                lbInfoSMSNoiMang.textAlignment = .left
                lbInfoSMSNoiMang.textColor = UIColor.gray
                lbInfoSMSNoiMang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfoSMSNoiMang.text = "SMS nội mạng miễn phí"
                ssdItemView.addSubview(lbInfoSMSNoiMang)
                
                let lbValueSMSNoiMang = UILabel(frame: CGRect(x: lbInfoSMSNoiMang.frame.size.width + lbInfoData.frame.origin.x, y:lbInfoSMSNoiMang.frame.origin.y, width: lbInfoSMSNoiMang.frame.size.width/2, height: Common.Size(s:16)))
                lbValueSMSNoiMang.textAlignment = .left
                lbValueSMSNoiMang.textColor = UIColor.black
                lbValueSMSNoiMang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbValueSMSNoiMang.text = "\(ssd.SMSNoiMang)"
                ssdItemView.addSubview(lbValueSMSNoiMang)
                
                let lbInfoFacebook = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbInfoSMSNoiMang.frame.size.height + lbInfoSMSNoiMang.frame.origin.y + Common.Size(s: 5), width: ssdItemView.frame.size.width/2, height: Common.Size(s:16)))
                lbInfoFacebook.textAlignment = .left
                lbInfoFacebook.textColor = UIColor.gray
                lbInfoFacebook.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfoFacebook.text = "Miễn phí Facebook"
                ssdItemView.addSubview(lbInfoFacebook)
                
                let lbValueFacebook = UILabel(frame: CGRect(x: lbInfoFacebook.frame.size.width + lbInfoFacebook.frame.origin.x, y:lbInfoFacebook.frame.origin.y, width: lbInfoSMSNoiMang.frame.size.width/2, height: Common.Size(s:16)))
                lbValueFacebook.textAlignment = .left
                lbValueFacebook.textColor = UIColor.black
                lbValueFacebook.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbValueFacebook.text = "Không"
                ssdItemView.addSubview(lbValueFacebook)
                
                if(ssd.Facebook > 0){
                    lbValueFacebook.text = "Có"
                }
                ssdItemView.frame.size.height = lbInfoFacebook.frame.size.height + lbInfoFacebook.frame.origin.y + Common.Size(s: 10)
                ySSDItemView = ssdItemView.frame.size.height + ySSDItemView + Common.Size(s: 5)
            }
            ssdViewBody.frame.size.height = ySSDItemView
            yBody = yBody +  ssdViewBody.frame.size.height + ssdViewBody.frame.origin.y
            //            if(self.groupView.count == countItem){
            //DAY NE
            //                ssdView.frame.size.height = ssdViewBody.frame.size.height + ssdViewBody.frame.origin.y
            ssdView.clipsToBounds = true
            ssdView.frame.size.height = Common.Size(s: 40)
            //            }else{
            //                let ssdViewLine = UIView(frame:CGRect(x:0,y:ssdViewBody.frame.size.height + ssdViewBody.frame.origin.y + Common.Size(s: 10),width: ssdView.frame.size.width,height:Common.Size(s: 0.5)))
            //                ssdViewLine.backgroundColor = .gray
            //                ssdView.addSubview(ssdViewLine)
            //                ssdView.frame.size.height = ssdViewLine.frame.size.height + ssdViewLine.frame.origin.y
            //            }
            ySSDView = ySSDView + ssdView.frame.size.height
        }
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: ySSDView  + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
    }
    @objc func someActionSSD(_ sender:UITapGestureRecognizer){
        let view:UIView = sender.view!
        let ssd = listSSDSelect[view.tag]
        print("\(ssd.NhaMang) \(ssd.TenGoiCuoc)")
        
        let viewController = ProductSubsidyViewController()
        viewController.ssd = ssd
        viewController.money = money
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func someActionHeader(_ sender:UITapGestureRecognizer){
        let view:UIView = sender.view!
        let header = listViewHeader[view.tag]
        header.clipsToBounds = true
        if(header.frame.size.height == Common.Size(s: 40)){
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                let yPos = (header.subviews.map { $0.frame.height }).reduce(20, +)
                header.frame.size.height = yPos
                
                var yView:CGFloat =  Common.Size(s:40)
                for item in self.listViewHeader{
                    
                    item.frame.origin.y = yView
                    yView = yView + item.frame.size.height
                    
                }
            }, completion: { _ in
                // do stuff once animation is complete
            })
        }else{
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                header.frame.size.height = Common.Size(s: 40)
                
                var yView:CGFloat = Common.Size(s:40)
                for item in self.listViewHeader{
                    
                    item.frame.origin.y = yView
                    yView = yView + item.frame.size.height
                    
                }
            }, completion: { _ in
                // do stuff once animation is complete
            })
        }
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: yBody + Common.Size(s: 80) + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Tư vấn Subsidy"
    }
}
