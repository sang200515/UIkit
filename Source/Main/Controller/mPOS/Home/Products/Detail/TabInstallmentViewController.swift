//
//  TabInstallmentViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ActionSheetPicker_3_0
import Toaster
class TabInstallmentViewController: UIViewController{
    
    var scrollView:UIScrollView!
    var viewCustomChoose: UIView!
    var viewListResult: UIView!
    var header: UIView!
    
    var proID: String!
    var prePayID: String!
    var termID: String!
    
    var lbBasicValue1:UILabel!
    var lbBasicTitle1:UILabel!
    var row1:UIView!
    var lineRow1:UIView!
    
    var line1Row1:UIView!
    var row2:UIView!
    var row3:UIView!
    var viewChoose:UIView!
    var btCheck: UIButton!
    
    var lbBasicValue2:UILabel!
    var lbBasicTitle2:UILabel!
    
    var lbBasicValue3:UILabel!
    var lbBasicTitle3:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Trả góp"
        navigationController?.navigationBar.isTranslucent = false
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 2)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        //header
        header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 400))
        header.backgroundColor = .white
        scrollView.addSubview(header)
        
        //shop name
        let sizeShopName = "\(String(describing: Cache.user!.ShopName))".height(withConstrainedWidth: self.view.frame.size.width - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:18)))
        let lbNameShop = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: self.view.frame.size.width - Common.Size(s:10), height: sizeShopName))
        lbNameShop.textAlignment = .center
        lbNameShop.textColor = UIColor(netHex:0x47B054)
        lbNameShop.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbNameShop.text = "\(String(describing: Cache.user!.ShopName))"
        lbNameShop.numberOfLines = 1
        header.addSubview(lbNameShop)
        
        //CompanyAmortization`
        let lbCompanyAmortization = UILabel(frame: CGRect(x: 0, y: lbNameShop.frame.size.height + lbNameShop.frame.origin.y + Common.Size(s:10), width: header.frame.size.width, height: Common.Size(s:30)))
        lbCompanyAmortization.textAlignment = .center
        lbCompanyAmortization.textColor = UIColor.white
        lbCompanyAmortization.backgroundColor = UIColor(netHex:0x47B054)
        lbCompanyAmortization.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbCompanyAmortization.text = "Đơn vị tài chính"
        header.addSubview(lbCompanyAmortization)
        
        //row
        var indexYCompanyAmortization:CGFloat = lbCompanyAmortization.frame.size.height + lbCompanyAmortization.frame.origin.y + Common.Size(s:10)
        var indexYCompanyAmortizationMax:CGFloat = 0
        
        var count:Int = 0
        for item in Cache.companyAmortizations {
            if (count % 2 == 0){
                let lbInfoBasic = UILabel(frame: CGRect(x: 0, y: indexYCompanyAmortization, width: self.scrollView.frame.size.width/2, height: Common.Size(s:16)))
                lbInfoBasic.textAlignment = .center
                lbInfoBasic.textColor = UIColor.black
                lbInfoBasic.backgroundColor = UIColor.white
                lbInfoBasic.font = UIFont.systemFont(ofSize: Common.Size(s:16))
                lbInfoBasic.text = "\(item.ComName)"
                header.addSubview(lbInfoBasic)
                count = count + 1
                if ((lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y + Common.Size(s:10)) > indexYCompanyAmortizationMax) {
                    indexYCompanyAmortizationMax = (lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y + Common.Size(s:10))
                }
            }else{
                let lbInfoBasic = UILabel(frame: CGRect(x: self.scrollView.frame.size.width/2, y: indexYCompanyAmortization, width: self.scrollView.frame.size.width/2, height: Common.Size(s:16)))
                lbInfoBasic.textAlignment = .center
                lbInfoBasic.textColor =  UIColor.black
                lbInfoBasic.backgroundColor = UIColor.white
                lbInfoBasic.font = UIFont.systemFont(ofSize: Common.Size(s:16))
                lbInfoBasic.text = "\(item.ComName)"
                header.addSubview(lbInfoBasic)
                indexYCompanyAmortization = lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y + Common.Size(s:10)
                count = count + 1
                if ((lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y + Common.Size(s:10)) > indexYCompanyAmortizationMax) {
                    indexYCompanyAmortizationMax = (lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y + Common.Size(s:10))
                }
            }
        }
        
        //
        let items = ["Gói gợi ý", "Gói tự chọn"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.frame = CGRect(x: Common.Size(s:5), y: indexYCompanyAmortizationMax, width: self.scrollView.frame.size.width - Common.Size(s:10), height: Common.Size(s:30))
        customSC.layer.cornerRadius = 5.0
        customSC.backgroundColor = UIColor.white
        customSC.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:16))],
                                        for: .normal)
        customSC.tintColor = UIColor(netHex:0x47B054)
        
        customSC.addTarget(self, action: #selector(TabInstallmentViewController.segmentedValueChanged(_:)), for: .valueChanged)
        header.addSubview(customSC)
        header.frame.size.height = customSC.frame.origin.y + customSC.frame.size.height
        
        viewCustomChoose = UIView(frame: CGRect(x: Common.Size(s:5), y: header.frame.origin.y + header.frame.size.height + Common.Size(s:10), width: customSC.frame.size.width, height: 100))
        
        viewCustomChoose.clipsToBounds = true
        self.scrollView.addSubview(viewCustomChoose)
        viewCustomChoose.isHidden = true
        //----
        
        viewChoose = UIView(frame: CGRect(x: 0, y: 0, width: viewCustomChoose.frame.size.width, height: 100))
        viewChoose.layer.borderWidth = 0.5
        viewChoose.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        viewChoose.layer.cornerRadius = 3.0
        viewCustomChoose.addSubview(viewChoose)
        //
        row1 = UIView(frame: CGRect(x: 0, y:0, width: viewCustomChoose.frame.size.width, height: 50))
        viewChoose.addSubview(row1)
        //
        lineRow1 = UIView(frame: CGRect(x: row1.frame.size.width * 3.5 / 10, y: 0, width: 0.5, height: row1.frame.size.height))
        lineRow1.backgroundColor = UIColor(netHex:0x47B054)
        row1.addSubview(lineRow1)
        
        //
        let heightLbTitle1 = "Thủ tục".height(withConstrainedWidth: lineRow1.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        //
        lbBasicTitle1  = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: lineRow1.frame.origin.x - Common.Size(s:10), height: heightLbTitle1))
        lbBasicTitle1.textAlignment = .left
        lbBasicTitle1.textColor = UIColor.black
        lbBasicTitle1.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbBasicTitle1.text = "Thủ tục"
        lbBasicTitle1.numberOfLines = 4
        row1.addSubview(lbBasicTitle1)
        //
        let heightLbValue1 = "Chọn...".height(withConstrainedWidth: viewChoose.frame.size.width - lineRow1.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        lbBasicValue1 = UILabel(frame: CGRect(x: lineRow1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle1.frame.origin.y, width: viewChoose.frame.size.width - lineRow1.frame.origin.x - Common.Size(s:10), height: heightLbValue1))
        lbBasicValue1.textAlignment = .left
        lbBasicValue1.textColor = UIColor.black
        lbBasicValue1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbBasicValue1.text = "Chọn..."
        lbBasicValue1.numberOfLines = 4
        row1.addSubview(lbBasicValue1)
        lineRow1.frame.size.height = row1.frame.size.height
        
        line1Row1 = UIView(frame: CGRect(x: 0, y: lbBasicTitle1.frame.origin.y + lbBasicTitle1.frame.size.height + Common.Size(s:10), width: row1.frame.size.width, height: 0.5))
        line1Row1.backgroundColor = UIColor(netHex:0x47B054)
        row1.addSubview(line1Row1)
        
        row1.frame.size.height = lbBasicTitle1.frame.size.height + lbBasicTitle1.frame.origin.y + Common.Size(s:10)
        let tapProperties = UITapGestureRecognizer(target: self, action: #selector(TabInstallmentViewController.tapProperties))
        row1.isUserInteractionEnabled = true
        row1.addGestureRecognizer(tapProperties)
        //
        row2 = UIView(frame: CGRect(x: 0, y: line1Row1.frame.origin.y, width: viewCustomChoose.frame.size.width, height: 50))
        viewChoose.addSubview(row2)
        let tapPrePay = UITapGestureRecognizer(target: self, action: #selector(TabInstallmentViewController.tapPrePay))
        row2.isUserInteractionEnabled = true
        row2.addGestureRecognizer(tapPrePay)
        //
        let line2 = UIView(frame: CGRect(x: row1.frame.size.width * 3.5 / 10, y: 0, width: 0.5, height: row2.frame.size.height))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        row2.addSubview(line2)
        
        //
        let heightLbTitle2 = "Trả trước".height(withConstrainedWidth: line2.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        //
        lbBasicTitle2 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: line2.frame.origin.x - Common.Size(s:10), height: heightLbTitle2))
        lbBasicTitle2.textAlignment = .left
        lbBasicTitle2.textColor = UIColor.black
        lbBasicTitle2.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbBasicTitle2.text = "Trả trước"
        lbBasicTitle2.numberOfLines = 4
        row2.addSubview(lbBasicTitle2)
        //
        let heightLbValue2 = "Chọn...".height(withConstrainedWidth: viewChoose.frame.size.width - line2.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        lbBasicValue2 = UILabel(frame: CGRect(x: line2.frame.origin.x + Common.Size(s:5), y: lbBasicTitle2.frame.origin.y, width: viewChoose.frame.size.width - line2.frame.origin.x - Common.Size(s:10), height: heightLbValue2))
        lbBasicValue2.textAlignment = .left
        lbBasicValue2.textColor = UIColor.black
        lbBasicValue2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbBasicValue2.text = "Chọn..."
        lbBasicValue2.numberOfLines = 4
        row2.addSubview(lbBasicValue2)
        line2.frame.size.height = row2.frame.size.height
        
        let line3 = UIView(frame: CGRect(x: 0, y: lbBasicTitle2.frame.origin.y + lbBasicTitle2.frame.size.height + Common.Size(s:10), width: row2.frame.size.width, height: 0.5))
        line3.backgroundColor = UIColor(netHex:0x47B054)
        row2.addSubview(line3)
        row2.frame.size.height = lbBasicTitle2.frame.size.height + lbBasicTitle2.frame.origin.y + Common.Size(s:10)
        //
        row3 = UIView(frame: CGRect(x: 0, y: row2.frame.origin.y + row2.frame.size.height, width: viewCustomChoose.frame.size.width, height: 50))
        viewChoose.addSubview(row3)
        let line4 = UIView(frame: CGRect(x: row3.frame.size.width * 3.5 / 10, y: 0, width: 0.5, height: row3.frame.size.height))
        line4.backgroundColor = UIColor(netHex:0x47B054)
        row3.addSubview(line4)
        
        let tapTerm = UITapGestureRecognizer(target: self, action: #selector(TabInstallmentViewController.tapTerm))
        row3.isUserInteractionEnabled = true
        row3.addGestureRecognizer(tapTerm)
        //
        let heightLbTitle3 = "Số tháng trả".height(withConstrainedWidth: line4.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        //
        lbBasicTitle3 = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: line4.frame.origin.x - Common.Size(s:10), height: heightLbTitle3))
        lbBasicTitle3.textAlignment = .left
        lbBasicTitle3.textColor = UIColor.black
        lbBasicTitle3.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbBasicTitle3.text = "Số tháng trả"
        lbBasicTitle3.numberOfLines = 4
        row3.addSubview(lbBasicTitle3)
        //
        let heightLbValue3 = "Chọn...".height(withConstrainedWidth: viewChoose.frame.size.width - line4.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        lbBasicValue3 = UILabel(frame: CGRect(x: line4.frame.origin.x + Common.Size(s:5), y: lbBasicTitle3.frame.origin.y, width: viewChoose.frame.size.width - line4.frame.origin.x - Common.Size(s:10), height: heightLbValue3))
        lbBasicValue3.textAlignment = .left
        lbBasicValue3.textColor = UIColor.black
        lbBasicValue3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbBasicValue3.text = "Chọn..."
        lbBasicValue3.numberOfLines = 4
        row3.addSubview(lbBasicValue3)
        row3.frame.size.height = lbBasicTitle3.frame.size.height + lbBasicTitle3.frame.origin.y + Common.Size(s:10)
        viewChoose.frame.size.height = row3.frame.size.height + row3.frame.origin.y
        line4.frame.size.height = row3.frame.size.height
        //
        btCheck = UIButton(frame:CGRect(x: viewChoose.frame.size.width * 2 / 10, y: viewChoose.frame.origin.y + viewChoose.frame.size.height + Common.Size(s:20), width: viewChoose.frame.size.width * 6 / 10, height:viewChoose.frame.size.width * 1.2 / 10))
        btCheck.backgroundColor = UIColor(netHex:0xEF4A40)
        btCheck.setTitle("Kiểm tra gói", for: .normal)
        btCheck.addTarget(self, action: #selector(self.actionCheck), for: .touchUpInside)
        btCheck.layer.borderWidth = 0.5
        btCheck.layer.borderColor = UIColor.white.cgColor
        btCheck.layer.cornerRadius = 5.0
        viewCustomChoose.addSubview(btCheck)
        
        
        
        
        viewCustomChoose.frame.size.height = btCheck.frame.size.height + btCheck.frame.origin.y + Common.Size(s:10)
        //----
        viewListResult = UIView(frame: CGRect(x: Common.Size(s:5), y: header.frame.origin.y + header.frame.size.height + Common.Size(s:10), width: customSC.frame.size.width, height: 100))
        viewListResult.clipsToBounds = true
        self.scrollView.addSubview(viewListResult)
        MPOSAPIManager.getAmortizationsDefinitions(itemCode: "\(Cache.product?.product.sku ?? "")", price: "\(Cache.product?.product.price ?? 0)") { [weak self](results, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(results.count > 0){
                    self.loadListView(results:results)
                }
            }
        
       
        }
    }
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        viewListResult.subviews.forEach({ $0.removeFromSuperview() })
        if (sender.selectedSegmentIndex == 0){
            
            MPOSAPIManager.getAmortizationsDefinitions(itemCode: "\(Cache.product?.product.sku ?? "")", price: "\(Cache.product?.product.price ?? 0)") { [weak self] (results, err) in
                guard let self = self else {return}
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(results.count > 0){
                        self.loadListView(results:results)
                    }
                }
            }
            viewCustomChoose.isHidden = true
            viewListResult.frame.origin.y = header.frame.origin.y + header.frame.size.height + Common.Size(s:10)
        }else{
            viewCustomChoose.isHidden = false
            viewListResult.frame.origin.y = viewCustomChoose.frame.origin.y + viewCustomChoose.frame.size.height + Common.Size(s:10)
            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  viewListResult.frame.size.height +  viewListResult.frame.origin.y + Common.Size(s:5) + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        }
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:  viewListResult.frame.size.height +  viewListResult.frame.origin.y + Common.Size(s:5) + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        
    }
    @objc func tapProperties(sender:UITapGestureRecognizer) {
        MPOSAPIManager.getAllAmortizationsProperties { [weak self](results, err) in
            guard let self = self else {return}
            print(results)
            if (results.count > 0){
                var list:[String] = []
                for item in results {
                    list.append(item.ProValue)
                }
                ActionSheetStringPicker.show(withTitle: "Chọn giấy tờ bạn có", rows: list, initialSelection: 0, doneBlock: {
                    picker, value, index in
                    print("\(String(describing: results[value].ProValue))")
                    self.proID = "\(results[value].ProID)"
                    self.lbBasicValue1.text = "\(String(describing: results[value].ProValue))"
                    
                    let heightLbComValue = "\(String(describing: results[value].ProValue))".height(withConstrainedWidth: self.viewCustomChoose.frame.size.width - (self.viewCustomChoose.frame.size.width * 3.5 / 10) - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
                    
                    self.lbBasicValue1.frame.size.height = heightLbComValue
                    
                    self.lbBasicTitle1.frame.size.height = self.lbBasicValue1.frame.size.height
                    
                    self.row1.frame.size.height = self.lbBasicValue1.frame.size.height + self.lbBasicValue1.frame.origin.y + Common.Size(s:10)
                    self.line1Row1.frame.origin.y = self.lbBasicTitle1.frame.origin.y + self.lbBasicTitle1.frame.size.height + Common.Size(s:10)
                    self.lineRow1.frame.size.height =  self.row1.frame.size.height
                    self.row2.frame.origin.y = self.row1.frame.size.height + self.row1.frame.origin.y
                    self.row3.frame.origin.y = self.row2.frame.size.height + self.row2.frame.origin.y
                    self.viewChoose.frame.size.height = self.row3.frame.size.height + self.row3.frame.origin.y
                    self.btCheck.frame.origin.y = self.row3.frame.size.height + self.row3.frame.origin.y + Common.Size(s:20)
                    
                    self.viewCustomChoose.frame.size.height = self.btCheck.frame.size.height + self.btCheck.frame.origin.y + Common.Size(s:5)
                    return
                }, cancel: { ActionStringCancelBlock in
                    return
                }, origin: self.view)
                
            }
        }
        
    }
    @objc func tapPrePay(sender:UITapGestureRecognizer) {
        MPOSAPIManager.getAllAmortizationsPrePays { (results, err) in
            if (results.count > 0){
                var list:[String] = []
                for item in results {
                    list.append(item.PrePayName)
                }
                ActionSheetStringPicker.show(withTitle: "Chọn tiền trả trước", rows: list, initialSelection: 0, doneBlock: {
                    picker, value, index in
                    print("\(String(describing: results[value].PrePayName))")
                    self.prePayID = results[value].PrePayID
                    self.lbBasicValue2.text = "\(String(describing: results[value].PrePayName))"
                    
                    let heightLbComValue = "\(String(describing: results[value].PrePayName))".height(withConstrainedWidth: self.row2.frame.size.width - (self.row2.frame.size.width * 3.5 / 10) - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
                    
                    self.lbBasicValue2.frame.size.height = heightLbComValue
                    self.lbBasicTitle2.frame.size.height = self.lbBasicValue2.frame.size.height
                    
                    
                    return
                }, cancel: { ActionStringCancelBlock in
                    return
                }, origin: self.view)
                
            }
        }
        
    }
    @objc func tapTerm(sender:UITapGestureRecognizer) {
        MPOSAPIManager.getAllAmortizationsTerms { (results, err) in
            print(results)
            if (results.count > 0){
                var list:[String] = []
                for item in results {
                    list.append(item.TermName)
                }
                ActionSheetStringPicker.show(withTitle: "Chọn số tháng trả", rows: list, initialSelection: 0, doneBlock: {
                    picker, value, index in
                    print("\(String(describing: results[value].TermName))")
                    self.lbBasicValue3.text = "\(String(describing: results[value].TermName))"
                    self.termID = results[value].TermID
                    let heightLbComValue = "\(String(describing: results[value].TermName))".height(withConstrainedWidth: self.row3.frame.size.width - (self.row3.frame.size.width * 3.5 / 10) - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
                    
                    self.lbBasicValue3.frame.size.height = heightLbComValue
                    
                    self.lbBasicTitle3.frame.size.height = self.lbBasicValue3.frame.size.height
                    
                    return
                }, cancel: { ActionStringCancelBlock in
                    return
                }, origin: self.view)
                
            }
        }
        
    }
    @objc func actionCheck(sender: UIButton!) {
        let product = Cache.product!
        if (self.proID != nil && self.prePayID != nil && self.termID != nil){
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            viewListResult.subviews.forEach({ $0.removeFromSuperview() })
            MPOSAPIManager.getAmortizationsDefinitionsDetail(itemCode: "\(product.product.sku)", price: "\(product.product.price)", proID: self.proID, prePayID: self.prePayID, termID: self.termID) { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                   if(err.count <= 0){
                    if(results.count > 0){
                          self.loadListView(results: results)
                    }else{
                          Toast(text: "Không tìm thấy thông tin trả góp").show()
                    }
                    
                    }else{
                          Toast(text: err).show()
                    }
                    
                }
            }
        }else{
//            TODO
            Toast(text: "Bạn phải chọn giá trị trả góp!").show()
        }
        
    }
    func loadListView(results:[AmortizationsDefinition]){
        var indexYAmortizationsDefinition:CGFloat = 0.0
        for item in results{
            let row = UIView(frame: CGRect(x: 0, y:indexYAmortizationsDefinition, width: viewListResult.frame.size.width, height: 100))
            row.backgroundColor = UIColor.white
            row.layer.borderWidth = 0.5
            row.layer.borderColor = UIColor(netHex:0x47B054).cgColor
            row.layer.cornerRadius = 3.0
            viewListResult.addSubview(row)
            //
            let lbInfoGroup = UILabel(frame: CGRect(x: 0, y: 0, width: row.frame.size.width, height: Common.Size(s:30)))
            lbInfoGroup.textAlignment = .center
            lbInfoGroup.textColor = UIColor(netHex:0x47B054)
            lbInfoGroup.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoGroup.text = "\(item.TenGoi)"
            row.addSubview(lbInfoGroup)
            let line = UIView(frame: CGRect(x: 0, y: lbInfoGroup.frame.origin.y + lbInfoGroup.frame.size.height, width: row.frame.size.width, height: 0.5))
            line.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line)
            //
            let line1 = UIView(frame: CGRect(x: row.frame.size.width * 3.5 / 10, y: line.frame.origin.y, width: 0.5, height: row.frame.size.height - line.frame.origin.y))
            line1.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line1)
            //
            let heightLbTitle1 = "Đơn vị tài trợ".height(withConstrainedWidth: line1.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            //
            let lbBasicTitle1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: line.frame.origin.y + line.frame.size.height + Common.Size(s:10), width: line1.frame.origin.x - Common.Size(s:10), height: heightLbTitle1))
            lbBasicTitle1.textAlignment = .left
            lbBasicTitle1.textColor = UIColor.black
            lbBasicTitle1.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbBasicTitle1.text = "Đơn vị tài trợ"
            lbBasicTitle1.numberOfLines = 4
            row.addSubview(lbBasicTitle1)
            //
            let heightLbValue1 = "\(item.CongTyDuyet)".height(withConstrainedWidth: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicValue1 = UILabel(frame: CGRect(x: line1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle1.frame.origin.y, width: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), height: heightLbValue1))
            lbBasicValue1.textAlignment = .left
            lbBasicValue1.textColor = UIColor.black
            lbBasicValue1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbBasicValue1.text = "\(item.CongTyDuyet)"
            lbBasicValue1.numberOfLines = 4
            row.addSubview(lbBasicValue1)
            
            let line2 = UIView(frame: CGRect(x: 0, y: lbBasicTitle1.frame.origin.y + lbBasicTitle1.frame.size.height + Common.Size(s:10), width: row.frame.size.width, height: 0.5))
            line2.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line2)
            //
            let heightLbTitle2 = "Trả trước".height(withConstrainedWidth: line2.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicTitle2 = UILabel(frame: CGRect(x: Common.Size(s:5), y: line2.frame.origin.y + line2.frame.size.height + Common.Size(s:10), width: line1.frame.origin.x - Common.Size(s:10), height: heightLbTitle2))
            lbBasicTitle2.textAlignment = .left
            lbBasicTitle2.textColor = UIColor.black
            lbBasicTitle2.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbBasicTitle2.text = "Trả trước"
            lbBasicTitle2.numberOfLines = 4
            row.addSubview(lbBasicTitle2)
            //
            let heightLbValue2 = "\(Common.convertCurrencyFloat(value: item.TienTraTruoc))  (\(item.PhanTramTraTruoc)%)".height(withConstrainedWidth: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicValue2 = UILabel(frame: CGRect(x: line1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle2.frame.origin.y, width: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), height: heightLbValue2))
            lbBasicValue2.textAlignment = .left
            lbBasicValue2.textColor = UIColor(netHex:0xEF4A40)
            lbBasicValue2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbBasicValue2.text = "\(Common.convertCurrencyFloat(value: item.TienTraTruoc))  (\(item.PhanTramTraTruoc)%)"
            lbBasicValue2.numberOfLines = 4
            row.addSubview(lbBasicValue2)
            
            let line3 = UIView(frame: CGRect(x: 0, y: lbBasicTitle2.frame.origin.y + lbBasicTitle2.frame.size.height + Common.Size(s:10), width: row.frame.size.width, height: 0.5))
            line3.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line3)
            //
            let heightLbTitle3 = "Góp mỗi tháng".height(withConstrainedWidth: line1.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicTitle3 = UILabel(frame: CGRect(x: Common.Size(s:5), y: line3.frame.origin.y + line3.frame.size.height + Common.Size(s:10), width: line1.frame.origin.x - Common.Size(s:10), height: heightLbTitle3))
            lbBasicTitle3.textAlignment = .left
            lbBasicTitle3.textColor = UIColor.black
            lbBasicTitle3.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbBasicTitle3.text = "Góp mỗi tháng"
            lbBasicTitle3.numberOfLines = 4
            row.addSubview(lbBasicTitle3)
            
            let heightLbValue3 = "\(Common.convertCurrencyFloat(value: item.GopMoiThang))".height(withConstrainedWidth: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicValue3 = UILabel(frame: CGRect(x: line1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle3.frame.origin.y, width: viewListResult.frame.size.width - line2.frame.origin.x - Common.Size(s:10), height: heightLbValue3))
            lbBasicValue3.textAlignment = .left
            lbBasicValue3.textColor = UIColor.black
            lbBasicValue3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbBasicValue3.text = "\(Common.convertCurrencyFloat(value: item.GopMoiThang))"
            lbBasicValue3.numberOfLines = 4
            row.addSubview(lbBasicValue3)
            
            let line4 = UIView(frame: CGRect(x: 0, y:lbBasicTitle3.frame.origin.y + lbBasicTitle3.frame.size.height + Common.Size(s:10), width: row.frame.size.width, height: 0.5))
            line4.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line4)
            //
            let heightLbTitle4 = "Số tháng góp".height(withConstrainedWidth: line1.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicTitle4 = UILabel(frame: CGRect(x: Common.Size(s:5), y: line4.frame.origin.y + line4.frame.size.height + Common.Size(s:10), width: line1.frame.origin.x - Common.Size(s:10), height: heightLbTitle4))
            lbBasicTitle4.textAlignment = .left
            lbBasicTitle4.textColor = UIColor.black
            lbBasicTitle4.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbBasicTitle4.text = "Số tháng góp"
            lbBasicTitle4.numberOfLines = 4
            row.addSubview(lbBasicTitle4)
            
            let heightLbValue4 = "\(item.SoThangTra)".height(withConstrainedWidth: viewListResult.frame.size.width - line2.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicValue4 = UILabel(frame: CGRect(x: line1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle4.frame.origin.y, width: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), height: heightLbValue4))
            lbBasicValue4.textAlignment = .left
            lbBasicValue4.textColor = UIColor(netHex:0xEF4A40)
            lbBasicValue4.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbBasicValue4.text = "\(item.SoThangTra)"
            lbBasicValue4.numberOfLines = 4
            row.addSubview(lbBasicValue4)
            
            let line5 = UIView(frame: CGRect(x: 0, y:lbBasicTitle4.frame.origin.y + lbBasicTitle4.frame.size.height + Common.Size(s:10), width: row.frame.size.width, height: 0.5))
            line5.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line5)
            //
            let heightLbTitle5 = "Phí bảo hiểm".height(withConstrainedWidth: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicTitle5 = UILabel(frame: CGRect(x: Common.Size(s:5), y: line5.frame.origin.y + line5.frame.size.height + Common.Size(s:10), width: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), height: heightLbTitle5))
            lbBasicTitle5.textAlignment = .left
            lbBasicTitle5.textColor = UIColor.black
            lbBasicTitle5.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbBasicTitle5.text = "Phí bảo hiểm"
            lbBasicTitle5.numberOfLines = 4
            row.addSubview(lbBasicTitle5)
            
            let heightLbValue5 = "\(Common.convertCurrencyFloat(value: item.PhiBaoHiem))".height(withConstrainedWidth: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicValue5 = UILabel(frame: CGRect(x: line1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle5.frame.origin.y, width: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), height: heightLbValue5))
            lbBasicValue5.textAlignment = .left
            lbBasicValue5.textColor = UIColor.black
            lbBasicValue5.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbBasicValue5.text = "\(item.PhiBaoHiem.round())"
            lbBasicValue5.numberOfLines = 4
            row.addSubview(lbBasicValue5)
            
            let line6 = UIView(frame: CGRect(x: 0, y: lbBasicTitle5.frame.origin.y + lbBasicTitle5.frame.size.height + Common.Size(s:10), width: row.frame.size.width, height: 0.5))
            line6.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line6)
            //
            let heightLbTitle6 = "Phí thu hộ".height(withConstrainedWidth:  line1.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicTitle6 = UILabel(frame: CGRect(x: Common.Size(s:5), y: line6.frame.origin.y + line6.frame.size.height + Common.Size(s:10), width: line1.frame.origin.x - Common.Size(s:10), height: heightLbTitle6))
            lbBasicTitle6.textAlignment = .left
            lbBasicTitle6.textColor = UIColor.black
            lbBasicTitle6.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbBasicTitle6.text = "Phí thu hộ"
            lbBasicTitle6.numberOfLines = 4
            row.addSubview(lbBasicTitle6)
            
            let heightLbValue6 = "\(Common.convertCurrencyFloat(value: item.PhiThuHo))".height(withConstrainedWidth: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicValue6 = UILabel(frame: CGRect(x: line1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle6.frame.origin.y, width: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), height: heightLbValue6))
            lbBasicValue6.textAlignment = .left
            lbBasicValue6.textColor = UIColor.black
            lbBasicValue6.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbBasicValue6.text = "\(Common.convertCurrencyFloat(value: item.PhiThuHo))"
            lbBasicValue6.numberOfLines = 4
            row.addSubview(lbBasicValue6)
            
            let line7 = UIView(frame: CGRect(x: 0, y: lbBasicTitle6.frame.origin.y + lbBasicTitle6.frame.size.height + Common.Size(s:10), width: row.frame.size.width, height: 0.5))
            line7.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line7)
            //
            let heightLbTitle7 = "Chênh lệch".height(withConstrainedWidth: line1.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicTitle7 = UILabel(frame: CGRect(x: Common.Size(s:5), y: line7.frame.origin.y + line7.frame.size.height + Common.Size(s:10), width: line1.frame.origin.x - Common.Size(s:10), height: heightLbTitle7))
            lbBasicTitle7.textAlignment = .left
            lbBasicTitle7.textColor = UIColor.black
            lbBasicTitle7.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbBasicTitle7.text = "Chênh lệch"
            lbBasicTitle7.numberOfLines = 4
            row.addSubview(lbBasicTitle7)
            
            let heightLbValue7 = "\(Common.convertCurrencyFloat(value: item.TienChenhLech))".height(withConstrainedWidth: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicValue7 = UILabel(frame: CGRect(x: line1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle7.frame.origin.y, width: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), height: heightLbValue7))
            lbBasicValue7.textAlignment = .left
            lbBasicValue7.textColor = UIColor.black
            lbBasicValue7.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbBasicValue7.text = "\(Common.convertCurrencyFloat(value: item.TienChenhLech))"
            lbBasicValue7.numberOfLines = 4
            row.addSubview(lbBasicValue7)
            
            let line8 = UIView(frame: CGRect(x: 0, y:lbBasicTitle7.frame.origin.y + lbBasicTitle7.frame.size.height + Common.Size(s:10), width: row.frame.size.width, height: 0.5))
            line8.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line8)
            //
            let heightLbTitle8 = "Tổng tiền trả".height(withConstrainedWidth: line1.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicTitle8 = UILabel(frame: CGRect(x: Common.Size(s:5), y: line8.frame.origin.y + line8.frame.size.height + Common.Size(s:10), width: line1.frame.origin.x - Common.Size(s:10), height: heightLbTitle8))
            lbBasicTitle8.textAlignment = .left
            lbBasicTitle8.textColor = UIColor.black
            lbBasicTitle8.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbBasicTitle8.text = "Tổng tiền trả"
            lbBasicTitle8.numberOfLines = 4
            row.addSubview(lbBasicTitle8)
            
            let heightLbValue8 = "\(Common.convertCurrencyFloat(value: item.TongTienTra))".height(withConstrainedWidth: self.view.frame.size.width - line2.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicValue8 = UILabel(frame: CGRect(x: line1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle8.frame.origin.y, width: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), height: heightLbValue8))
            lbBasicValue8.textAlignment = .left
            lbBasicValue8.textColor = UIColor(netHex:0xEF4A40)
            lbBasicValue8.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbBasicValue8.text = "\(Common.convertCurrencyFloat(value: item.TongTienTra))"
            lbBasicValue8.numberOfLines = 4
            row.addSubview(lbBasicValue8)
            
            let line9 = UIView(frame: CGRect(x: 0, y: lbBasicTitle8.frame.origin.y + lbBasicTitle8.frame.size.height + Common.Size(s:10), width: row.frame.size.width, height: 0.5))
            line9.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line9)
            
            //
            let heightLbTitle9 = "Thủ tục".height(withConstrainedWidth: line2.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicTitle9 = UILabel(frame: CGRect(x: Common.Size(s:5), y: line9.frame.origin.y + line9.frame.size.height + Common.Size(s:10), width: line1.frame.origin.x - Common.Size(s:10), height: heightLbTitle9))
            lbBasicTitle9.textAlignment = .left
            lbBasicTitle9.textColor = UIColor.black
            lbBasicTitle9.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbBasicTitle9.text = "Thủ tục"
            lbBasicTitle9.numberOfLines = 4
            row.addSubview(lbBasicTitle9)
            
            let heightLbValue9 = "\(item.GiayToCanCo)".height(withConstrainedWidth: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicValue9 = UILabel(frame: CGRect(x: line1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle9.frame.origin.y, width: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), height: heightLbValue9))
            lbBasicValue9.textAlignment = .left
            lbBasicValue9.textColor = UIColor.black
            lbBasicValue9.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbBasicValue9.text = "\(item.GiayToCanCo)"
            lbBasicValue9.numberOfLines = 4
            row.addSubview(lbBasicValue9)
            
            let line10 = UIView(frame: CGRect(x: 0, y: lbBasicTitle9.frame.origin.y + lbBasicTitle9.frame.size.height + Common.Size(s:10), width: row.frame.size.width, height: 0.5))
            line10.backgroundColor = UIColor(netHex:0x47B054)
            row.addSubview(line10)
            
            //
            let heightLbTitle10 = "Scheme code".height(withConstrainedWidth: line2.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicTitle10 = UILabel(frame: CGRect(x: Common.Size(s:5), y: line10.frame.origin.y + line10.frame.size.height + Common.Size(s:10), width: line1.frame.origin.x - Common.Size(s:10), height: heightLbTitle10))
            lbBasicTitle10.textAlignment = .left
            lbBasicTitle10.textColor = UIColor.black
            lbBasicTitle10.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbBasicTitle10.text = "Scheme code"
            lbBasicTitle10.numberOfLines = 4
            row.addSubview(lbBasicTitle10)
            
            let heightLbValue10 = "\(item.SchemeCode)".height(withConstrainedWidth: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            
            let lbBasicValue10 = UILabel(frame: CGRect(x: line1.frame.origin.x + Common.Size(s:5), y: lbBasicTitle10.frame.origin.y, width: viewListResult.frame.size.width - line1.frame.origin.x - Common.Size(s:10), height: heightLbValue10))
            lbBasicValue10.textAlignment = .left
            lbBasicValue10.textColor = UIColor.black
            lbBasicValue10.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbBasicValue10.text = "\(item.SchemeCode)"
            lbBasicValue10.numberOfLines = 4
            row.addSubview(lbBasicValue10)
//            lbBasicTitle9.frame.size.height = lbBasicValue9.frame.size.height
            
            row.frame.size.height = lbBasicTitle10.frame.origin.y + lbBasicTitle10.frame.size.height + Common.Size(s:10)
            line1.frame.size.height = row.frame.size.height - line1.frame.origin.y
            indexYAmortizationsDefinition =  row.frame.origin.y + row.frame.size.height + Common.Size(s:10)
        }
        viewListResult.frame.size.height = indexYAmortizationsDefinition
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height:  viewListResult.frame.size.height +  viewListResult.frame.origin.y + Common.Size(s:100) )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

