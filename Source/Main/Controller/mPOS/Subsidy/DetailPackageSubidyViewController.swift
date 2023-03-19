//
//  DetailPackageSubidyViewController.swift
//  mPOS
//
//  Created by MinhDH on 4/24/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
import ActionSheetPicker_3_0
class DetailPackageSubidyViewController: UIViewController,UITextFieldDelegate{
    
    var scrollView:UIScrollView!
    var product:ProductBySku!
    var ssd: SSDGoiCuoc!
    var itemCodeSubSidy: ItemCodeSubSidy!
    var money:Float = 0
    var sumMoney:Float = 0
    var itemDetailSubsidy:DetailSubsidy!
    override func viewDidLoad() {
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Chi tiết \(ssd.TenGoiCuoc)"
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_sp_Get_ThongTinSSD_ChiTietGoiCuoc(MaSPMay: "\(itemCodeSubSidy.ItemCode)", MaSPGoiCuoc: "\(ssd.MaSP)", SoTienChiTieu: money, GiaMay: itemCodeSubSidy.Price) { (results, err) in
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results.count > 0){
                        self.loadUI(item:results[0])
                    }else{
                        let popup = PopupDialog(title: "THÔNG BÁO", message: "Không tìm thấy thông tin subsidy!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            _ = self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }else{
                    let popup = PopupDialog(title: "THÔNG BÁO", message: "Không tìm thấy thông tin subsidy!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        _ = self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
    func loadUI(item:DetailSubsidy){
        itemDetailSubsidy = item
        let logo = UIImageView(frame:CGRect(x:scrollView.frame.size.width/4,y:0,width: scrollView.frame.size.width/2,height: scrollView.frame.size.width/5))
        if(ssd.NhaMang == "Vietnamobile"){
            logo.image = #imageLiteral(resourceName: "Vietnamobile")
        }else if(ssd.NhaMang == "Mobifone"){
            logo.image = #imageLiteral(resourceName: "MOBI-1")
        }
        logo.contentMode = .scaleAspectFit
        scrollView.addSubview(logo)
        
        let lbInfo = UILabel(frame: CGRect(x: 0, y: logo.frame.size.height + logo.frame.origin.y, width: scrollView.frame.size.width, height: Common.Size(s:20)))
        lbInfo.textAlignment = .center
        lbInfo.textColor = UIColor(netHex:0x47B054)
        lbInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbInfo.text = "\(ssd.TenGoiCuoc)"
        scrollView.addSubview(lbInfo)
        
        let lbInfoDec = UILabel(frame: CGRect(x: 0, y: lbInfo.frame.size.height + lbInfo.frame.origin.y + Common.Size(s: 5), width: scrollView.frame.size.width, height: Common.Size(s:16)))
        lbInfoDec.textAlignment = .center
        lbInfoDec.textColor = UIColor.black
        lbInfoDec.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        //        lbInfoDec.text = "Gói cước trả trước \(Common.convertCurrency(value: ssd.GiaGoi))/tháng duy trì \(ssd.SothangCamKet) tháng"
        
        lbInfoDec.attributedText = Common.attributedText(withString: "Gói cước trả trước \(Common.convertCurrency(value: ssd.GiaGoi))/tháng duy trì \(ssd.SothangCamKet) tháng", boldString: "\(Common.convertCurrency(value: ssd.GiaGoi))/tháng", font: UIFont.systemFont(ofSize: Common.Size(s:12)))
        scrollView.addSubview(lbInfoDec)
        
        
        let viewInfoBasicRow = UIView(frame: CGRect(x: Common.Size(s:5), y: lbInfoDec.frame.size.height + lbInfoDec.frame.origin.y + Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:10), height: Common.Size(s:40)))
        viewInfoBasicRow.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewInfoBasicRow)
        
        let lbHeaderC1 = UILabel(frame: CGRect(x: 0, y: 0, width: (viewInfoBasicRow.frame.size.width * 5 / 10), height: viewInfoBasicRow.frame.size.height))
        lbHeaderC1.textAlignment = .center
        lbHeaderC1.textColor = UIColor.white
        lbHeaderC1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbHeaderC1.text = "Nội dung"
        viewInfoBasicRow.addSubview(lbHeaderC1)
        
        let lbHeaderC2 = UILabel(frame: CGRect(x: lbHeaderC1.frame.size.width + lbHeaderC1.frame.origin.x, y: 0, width: viewInfoBasicRow.frame.size.width * 2.5 / 10, height: viewInfoBasicRow.frame.size.height))
        lbHeaderC2.textAlignment = .center
        lbHeaderC2.textColor = UIColor.white
        lbHeaderC2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbHeaderC2.text = "Ưu đãi"
        viewInfoBasicRow.addSubview(lbHeaderC2)
        
        let lbHeaderC3 = UILabel(frame: CGRect(x: lbHeaderC2.frame.size.width + lbHeaderC2.frame.origin.x, y: 0, width: viewInfoBasicRow.frame.size.width * 2.5 / 10, height: viewInfoBasicRow.frame.size.height))
        lbHeaderC3.textAlignment = .center
        lbHeaderC3.textColor = UIColor.white
        lbHeaderC3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbHeaderC3.text = "Cước phí"
        viewInfoBasicRow.addSubview(lbHeaderC3)
        
        //line1
        let lbLine1C1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y, width: lbHeaderC1.frame.size.width - Common.Size(s:5), height: viewInfoBasicRow.frame.size.height))
        lbLine1C1.textAlignment = .center
        lbLine1C1.textColor = UIColor.black
        lbLine1C1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine1C1.text = "Gọi nội mạng miễn phí"
        scrollView.addSubview(lbLine1C1)
        
        let lbLine1C2 = UILabel(frame: CGRect(x: lbLine1C1.frame.size.width + lbLine1C1.frame.origin.x, y: viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y, width: lbHeaderC2.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine1C2.textAlignment = .center
        lbLine1C2.textColor = UIColor.black
        lbLine1C2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine1C2.text = "\(item.UuDaiNoiMang)"
        lbLine1C2.numberOfLines = 2
        scrollView.addSubview(lbLine1C2)
        
        
        
        let lbLine1C3 = UILabel(frame: CGRect(x: lbLine1C2.frame.size.width + lbLine1C2.frame.origin.x, y: viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y, width: lbHeaderC3.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine1C3.textAlignment = .center
        lbLine1C3.textColor = UIColor.blue
        lbLine1C3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        //        lbLine1C3.text = "\(item.CPNoiMang)"
        lbLine1C3.numberOfLines = 2
        scrollView.addSubview(lbLine1C3)
        
        
        let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString1 = NSAttributedString(string:  "\(item.CPNoiMang)", attributes: underlineAttribute1)
        lbLine1C3.attributedText = underlineAttributedString1
        
        let tapLbLine1C3 = UITapGestureRecognizer(target: self, action: #selector(DetailPackageSubidyViewController.tapLbLine1C3))
        lbLine1C3.isUserInteractionEnabled = true
        lbLine1C3.addGestureRecognizer(tapLbLine1C3)
        
        let viewLine1 = UIView(frame: CGRect(x: Common.Size(s:5), y: lbLine1C1.frame.size.height + lbLine1C1.frame.origin.y, width: viewInfoBasicRow.frame.size.width, height: Common.Size(s:1)))
        viewLine1.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine1)
        
        //line2
        let lbLine2C1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: viewLine1.frame.size.height + viewLine1.frame.origin.y, width: lbHeaderC1.frame.size.width - Common.Size(s:5), height: viewInfoBasicRow.frame.size.height))
        lbLine2C1.textAlignment = .center
        lbLine2C1.textColor = UIColor.black
        lbLine2C1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine2C1.text = "Gọi ngoại mạng miễn phí"
        scrollView.addSubview(lbLine2C1)
        
        let lbLine2C2 = UILabel(frame: CGRect(x: lbLine2C1.frame.size.width + lbLine2C1.frame.origin.x, y: lbLine2C1.frame.origin.y, width: lbHeaderC2.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine2C2.textAlignment = .center
        lbLine2C2.textColor = UIColor.black
        lbLine2C2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine2C2.text = "\(item.UuDaiNgoaiMang)"
        lbLine2C2.numberOfLines = 2
        scrollView.addSubview(lbLine2C2)
        
        let lbLine2C3 = UILabel(frame: CGRect(x: lbLine2C2.frame.size.width + lbLine2C2.frame.origin.x, y: lbLine2C2.frame.origin.y, width: lbHeaderC3.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine2C3.textAlignment = .center
        lbLine2C3.textColor = UIColor.blue
        lbLine2C3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        //        lbLine2C3.text = "\(item.CPNgoaiMang)"
        lbLine2C3.numberOfLines = 2
        scrollView.addSubview(lbLine2C3)
        
        let underlineAttribute2 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString2 = NSAttributedString(string:  "\(item.CPNgoaiMang)", attributes: underlineAttribute2)
        lbLine2C3.attributedText = underlineAttributedString2
        
        let tapLbLine2C3 = UITapGestureRecognizer(target: self, action: #selector(DetailPackageSubidyViewController.tapLbLine2C3))
        lbLine2C3.isUserInteractionEnabled = true
        lbLine2C3.addGestureRecognizer(tapLbLine2C3)
        
        let viewLine2 = UIView(frame: CGRect(x: Common.Size(s:5), y: lbLine2C1.frame.size.height + lbLine2C1.frame.origin.y, width: viewInfoBasicRow.frame.size.width, height: Common.Size(s:1)))
        viewLine2.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine2)
        
        //line3
        let lbLine3C1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: viewLine2.frame.size.height + viewLine2.frame.origin.y, width: lbHeaderC1.frame.size.width - Common.Size(s:5), height: viewInfoBasicRow.frame.size.height))
        lbLine3C1.textAlignment = .center
        lbLine3C1.textColor = UIColor.black
        lbLine3C1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine3C1.text = "Data miễn phí (3G/4G)"
        scrollView.addSubview(lbLine3C1)
        
        let lbLine3C2 = UILabel(frame: CGRect(x: lbLine3C1.frame.size.width + lbLine3C1.frame.origin.x, y: lbLine3C1.frame.origin.y, width: lbHeaderC2.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine3C2.textAlignment = .center
        lbLine3C2.textColor = UIColor.black
        lbLine3C2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine3C2.text = "\(item.UuDaiData)"
        lbLine3C2.numberOfLines = 2
        scrollView.addSubview(lbLine3C2)
        
        let lbLine3C3 = UILabel(frame: CGRect(x: lbLine3C2.frame.size.width + lbLine3C2.frame.origin.x, y: lbLine3C2.frame.origin.y, width: lbHeaderC3.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine3C3.textAlignment = .center
        lbLine3C3.textColor = UIColor.blue
        lbLine3C3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine3C3.numberOfLines = 2
        //        lbLine3C3.text = "\(item.CPData)"
        scrollView.addSubview(lbLine3C3)
        
        let underlineAttribute3 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString3 = NSAttributedString(string:  "\(item.CPData)", attributes: underlineAttribute3)
        lbLine3C3.attributedText = underlineAttributedString3
        
        let tapLbLine3C3 = UITapGestureRecognizer(target: self, action: #selector(DetailPackageSubidyViewController.tapLbLine3C3))
        lbLine3C3.isUserInteractionEnabled = true
        lbLine3C3.addGestureRecognizer(tapLbLine3C3)
        
        let viewLine3 = UIView(frame: CGRect(x: Common.Size(s:5), y: lbLine3C3.frame.size.height + lbLine3C3.frame.origin.y, width: viewInfoBasicRow.frame.size.width, height: Common.Size(s:1)))
        viewLine3.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine3)
        
        //line4
        let lbLine4C1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: viewLine3.frame.size.height + viewLine3.frame.origin.y, width: lbHeaderC1.frame.size.width - Common.Size(s:5), height: viewInfoBasicRow.frame.size.height))
        lbLine4C1.textAlignment = .center
        lbLine4C1.textColor = UIColor.black
        lbLine4C1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine4C1.text = "SMS nội mạng miễn phí"
        scrollView.addSubview(lbLine4C1)
        
        let lbLine4C2 = UILabel(frame: CGRect(x: lbLine4C1.frame.size.width + lbLine4C1.frame.origin.x, y: lbLine4C1.frame.origin.y, width: lbHeaderC2.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine4C2.textAlignment = .center
        lbLine4C2.textColor = UIColor.black
        lbLine4C2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine4C2.text = "\(item.UuDaiSMS)"
        lbLine4C2.numberOfLines = 2
        scrollView.addSubview(lbLine4C2)
        
        let lbLine4C3 = UILabel(frame: CGRect(x: lbLine4C2.frame.size.width + lbLine4C2.frame.origin.x, y: lbLine4C2.frame.origin.y, width: lbHeaderC3.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine4C3.textAlignment = .center
        lbLine4C3.textColor = UIColor.blue
        lbLine4C3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        //        lbLine4C3.text = "\(item.CPSMS)"
        lbLine4C3.numberOfLines = 2
        scrollView.addSubview(lbLine4C3)
        
        let underlineAttribute4 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString4 = NSAttributedString(string:  "\(item.CPSMS)", attributes: underlineAttribute4)
        lbLine4C3.attributedText = underlineAttributedString4
        
        let tapLbLine4C3 = UITapGestureRecognizer(target: self, action: #selector(DetailPackageSubidyViewController.tapLbLine4C3))
        lbLine4C3.isUserInteractionEnabled = true
        lbLine4C3.addGestureRecognizer(tapLbLine4C3)
        
        let viewLine4 = UIView(frame: CGRect(x: Common.Size(s:5), y: lbLine4C3.frame.size.height + lbLine4C3.frame.origin.y, width: viewInfoBasicRow.frame.size.width, height: Common.Size(s:1)))
        viewLine4.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine4)
        
        //line5
        let lbLine5C1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: viewLine4.frame.size.height + viewLine4.frame.origin.y, width: lbHeaderC1.frame.size.width - Common.Size(s:5), height: viewInfoBasicRow.frame.size.height))
        lbLine5C1.textAlignment = .center
        lbLine5C1.textColor = UIColor.black
        lbLine5C1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine5C1.text = "Miễn phí Facebook"
        scrollView.addSubview(lbLine5C1)
        
        let lbLine5C2 = UILabel(frame: CGRect(x: lbLine5C1.frame.size.width + lbLine5C1.frame.origin.x, y: lbLine5C1.frame.origin.y, width: lbHeaderC2.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine5C2.textAlignment = .center
        lbLine5C2.textColor = UIColor.black
        lbLine5C2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine5C2.text = "\(item.UuDaiFacebook)"
        scrollView.addSubview(lbLine5C2)
        
        let lbLine5C3 = UILabel(frame: CGRect(x: lbLine5C2.frame.size.width + lbLine5C2.frame.origin.x, y: lbLine5C2.frame.origin.y, width: lbHeaderC3.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine5C3.textAlignment = .center
        lbLine5C3.textColor = UIColor.black
        lbLine5C3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine5C3.text = "\(item.CPFacebook)"
        scrollView.addSubview(lbLine5C3)
        
        let viewLine5 = UIView(frame: CGRect(x: Common.Size(s:5), y: lbLine5C3.frame.size.height + lbLine5C3.frame.origin.y, width: viewInfoBasicRow.frame.size.width, height: Common.Size(s:1)))
        viewLine5.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine5)
        
        //line6
        let lbLine6C1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: viewLine5.frame.size.height + viewLine5.frame.origin.y, width: lbHeaderC1.frame.size.width + lbHeaderC2.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine6C1.textAlignment = .center
        lbLine6C1.textColor = UIColor(netHex:0x47b053)
        lbLine6C1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbLine6C1.text = "Tổng chi phí/ tháng"
        lbLine6C1.numberOfLines = 2
        scrollView.addSubview(lbLine6C1)
        
        let lbLine6C3 = UILabel(frame: CGRect(x: lbLine6C1.frame.size.width + lbLine6C1.frame.origin.x, y: lbLine6C1.frame.origin.y, width: lbHeaderC3.frame.size.width, height: viewInfoBasicRow.frame.size.height))
        lbLine6C3.textAlignment = .center
        lbLine6C3.textColor = UIColor(netHex:0x47b053)
        lbLine6C3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbLine6C3.text = "\(item.TongCong)"
        scrollView.addSubview(lbLine6C3)
        
        let viewLine6 = UIView(frame: CGRect(x: Common.Size(s:5), y: lbLine6C3.frame.size.height + lbLine6C3.frame.origin.y, width: viewInfoBasicRow.frame.size.width, height: Common.Size(s:1)))
        viewLine6.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine6)
        
        let lbLine7C0 = UILabel(frame: CGRect(x: viewLine6.frame.origin.x + Common.Size(s: 5), y: viewLine6.frame.size.height + viewLine6.frame.origin.y, width: viewInfoBasicRow.frame.size.width - Common.Size(s: 10), height: viewInfoBasicRow.frame.size.height))
        lbLine7C0.textAlignment = .center
        lbLine7C0.textColor = UIColor.blue
        lbLine7C0.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLine7C0.numberOfLines = 10
        scrollView.addSubview(lbLine7C0)
        
        let attrStr = try! NSAttributedString(
            data: "\(item.SoTienTietKiem)".data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        lbLine7C0.attributedText = attrStr
        
        let sizeF = lbLine7C0.sizeThatFits(lbLine7C0.frame.size)
        lbLine7C0.frame.size.height = sizeF.height
        
        let viewLine11 = UIView(frame: CGRect(x: Common.Size(s:5), y: lbLine7C0.frame.size.height + lbLine7C0.frame.origin.y, width: viewInfoBasicRow.frame.size.width, height: Common.Size(s:1)))
        viewLine11.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine11)
        
        let viewLine7 = UIView(frame: CGRect(x: Common.Size(s:5), y: viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y, width: Common.Size(s:1), height:viewLine11.frame.origin.y - (viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y)))
        viewLine7.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine7)
        
        let viewLine8 = UIView(frame: CGRect(x: viewInfoBasicRow.frame.size.width + viewInfoBasicRow.frame.origin.x - Common.Size(s:1), y: viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y, width: Common.Size(s:1), height:viewLine11.frame.origin.y - (viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y)))
        viewLine8.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine8)
        
        let viewLine9 = UIView(frame: CGRect(x: lbHeaderC1.frame.size.width + lbHeaderC1.frame.origin.x - Common.Size(s:0.5), y: viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y, width: Common.Size(s:1), height:viewLine5.frame.origin.y - (viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y)))
        viewLine9.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine9)
        
        let viewLine10 = UIView(frame: CGRect(x: lbHeaderC2.frame.size.width + lbHeaderC2.frame.origin.x - Common.Size(s:0.5), y: viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y, width: Common.Size(s:1), height:viewLine6.frame.origin.y - (viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y)))
        viewLine10.backgroundColor = UIColor(netHex:0x47b053)
        scrollView.addSubview(viewLine10)
        
        
        let heightTitel = item.GiaDinh.height(withConstrainedWidth: viewInfoBasicRow.frame.size.width, font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
        
        let note = UILabel(frame: CGRect(x: viewInfoBasicRow.frame.origin.x, y: viewLine11.frame.size.height + viewLine11.frame.origin.y + Common.Size(s:10), width: viewInfoBasicRow.frame.size.width , height: heightTitel))
        note.textAlignment = .left
        note.textColor = UIColor.red
        note.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        note.text = item.GiaDinh
        note.numberOfLines = 5
        scrollView.addSubview(note)
        
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: scrollView.frame.size.width / 4, y: note.frame.origin.y + note.frame.size.height + Common.Size(s: 15), width: scrollView.frame.size.width / 2 - Common.Size(s:10), height: Common.Size(s:40 ) * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.setTitle("Mua ngay", for: .normal)
        btPay.addTarget(self, action: #selector(cartAction(_:)), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        btPay.clipsToBounds = true
        scrollView.addSubview(btPay)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20) + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        //        let viewInfoBasicLine = UIView(frame: CGRect(x: viewInfoBasicRow.frame.size.width * 3/10, y: 0, width: 0.5, height: viewInfoBasicRow.frame.size.height))
        //        viewInfoBasicLine.backgroundColor = UIColor(netHex:0x47B054)
        //        viewInfoBasicRow.addSubview(viewInfoBasicLine)
    }
    
    @objc func tapLbLine1C3(sender:UITapGestureRecognizer) {
        if(itemDetailSubsidy.NoiMangLink != ""){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "\(itemDetailSubsidy.NoiMangLink)")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: "\(itemDetailSubsidy.NoiMangLink)")!)
            }
        }else{
            let popup = PopupDialog(title: "THÔNG BÁO", message: "\(itemDetailSubsidy.NoiMangNote)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
    }
    @objc func tapLbLine2C3(sender:UITapGestureRecognizer) {
        if(itemDetailSubsidy.NgoaiMangLink != ""){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "\(itemDetailSubsidy.NgoaiMangLink)")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: "\(itemDetailSubsidy.NgoaiMangLink)")!)
            }
        }else{
            let popup = PopupDialog(title: "THÔNG BÁO", message: "\(itemDetailSubsidy.NgoaiMagNote)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    @objc func tapLbLine3C3(sender:UITapGestureRecognizer) {
        if(itemDetailSubsidy.DataLink != ""){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "\(itemDetailSubsidy.DataLink)")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: "\(itemDetailSubsidy.DataLink)")!)
            }
        }else{
            let popup = PopupDialog(title: "THÔNG BÁO", message: "\(itemDetailSubsidy.DataNote)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
    }
    @objc func tapLbLine4C3(sender:UITapGestureRecognizer) {
        if(itemDetailSubsidy.SMSLink != ""){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "\(itemDetailSubsidy.SMSLink)")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: "\(itemDetailSubsidy.SMSLink)")!)
            }
        }else{
            let popup = PopupDialog(title: "THÔNG BÁO", message: "\(itemDetailSubsidy.SMSNote)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
    }
    @objc func cartAction(_ sender:UITapGestureRecognizer){
        navigationController?.navigationBar.isTranslucent = true
        if (self.product.product.qlSerial == "Y"){
            var arrColor:[String] = []
            for item in self.product.variant {
                arrColor.append(item.colorName)
            }
            if (arrColor.count == 1){
                //                let sku = self.product.variant[0].sku
                //                let colorProduct = self.product.variant[0].colorValue
                //                let priceBeforeTax = self.product.variant[0].priceBeforeTax
                //                let price = self.product.variant[0].price
                //                let product = self.product.product.copy() as! Product
                //
                //                product.sku = sku
                //                product.price = price
                //                product.priceBeforeTax = priceBeforeTax
                
                //                let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "")
                //                Cache.carts.append(cart)
                //                Cache.itemsPromotion.removeAll()
                //
                //                let newViewController = CartViewController()
                //                self.navigationController?.pushViewController(newViewController, animated: true)
                loadSim(value:0)
                
            }else{
                ActionSheetStringPicker.show(withTitle: "Chọn màu sản phẩm", rows: arrColor, initialSelection: 0, doneBlock: {
                    picker, value, index in
                    self.loadSim(value:value)
                    
                    return
                }, cancel: { ActionStringCancelBlock in
                    return
                }, origin: self.view)
                
            }
            
        }else{
            // da chuuyen san phu kien
        }
        
    }
    func loadSim(value:Int){
        let sku = self.product.variant[value].sku
        let colorProduct = self.product.variant[value].colorValue
        let priceBeforeTax = self.product.variant[value].priceBeforeTax
        let price = self.product.variant[value].price
        let product = self.product.product.copy() as! Product
        
        product.sku = sku
        product.price = price
        product.priceBeforeTax = priceBeforeTax
        
        MPOSAPIManager.sp_mpos_SSD_MSP_SIM_10_11_for_MPOS(MSPGoiCuoc: "\(self.ssd.MaSP)", MSPMay: sku, handler: { (results, error) in
            if(error.count <= 0){
                if(results.count > 0){
                    let alert = UIAlertController(title: "Chú ý", message: "Bạn vui lòng chọn đầu số", preferredStyle: UIAlertController.Style.alert)
                    
                    for item in results {
                        alert.addAction(UIAlertAction(title: "\(item.ItemName)", style: UIAlertAction.Style.default, handler:{ action in
                            print("AAA \(item.ItemCode)")
                            
                            ProductAPIManager.product_detais_by_sku(sku: "\(self.ssd.MaSP)", handler: { (pruductRS, err) in
                                if(err.count <= 0){
                                    if(pruductRS.count > 0){
                                        ProductAPIManager.product_detais_by_sku(sku: "\(item.ItemCode)", handler: { (pruductSim, errSim) in
                                            if(errSim.count <= 0){
                                                if(pruductSim.count > 0){
                                                    let skuSim = pruductSim[0].variant[0].sku
                                                    let colorProductSim = pruductSim[0].variant[0].colorValue
                                                    let priceBeforeTaxSim = pruductSim[0].variant[0].priceBeforeTax
                                                    let priceSim = pruductSim[0].variant[0].price
                                                    let productSim = pruductSim[0].product.copy() as! Product
                                                    
                                                    let cart2 = Cart(sku: skuSim, product: productSim,quantity: 1,color:colorProductSim,inStock:-1, imei: "N/A",price: priceSim, priceBT: priceBeforeTaxSim, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                                    Cache.carts.append(cart2)
                                                    
                                                    let skuItem = pruductRS[0].variant[0].sku
                                                    let colorProductItem = pruductRS[0].variant[0].colorValue
                                                    let priceBeforeTaxItem = pruductRS[0].variant[0].priceBeforeTax
                                                    let priceItem = pruductRS[0].variant[0].price
                                                    let productItem = pruductRS[0].product.copy() as! Product
                                                    
                                                    let cart = Cart(sku: skuItem, product: productItem,quantity: 1,color:colorProductItem,inStock:-1, imei: "N/A",price: priceItem, priceBT: priceBeforeTaxItem, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                                    Cache.carts.append(cart)
                                                    
                                                    let cart1 = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                                    Cache.carts.append(cart1)
                                                    Cache.itemsPromotion.removeAll()
                                                    let newViewController = CartViewController()
                                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                                }
                                            }
                                        })
                                    }else{
                                        Toast(text: "Không tìm thấy mã sản phẩm \(self.ssd.MaSP)").show()
                                    }
                                }else{
                                    Toast(text: err).show()
                                }
                            })
                        })
                        )
                    }
                    //                                alert.addAction(UIAlertAction(title: "Huỷ", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    ProductAPIManager.product_detais_by_sku(sku: "\(self.ssd.MaSP)", handler: { (pruductRS, err) in
                        if(err.count <= 0){
                            if(pruductRS.count != 0){
                                let skuItem = pruductRS[0].variant[0].sku
                                let colorProductItem = pruductRS[0].variant[0].colorValue
                                let priceBeforeTaxItem = pruductRS[0].variant[0].priceBeforeTax
                                let priceItem = pruductRS[0].variant[0].price
                                let productItem = pruductRS[0].product.copy() as! Product
                                
                                let cart = Cart(sku: skuItem, product: productItem,quantity: 1,color:colorProductItem,inStock:-1, imei: "N/A",price: priceItem, priceBT: priceBeforeTaxItem, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                Cache.carts.append(cart)
                                
                                let cart1 = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                Cache.carts.append(cart1)
                                Cache.itemsPromotion.removeAll()
                                let newViewController = CartViewController()
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }else{
                                Toast(text: "Không tìm thấy mã sản phẩm \(self.ssd.MaSP)").show()
                            }
                        }else{
                            Toast(text: err).show()
                        }
                    })
                }
            }else{
                Toast(text: error).show()
            }
        })
    }
}
