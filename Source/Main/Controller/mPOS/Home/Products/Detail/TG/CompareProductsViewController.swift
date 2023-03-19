//
//  CompareProductsViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/29/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Kingfisher
import QuartzCore
import StringExtensionHTML
import ActionSheetPicker_3_0
import PopupDialog
class CompareProductsViewController: UIViewController{
    var scrollView:UIScrollView!
    var product:ProductBySku!
    var productCompare:SPTraGop!
    
    var compareProduct:ProductBySku!
    var customAlert = PopUpPickColorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        self.title = "Chi tiết"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(CompareProductsViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        if(productCompare.model_id != ""){
            ProductAPIManager.product_detais_by_model_id(model_id: "\(productCompare.model_id)", sku: productCompare.ItemCode,handler: { (success , error) in
                  if(success.count > 0){
                          if(success[0].product.qlSerial != "N"){
                              MPOSAPIManager.sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP(ItemCodeGoc: "\(self.product.product.sku)", ItemCodeTuVan: "\(success[0].product.sku)", GiaSPTuVan: "\(String(format: "%.6f", success[0].product.price))", handler: { (results, err) in
                                  let when = DispatchTime.now() + 0.5
                                  DispatchQueue.main.asyncAfter(deadline: when) {
                                      nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                      if(err.count <= 0){
                                          self.initUI(compareProduct:success[0],listSPLenDoi:results)
                                      }else{
                                          let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                              print("Completed")
                                          }
                                          let buttonOne = DefaultButton(title: "OK") {
                                              self.navigationController?.popViewController(animated: true)
                                          }
                                          popup.addButtons([buttonOne])
                                          self.present(popup, animated: true, completion: nil)
                                      }
                                  }
                              })
                          }else{
                              let when = DispatchTime.now() + 0.5
                              DispatchQueue.main.asyncAfter(deadline: when) {
                                  nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                  let popup = PopupDialog(title: "Thông báo", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                      print("Completed")
                                  }
                                  let buttonOne = DefaultButton(title: "OK") {
                                      self.navigationController?.popViewController(animated: true)
                                  }
                                  popup.addButtons([buttonOne])
                                  self.present(popup, animated: true, completion: nil)
                              }
                          }
                      }else{
                          let when = DispatchTime.now() + 0.5
                          DispatchQueue.main.asyncAfter(deadline: when) {
                              nc.post(name: Notification.Name("dismissLoading"), object: nil)
                              let popup = PopupDialog(title: "Thông báo", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                  print("Completed")
                              }
                              let buttonOne = DefaultButton(title: "OK") {
                                  self.navigationController?.popViewController(animated: true)
                              }
                              popup.addButtons([buttonOne])
                              self.present(popup, animated: true, completion: nil)
                          }
                      }
              })
        }else{
            ProductAPIManager.product_detais_by_sku(sku: "\(productCompare.ItemCode)",handler: { (success , error) in
                  if(success.count > 0){
                          if(success[0].product.qlSerial != "N"){
                              MPOSAPIManager.sp_mpos_FRT_SP_TraGop_LoadThongTin_LenDoiSP(ItemCodeGoc: "\(self.product.product.sku)", ItemCodeTuVan: "\(success[0].product.sku)", GiaSPTuVan: "\(String(format: "%.6f", success[0].product.price))", handler: { (results, err) in
                                  let when = DispatchTime.now() + 0.5
                                  DispatchQueue.main.asyncAfter(deadline: when) {
                                      nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                      if(err.count <= 0){
                                          self.initUI(compareProduct:success[0],listSPLenDoi:results)
                                      }else{
                                          let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                              print("Completed")
                                          }
                                          let buttonOne = DefaultButton(title: "OK") {
                                              self.navigationController?.popViewController(animated: true)
                                          }
                                          popup.addButtons([buttonOne])
                                          self.present(popup, animated: true, completion: nil)
                                      }
                                  }
                              })
                          }else{
                              let when = DispatchTime.now() + 0.5
                              DispatchQueue.main.asyncAfter(deadline: when) {
                                  nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                  let popup = PopupDialog(title: "Thông báo", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                      print("Completed")
                                  }
                                  let buttonOne = DefaultButton(title: "OK") {
                                      self.navigationController?.popViewController(animated: true)
                                  }
                                  popup.addButtons([buttonOne])
                                  self.present(popup, animated: true, completion: nil)
                              }
                          }
                      }else{
                          let when = DispatchTime.now() + 0.5
                          DispatchQueue.main.asyncAfter(deadline: when) {
                              nc.post(name: Notification.Name("dismissLoading"), object: nil)
                              let popup = PopupDialog(title: "Thông báo", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                  print("Completed")
                              }
                              let buttonOne = DefaultButton(title: "OK") {
                                  self.navigationController?.popViewController(animated: true)
                              }
                              popup.addButtons([buttonOne])
                              self.present(popup, animated: true, completion: nil)
                          }
                      }
              })
        }
  
    }
    func initUI(compareProduct:ProductBySku,listSPLenDoi:[LenDoiSP]){
        self.compareProduct = compareProduct
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "SO SÁNH CẤU HÌNH"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        let infoView = UIView()
        infoView.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        infoView.backgroundColor = UIColor.white
        scrollView.addSubview(infoView)
        
        let infoHeaderView = UIView(frame: CGRect(x: 0, y:0, width: scrollView.frame.size.width, height: Common.Size(s: 30)))
        infoHeaderView.backgroundColor = UIColor(netHex: 0x04AB6E)
        infoView.addSubview(infoHeaderView)
        
        //product 1
        let sizeNameProduct1 =  product.product.name.height(withConstrainedWidth: infoHeaderView.frame.width * 3/8, font: UIFont.boldSystemFont(ofSize: Common.Size(s:13)))
        let lbNameProduct1 = UILabel(frame: CGRect(x: infoHeaderView.frame.width * 2/8, y: Common.Size(s:3), width:infoHeaderView.frame.width * 3/8, height: sizeNameProduct1))
        lbNameProduct1.text = product.product.name
        lbNameProduct1.numberOfLines = 4
        lbNameProduct1.textColor = .white
        lbNameProduct1.textAlignment = .center
        lbNameProduct1.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        infoHeaderView.addSubview(lbNameProduct1)
        
        //product 2
        let sizeNameProduct2 = compareProduct.product.name.height(withConstrainedWidth: infoHeaderView.frame.width * 3/8, font: UIFont.boldSystemFont(ofSize: Common.Size(s:13)))
        let lbNameProduct2 = UILabel(frame: CGRect(x: infoHeaderView.frame.width * 5/8, y: Common.Size(s:3), width:infoHeaderView.frame.width * 3/8, height: sizeNameProduct2))
        lbNameProduct2.text = compareProduct.product.name
        lbNameProduct2.numberOfLines = 4
        lbNameProduct2.textColor = .white
        lbNameProduct2.textAlignment = .center
        lbNameProduct2.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        infoHeaderView.addSubview(lbNameProduct2)
        
        infoHeaderView.frame.size.height = lbNameProduct1.frame.size.height + lbNameProduct1.frame.origin.y + Common.Size(s:3)
        if(sizeNameProduct1 < sizeNameProduct2){
            infoHeaderView.frame.size.height = lbNameProduct2.frame.size.height + lbNameProduct2.frame.origin.y + Common.Size(s:3)
        }
        
        var indexYBasic:CGFloat = infoHeaderView.frame.size.height + infoHeaderView.frame.origin.y
        if(product.atrribute.count > 0 && compareProduct.atrribute.count > 0){
            for item in product.atrribute {
                if (item.group == "Thông số cơ bản"){
                    for itemCompare in compareProduct.atrribute {
                        if (itemCompare.group == "Thông số cơ bản"){
                            var indxGroup:Int = 0
                            for atrribute in item.attributes {
                                for atrributeCompare in itemCompare.attributes {
                                    if(atrribute.name == atrributeCompare.name){
                                        
                                        let viewInfoBasicRow = UIView(frame: CGRect(x: 0, y: indexYBasic, width: infoView.frame.size.width, height: CGFloat(50.0)))
                                        infoView.addSubview(viewInfoBasicRow)
                                        
                                        viewInfoBasicRow.backgroundColor = UIColor.white
                                        let heightLb = "\(atrribute.name)".height(withConstrainedWidth: viewInfoBasicRow.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
                                        
                                        let lbBasicRow = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb))
                                        lbBasicRow.textAlignment = .left
                                        lbBasicRow.textColor = UIColor.black
                                        lbBasicRow.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                                        lbBasicRow.text = "\(atrribute.name)"
                                        lbBasicRow.numberOfLines = 4
                                        viewInfoBasicRow.addSubview(lbBasicRow)
                                        
                                        let heightValue1 = "\(atrribute.value)".height(withConstrainedWidth: viewInfoBasicRow.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
                                        
                                        let lbBasicValue1 = UILabel(frame: CGRect(x:viewInfoBasicRow.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue1))
                                        lbBasicValue1.textAlignment = .left
                                        lbBasicValue1.textColor = UIColor.black
                                        lbBasicValue1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                                        lbBasicValue1.text = "\(atrribute.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
                                        lbBasicValue1.numberOfLines = 10
                                        lbBasicValue1.textAlignment = .center
                                        viewInfoBasicRow.addSubview(lbBasicValue1)
                                        
                                        let heightValue2 = "\(atrributeCompare.value)".height(withConstrainedWidth: viewInfoBasicRow.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
                                        
                                        let lbBasicValue2 = UILabel(frame: CGRect(x:viewInfoBasicRow.frame.size.width * 5/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue2))
                                        lbBasicValue2.textAlignment = .left
                                        lbBasicValue2.textColor = UIColor.black
                                        lbBasicValue2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                                        lbBasicValue2.text = "\(atrributeCompare.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
                                        lbBasicValue2.numberOfLines = 10
                                        lbBasicValue2.textAlignment = .center
                                        viewInfoBasicRow.addSubview(lbBasicValue2)
                                        
                                        viewInfoBasicRow.frame.size.height = lbBasicRow.frame.origin.y + lbBasicRow.frame.size.height + Common.Size(s:10)
                                        if (heightLb < heightValue1){
                                            viewInfoBasicRow.frame.size.height = lbBasicValue1.frame.origin.y + lbBasicValue1.frame.size.height + Common.Size(s:10)
                                        }
                                        if (heightValue1 < heightValue2){
                                            viewInfoBasicRow.frame.size.height = lbBasicValue2.frame.origin.y + lbBasicValue2.frame.size.height + Common.Size(s:10)
                                        }
                                        
                                        let viewInfoBasicLine = UIView(frame: CGRect(x: viewInfoBasicRow.frame.size.width * 2/8, y: 0, width: 0.5, height: viewInfoBasicRow.frame.size.height))
                                        viewInfoBasicLine.backgroundColor = UIColor(netHex: 0x04AB6E)
                                        viewInfoBasicRow.addSubview(viewInfoBasicLine)
                                        
                                        let viewInfoBasicLine2 = UIView(frame: CGRect(x: viewInfoBasicRow.frame.size.width * 5/8, y: 0, width: 0.5, height: viewInfoBasicRow.frame.size.height))
                                        viewInfoBasicLine2.backgroundColor = UIColor(netHex: 0x04AB6E)
                                        viewInfoBasicRow.addSubview(viewInfoBasicLine2)
                                        
                                        let viewInfoBasicLineHeader = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow.frame.size.height - 0.5, width: viewInfoBasicRow.frame.size.width, height: 0.5))
                                        viewInfoBasicLineHeader.backgroundColor = UIColor(netHex: 0x04AB6E)
                                        viewInfoBasicRow.addSubview(viewInfoBasicLineHeader)
                                        
                                        indexYBasic = viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y
                                        indxGroup = indxGroup + 1
                                        
                                        break
                                    }
                                }
                            }
                            break
                        }
                    }
                }
            }
        }else{
            label1.frame.size.height = 0
            infoView.frame.origin.y = label1.frame.size.height + label1.frame.origin.y
            infoView.frame.size.height = 0
            label1.clipsToBounds = true
            infoView.clipsToBounds = true
            infoHeaderView.frame.size.height = 0
            infoHeaderView.clipsToBounds = true
            indexYBasic = infoHeaderView.frame.size.height + infoHeaderView.frame.origin.y
        }
        
        infoView.frame.size.height = indexYBasic
        //---------
        let label2 = UILabel(frame: CGRect(x: label1.frame.origin.x, y: infoView.frame.origin.y + infoView.frame.size.height, width: label1.frame.size.width, height: Common.Size(s: 35)))
        label2.text = "KỊCH BẢN THÔNG TIN TÀI CHÍNH"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        let financeView = UIView()
        financeView.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        financeView.backgroundColor = UIColor.white
        scrollView.addSubview(financeView)
       
        if(listSPLenDoi.count == 2){
            let listSP = listSPLenDoi.sorted(by: { $0.Flag < $1.Flag })

            let infoHeaderFinanceView = UIView(frame: CGRect(x: 0, y:0, width: scrollView.frame.size.width, height: Common.Size(s: 30)))
            infoHeaderFinanceView.backgroundColor = UIColor(netHex: 0x04AB6E)
            financeView.addSubview(infoHeaderFinanceView)
            
            //product 1
            let sizeNameFinance1 =  listSP[0].Cty.height(withConstrainedWidth: infoHeaderFinanceView.frame.width * 3/8, font: UIFont.boldSystemFont(ofSize: Common.Size(s:13)))
            let lbNameFinance1 = UILabel(frame: CGRect(x: infoHeaderFinanceView.frame.width * 2/8, y: Common.Size(s:10), width:infoHeaderFinanceView.frame.width * 3/8, height: sizeNameFinance1))
            lbNameFinance1.text = listSP[0].Cty
            lbNameFinance1.numberOfLines = 4
            lbNameFinance1.textColor = .white
            lbNameFinance1.textAlignment = .center
            lbNameFinance1.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
            infoHeaderFinanceView.addSubview(lbNameFinance1)
            
            //product 2
            let sizeNameFinance2 = listSP[1].Cty.height(withConstrainedWidth: infoHeaderFinanceView.frame.width * 3/8, font: UIFont.boldSystemFont(ofSize: Common.Size(s:13)))
            let lbNameFinance2 = UILabel(frame: CGRect(x: infoHeaderFinanceView.frame.width * 5/8, y: Common.Size(s:10), width:infoHeaderFinanceView.frame.width * 3/8, height: sizeNameFinance2))
            lbNameFinance2.text = listSP[1].Cty
            lbNameFinance2.numberOfLines = 4
            lbNameFinance2.textColor = .white
            lbNameFinance2.textAlignment = .center
            lbNameFinance2.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
            infoHeaderFinanceView.addSubview(lbNameFinance2)
            
            infoHeaderFinanceView.frame.size.height = lbNameFinance1.frame.size.height + lbNameFinance1.frame.origin.y + Common.Size(s:10)
            if(sizeNameFinance1 < sizeNameFinance2){
                infoHeaderFinanceView.frame.size.height = lbNameFinance2.frame.size.height + lbNameFinance2.frame.origin.y + Common.Size(s:10)
            }
            //-----
            let viewInfoBasicRow1 = UIView(frame: CGRect(x: 0, y: infoHeaderFinanceView.frame.size.height + infoHeaderFinanceView.frame.origin.y, width: infoHeaderFinanceView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow1)
            viewInfoBasicRow1.backgroundColor = UIColor.white
            
            let heightLb1 = "Kỳ hạn trả góp".height(withConstrainedWidth: viewInfoBasicRow1.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow1.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb1))
            lbBasicRow1.textAlignment = .left
            lbBasicRow1.textColor = UIColor.black
            lbBasicRow1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow1.text = "Kỳ hạn trả góp"
            lbBasicRow1.numberOfLines = 4
            viewInfoBasicRow1.addSubview(lbBasicRow1)
            
            let heightValue1_1 = "\(listSP[0].SoThangTra.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: viewInfoBasicRow1.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue1_1 = UILabel(frame: CGRect(x:viewInfoBasicRow1.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow1.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue1_1))
            lbBasicValue1_1.textAlignment = .left
            lbBasicValue1_1.textColor = UIColor.black
            lbBasicValue1_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicValue1_1.text = "\(listSP[0].SoThangTra.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
            lbBasicValue1_1.numberOfLines = 10
            lbBasicValue1_1.textAlignment = .center
            viewInfoBasicRow1.addSubview(lbBasicValue1_1)
            
            let heightValue1_2 = "\(listSP[1].SoThangTra.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: viewInfoBasicRow1.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue1_2 = UILabel(frame: CGRect(x:viewInfoBasicRow1.frame.size.width * 5/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow1.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue1_2))
            lbBasicValue1_2.textAlignment = .left
            lbBasicValue1_2.textColor = UIColor.black
            lbBasicValue1_2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicValue1_2.text = "\(listSP[1].SoThangTra.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
            lbBasicValue1_2.numberOfLines = 10
            lbBasicValue1_2.textAlignment = .center
            viewInfoBasicRow1.addSubview(lbBasicValue1_2)
            
            viewInfoBasicRow1.frame.size.height = lbBasicRow1.frame.origin.y + lbBasicRow1.frame.size.height + Common.Size(s:10)
            if (heightLb1 < heightValue1_1){
                viewInfoBasicRow1.frame.size.height = lbBasicValue1_1.frame.origin.y + lbBasicValue1_1.frame.size.height + Common.Size(s:10)
            }
            if (heightValue1_1 < heightValue1_2){
                viewInfoBasicRow1.frame.size.height = lbBasicValue1_2.frame.origin.y + lbBasicValue1_2.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader1 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow1.frame.size.height - 0.5, width: viewInfoBasicRow1.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader1.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow1.addSubview(viewInfoBasicLineHeader1)
            
            //-----
            //-----
            let viewInfoBasicRow2 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow1.frame.size.height + viewInfoBasicRow1.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow2)
            viewInfoBasicRow2.backgroundColor = UIColor.white
            
            let heightLb2 = "Giá mua".height(withConstrainedWidth: viewInfoBasicRow2.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow2 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow2.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb2))
            lbBasicRow2.textAlignment = .left
            lbBasicRow2.textColor = UIColor.black
            lbBasicRow2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow2.text = "Giá mua"
            lbBasicRow2.numberOfLines = 4
            viewInfoBasicRow2.addSubview(lbBasicRow2)
            
            let heightValue2_1 = "\(Common.convertCurrency(value:listSP[0].GiaMuaTraThang))".height(withConstrainedWidth: viewInfoBasicRow2.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue2_1 = UILabel(frame: CGRect(x:viewInfoBasicRow2.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow2.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue2_1))
            lbBasicValue2_1.textAlignment = .left
            lbBasicValue2_1.textColor = UIColor.black
            lbBasicValue2_1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue2_1.text = "\(Common.convertCurrency(value:listSP[0].GiaMuaTraThang))"
            lbBasicValue2_1.numberOfLines = 10
            lbBasicValue2_1.textAlignment = .center
            viewInfoBasicRow2.addSubview(lbBasicValue2_1)
            
            let heightValue2_2 = "\(Common.convertCurrency(value: listSP[1].GiaMuaTraThang))".height(withConstrainedWidth: viewInfoBasicRow2.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue2_2 = UILabel(frame: CGRect(x:viewInfoBasicRow2.frame.size.width * 5/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow2.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue2_2))
            lbBasicValue2_2.textAlignment = .left
            lbBasicValue2_2.textColor = UIColor.black
            lbBasicValue2_2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue2_2.text = "\(Common.convertCurrency(value:listSP[1].GiaMuaTraThang))"
            lbBasicValue2_2.numberOfLines = 10
            lbBasicValue2_2.textAlignment = .center
            viewInfoBasicRow2.addSubview(lbBasicValue2_2)
            
            viewInfoBasicRow2.frame.size.height = lbBasicRow2.frame.origin.y + lbBasicRow2.frame.size.height + Common.Size(s:10)
            if (heightLb2 < heightValue2_1){
                viewInfoBasicRow2.frame.size.height = lbBasicValue2_1.frame.origin.y + lbBasicValue2_1.frame.size.height + Common.Size(s:10)
            }
            if (heightValue2_1 < heightValue2_2){
                viewInfoBasicRow2.frame.size.height = lbBasicValue2_2.frame.origin.y + lbBasicValue2_2.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader2 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow2.frame.size.height - 0.5, width: viewInfoBasicRow2.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader2.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow2.addSubview(viewInfoBasicLineHeader2)
            //-----
            //-----
            let viewInfoBasicRow3 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow2.frame.size.height + viewInfoBasicRow2.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow3)
            viewInfoBasicRow3.backgroundColor = UIColor.white
            
            let heightLb3 = "Giá mua trả góp".height(withConstrainedWidth: viewInfoBasicRow3.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow3 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow3.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb3))
            lbBasicRow3.textAlignment = .left
            lbBasicRow3.textColor = UIColor.black
            lbBasicRow3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow3.text = "Giá mua trả góp"
            lbBasicRow3.numberOfLines = 4
            viewInfoBasicRow3.addSubview(lbBasicRow3)
            
            let heightValue3_1 = "\(Common.convertCurrency(value:listSP[0].GiaMuaTraGop))".height(withConstrainedWidth: viewInfoBasicRow3.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue3_1 = UILabel(frame: CGRect(x:viewInfoBasicRow3.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow3.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue3_1))
            lbBasicValue3_1.textAlignment = .left
            lbBasicValue3_1.textColor = UIColor.black
            lbBasicValue3_1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue3_1.text = "\(Common.convertCurrency(value:listSP[0].GiaMuaTraGop))"
            lbBasicValue3_1.numberOfLines = 10
            lbBasicValue3_1.textAlignment = .center
            viewInfoBasicRow3.addSubview(lbBasicValue3_1)
            
            let heightValue3_2 = "\(Common.convertCurrency(value: listSP[1].GiaMuaTraGop))".height(withConstrainedWidth: viewInfoBasicRow3.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue3_2 = UILabel(frame: CGRect(x:viewInfoBasicRow3.frame.size.width * 5/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow3.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue3_2))
            lbBasicValue3_2.textAlignment = .left
            lbBasicValue3_2.textColor = UIColor.black
            lbBasicValue3_2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue3_2.text = "\(Common.convertCurrency(value:listSP[1].GiaMuaTraGop))"
            lbBasicValue3_2.numberOfLines = 10
            lbBasicValue3_2.textAlignment = .center
            viewInfoBasicRow3.addSubview(lbBasicValue3_2)
            
            viewInfoBasicRow3.frame.size.height = lbBasicRow3.frame.origin.y + lbBasicRow3.frame.size.height + Common.Size(s:10)
            if (heightLb3 < heightValue3_1){
                viewInfoBasicRow3.frame.size.height = lbBasicValue3_1.frame.origin.y + lbBasicValue3_1.frame.size.height + Common.Size(s:10)
            }
            if (heightValue3_1 < heightValue3_2){
                viewInfoBasicRow3.frame.size.height = lbBasicValue3_2.frame.origin.y + lbBasicValue3_2.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader3 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow3.frame.size.height - 0.5, width: viewInfoBasicRow3.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader3.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow3.addSubview(viewInfoBasicLineHeader3)
            //-----
            //-----
            let viewInfoBasicRow4 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow3.frame.size.height + viewInfoBasicRow3.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow4)
            viewInfoBasicRow4.backgroundColor = UIColor.white
            
            let heightLb4 = "Trả trước".height(withConstrainedWidth: viewInfoBasicRow4.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow4 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow4.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb4))
            lbBasicRow4.textAlignment = .left
            lbBasicRow4.textColor = UIColor.black
            lbBasicRow4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow4.text = "Trả trước"
            lbBasicRow4.numberOfLines = 4
            viewInfoBasicRow4.addSubview(lbBasicRow4)
            
            let heightValue4_1 = "\(Common.convertCurrency(value:listSP[0].TienTraTruoc))".height(withConstrainedWidth: viewInfoBasicRow4.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue4_1 = UILabel(frame: CGRect(x:viewInfoBasicRow4.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow4.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue4_1))
            lbBasicValue4_1.textAlignment = .left
            lbBasicValue4_1.textColor = UIColor.red
            lbBasicValue4_1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue4_1.text = "\(Common.convertCurrency(value:listSP[0].TienTraTruoc))"
            lbBasicValue4_1.numberOfLines = 10
            lbBasicValue4_1.textAlignment = .center
            viewInfoBasicRow4.addSubview(lbBasicValue4_1)
            
            let heightValue4_2 = "\(Common.convertCurrency(value: listSP[1].TienTraTruoc))".height(withConstrainedWidth: viewInfoBasicRow4.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue4_2 = UILabel(frame: CGRect(x:viewInfoBasicRow4.frame.size.width * 5/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow4.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue4_2))
            lbBasicValue4_2.textAlignment = .left
            lbBasicValue4_2.textColor = UIColor.red
            lbBasicValue4_2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue4_2.text = "\(Common.convertCurrency(value:listSP[1].TienTraTruoc))"
            lbBasicValue4_2.numberOfLines = 10
            lbBasicValue4_2.textAlignment = .center
            viewInfoBasicRow4.addSubview(lbBasicValue4_2)
            
            viewInfoBasicRow4.frame.size.height = lbBasicRow4.frame.origin.y + lbBasicRow4.frame.size.height + Common.Size(s:10)
            if (heightLb4 < heightValue4_1){
                viewInfoBasicRow4.frame.size.height = lbBasicValue4_1.frame.origin.y + lbBasicValue4_1.frame.size.height + Common.Size(s:10)
            }
            if (heightValue4_1 < heightValue4_2){
                viewInfoBasicRow4.frame.size.height = lbBasicValue4_2.frame.origin.y + lbBasicValue4_2.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader4 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow4.frame.size.height - 0.5, width: viewInfoBasicRow4.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader4.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow4.addSubview(viewInfoBasicLineHeader4)
            //-----
            //-----
            let viewInfoBasicRow5 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow4.frame.size.height + viewInfoBasicRow4.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow5)
            viewInfoBasicRow5.backgroundColor = UIColor.white
            
            let heightLb5 = "Lãi suất thực".height(withConstrainedWidth: viewInfoBasicRow5.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow5 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow5.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb5))
            lbBasicRow5.textAlignment = .left
            lbBasicRow5.textColor = UIColor.black
            lbBasicRow5.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow5.text = "Lãi suất thực"
            lbBasicRow5.numberOfLines = 4
            viewInfoBasicRow5.addSubview(lbBasicRow5)
            
            let heightValue5_1 = "\(listSP[0].LaiSuatThuc) %".height(withConstrainedWidth: viewInfoBasicRow5.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue5_1 = UILabel(frame: CGRect(x:viewInfoBasicRow5.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow5.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue5_1))
            lbBasicValue5_1.textAlignment = .left
            lbBasicValue5_1.textColor = UIColor.black
            lbBasicValue5_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicValue5_1.text = "\(listSP[0].LaiSuatThuc) %"
            lbBasicValue5_1.numberOfLines = 10
            lbBasicValue5_1.textAlignment = .center
            viewInfoBasicRow5.addSubview(lbBasicValue5_1)
            
            let heightValue5_2 = "\(listSP[1].LaiSuatThuc) %".height(withConstrainedWidth: viewInfoBasicRow5.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue5_2 = UILabel(frame: CGRect(x:viewInfoBasicRow5.frame.size.width * 5/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow5.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue5_2))
            lbBasicValue5_2.textAlignment = .left
            lbBasicValue5_2.textColor = UIColor.black
            lbBasicValue5_2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicValue5_2.text = "\(listSP[1].LaiSuatThuc) %"
            lbBasicValue5_2.numberOfLines = 10
            lbBasicValue5_2.textAlignment = .center
            viewInfoBasicRow5.addSubview(lbBasicValue5_2)
            
            viewInfoBasicRow5.frame.size.height = lbBasicRow5.frame.origin.y + lbBasicRow5.frame.size.height + Common.Size(s:10)
            if (heightLb5 < heightValue5_1){
                viewInfoBasicRow5.frame.size.height = lbBasicValue5_1.frame.origin.y + lbBasicValue5_1.frame.size.height + Common.Size(s:10)
            }
            if (heightValue5_1 < heightValue5_2){
                viewInfoBasicRow5.frame.size.height = lbBasicValue5_2.frame.origin.y + lbBasicValue5_2.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader5 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow5.frame.size.height - 0.5, width: viewInfoBasicRow5.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader5.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow5.addSubview(viewInfoBasicLineHeader5)
            //-----
            //-----
            let viewInfoBasicRow6 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow5.frame.size.height + viewInfoBasicRow5.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow6)
            viewInfoBasicRow6.backgroundColor = UIColor.white
            
            let heightLb6 = "Số tiền trả góp mỗi tháng".height(withConstrainedWidth: viewInfoBasicRow6.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow6 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow6.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb6))
            lbBasicRow6.textAlignment = .left
            lbBasicRow6.textColor = UIColor.black
            lbBasicRow6.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow6.text = "Số tiền trả góp mỗi tháng"
            lbBasicRow6.numberOfLines = 4
            viewInfoBasicRow6.addSubview(lbBasicRow6)
            
            let heightValue6_1 = "\(Common.convertCurrency(value: listSP[0].GopMoiThang) )".height(withConstrainedWidth: viewInfoBasicRow6.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue6_1 = UILabel(frame: CGRect(x:viewInfoBasicRow6.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow6.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue6_1))
            lbBasicValue6_1.textAlignment = .left
            lbBasicValue6_1.textColor = UIColor.black
            lbBasicValue6_1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue6_1.text = "\(Common.convertCurrency(value: listSP[0].GopMoiThang))"
            lbBasicValue6_1.numberOfLines = 10
            lbBasicValue6_1.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicValue6_1)
            
            //
            let lbBasicLB6_1_1 = UILabel(frame: CGRect(x:lbBasicValue6_1.frame.origin.x , y: lbBasicValue6_1.frame.origin.y + lbBasicValue6_1.frame.size.height + Common.Size(s:5), width: lbBasicValue6_1.frame.size.width, height: heightValue6_1))
            lbBasicLB6_1_1.textAlignment = .left
            lbBasicLB6_1_1.textColor = UIColor.gray
            lbBasicLB6_1_1.font = UIFont.systemFont(ofSize: Common.Size(s:10))
            lbBasicLB6_1_1.text = "Phí thu hộ"
            lbBasicLB6_1_1.numberOfLines = 1
            lbBasicLB6_1_1.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicLB6_1_1)
            
            let lbBasicVL6_1_1 = UILabel(frame: CGRect(x:lbBasicLB6_1_1.frame.origin.x , y: lbBasicLB6_1_1.frame.origin.y + lbBasicLB6_1_1.frame.size.height + Common.Size(s:5), width: lbBasicLB6_1_1.frame.size.width, height: heightValue6_1))
            lbBasicVL6_1_1.textAlignment = .left
            lbBasicVL6_1_1.textColor = UIColor.black
            lbBasicVL6_1_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicVL6_1_1.text = "\(Common.convertCurrency(value: listSP[0].PhiThuHo))"
            lbBasicVL6_1_1.numberOfLines = 1
            lbBasicVL6_1_1.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicVL6_1_1)
            
            let lbBasicLB6_1_2 = UILabel(frame: CGRect(x:lbBasicVL6_1_1.frame.origin.x , y: lbBasicVL6_1_1.frame.origin.y + lbBasicVL6_1_1.frame.size.height + Common.Size(s:5), width: lbBasicVL6_1_1.frame.size.width, height: heightValue6_1))
            lbBasicLB6_1_2.textAlignment = .left
            lbBasicLB6_1_2.textColor = UIColor.gray
            lbBasicLB6_1_2.font = UIFont.systemFont(ofSize: Common.Size(s:10))
            lbBasicLB6_1_2.text = "Bảo hiểm"
            lbBasicLB6_1_2.numberOfLines = 1
            lbBasicLB6_1_2.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicLB6_1_2)
            
            let lbBasicVL6_1_2 = UILabel(frame: CGRect(x:lbBasicLB6_1_2.frame.origin.x , y: lbBasicLB6_1_2.frame.origin.y + lbBasicLB6_1_2.frame.size.height + Common.Size(s:5), width: lbBasicLB6_1_2.frame.size.width, height: heightValue6_1))
            lbBasicVL6_1_2.textAlignment = .left
            lbBasicVL6_1_2.textColor = UIColor.black
            lbBasicVL6_1_2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicVL6_1_2.text = "\(Common.convertCurrency(value: listSP[0].TienBHMoiThang))"
            lbBasicVL6_1_2.numberOfLines = 1
            lbBasicVL6_1_2.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicVL6_1_2)
            
            let lbBasicLB6_1_3 = UILabel(frame: CGRect(x:lbBasicVL6_1_2.frame.origin.x , y: lbBasicVL6_1_2.frame.origin.y + lbBasicVL6_1_2.frame.size.height + Common.Size(s:5), width: lbBasicVL6_1_2.frame.size.width, height: heightValue6_1))
            lbBasicLB6_1_3.textAlignment = .left
            lbBasicLB6_1_3.textColor = UIColor.gray
            lbBasicLB6_1_3.font = UIFont.systemFont(ofSize: Common.Size(s:10))
            lbBasicLB6_1_3.text = "Tổng chi phí"
            lbBasicLB6_1_3.numberOfLines = 1
            lbBasicLB6_1_3.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicLB6_1_3)
            
            let lbBasicVL6_1_3 = UILabel(frame: CGRect(x:lbBasicLB6_1_3.frame.origin.x , y: lbBasicLB6_1_3.frame.origin.y + lbBasicLB6_1_3.frame.size.height + Common.Size(s:5), width: lbBasicLB6_1_3.frame.size.width, height: heightValue6_1))
            lbBasicVL6_1_3.textAlignment = .left
            lbBasicVL6_1_3.textColor = UIColor.red
            lbBasicVL6_1_3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicVL6_1_3.text = "\(Common.convertCurrency(value: listSP[0].TongChiPhi))"
            lbBasicVL6_1_3.numberOfLines = 1
            lbBasicVL6_1_3.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicVL6_1_3)
            
            //
            let heightValue6_2 = "\(Common.convertCurrency(value: listSP[1].GopMoiThang))".height(withConstrainedWidth: viewInfoBasicRow6.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue6_2 = UILabel(frame: CGRect(x:viewInfoBasicRow6.frame.size.width * 5/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow6.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue6_2))
            lbBasicValue6_2.textAlignment = .left
            lbBasicValue6_2.textColor = UIColor.black
            lbBasicValue6_2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue6_2.text = "\(Common.convertCurrency(value: listSP[1].GopMoiThang))"
            lbBasicValue6_2.numberOfLines = 10
            lbBasicValue6_2.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicValue6_2)
            
            //--
            let lbBasicLB6_2_1 = UILabel(frame: CGRect(x:lbBasicValue6_2.frame.origin.x , y: lbBasicValue6_2.frame.origin.y + lbBasicValue6_2.frame.size.height + Common.Size(s:5), width: lbBasicValue6_2.frame.size.width, height: heightValue6_2))
            lbBasicLB6_2_1.textAlignment = .left
            lbBasicLB6_2_1.textColor = UIColor.gray
            lbBasicLB6_2_1.font = UIFont.systemFont(ofSize: Common.Size(s:10))
            lbBasicLB6_2_1.text = "Phí thu hộ"
            lbBasicLB6_2_1.numberOfLines = 1
            lbBasicLB6_2_1.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicLB6_2_1)
            
            let lbBasicVL6_2_1 = UILabel(frame: CGRect(x:lbBasicLB6_2_1.frame.origin.x , y: lbBasicLB6_2_1.frame.origin.y + lbBasicLB6_2_1.frame.size.height + Common.Size(s:5), width: lbBasicLB6_2_1.frame.size.width, height: heightValue6_1))
            lbBasicVL6_2_1.textAlignment = .left
            lbBasicVL6_2_1.textColor = UIColor.black
            lbBasicVL6_2_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicVL6_2_1.text = "\(Common.convertCurrency(value: listSP[1].PhiThuHo))"
            lbBasicVL6_2_1.numberOfLines = 1
            lbBasicVL6_2_1.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicVL6_2_1)
            
            let lbBasicLB6_2_2 = UILabel(frame: CGRect(x:lbBasicVL6_2_1.frame.origin.x , y: lbBasicVL6_2_1.frame.origin.y + lbBasicVL6_2_1.frame.size.height + Common.Size(s:5), width: lbBasicVL6_2_1.frame.size.width, height: heightValue6_1))
            lbBasicLB6_2_2.textAlignment = .left
            lbBasicLB6_2_2.textColor = UIColor.gray
            lbBasicLB6_2_2.font = UIFont.systemFont(ofSize: Common.Size(s:10))
            lbBasicLB6_2_2.text = "Bảo hiểm"
            lbBasicLB6_2_2.numberOfLines = 1
            lbBasicLB6_2_2.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicLB6_2_2)
            
            let lbBasicVL6_2_2 = UILabel(frame: CGRect(x:lbBasicLB6_2_2.frame.origin.x , y: lbBasicLB6_2_2.frame.origin.y + lbBasicLB6_2_2.frame.size.height + Common.Size(s:5), width: lbBasicLB6_2_2.frame.size.width, height: heightValue6_1))
            lbBasicVL6_2_2.textAlignment = .left
            lbBasicVL6_2_2.textColor = UIColor.black
            lbBasicVL6_2_2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicVL6_2_2.text = "\(Common.convertCurrency(value: listSP[1].TienBHMoiThang))"
            lbBasicVL6_2_2.numberOfLines = 1
            lbBasicVL6_2_2.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicVL6_2_2)
            
            let lbBasicLB6_2_3 = UILabel(frame: CGRect(x:lbBasicVL6_2_2.frame.origin.x , y: lbBasicVL6_2_2.frame.origin.y + lbBasicVL6_2_2.frame.size.height + Common.Size(s:5), width: lbBasicVL6_2_2.frame.size.width, height: heightValue6_1))
            lbBasicLB6_2_3.textAlignment = .left
            lbBasicLB6_2_3.textColor = UIColor.gray
            lbBasicLB6_2_3.font = UIFont.systemFont(ofSize: Common.Size(s:10))
            lbBasicLB6_2_3.text = "Tổng chi phí"
            lbBasicLB6_2_3.numberOfLines = 1
            lbBasicLB6_2_3.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicLB6_2_3)
            
            let lbBasicVL6_2_3 = UILabel(frame: CGRect(x:lbBasicLB6_2_3.frame.origin.x , y: lbBasicLB6_2_3.frame.origin.y + lbBasicLB6_2_3.frame.size.height + Common.Size(s:5), width: lbBasicLB6_2_3.frame.size.width, height: heightValue6_1))
            lbBasicVL6_2_3.textAlignment = .left
            lbBasicVL6_2_3.textColor = UIColor.red
            lbBasicVL6_2_3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicVL6_2_3.text = "\(Common.convertCurrency(value: listSP[1].TongChiPhi))"
            lbBasicVL6_2_3.numberOfLines = 1
            lbBasicVL6_2_3.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicVL6_2_3)
            
            //
            viewInfoBasicRow6.frame.size.height = lbBasicVL6_2_3.frame.origin.y + lbBasicVL6_2_3.frame.size.height + Common.Size(s:10)
            let viewInfoBasicLineHeader6 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow6.frame.size.height - 0.5, width: viewInfoBasicRow6.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader6.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow6.addSubview(viewInfoBasicLineHeader6)
            //-----
            let viewInfoBasicRow7 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow6.frame.size.height + viewInfoBasicRow6.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow7)
            viewInfoBasicRow7.backgroundColor = UIColor.white
            
            let heightLb7 = "Chênh lệch với trả thẳng".height(withConstrainedWidth: viewInfoBasicRow7.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow7 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow7.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb7))
            lbBasicRow7.textAlignment = .left
            lbBasicRow7.textColor = UIColor.black
            lbBasicRow7.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow7.text = "Chênh lệch với trả thẳng"
            lbBasicRow7.numberOfLines = 4
            viewInfoBasicRow7.addSubview(lbBasicRow7)
            
            let heightValue7_1 = "\(Common.convertCurrency(value:listSP[0].TienChenhLech))".height(withConstrainedWidth: viewInfoBasicRow7.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue7_1 = UILabel(frame: CGRect(x:viewInfoBasicRow7.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow7.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue7_1))
            lbBasicValue7_1.textAlignment = .left
            lbBasicValue7_1.textColor = UIColor.black
            lbBasicValue7_1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue7_1.text = "\(Common.convertCurrency(value:listSP[0].TienChenhLech))"
            lbBasicValue7_1.numberOfLines = 10
            lbBasicValue7_1.textAlignment = .center
            viewInfoBasicRow7.addSubview(lbBasicValue7_1)
            
            let heightValue7_2 = "\(Common.convertCurrency(value: listSP[1].TienChenhLech))".height(withConstrainedWidth: viewInfoBasicRow7.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue7_2 = UILabel(frame: CGRect(x:viewInfoBasicRow7.frame.size.width * 5/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow7.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue7_2))
            lbBasicValue7_2.textAlignment = .left
            lbBasicValue7_2.textColor = UIColor.black
            lbBasicValue7_2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue7_2.text = "\(Common.convertCurrency(value:listSP[1].TienChenhLech))"
            lbBasicValue7_2.numberOfLines = 10
            lbBasicValue7_2.textAlignment = .center
            viewInfoBasicRow7.addSubview(lbBasicValue7_2)
            
            viewInfoBasicRow7.frame.size.height = lbBasicRow7.frame.origin.y + lbBasicRow7.frame.size.height + Common.Size(s:10)
            if (heightLb7 < heightValue7_1){
                viewInfoBasicRow7.frame.size.height = lbBasicValue7_1.frame.origin.y + lbBasicValue7_1.frame.size.height + Common.Size(s:10)
            }
            if (heightValue7_1 < heightValue7_2){
                viewInfoBasicRow7.frame.size.height = lbBasicValue7_2.frame.origin.y + lbBasicValue7_2.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader7 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow7.frame.size.height - 0.5, width: viewInfoBasicRow7.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader7.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow7.addSubview(viewInfoBasicLineHeader7)

           
            //-----
            //-----
            let viewInfoBasicRow8 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow7.frame.size.height + viewInfoBasicRow7.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow8)
            viewInfoBasicRow8.backgroundColor = UIColor.white
            
            let heightLb8 = "Giấy tờ cần có".height(withConstrainedWidth: viewInfoBasicRow8.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow8 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow8.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb8))
            lbBasicRow8.textAlignment = .left
            lbBasicRow8.textColor = UIColor.black
            lbBasicRow8.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow8.text = "Giấy tờ cần có"
            lbBasicRow8.numberOfLines = 4
            viewInfoBasicRow8.addSubview(lbBasicRow8)
            
            let swiftyString1 = "-\(listSP[0].GiayToCanCo)".replacingOccurrences(of: "@", with: "\r\n-")
            
            let heightValue8_1 = swiftyString1.height(withConstrainedWidth: viewInfoBasicRow8.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue8_1 = UILabel(frame: CGRect(x:viewInfoBasicRow8.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow8.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue8_1))
            lbBasicValue8_1.textAlignment = .left
            lbBasicValue8_1.textColor = UIColor.black
            lbBasicValue8_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicValue8_1.text = swiftyString1
            lbBasicValue8_1.numberOfLines = 10
            lbBasicValue8_1.textAlignment = .left
            viewInfoBasicRow8.addSubview(lbBasicValue8_1)
            
             let swiftyString2 = "-\(listSP[1].GiayToCanCo)".replacingOccurrences(of: "@", with: "\r\n-")
            
            let heightValue8_2 = swiftyString2.height(withConstrainedWidth: viewInfoBasicRow8.frame.size.width * 3/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue8_2 = UILabel(frame: CGRect(x:viewInfoBasicRow8.frame.size.width * 5/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow8.frame.size.width * 3/8 - Common.Size(s:10), height: heightValue8_2))
            lbBasicValue8_2.textAlignment = .left
            lbBasicValue8_2.textColor = UIColor.black
            lbBasicValue8_2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicValue8_2.text = swiftyString2
            lbBasicValue8_2.numberOfLines = 10
            lbBasicValue8_2.textAlignment = .left
            viewInfoBasicRow8.addSubview(lbBasicValue8_2)
            
            viewInfoBasicRow8.frame.size.height = lbBasicRow8.frame.origin.y + lbBasicRow8.frame.size.height + Common.Size(s:10)
            if (heightLb8 < heightValue8_1){
                viewInfoBasicRow8.frame.size.height = lbBasicValue8_1.frame.origin.y + lbBasicValue8_1.frame.size.height + Common.Size(s:10)
            }
            if (heightValue8_1 < heightValue8_2){
                viewInfoBasicRow8.frame.size.height = lbBasicValue8_2.frame.origin.y + lbBasicValue8_2.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader8 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow8.frame.size.height - 0.5, width: viewInfoBasicRow8.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader8.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow8.addSubview(viewInfoBasicLineHeader8)
            
            
            //-----
            let viewInfoBasicRow9 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow8.frame.size.height + viewInfoBasicRow8.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow9)
            viewInfoBasicRow9.backgroundColor = UIColor.white
            
            let btCompare1 = UIButton()
            btCompare1.frame = CGRect(x: viewInfoBasicRow9.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow9.frame.size.width * 3/8 - Common.Size(s:10), height: viewInfoBasicRow9.frame.size.width / 10)
            btCompare1.backgroundColor = UIColor.blue
            btCompare1.setTitle("Mua ngay", for: .normal)
            btCompare1.addTarget(self, action: #selector(cartAction), for: .touchUpInside)
            btCompare1.layer.borderWidth = 0.5
            btCompare1.layer.borderColor = UIColor.white.cgColor
            btCompare1.layer.cornerRadius = 5.0
            viewInfoBasicRow9.addSubview(btCompare1)
            
            let btCompare2 = UIButton()
            btCompare2.frame = CGRect(x: viewInfoBasicRow9.frame.size.width *  5/8  + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow9.frame.size.width * 3/8 - Common.Size(s:10), height: viewInfoBasicRow9.frame.size.width / 10)
            btCompare2.backgroundColor = UIColor.blue
            btCompare2.setTitle("Mua ngay", for: .normal)
             btCompare2.addTarget(self, action: #selector(cartActionCompare), for: .touchUpInside)
            btCompare2.layer.borderWidth = 0.5
            btCompare2.layer.borderColor = UIColor.white.cgColor
            btCompare2.layer.cornerRadius = 5.0
            viewInfoBasicRow9.addSubview(btCompare2)
            
            viewInfoBasicRow9.frame.size.height = btCompare2.frame.origin.y + btCompare2.frame.size.height + Common.Size(s:10)
            
            let viewInfoBasicLineHeader9 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow9.frame.size.height - 0.5, width: viewInfoBasicRow9.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader9.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow9.addSubview(viewInfoBasicLineHeader9)
            
            financeView.frame.size.height = viewInfoBasicRow9.frame.size.height + viewInfoBasicRow9.frame.origin.y
            
            let viewInfoBasicLine11 = UIView(frame: CGRect(x: financeView.frame.size.width * 2/8, y: 0, width: 0.5, height: financeView.frame.size.height))
            viewInfoBasicLine11.backgroundColor = UIColor(netHex: 0x04AB6E)
            financeView.addSubview(viewInfoBasicLine11)
            let viewInfoBasicLine22 = UIView(frame: CGRect(x: financeView.frame.size.width * 5/8, y: 0, width: 0.5, height: financeView.frame.size.height))
            viewInfoBasicLine22.backgroundColor = UIColor(netHex: 0x04AB6E)
            financeView.addSubview(viewInfoBasicLine22)
            
            //-----
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: financeView.frame.size.height + financeView.frame.origin.y)
        }else if(listSPLenDoi.count == 1){
            let listSP = listSPLenDoi.sorted(by: { $0.Flag < $1.Flag })
            
            let infoHeaderFinanceView = UIView(frame: CGRect(x: 0, y:0, width: scrollView.frame.size.width, height: Common.Size(s: 30)))
            infoHeaderFinanceView.backgroundColor = UIColor(netHex: 0x04AB6E)
            financeView.addSubview(infoHeaderFinanceView)
            
            //product 1
            let sizeNameFinance1 =  listSP[0].Cty.height(withConstrainedWidth: infoHeaderFinanceView.frame.width * 6/8, font: UIFont.boldSystemFont(ofSize: Common.Size(s:13)))
            let lbNameFinance1 = UILabel(frame: CGRect(x: infoHeaderFinanceView.frame.width * 2/8, y: Common.Size(s:10), width:infoHeaderFinanceView.frame.width * 6/8, height: sizeNameFinance1))
            lbNameFinance1.text = listSP[0].Cty
            lbNameFinance1.numberOfLines = 4
            lbNameFinance1.textColor = .white
            lbNameFinance1.textAlignment = .center
            lbNameFinance1.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
            infoHeaderFinanceView.addSubview(lbNameFinance1)
            
            infoHeaderFinanceView.frame.size.height = lbNameFinance1.frame.size.height + lbNameFinance1.frame.origin.y + Common.Size(s:10)

            //-----
            let viewInfoBasicRow1 = UIView(frame: CGRect(x: 0, y: infoHeaderFinanceView.frame.size.height + infoHeaderFinanceView.frame.origin.y, width: infoHeaderFinanceView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow1)
            viewInfoBasicRow1.backgroundColor = UIColor.white
            
            let heightLb1 = "Kỳ hạn trả góp".height(withConstrainedWidth: viewInfoBasicRow1.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow1.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb1))
            lbBasicRow1.textAlignment = .left
            lbBasicRow1.textColor = UIColor.black
            lbBasicRow1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow1.text = "Kỳ hạn trả góp"
            lbBasicRow1.numberOfLines = 4
            viewInfoBasicRow1.addSubview(lbBasicRow1)
            
            let heightValue1_1 = "\(listSP[0].SoThangTra.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: viewInfoBasicRow1.frame.size.width * 6/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue1_1 = UILabel(frame: CGRect(x:viewInfoBasicRow1.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow1.frame.size.width * 6/8 - Common.Size(s:10), height: heightValue1_1))
            lbBasicValue1_1.textAlignment = .left
            lbBasicValue1_1.textColor = UIColor.black
            lbBasicValue1_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicValue1_1.text = "\(listSP[0].SoThangTra.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
            lbBasicValue1_1.numberOfLines = 10
            lbBasicValue1_1.textAlignment = .center
            viewInfoBasicRow1.addSubview(lbBasicValue1_1)
            
            viewInfoBasicRow1.frame.size.height = lbBasicRow1.frame.origin.y + lbBasicRow1.frame.size.height + Common.Size(s:10)
            if (heightLb1 < heightValue1_1){
                viewInfoBasicRow1.frame.size.height = lbBasicValue1_1.frame.origin.y + lbBasicValue1_1.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader1 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow1.frame.size.height - 0.5, width: viewInfoBasicRow1.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader1.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow1.addSubview(viewInfoBasicLineHeader1)
            
            //-----
            //-----
            let viewInfoBasicRow2 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow1.frame.size.height + viewInfoBasicRow1.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow2)
            viewInfoBasicRow2.backgroundColor = UIColor.white
            
            let heightLb2 = "Giá mua".height(withConstrainedWidth: viewInfoBasicRow2.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow2 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow2.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb2))
            lbBasicRow2.textAlignment = .left
            lbBasicRow2.textColor = UIColor.black
            lbBasicRow2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow2.text = "Giá mua"
            lbBasicRow2.numberOfLines = 4
            viewInfoBasicRow2.addSubview(lbBasicRow2)
            
            let heightValue2_1 = "\(Common.convertCurrency(value:listSP[0].GiaMuaTraThang))".height(withConstrainedWidth: viewInfoBasicRow2.frame.size.width * 6/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue2_1 = UILabel(frame: CGRect(x:viewInfoBasicRow2.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow2.frame.size.width * 6/8 - Common.Size(s:10), height: heightValue2_1))
            lbBasicValue2_1.textAlignment = .left
            lbBasicValue2_1.textColor = UIColor.black
            lbBasicValue2_1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue2_1.text = "\(Common.convertCurrency(value:listSP[0].GiaMuaTraThang))"
            lbBasicValue2_1.numberOfLines = 10
            lbBasicValue2_1.textAlignment = .center
            viewInfoBasicRow2.addSubview(lbBasicValue2_1)
            
            
            
            viewInfoBasicRow2.frame.size.height = lbBasicRow2.frame.origin.y + lbBasicRow2.frame.size.height + Common.Size(s:10)
            if (heightLb2 < heightValue2_1){
                viewInfoBasicRow2.frame.size.height = lbBasicValue2_1.frame.origin.y + lbBasicValue2_1.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader2 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow2.frame.size.height - 0.5, width: viewInfoBasicRow2.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader2.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow2.addSubview(viewInfoBasicLineHeader2)
            //-----
            //-----
            let viewInfoBasicRow3 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow2.frame.size.height + viewInfoBasicRow2.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow3)
            viewInfoBasicRow3.backgroundColor = UIColor.white
            
            let heightLb3 = "Giá mua trả góp".height(withConstrainedWidth: viewInfoBasicRow3.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow3 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow3.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb3))
            lbBasicRow3.textAlignment = .left
            lbBasicRow3.textColor = UIColor.black
            lbBasicRow3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow3.text = "Giá mua trả góp"
            lbBasicRow3.numberOfLines = 4
            viewInfoBasicRow3.addSubview(lbBasicRow3)
            
            let heightValue3_1 = "\(Common.convertCurrency(value:listSP[0].GiaMuaTraGop))".height(withConstrainedWidth: viewInfoBasicRow3.frame.size.width * 6/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue3_1 = UILabel(frame: CGRect(x:viewInfoBasicRow3.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow3.frame.size.width * 6/8 - Common.Size(s:10), height: heightValue3_1))
            lbBasicValue3_1.textAlignment = .left
            lbBasicValue3_1.textColor = UIColor.black
            lbBasicValue3_1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue3_1.text = "\(Common.convertCurrency(value:listSP[0].GiaMuaTraGop))"
            lbBasicValue3_1.numberOfLines = 10
            lbBasicValue3_1.textAlignment = .center
            viewInfoBasicRow3.addSubview(lbBasicValue3_1)
            
            
            
            viewInfoBasicRow3.frame.size.height = lbBasicRow3.frame.origin.y + lbBasicRow3.frame.size.height + Common.Size(s:10)
            if (heightLb3 < heightValue3_1){
                viewInfoBasicRow3.frame.size.height = lbBasicValue3_1.frame.origin.y + lbBasicValue3_1.frame.size.height + Common.Size(s:10)
            }
           
            let viewInfoBasicLineHeader3 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow3.frame.size.height - 0.5, width: viewInfoBasicRow3.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader3.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow3.addSubview(viewInfoBasicLineHeader3)
            //-----
            //-----
            let viewInfoBasicRow4 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow3.frame.size.height + viewInfoBasicRow3.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow4)
            viewInfoBasicRow4.backgroundColor = UIColor.white
            
            let heightLb4 = "Trả trước".height(withConstrainedWidth: viewInfoBasicRow4.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow4 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow4.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb4))
            lbBasicRow4.textAlignment = .left
            lbBasicRow4.textColor = UIColor.black
            lbBasicRow4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow4.text = "Trả trước"
            lbBasicRow4.numberOfLines = 4
            viewInfoBasicRow4.addSubview(lbBasicRow4)
            
            let heightValue4_1 = "\(Common.convertCurrency(value:listSP[0].TienTraTruoc))".height(withConstrainedWidth: viewInfoBasicRow4.frame.size.width * 6/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue4_1 = UILabel(frame: CGRect(x:viewInfoBasicRow4.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow4.frame.size.width * 6/8 - Common.Size(s:10), height: heightValue4_1))
            lbBasicValue4_1.textAlignment = .left
            lbBasicValue4_1.textColor = UIColor.red
            lbBasicValue4_1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue4_1.text = "\(Common.convertCurrency(value:listSP[0].TienTraTruoc))"
            lbBasicValue4_1.numberOfLines = 10
            lbBasicValue4_1.textAlignment = .center
            viewInfoBasicRow4.addSubview(lbBasicValue4_1)
            
            
            
            viewInfoBasicRow4.frame.size.height = lbBasicRow4.frame.origin.y + lbBasicRow4.frame.size.height + Common.Size(s:10)
            if (heightLb4 < heightValue4_1){
                viewInfoBasicRow4.frame.size.height = lbBasicValue4_1.frame.origin.y + lbBasicValue4_1.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader4 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow4.frame.size.height - 0.5, width: viewInfoBasicRow4.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader4.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow4.addSubview(viewInfoBasicLineHeader4)
            //-----
            //-----
            let viewInfoBasicRow5 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow4.frame.size.height + viewInfoBasicRow4.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow5)
            viewInfoBasicRow5.backgroundColor = UIColor.white
            
            let heightLb5 = "Lãi suất thực".height(withConstrainedWidth: viewInfoBasicRow5.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow5 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow5.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb5))
            lbBasicRow5.textAlignment = .left
            lbBasicRow5.textColor = UIColor.black
            lbBasicRow5.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow5.text = "Lãi suất thực"
            lbBasicRow5.numberOfLines = 4
            viewInfoBasicRow5.addSubview(lbBasicRow5)
            
            let heightValue5_1 = "\(listSP[0].LaiSuatThuc) %".height(withConstrainedWidth: viewInfoBasicRow5.frame.size.width * 6/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue5_1 = UILabel(frame: CGRect(x:viewInfoBasicRow5.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow5.frame.size.width * 6/8 - Common.Size(s:10), height: heightValue5_1))
            lbBasicValue5_1.textAlignment = .left
            lbBasicValue5_1.textColor = UIColor.black
            lbBasicValue5_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicValue5_1.text = "\(listSP[0].LaiSuatThuc) %"
            lbBasicValue5_1.numberOfLines = 10
            lbBasicValue5_1.textAlignment = .center
            viewInfoBasicRow5.addSubview(lbBasicValue5_1)
            
            
            
            viewInfoBasicRow5.frame.size.height = lbBasicRow5.frame.origin.y + lbBasicRow5.frame.size.height + Common.Size(s:10)
            if (heightLb5 < heightValue5_1){
                viewInfoBasicRow5.frame.size.height = lbBasicValue5_1.frame.origin.y + lbBasicValue5_1.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader5 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow5.frame.size.height - 0.5, width: viewInfoBasicRow5.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader5.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow5.addSubview(viewInfoBasicLineHeader5)
            //-----
            //-----
            let viewInfoBasicRow6 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow5.frame.size.height + viewInfoBasicRow5.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow6)
            viewInfoBasicRow6.backgroundColor = UIColor.white
            
            let heightLb6 = "Số tiền trả góp mỗi tháng".height(withConstrainedWidth: viewInfoBasicRow6.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow6 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow6.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb6))
            lbBasicRow6.textAlignment = .left
            lbBasicRow6.textColor = UIColor.black
            lbBasicRow6.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow6.text = "Số tiền trả góp mỗi tháng"
            lbBasicRow6.numberOfLines = 4
            viewInfoBasicRow6.addSubview(lbBasicRow6)
            
            let heightValue6_1 = "\(Common.convertCurrency(value: listSP[0].GopMoiThang) )".height(withConstrainedWidth: viewInfoBasicRow6.frame.size.width * 6/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue6_1 = UILabel(frame: CGRect(x:viewInfoBasicRow6.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow6.frame.size.width * 6/8 - Common.Size(s:10), height: heightValue6_1))
            lbBasicValue6_1.textAlignment = .left
            lbBasicValue6_1.textColor = UIColor.black
            lbBasicValue6_1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue6_1.text = "\(Common.convertCurrency(value: listSP[0].GopMoiThang))"
            lbBasicValue6_1.numberOfLines = 10
            lbBasicValue6_1.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicValue6_1)
            
            //
            let lbBasicLB6_1_1 = UILabel(frame: CGRect(x:lbBasicValue6_1.frame.origin.x , y: lbBasicValue6_1.frame.origin.y + lbBasicValue6_1.frame.size.height + Common.Size(s:5), width: lbBasicValue6_1.frame.size.width, height: heightValue6_1))
            lbBasicLB6_1_1.textAlignment = .left
            lbBasicLB6_1_1.textColor = UIColor.gray
            lbBasicLB6_1_1.font = UIFont.systemFont(ofSize: Common.Size(s:10))
            lbBasicLB6_1_1.text = "Phí thu hộ"
            lbBasicLB6_1_1.numberOfLines = 1
            lbBasicLB6_1_1.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicLB6_1_1)
            
            let lbBasicVL6_1_1 = UILabel(frame: CGRect(x:lbBasicLB6_1_1.frame.origin.x , y: lbBasicLB6_1_1.frame.origin.y + lbBasicLB6_1_1.frame.size.height + Common.Size(s:5), width: lbBasicLB6_1_1.frame.size.width, height: heightValue6_1))
            lbBasicVL6_1_1.textAlignment = .left
            lbBasicVL6_1_1.textColor = UIColor.black
            lbBasicVL6_1_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicVL6_1_1.text = "\(Common.convertCurrency(value: listSP[0].PhiThuHo))"
            lbBasicVL6_1_1.numberOfLines = 1
            lbBasicVL6_1_1.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicVL6_1_1)
            
            let lbBasicLB6_1_2 = UILabel(frame: CGRect(x:lbBasicVL6_1_1.frame.origin.x , y: lbBasicVL6_1_1.frame.origin.y + lbBasicVL6_1_1.frame.size.height + Common.Size(s:5), width: lbBasicVL6_1_1.frame.size.width, height: heightValue6_1))
            lbBasicLB6_1_2.textAlignment = .left
            lbBasicLB6_1_2.textColor = UIColor.gray
            lbBasicLB6_1_2.font = UIFont.systemFont(ofSize: Common.Size(s:10))
            lbBasicLB6_1_2.text = "Bảo hiểm"
            lbBasicLB6_1_2.numberOfLines = 1
            lbBasicLB6_1_2.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicLB6_1_2)
            
            let lbBasicVL6_1_2 = UILabel(frame: CGRect(x:lbBasicLB6_1_2.frame.origin.x , y: lbBasicLB6_1_2.frame.origin.y + lbBasicLB6_1_2.frame.size.height + Common.Size(s:5), width: lbBasicLB6_1_2.frame.size.width, height: heightValue6_1))
            lbBasicVL6_1_2.textAlignment = .left
            lbBasicVL6_1_2.textColor = UIColor.black
            lbBasicVL6_1_2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicVL6_1_2.text = "\(Common.convertCurrency(value: listSP[0].TienBHMoiThang))"
            lbBasicVL6_1_2.numberOfLines = 1
            lbBasicVL6_1_2.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicVL6_1_2)
            
            let lbBasicLB6_1_3 = UILabel(frame: CGRect(x:lbBasicVL6_1_2.frame.origin.x , y: lbBasicVL6_1_2.frame.origin.y + lbBasicVL6_1_2.frame.size.height + Common.Size(s:5), width: lbBasicVL6_1_2.frame.size.width, height: heightValue6_1))
            lbBasicLB6_1_3.textAlignment = .left
            lbBasicLB6_1_3.textColor = UIColor.gray
            lbBasicLB6_1_3.font = UIFont.systemFont(ofSize: Common.Size(s:10))
            lbBasicLB6_1_3.text = "Tổng chi phí"
            lbBasicLB6_1_3.numberOfLines = 1
            lbBasicLB6_1_3.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicLB6_1_3)
            
            let lbBasicVL6_1_3 = UILabel(frame: CGRect(x:lbBasicLB6_1_3.frame.origin.x , y: lbBasicLB6_1_3.frame.origin.y + lbBasicLB6_1_3.frame.size.height + Common.Size(s:5), width: lbBasicLB6_1_3.frame.size.width, height: heightValue6_1))
            lbBasicVL6_1_3.textAlignment = .left
            lbBasicVL6_1_3.textColor = UIColor.red
            lbBasicVL6_1_3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicVL6_1_3.text = "\(Common.convertCurrency(value: listSP[0].TongChiPhi))"
            lbBasicVL6_1_3.numberOfLines = 1
            lbBasicVL6_1_3.textAlignment = .center
            viewInfoBasicRow6.addSubview(lbBasicVL6_1_3)
            
            //
            viewInfoBasicRow6.frame.size.height = lbBasicVL6_1_3.frame.origin.y + lbBasicVL6_1_3.frame.size.height + Common.Size(s:10)
            let viewInfoBasicLineHeader6 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow6.frame.size.height - 0.5, width: viewInfoBasicRow6.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader6.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow6.addSubview(viewInfoBasicLineHeader6)
            //-----
            let viewInfoBasicRow7 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow6.frame.size.height + viewInfoBasicRow6.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow7)
            viewInfoBasicRow7.backgroundColor = UIColor.white
            
            let heightLb7 = "Chênh lệch với trả thẳng".height(withConstrainedWidth: viewInfoBasicRow7.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow7 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow7.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb7))
            lbBasicRow7.textAlignment = .left
            lbBasicRow7.textColor = UIColor.black
            lbBasicRow7.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow7.text = "Chênh lệch với trả thẳng"
            lbBasicRow7.numberOfLines = 4
            viewInfoBasicRow7.addSubview(lbBasicRow7)
            
            let heightValue7_1 = "\(Common.convertCurrency(value:listSP[0].TienChenhLech))".height(withConstrainedWidth: viewInfoBasicRow7.frame.size.width * 6/8 - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue7_1 = UILabel(frame: CGRect(x:viewInfoBasicRow7.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow7.frame.size.width * 6/8 - Common.Size(s:10), height: heightValue7_1))
            lbBasicValue7_1.textAlignment = .left
            lbBasicValue7_1.textColor = UIColor.black
            lbBasicValue7_1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbBasicValue7_1.text = "\(Common.convertCurrency(value:listSP[0].TienChenhLech))"
            lbBasicValue7_1.numberOfLines = 10
            lbBasicValue7_1.textAlignment = .center
            viewInfoBasicRow7.addSubview(lbBasicValue7_1)
            
            
            
            viewInfoBasicRow7.frame.size.height = lbBasicRow7.frame.origin.y + lbBasicRow7.frame.size.height + Common.Size(s:10)
            if (heightLb7 < heightValue7_1){
                viewInfoBasicRow7.frame.size.height = lbBasicValue7_1.frame.origin.y + lbBasicValue7_1.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader7 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow7.frame.size.height - 0.5, width: viewInfoBasicRow7.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader7.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow7.addSubview(viewInfoBasicLineHeader7)
            
            
            //-----
            //-----
            let viewInfoBasicRow8 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow7.frame.size.height + viewInfoBasicRow7.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow8)
            viewInfoBasicRow8.backgroundColor = UIColor.white
            
            let heightLb8 = "Giấy tờ cần có".height(withConstrainedWidth: viewInfoBasicRow8.frame.size.width * 2/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicRow8 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow8.frame.size.width * 2/8 - Common.Size(s:10), height: heightLb8))
            lbBasicRow8.textAlignment = .left
            lbBasicRow8.textColor = UIColor.black
            lbBasicRow8.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicRow8.text = "Giấy tờ cần có"
            lbBasicRow8.numberOfLines = 4
            viewInfoBasicRow8.addSubview(lbBasicRow8)
            
            let swiftyString1 = "-\(listSP[0].GiayToCanCo)".replacingOccurrences(of: "@", with: "\r\n-")
            
            let heightValue8_1 = swiftyString1.height(withConstrainedWidth: viewInfoBasicRow8.frame.size.width * 6/8 - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbBasicValue8_1 = UILabel(frame: CGRect(x:viewInfoBasicRow8.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow8.frame.size.width * 6/8 - Common.Size(s:10), height: heightValue8_1))
            lbBasicValue8_1.textAlignment = .left
            lbBasicValue8_1.textColor = UIColor.black
            lbBasicValue8_1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbBasicValue8_1.text = swiftyString1
            lbBasicValue8_1.numberOfLines = 10
            lbBasicValue8_1.textAlignment = .left
            viewInfoBasicRow8.addSubview(lbBasicValue8_1)
            
            
            
            viewInfoBasicRow8.frame.size.height = lbBasicRow8.frame.origin.y + lbBasicRow8.frame.size.height + Common.Size(s:10)
            if (heightLb8 < heightValue8_1){
                viewInfoBasicRow8.frame.size.height = lbBasicValue8_1.frame.origin.y + lbBasicValue8_1.frame.size.height + Common.Size(s:10)
            }
            let viewInfoBasicLineHeader8 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow8.frame.size.height - 0.5, width: viewInfoBasicRow8.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader8.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow8.addSubview(viewInfoBasicLineHeader8)
            
            
            //-----
            let viewInfoBasicRow9 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow8.frame.size.height + viewInfoBasicRow8.frame.origin.y, width: infoHeaderView.frame.size.width, height: CGFloat(50.0)))
            financeView.addSubview(viewInfoBasicRow9)
            viewInfoBasicRow9.backgroundColor = UIColor.white
            
            let btCompare1 = UIButton()
            btCompare1.frame = CGRect(x: viewInfoBasicRow9.frame.size.width * 2/8 + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow9.frame.size.width * 6/8 - Common.Size(s:10), height: viewInfoBasicRow9.frame.size.width / 10)
            btCompare1.backgroundColor = UIColor.blue
            btCompare1.setTitle("Mua ngay", for: .normal)
            btCompare1.addTarget(self, action: #selector(cartAction), for: .touchUpInside)
            btCompare1.layer.borderWidth = 0.5
            btCompare1.layer.borderColor = UIColor.white.cgColor
            btCompare1.layer.cornerRadius = 5.0
            viewInfoBasicRow9.addSubview(btCompare1)
            
           
            
            viewInfoBasicRow9.frame.size.height = btCompare1.frame.origin.y + btCompare1.frame.size.height + Common.Size(s:10)
            
            let viewInfoBasicLineHeader9 = UIView(frame: CGRect(x: 0, y: viewInfoBasicRow9.frame.size.height - 0.5, width: viewInfoBasicRow9.frame.size.width, height: 0.5))
            viewInfoBasicLineHeader9.backgroundColor = UIColor(netHex: 0x04AB6E)
            viewInfoBasicRow9.addSubview(viewInfoBasicLineHeader9)
            
            financeView.frame.size.height = viewInfoBasicRow9.frame.size.height + viewInfoBasicRow9.frame.origin.y
            
            let viewInfoBasicLine11 = UIView(frame: CGRect(x: financeView.frame.size.width * 2/8, y: 0, width: 0.5, height: financeView.frame.size.height))
            viewInfoBasicLine11.backgroundColor = UIColor(netHex: 0x04AB6E)
            financeView.addSubview(viewInfoBasicLine11)
          
            
            //-----
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: financeView.frame.size.height + financeView.frame.origin.y)
        }else{
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: financeView.frame.size.height + financeView.frame.origin.y)
        }
    }
    @objc func cartAction(_ sender:UITapGestureRecognizer){
        //
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                ProductAPIManager.mpos_FRT_SP_innovation_MDMH_Sim(itemcode:self.product.product.sku,handler: { (results, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if(err.count <= 0){
                            if (self.product.product.qlSerial == "Y"){
                                var arrColor:[String] = []
                                for item in self.product.variant {
                                    arrColor.append(item.colorName)
                                }
                                if (arrColor.count == 1){
                                    let sku = self.product.variant[0].sku
                                    let colorProduct = self.product.variant[0].colorValue
                                    let priceBeforeTax = self.product.variant[0].priceBeforeTax
                                    let price = self.product.variant[0].price
                                    let product = self.product.product.copy() as! Product
                                    
                                    product.sku = sku
                                    product.price = price
                                    product.priceBeforeTax = priceBeforeTax
                                    product.brandName = results[0].Brandname
                                    product.labelName = results[0].p_sim
                                    
                                    let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                    Cache.carts.append(cart)
                                    Cache.itemsPromotion.removeAll()
                                    
                                    let newViewController = CartViewController()
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                    
                                }else{
                 
                                    //
                                    self.customAlert = PopUpPickColorView()
                                    self.customAlert.showAlert(with: "Chọn màu sản phẩm", on: self,productView: self.product,mdmhSimView:results[0],isAccessoriesView:false)
                                    //
                                    
                                }
                                
                            }else{
                                // da chuuyen san phu kien
                            }
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.present(alert, animated: true)
                        }
                        
                    }
                    
                })
            
        }
        //
    
        
    }
    @objc func cartActionCompare(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            ProductAPIManager.mpos_FRT_SP_innovation_MDMH_Sim(itemcode:self.compareProduct.product.sku,handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(err.count <= 0){
                        if (self.compareProduct.product.qlSerial == "Y"){
                            var arrColor:[String] = []
                            for item in self.compareProduct.variant {
                                arrColor.append(item.colorName)
                            }
                            if (arrColor.count == 1){
                                let sku = self.compareProduct.variant[0].sku
                                let colorProduct = self.compareProduct.variant[0].colorValue
                                let priceBeforeTax = self.compareProduct.variant[0].priceBeforeTax
                                let price = self.compareProduct.variant[0].price
                                let product = self.compareProduct.product.copy() as! Product
                                
                                product.sku = sku
                                product.price = price
                                product.priceBeforeTax = priceBeforeTax
                                product.brandName = results[0].Brandname
                                product.labelName = results[0].p_sim
                                
                                let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                Cache.carts.append(cart)
                                Cache.itemsPromotion.removeAll()
                                
                                let newViewController = CartViewController()
                                self.navigationController?.pushViewController(newViewController, animated: true)
                                
                            }else{
                                
                                //
                                self.customAlert = PopUpPickColorView()
                                self.customAlert.showAlert(with: "Chọn màu sản phẩm", on: self,productView: self.compareProduct,mdmhSimView:results[0],isAccessoriesView:false)
                                //
                                
                            }
                            
                        }else{
                            // da chuuyen san phu kien
                        }
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    
                }
                
            })
            
        }
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
