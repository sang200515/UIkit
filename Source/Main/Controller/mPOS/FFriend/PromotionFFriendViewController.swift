//
//  PromotionFFriendViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import FZAccordionTableView
import DLRadioButton
import PopupDialog
class PromotionFFriendViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, ChangePromotionViewControllerDelegate {
    var promotions: [String:NSMutableArray] = [:]
    var lbTotalValue: UILabel!
    var tableView: FZAccordionTableView = FZAccordionTableView()
    var group: [String]!
    var radios:[DLRadioButton]!
    var groupChoose:String = ""
  
    var notPromotion : UIImageView!
    var notPromotionValue:Bool = true
    var productPromotions: [ProductPromotions]!
    var result: [PromotionsObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Khuyến mãi"
        self.view.backgroundColor = UIColor.white
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(PromotionFFriendViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        radios = [DLRadioButton]()
        group = [String]()
        
        self.promotions = Cache.promotionsFF
        self.group = Cache.groupFF
        var list: [PromotionsObject] = []
        for items in self.productPromotions {
            var check: Bool = false
            for item in list{
                //cung nhom
                if(items.Nhom == item.group){
                    var checkSPMua: Bool = false
                    var checkSPTang: Bool = false
                    //check cung sp mua
                    for itm in item.promotions!{
                        if (itm.promotionsMain.SanPham_Mua == items.SanPham_Mua){
                            //cung sp tang
                            if ((itm.promotionsMain.SanPham_Tang == items.SanPham_Tang) && items.SanPham_Tang != ""){
                                if(items.SL_ThayThe > 0){
                                    let pro1: ProductPromotions = ProductPromotions(Loai_KM: items.Loai_KM, MaCTKM: items.MaCTKM, MaSP: items.MaSP, TenSanPham_Mua: items.TenSanPham_Mua, Nhom: items.Nhom, SL_Tang: items.SL_ThayThe, SanPham_Tang: items.MaSP_ThayThe, SanPham_Mua: items.SanPham_Mua, TenCTKM: items.TenCTKM, TenSanPham_Tang: items.TenSP_ThayThe, TienGiam: items.TienGiam, MaSP_ThayThe: "", SL_ThayThe: 0, TenSP_ThayThe: "", MenhGia_VC: items.MenhGia_VC, VC_used: items.VC_used, KhoTang: items.KhoTang, is_imei:items.is_imei,imei:"")
                                    itm.productPromotions?.append(pro1)
                                }
                                checkSPTang = true
                            }
                            checkSPMua = true
                        }
                    }
                    if(!checkSPMua || !checkSPTang){
                        if(items.SL_ThayThe > 0){
                            let pro1: ProductPromotions = ProductPromotions(Loai_KM: items.Loai_KM, MaCTKM: items.MaCTKM, MaSP: items.MaSP, TenSanPham_Mua: items.TenSanPham_Mua, Nhom: items.Nhom, SL_Tang: items.SL_ThayThe, SanPham_Tang: items.MaSP_ThayThe, SanPham_Mua: items.SanPham_Mua, TenCTKM: items.TenCTKM, TenSanPham_Tang: items.TenSP_ThayThe, TienGiam: items.TienGiam, MaSP_ThayThe: "", SL_ThayThe: 0, TenSP_ThayThe: "", MenhGia_VC: items.MenhGia_VC, VC_used: items.VC_used, KhoTang: items.KhoTang, is_imei:items.is_imei,imei:"")
                            
                            var arrPro: [ProductPromotions] = []
                            arrPro.append(pro1)
                            
                            let proArr: ProductPromotionsArray = ProductPromotionsArray(promotionsMain: items, productPromotions: arrPro)
                            item.promotions?.append(proArr)
                        }else{
                            let proArr: ProductPromotionsArray = ProductPromotionsArray(promotionsMain: items, productPromotions: [])
                            item.promotions?.append(proArr)
                        }
                    }
                    check = true
                }
            }
            
            // khac nhom
            if(list.isEmpty || !check){
                
                var arr: [ProductPromotionsArray] = []
                
                if(items.SL_ThayThe > 0){
                    let pro1: ProductPromotions = ProductPromotions(Loai_KM: items.Loai_KM, MaCTKM: items.MaCTKM, MaSP: items.MaSP, TenSanPham_Mua: items.TenSanPham_Mua, Nhom: items.Nhom, SL_Tang: items.SL_ThayThe, SanPham_Tang: items.MaSP_ThayThe, SanPham_Mua: items.SanPham_Mua, TenCTKM: items.TenCTKM, TenSanPham_Tang: items.TenSP_ThayThe, TienGiam: items.TienGiam, MaSP_ThayThe: "", SL_ThayThe: 0, TenSP_ThayThe: "", MenhGia_VC: items.MenhGia_VC, VC_used: items.VC_used, KhoTang: items.KhoTang, is_imei:items.is_imei,imei:"")
                    
                    var arrPro: [ProductPromotions] = []
                    arrPro.append(pro1)
                    
                    let proArr: ProductPromotionsArray = ProductPromotionsArray(promotionsMain: items, productPromotions: arrPro)
                    arr.append(proArr)
                }else{
                    let proArr: ProductPromotionsArray = ProductPromotionsArray(promotionsMain: items, productPromotions: [])
                    arr.append(proArr)
                }
                
                let pro:PromotionsObject =  PromotionsObject(group: items.Nhom, promotions: arr)
                list.append(pro)
            }
        }
        for items in list {
            print("GROUP: \(items.group)")
            for itm in items.promotions!{
                print("TANG: \(itm.promotionsMain.TenSanPham_Tang)")
                for chag in itm.productPromotions!{
                    print("THAY: \(chag.TenSanPham_Tang)")
                }
            }
        }
        result.append(contentsOf: list)
        Cache.resultPromostionsFF.removeAll()
        Cache.resultPromostionsFF.append(contentsOf: list)
        self.setupUI()
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
   @objc func actionOpenMenuLeft() {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func setupUI(){
        
        let lbGroupPromotion = UILabel(frame: CGRect(x: 0, y: Common.Size(s:10), width: self.view.frame.size.width, height: Common.Size(s:20)))
        lbGroupPromotion.textAlignment = .center
        lbGroupPromotion.textColor = UIColor(netHex:0x47B054)
        lbGroupPromotion.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbGroupPromotion.text = "CHỌN NHÓM KHUYẾN MÃI"
        self.view.addSubview(lbGroupPromotion)
        
        let footer = UIView()
        footer.frame = CGRect(x: 0, y: self.view.frame.size.height - Common.Size(s:44) - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: Common.Size(s: 44))
        footer.backgroundColor = UIColor(netHex:0x47B054)
        self.view.addSubview(footer)
        // - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        let footerTotal = UIView()
        footerTotal.frame = CGRect(x: 0, y:0, width: footer.frame.size.width * 6.5/10, height: footer.frame.size.height)
        footer.addSubview(footerTotal)
        
        let totalText = "Tổng tiền thanh toán"
        let sizeLbTotal: CGSize = totalText.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:14))])
        let lbTotal = UILabel(frame: CGRect(x: 0, y: Common.Size(s:5), width: footerTotal.frame.size.width, height: sizeLbTotal.height))
        lbTotal.textAlignment = .center
        lbTotal.textColor = UIColor.white
        lbTotal.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotal.text = totalText
        footerTotal.addSubview(lbTotal)
        
        lbTotalValue = UILabel(frame: CGRect(x: 0, y: lbTotal.frame.origin.y + lbTotal.frame.size.height, width: footerTotal.frame.size.width, height: footerTotal.frame.size.height - (lbTotal.frame.origin.y + lbTotal.frame.size.height)))
        lbTotalValue.textAlignment = .center
        lbTotalValue.textColor = UIColor(netHex:0xEF4A40)
        lbTotalValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        footerTotal.addSubview(lbTotalValue)
        
        let footerLine = UIView()
        footerLine.frame = CGRect(x: footerTotal.frame.origin.x + footerTotal.frame.size.width, y:footer.frame.size.height * 2/10, width: 1, height: footer.frame.size.height * 6/10)
        footerLine.backgroundColor = .white
        footer.addSubview(footerLine)
        
        let footerPay = UIView()
        footerPay.frame = CGRect(x: footerTotal.frame.origin.x + footerTotal.frame.size.width, y:0, width: footer.frame.size.width - (footerTotal.frame.origin.x + footerTotal.frame.size.width), height: footer.frame.size.height)
        footerPay.backgroundColor = UIColor(netHex:0xEF4A40)
        footer.addSubview(footerPay)
        
        let lbPay = UILabel(frame: CGRect(x: 0, y: 0, width: footerPay.frame.size.width, height: footerPay.frame.size.height))
        lbPay.textAlignment = .center
        lbPay.textColor = UIColor.white
        lbPay.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbPay.text = "Tiếp tục"
        footerPay.addSubview(lbPay)
        let payAction = UITapGestureRecognizer(target: self, action:  #selector (self.payAction (_:)))
        footerPay.addGestureRecognizer(payAction)
        
        tableView.frame = CGRect(x: 0, y:lbGroupPromotion.frame.origin.y + lbGroupPromotion.frame.size.height + Common.Size(s:10), width: self.view.frame.size.width, height: footer.frame.origin.y - (lbGroupPromotion.frame.origin.y + lbGroupPromotion.frame.size.height + Common.Size(s:10)))
        self.tableView.initialOpenSections = Set([0])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemGiftTableViewCellV2.self, forCellReuseIdentifier: "ItemGiftTableViewCellV2")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Common.Size(s:100)
        tableView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(tableView)
        tableView.reloadData()
        
        self.updateTotal(discountPrice: 0)
        //         loadingView.isHidden = true
        
    }
    @objc func payAction(_ sender:UITapGestureRecognizer){
        
        
        
        if groupChoose.count > 0 || notPromotionValue{
            
            for item in self.result{
                if(item.group == groupChoose){
                    Cache.itemsPromotionFF.removeAll()
                    for itm in item.promotions!{
                        Cache.itemsPromotionFF.append(itm.promotionsMain)
                    }
                    break
                }
            }
            var promos:[ProductPromotions] = []
            for item in Cache.itemsPromotionFF{
                let it = item
                if (it.TienGiam <= 0){
                    if (promos.count == 0){
                        promos.append(it)
                        Cache.itemsPromotionTempFF.append(item)
                    }else{
                        for pro in promos {
                            if (pro.SanPham_Tang == it.SanPham_Tang){
                                pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
                            }else{
                                promos.append(it)
                                Cache.itemsPromotionTempFF.append(item)
                            }
                        }
                    }
                }else{
                    Cache.itemsPromotionTempFF.append(item)
                }
            }
            
            if(Cache.typeOrder == "09"){
                let newViewController = ReadSOFFriendDetailViewController()
                newViewController.carts = Cache.cartsTempFF
                newViewController.itemsPromotion = Cache.itemsPromotionTempFF
                newViewController.phone = Cache.phoneTemp
                newViewController.name = Cache.nameTemp
                self.navigationController?.pushViewController(newViewController, animated: true)
            }else if(Cache.typeOrder == "10"){
                let newViewController = ReadSOPayDirectlyFFriendDetailViewController()
                newViewController.carts = Cache.cartsTempFF
                newViewController.itemsPromotion = Cache.itemsPromotionTempFF
                newViewController.phone = Cache.phoneTemp
                newViewController.name = Cache.nameTemp
                self.navigationController?.pushViewController(newViewController, animated: true)
            }else if(Cache.typeOrder == "20"){
                let newViewController = ReadSOCreditFFriendViewController()
                newViewController.carts = Cache.cartsTempFF
                newViewController.itemsPromotion = Cache.itemsPromotionTempFF
                newViewController.phone = Cache.phoneTemp
                newViewController.name = Cache.nameTemp
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            
        }else{
            
            // Prepare the popup
            let title = "CHÚ Ý"
            let message = "Bạn chưa chọn nhóm khuyến mãi!"
            
            // Create the dialog
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            
            // Create first button
            let buttonOne = CancelButton(title: "OK") {
                
            }
            
            
            // Add buttons to dialog
            popup.addButtons([buttonOne])
            
            // Present dialog
            present(popup, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result[section].promotions!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.result.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Common.Size(s:44)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return self.tableView(tableView, heightForHeaderInSection:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemGiftTableViewCellV2(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemGiftTableViewCellV2")
        
        let item:ProductPromotionsArray = self.result[indexPath.section].promotions![indexPath.row]
        
        // cell.setup(promotion: item)
        var price:String = ""
        if (item.promotionsMain.TienGiam > 0){
            price = "Giảm giá: \(item.promotionsMain.TenCTKM)"
            cell.quanlity.isHidden = false
            cell.quanlity.text = "Tiền giảm: \(Common.convertCurrencyFloat(value: item.promotionsMain.TienGiam))"
        }else{
            price = "Tặng: \(item.promotionsMain.TenSanPham_Tang)"
            cell.quanlity.isHidden = false
            cell.quanlity.text = "Số lượng: \(item.promotionsMain.SL_Tang)"
        }
        cell.title.text = price
        cell.selectionStyle = .none
        if (item.productPromotions!.count > 0){
            cell.quanlityChange.isHidden = false
            cell.accessoryType = .disclosureIndicator
            cell.quanlityChange.text = "Có \(item.productPromotions!.count) khuyến mãi thay thế"
        }else{
            cell.quanlityChange.isHidden = true
        }
        
        cell.note.text = "(Khi mua: \(item.promotionsMain.TenSanPham_Mua))"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:ProductPromotionsArray = self.result[indexPath.section].promotions![indexPath.row]
        if (item.productPromotions!.count > 0){
            let newViewController = ChangePromotionViewController()
            newViewController.promotion = item
            newViewController.secsion = indexPath.section
            newViewController.index = indexPath.row
            newViewController.delegate = self
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    func changePromotion(_ secsion: Int, index: Int, promotion: ProductPromotions){
        
        let item:ProductPromotionsArray = self.result[secsion].promotions![index]
        let temp: ProductPromotions = self.result[secsion].promotions![index].promotionsMain .copy() as! ProductPromotions
        var count: Int = -1
        for itm in self.result[secsion].promotions![index].productPromotions!{
            count = count + 1
            if (itm.SanPham_Tang == promotion.SanPham_Tang){
                break
            }
        }
        if(count >= 0 ){
            self.result[secsion].promotions![index].productPromotions?.remove(at: count)
            self.result[secsion].promotions![index].productPromotions?.append(temp)
            item.promotionsMain = promotion
            tableView.reloadData()
        }
        
        print("CHON \(secsion) \(index) \(item.promotionsMain.SanPham_Tang) \(promotion.SanPham_Tang)")
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = FZAccordionTableViewHeaderView(frame: CGRect(x:0,y: 0,width: tableView.frame.size.width,height: Common.Size(s:44)))
        
        view.backgroundColor = UIColor.white
        
        let  radioPayNow = createRadioButtonGroup(CGRect(x: Common.Size(s:10),y:0 , width: tableView.frame.size.width/2, height: Common.Size(s:44)), title: "\(self.result[section].group)", color: UIColor(netHex:0x47B054));
        if (groupChoose == "\(self.result[section].group)"){
            radioPayNow.isSelected = true
        }else if (groupChoose == ""){
            
            groupChoose = "\(self.result[section].group)"
            radioPayNow.isSelected = true
            Cache.itemsPromotionFF.removeAll()
            for item in self.result{
                if(item.group == groupChoose){
                    Cache.itemsPromotionFF.removeAll()
                    var sum:Float = 0.0
                    for itm in item.promotions!{
                        sum = sum + itm.promotionsMain.TienGiam
                    }
                    self.updateTotal(discountPrice: sum)
                    break
                }
            }
        }
        view.addSubview(radioPayNow)
        radios.append(radioPayNow)
        
        let icon = UIImageView(frame: CGRect(x: view.frame.size.width - view.frame.size.height, y:  0,width:view.frame.size.height/2, height:  view.frame.size.height))
        icon.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(icon)
        icon.image = #imageLiteral(resourceName: "dropdown")
        
        return view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    fileprivate func createRadioButtonGroup(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(self.logSelectedButtonPayType), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonPayType(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            
            for item in radios {
                item.isSelected = false
            }
            groupChoose = temp
            radioButton.isSelected = true
            
            for item in self.result{
                if(item.group == groupChoose){
                    Cache.itemsPromotionFF.removeAll()
                    var sum:Float = 0.0
                    for itm in item.promotions!{
                        sum = sum + itm.promotionsMain.TienGiam
                    }
                    self.updateTotal(discountPrice: sum)
                    break
                }
            }
        }
    }
    func updateTotal(discountPrice: Float){
        var sum: Float = 0
        for item in Cache.cartsFF {
            sum = sum + Float(item.quantity) * item.product.price
        }
        sum = sum - discountPrice
        lbTotalValue.text = Common.convertCurrencyFloat(value: sum)
    }
}

extension PromotionFFriendViewController : FZAccordionTableViewDelegate {
    
    func tableView(_ tableView: FZAccordionTableView, willOpenSection section: Int, withHeader header: UITableViewHeaderFooterView?) {
    }
    
    func tableView(_ tableView: FZAccordionTableView, didOpenSection section: Int, withHeader header: UITableViewHeaderFooterView?) {
    }
    
    func tableView(_ tableView: FZAccordionTableView, willCloseSection section: Int, withHeader header: UITableViewHeaderFooterView?) {
        
    }
    
    func tableView(_ tableView: FZAccordionTableView, didCloseSection section: Int, withHeader header: UITableViewHeaderFooterView?) {
        
    }
    
    func tableView(_ tableView: FZAccordionTableView, canInteractWithHeaderAtSection section: Int) -> Bool {
        return true
    }
}

